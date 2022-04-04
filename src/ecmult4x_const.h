/***********************************************************************
 * Copyright (c) 2022 Andrew Poelstra, Kaushik Nath                    *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

#ifndef SECP256K1_ECMULT4X_CONST_H
#define SECP256K1_ECMULT4X_CONST_H

#include "scalar.h"
#include "group.h"

#define ALIGN32 __attribute__ ((aligned(32)))

typedef uint64_t ALIGN32 vec4[4];

/**
 * Multiply: 4 instances of R = q*A (in constant-time)
 * Here `bits` should be set to the maximum bitlength of the _absolute value_ of `q`, plus
 * one because we internally sometimes add 2 to the number during the WNAF conversion.
 */
static void secp256k1_ecmult4x_const(secp256k1_gej *r, const secp256k1_ge *a, const secp256k1_scalar *q, int bits);

/*
 * Assembly routines
*/
extern void secp256k1_fe_pack_4to10(vec4 *, vec4 *);
extern void secp256k1_fe_pack_10to4(vec4 *, vec4 *);
extern void secp256k1_fe_mul4x(vec4 *, vec4 *, vec4 *);
extern void secp256k1_fe_sqr4x(vec4 *, vec4 *);
extern void secp256k1_fe_reduce4x(vec4 *, vec4 *);
extern void secp256k1_gej4x_add_ge4x(vec4 *, vec4 *, vec4 *);
extern void secp256k1_gej4x_double(vec4 *, vec4 *);
extern void secp256k1_fe_reduce(uint64_t *, uint64_t *);

#endif /* SECP256K1_ECMULT4X_CONST_H */
