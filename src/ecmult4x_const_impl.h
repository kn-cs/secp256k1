/***********************************************************************
 * Copyright (c) 2022 Pieter Wuille, Andrew Poelstra, Kaushik Nath     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

#ifndef SECP256K1_ECMULT4X_CONST_IMPL_H
#define SECP256K1_ECMULT4X_CONST_IMPL_H

#include "scalar.h"
#include "group.h"
#include "ecmult4x_const.h"
#include "ecmult_impl.h"

/* This is like `ECMULT_TABLE_GET_GE` but is constant time */
#define ECMULT_CONST_TABLE_GET_GE(r,pre,n,w) do { \
    int m = 0; \
    /* Extract the sign-bit for a constant time absolute-value. */ \
    int mask = (n) >> (sizeof(n) * CHAR_BIT - 1); \
    int abs_n = ((n) + mask) ^ mask; \
    int idx_n = abs_n >> 1; \
    secp256k1_fe neg_y; \
    VERIFY_CHECK(((n) & 1) == 1); \
    VERIFY_CHECK((n) >= -((1 << ((w)-1)) - 1)); \
    VERIFY_CHECK((n) <=  ((1 << ((w)-1)) - 1)); \
    VERIFY_SETUP(secp256k1_fe_clear(&(r)->x)); \
    VERIFY_SETUP(secp256k1_fe_clear(&(r)->y)); \
    /* Unconditionally set r->x = (pre)[m].x. r->y = (pre)[m].y. because it's either the correct one \
     * or will get replaced in the later iterations, this is needed to make sure `r` is initialized. */ \
    (r)->x = (pre)[m].x; \
    (r)->y = (pre)[m].y; \
    for (m = 1; m < ECMULT_TABLE_SIZE(w); m++) { \
        /* This loop is used to avoid secret data in array indices. See
         * the comment in ecmult_gen_impl.h for rationale. */ \
        secp256k1_fe_cmov(&(r)->x, &(pre)[m].x, m == idx_n); \
        secp256k1_fe_cmov(&(r)->y, &(pre)[m].y, m == idx_n); \
    } \
    (r)->infinity = 0; \
    secp256k1_fe_negate(&neg_y, &(r)->y, 1); \
    secp256k1_fe_cmov(&(r)->y, &neg_y, (n) != abs_n); \
} while(0)


/** Convert a number to WNAF notation.
 *  The number becomes represented by sum(2^{wi} * wnaf[i], i=0..WNAF_SIZE(w)+1) - return_val.
 *  It has the following guarantees:
 *  - each wnaf[i] an odd integer between -(1 << w) and (1 << w)
 *  - each wnaf[i] is nonzero
 *  - the number of words set is always WNAF_SIZE(w) + 1
 *
 *  Adapted from `The Width-w NAF Method Provides Small Memory and Fast Elliptic Scalar
 *  Multiplications Secure against Side Channel Attacks`, Okeya and Tagaki. M. Joye (Ed.)
 *  CT-RSA 2003, LNCS 2612, pp. 328-443, 2003. Springer-Verlag Berlin Heidelberg 2003
 *
 *  Numbers reference steps of `Algorithm SPA-resistant Width-w NAF with Odd Scalar` on pp. 335
 */
