/***********************************************************************
 * Copyright (c) 2022 Pieter Wuille, Andrew Poelstra, Kaushik Nath     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

#include "../include/secp256k1.h"
#include "../include/secp256k1_ecdh4x.h"
#include "util.h"
#include "bench.h"

typedef struct {
    secp256k1_context *ctx;
    secp256k1_pubkey point[4];
    secp256k1_scalar_bytes scalar[4];
} bench_ecdh4x_data;

static void bench_ecdh4x_setup(void* arg) {
    int i;
    bench_ecdh4x_data *data = (bench_ecdh4x_data*)arg;
    const unsigned char point[] = {
        0x03,
        0x54, 0x94, 0xc1, 0x5d, 0x32, 0x09, 0x97, 0x06,
        0xc2, 0x39, 0x5f, 0x94, 0x34, 0x87, 0x45, 0xfd,
        0x75, 0x7c, 0xe3, 0x0e, 0x4e, 0x8c, 0x90, 0xfb,
        0xa2, 0xba, 0xd1, 0x84, 0xf8, 0x83, 0xc6, 0x9f
    };

    for (i = 0; i < 32; i++) {    
    	data->scalar[0].data[i] = i + 1;
    	data->scalar[1].data[i] = i + 2;
    	data->scalar[2].data[i] = i + 3;
    	data->scalar[3].data[i] = i + 4;    	    	    	
    }
    
    for (i = 0; i < 4; i++) {
    	CHECK(secp256k1_ec_pubkey_parse(data->ctx, &data->point[i], point, sizeof(point)) == 1);   
    }
}

static void bench_ecdh4x(void* arg, int iters) {
    int i;
    secp256k1_ecdh_output res[4];
    bench_ecdh4x_data *data = (bench_ecdh4x_data*)arg;

    for (i = 0; i < iters; i++) {
        CHECK(secp256k1_ecdh4x(data->ctx, &res[0], &data->point[0], &data->scalar[0], NULL, NULL) == 1);        
    }
}

int main(void) {
    bench_ecdh4x_data data;

    int iters = get_iters(20000);

    /* create a context with no capabilities */
    data.ctx = secp256k1_context_create(SECP256K1_FLAGS_TYPE_CONTEXT);

    run_benchmark("ecdh4x", bench_ecdh4x, bench_ecdh4x_setup, NULL, &data, 10, iters);

    secp256k1_context_destroy(data.ctx);
    return 0;    
}


