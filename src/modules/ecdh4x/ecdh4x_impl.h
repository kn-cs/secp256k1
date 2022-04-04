/***********************************************************************
 * Copyright (c) 2022 Andrew Poelstra, Kaushik Nath                    *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

#ifndef SECP256K1_MODULE_ECDH4X_MAIN_H
#define SECP256K1_MODULE_ECDH4X_MAIN_H

#include "../../../include/secp256k1_ecdh4x.h"
#include "../../ecmult4x_const_impl.h"

static int ecdh_hash_function_sha256(unsigned char *output, const unsigned char *x32, const unsigned char *y32, void *data) {
    unsigned char version = (y32[31] & 0x01) | 0x02;
    secp256k1_sha256 sha;
    (void)data;

    secp256k1_sha256_initialize(&sha);
    secp256k1_sha256_write(&sha, &version, 1);
    secp256k1_sha256_write(&sha, x32, 32);
    secp256k1_sha256_finalize(&sha, output);

    return 1;
}

const secp256k1_ecdh_hash_function secp256k1_ecdh_hash_function_sha256 = ecdh_hash_function_sha256;
const secp256k1_ecdh_hash_function secp256k1_ecdh_hash_function_default = ecdh_hash_function_sha256;

int secp256k1_ecdh4x(const secp256k1_context* ctx, secp256k1_ecdh_output *output, const secp256k1_pubkey *point, const secp256k1_scalar_bytes *scalar, secp256k1_ecdh_hash_function hashfp, void *data) {
    int ret[4] = {0};
    int overflow[4] = {0};
    secp256k1_gej res[4]; 
    secp256k1_ge pt[4]; 
    secp256k1_scalar s[4]; 
    unsigned char x[32];
    unsigned char y[32];
    
    int i, ret4 = 0;

    VERIFY_CHECK(ctx != NULL);
    ARG_CHECK(output != NULL);
    ARG_CHECK(point != NULL);
    ARG_CHECK(scalar != NULL);

    if (hashfp == NULL) {
        hashfp = secp256k1_ecdh_hash_function_default;
    }

    for (i=0; i<4; i++) {    
        secp256k1_pubkey_load(ctx, pt+i, point+i);
        secp256k1_scalar_set_b32(s+i, (const unsigned char *)(scalar+i), overflow+i);

        overflow[i] |= secp256k1_scalar_is_zero(s+i);
        secp256k1_scalar_cmov(s+i, &secp256k1_scalar_one, overflow[i]);
    }

    secp256k1_ecmult4x_const(res, pt, s, 256);
    
    for (i=0; i<4; i++) {    
    	secp256k1_ge_set_gej(pt+i, res+i);
    	
        /* Compute a hash of the point */
        secp256k1_fe_normalize(&pt[i].x);
        secp256k1_fe_normalize(&pt[i].y);
        secp256k1_fe_get_b32(x, &pt[i].x);
        secp256k1_fe_get_b32(y, &pt[i].y);

        ret[i] = hashfp((unsigned char *)(output+i), x, y, data);
    }
    
    for (i=0; i<4; i++) {
    	secp256k1_scalar_clear(s+i);
    }
    
    memset(x, 0, 32);
    memset(y, 0, 32);    
    
    ret4 = !!ret[0] & !overflow[0];
    for (i=1; i<4; i++) {
    	ret4 = ret4 & (!!ret[i] & !overflow[i]);
    }

    return ret4;
}


#endif /* SECP256K1_MODULE_ECDH4X_MAIN_H */