static int secp256k1_wnaf_const(int *wnaf, const secp256k1_scalar *scalar, int w, int size) {
    int global_sign;
    int skew = 0;
    int word = 0;

    /* 1 2 3 */
    int u_last;
    int u;

    int flip;
    int bit;
    secp256k1_scalar s;
    int not_neg_one;

    VERIFY_CHECK(w > 0);
    VERIFY_CHECK(size > 0);

    /* Note that we cannot handle even numbers by negating them to be odd, as is
     * done in other implementations, since if our scalars were specified to have
     * width < 256 for performance reasons, their negations would have width 256
     * and we'd lose any performance benefit. Instead, we use a technique from
     * Section 4.2 of the Okeya/Tagaki paper, which is to add either 1 (for even)
     * or 2 (for odd) to the number we are encoding, returning a skew value indicating
     * this, and having the caller compensate after doing the multiplication.
     *
     * In fact, we _do_ want to negate numbers to minimize their bit-lengths (and in
     * particular, to ensure that the outputs from the endomorphism-split fit into
     * 128 bits). If we negate, the parity of our number flips, inverting which of
     * {1, 2} we want to add to the scalar when ensuring that it's odd. Further
     * complicating things, -1 interacts badly with `secp256k1_scalar_cadd_bit` and
     * we need to special-case it in this logic. */
    flip = secp256k1_scalar_is_high(scalar);
    /* We add 1 to even numbers, 2 to odd ones, noting that negation flips parity */
    bit = flip ^ !secp256k1_scalar_is_even(scalar);
    /* We check for negative one, since adding 2 to it will cause an overflow */
    secp256k1_scalar_negate(&s, scalar);
    not_neg_one = !secp256k1_scalar_is_one(&s);
    s = *scalar;
    secp256k1_scalar_cadd_bit(&s, bit, not_neg_one);
    /* If we had negative one, flip == 1, s.d[0] == 0, bit == 1, so caller expects
     * that we added two to it and flipped it. In fact for -1 these operations are
     * identical. We only flipped, but since skewing is required (in the sense that
     * the skew must be 1 or 2, never zero) and flipping is not, we need to change
     * our flags to claim that we only skewed. */
    global_sign = secp256k1_scalar_cond_negate(&s, flip);
    global_sign *= not_neg_one * 2 - 1;
    skew = 1 << bit;

    /* 4 */
    u_last = secp256k1_scalar_shr_int(&s, w);
    do {
        int even;

        /* 4.1 4.4 */
        u = secp256k1_scalar_shr_int(&s, w);
        /* 4.2 */
        even = ((u & 1) == 0);
        /* In contrast to the original algorithm, u_last is always > 0 and
         * therefore we do not need to check its sign. In particular, it's easy
         * to see that u_last is never < 0 because u is never < 0. Moreover,
         * u_last is never = 0 because u is never even after a loop
         * iteration. The same holds analogously for the initial value of
         * u_last (in the first loop iteration). */
        VERIFY_CHECK(u_last > 0);
        VERIFY_CHECK((u_last & 1) == 1);
        u += even;
        u_last -= even * (1 << w);

        /* 4.3, adapted for global sign change */
        wnaf[word++] = u_last * global_sign;

        u_last = u;
    } while (word * w < size);
    wnaf[word] = u * global_sign;

    VERIFY_CHECK(secp256k1_scalar_is_zero(&s));
    VERIFY_CHECK(word == WNAF_SIZE_BITS(size, w));
    return skew;
}

// 4-way version of ecmult_const
static void secp256k1_ecmult4x_const(secp256k1_gej *r, const secp256k1_ge *a, const secp256k1_scalar *scalar, int size) {

    secp256k1_ge pre_a4[4*ECMULT_TABLE_SIZE(WINDOW_A)], *pre_a;
    secp256k1_ge tmpa;
    secp256k1_fe Z[4];

    int skew_1[4];
    secp256k1_ge pre_a_lam4[4*ECMULT_TABLE_SIZE(WINDOW_A)], *pre_a_lam;
    int wnaf_lam4[4*(1 + WNAF_SIZE(WINDOW_A - 1))], *wnaf_lam;
    int skew_lam[4];
    secp256k1_scalar q_1, q_lam;
    int wnaf_1_4[4*(1 + WNAF_SIZE(WINDOW_A - 1))], *wnaf_1;

    int i,j;
    
    vec4 u[31] = {0};
    vec4 v[20] = {0};    
    vec4 t[12] = {0};
    vec4 one4 = {1,1,1,1};

    /* build wnaf representation for q. */
    int rsize = size;
    if (size > 128) {
        rsize = 128;
        /* split q into q_1 and q_lam (where q = q_1 + q_lam*lambda, and q_1 and q_lam are ~128 bit) */
        for (i=0; i<4; i++) {         
                secp256k1_scalar_split_lambda(&q_1, &q_lam, scalar+i);
                wnaf_1 = wnaf_1_4 + i*(1 + WNAF_SIZE(WINDOW_A - 1));
                wnaf_lam = wnaf_lam4 + i*(1 + WNAF_SIZE(WINDOW_A - 1));
                skew_1[i] = secp256k1_wnaf_const(wnaf_1, &q_1, WINDOW_A - 1, 128);
                skew_lam[i] = secp256k1_wnaf_const(wnaf_lam, &q_lam, WINDOW_A - 1, 128);
        }
    } else {    
        for (i=0; i<4; i++) {        
                wnaf_1 = wnaf_1_4 + i*(1 + WNAF_SIZE(WINDOW_A - 1));        
                skew_1[i] = secp256k1_wnaf_const(wnaf_1, scalar, WINDOW_A - 1, size);
                skew_lam[i] = 0;
        }
    }

    /* Calculate odd multiples of a.
     * All multiples are brought to the same Z 'denominator', which is stored
     * in Z. Due to secp256k1' isomorphism we can do all operations pretending
     * that the Z coordinate was 1, use affine addition formulae, and correct
     * the Z coordinate of the result once at the end.
     */
    for (j=0; j<4; j++) {
        secp256k1_gej_set_ge(r+j, a+j);
        pre_a = pre_a4 + j*ECMULT_TABLE_SIZE(WINDOW_A);
        pre_a_lam = pre_a_lam4 + j*ECMULT_TABLE_SIZE(WINDOW_A);
        secp256k1_ecmult_odd_multiples_table_globalz_windowa(pre_a, &Z[j], r+j);
        for (i = 0; i < ECMULT_TABLE_SIZE(WINDOW_A); i++) {
                secp256k1_fe_normalize_weak(&pre_a[i].y);
        }
        if (size > 128) {
                for (i = 0; i < ECMULT_TABLE_SIZE(WINDOW_A); i++) {
                        secp256k1_ge_mul_lambda(&pre_a_lam[i], &pre_a[i]);
                }
        }
    }

    /* first loop iteration (separated out so we can directly set r, rather
     * than having it start at infinity, get doubled several times, then have
     * its new value added to it) */
    for (j=0; j<4; j++) {
        wnaf_1 = wnaf_1_4 + j*(1 + WNAF_SIZE(WINDOW_A - 1));    
        i = wnaf_1[WNAF_SIZE_BITS(rsize, WINDOW_A - 1)];
        VERIFY_CHECK(i != 0);
        pre_a = pre_a4 + j*ECMULT_TABLE_SIZE(WINDOW_A);        
        ECMULT_CONST_TABLE_GET_GE(&tmpa, pre_a, i, WINDOW_A);
        secp256k1_fe_reduce((uint64_t *)&t[j], (uint64_t *)&tmpa.x);
        secp256k1_fe_reduce((uint64_t *)&t[j+4], (uint64_t *)&tmpa.y);
    }
    secp256k1_fe_pack_4to10(u, t);
    secp256k1_fe_pack_4to10(u+10, t+4);    
    memcpy(&u[20], one4, sizeof(one4)); 
    memcpy(&u[30], one4, sizeof(one4)); 
    if (size > 128) {
        for (j=0; j<4; j++) {
            wnaf_lam = wnaf_lam4 + j*(1 + WNAF_SIZE(WINDOW_A - 1));
            i = wnaf_lam[WNAF_SIZE_BITS(rsize, WINDOW_A - 1)];
            VERIFY_CHECK(i != 0);
            pre_a_lam = pre_a_lam4 + j*ECMULT_TABLE_SIZE(WINDOW_A);
            ECMULT_CONST_TABLE_GET_GE(&tmpa, pre_a_lam, i, WINDOW_A);
            secp256k1_fe_reduce((uint64_t *)&t[j], (uint64_t *)&tmpa.x);
            secp256k1_fe_reduce((uint64_t *)&t[j+4], (uint64_t *)&tmpa.y);
        }
    }
    secp256k1_fe_pack_4to10(v, t);
    secp256k1_fe_pack_4to10(v+10, t+4);    
    secp256k1_gej4x_add_ge4x(u, u, v);
    /* remaining loop iterations */
    for (i = WNAF_SIZE_BITS(rsize, WINDOW_A - 1) - 1; i >= 0; i--) {
        int n;
        for (j = 0; j < WINDOW_A - 1; j++) {
            secp256k1_gej4x_double(u, u);
        }

        for (j=0; j<4; j++) {
            wnaf_1 = wnaf_1_4 + j*(1 + WNAF_SIZE(WINDOW_A - 1));
            n = wnaf_1[i];
            pre_a = pre_a4 + j*ECMULT_TABLE_SIZE(WINDOW_A);            
            ECMULT_CONST_TABLE_GET_GE(&tmpa, pre_a, n, WINDOW_A);
            VERIFY_CHECK(n != 0);
            secp256k1_fe_reduce((uint64_t *)&t[j], (uint64_t *)&tmpa.x);
            secp256k1_fe_reduce((uint64_t *)&t[j+4], (uint64_t *)&tmpa.x);          
        }
        secp256k1_fe_pack_4to10(v, t);
        secp256k1_fe_pack_4to10(v+10, t+4);        
        secp256k1_gej4x_add_ge4x(u, u, v);
        if (size > 128) {
            for (j=0; j<4; j++) {
                wnaf_lam = wnaf_lam4 + j*(1 + WNAF_SIZE(WINDOW_A - 1));                    
                n = wnaf_lam[i];
                pre_a_lam = pre_a_lam4 + j*ECMULT_TABLE_SIZE(WINDOW_A);                
                ECMULT_CONST_TABLE_GET_GE(&tmpa, pre_a_lam, n, WINDOW_A);
                VERIFY_CHECK(n != 0);
                secp256k1_fe_reduce((uint64_t *)&t[j], (uint64_t *)&tmpa.x);
                secp256k1_fe_reduce((uint64_t *)&t[j+4], (uint64_t *)&tmpa.x);
            }
            secp256k1_fe_pack_4to10(v, t);
            secp256k1_fe_pack_4to10(v+10, t+4);            
            secp256k1_gej4x_add_ge4x(u, u, v);
        }
    }

    secp256k1_fe_pack_4to10(v, Z);
    secp256k1_fe_mul4x(u+20, u+20, v);

    secp256k1_fe_reduce4x(u);
    secp256k1_fe_reduce4x(u+10);
    secp256k1_fe_reduce4x(u+20);

    secp256k1_fe_pack_10to4(t, u);
    secp256k1_fe_pack_10to4(t+4, u+10);
    secp256k1_fe_pack_10to4(t+8, u+20);
    
    for (i=0; i<4; i++) {
        memcpy(&r[i].x, &t[i], sizeof(t[i]));
        memcpy(&r[i].y, &t[i+4], sizeof(t[i+4]));
        memcpy(&r[i].z, &t[i+8], sizeof(t[i+8]));
        r[i].infinity = u[30][i];                
    }    

    {
        /* Correct for wNAF skew */
        for (i=0; i<4; i++) {        
        	secp256k1_ge correction = *(a+i);
        	secp256k1_ge_storage correction_1_stor;
        	secp256k1_ge_storage correction_lam_stor;
        	secp256k1_ge_storage a2_stor;
        	secp256k1_gej tmpj;
        	secp256k1_gej_set_ge(&tmpj, &correction);
        	secp256k1_gej_double_var(&tmpj, &tmpj, NULL);
        	secp256k1_ge_set_gej(&correction, &tmpj);
        	secp256k1_ge_to_storage(&correction_1_stor, a+i);
        	if (size > 128) {
            		secp256k1_ge_to_storage(&correction_lam_stor, a+i);
        	}
        	secp256k1_ge_to_storage(&a2_stor, &correction);

        	/* For odd numbers this is 2a (so replace it), for even ones a (so no-op) */
        	secp256k1_ge_storage_cmov(&correction_1_stor, &a2_stor, skew_1[i] == 2);
        	if (size > 128) {
            		secp256k1_ge_storage_cmov(&correction_lam_stor, &a2_stor, skew_lam[i] == 2);
        	}

            	/* Apply the correction */
            	secp256k1_ge_from_storage(&correction, &correction_1_stor);
            	secp256k1_ge_neg(&correction, &correction);
            	secp256k1_gej_add_ge(&r[i], &r[i], &correction);

            	if (size > 128) {
               	secp256k1_ge_from_storage(&correction, &correction_lam_stor);
                	secp256k1_ge_neg(&correction, &correction);
                	secp256k1_ge_mul_lambda(&correction, &correction);
                	secp256k1_gej_add_ge(&r[i], &r[i], &correction);
            	}
        }
    }
}

#endif /* SECP256K1_ECMULT4X_CONST_IMPL_H */
