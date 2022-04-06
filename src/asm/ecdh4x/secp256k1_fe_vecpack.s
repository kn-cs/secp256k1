/***********************************************************************
 * Copyright (c) 2022 Kaushik Nath                                     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

        .p2align 5
        .globl secp256k1_fe_pack_4to10
secp256k1_fe_pack_4to10:

        vmovdqa   0(%rsi),%ymm8
        vmovdqa   32(%rsi),%ymm9
        vmovdqa   64(%rsi),%ymm10
        vmovdqa   96(%rsi),%ymm11

        vpunpcklqdq    %ymm9,%ymm8,%ymm12
        vpunpckhqdq    %ymm9,%ymm8,%ymm13
        vpunpcklqdq    %ymm11,%ymm10,%ymm14
        vpunpckhqdq    %ymm11,%ymm10,%ymm15        
        vpermq    $68,%ymm14,%ymm7
        vpblendd  $240,%ymm7,%ymm12,%ymm10
        vpermq    $68,%ymm15,%ymm7
        vpblendd  $240,%ymm7,%ymm13,%ymm11
        vpermq    $238,%ymm12,%ymm7
        vpblendd  $240,%ymm14,%ymm7,%ymm12
        vpermq    $238,%ymm13,%ymm7
        vpblendd  $240,%ymm15,%ymm7,%ymm13
        vpand     pmask1(%rip),%ymm10,%ymm0
        vpand     pmask2(%rip),%ymm10,%ymm1
        vpsrlq    $26,%ymm1,%ymm1
        vpand     pmask3(%rip),%ymm10,%ymm2
        vpsrlq    $52,%ymm2,%ymm2
        vpand     pmask4(%rip),%ymm11,%ymm3
        vpsllq    $12,%ymm3,%ymm3
        vpor      %ymm3,%ymm2,%ymm2
        vpand     pmask5(%rip),%ymm11,%ymm3
        vpsrlq    $14,%ymm3,%ymm3
        vpand     pmask6(%rip),%ymm11,%ymm4
        vpsrlq    $40,%ymm4,%ymm4
        vpand     pmask7(%rip),%ymm12,%ymm5
        vpsllq    $24,%ymm5,%ymm5
        vpor      %ymm5,%ymm4,%ymm4
        vpand     pmask8(%rip),%ymm12,%ymm5
        vpsrlq    $2,%ymm5,%ymm5
        vpand     pmask9(%rip),%ymm12,%ymm6
        vpsrlq    $28,%ymm6,%ymm6
        vpand     pmask10(%rip),%ymm12,%ymm7
        vpsrlq    $54,%ymm7,%ymm7
        vpand     pmask11(%rip),%ymm13,%ymm8
        vpsllq    $10,%ymm8,%ymm8
        vpor      %ymm8,%ymm7,%ymm7
        vpand     pmask12(%rip),%ymm13,%ymm8
        vpsrlq    $16,%ymm8,%ymm8
        vpand     pmask13(%rip),%ymm13,%ymm9
        vpsrlq    $42,%ymm9,%ymm9

        vmovdqa   %ymm0,0(%rdi)
        vmovdqa   %ymm1,32(%rdi)
        vmovdqa   %ymm2,64(%rdi)
        vmovdqa   %ymm3,96(%rdi)
        vmovdqa   %ymm4,128(%rdi)
        vmovdqa   %ymm5,160(%rdi)
        vmovdqa   %ymm6,192(%rdi)
        vmovdqa   %ymm7,224(%rdi)
        vmovdqa   %ymm8,256(%rdi)
        vmovdqa   %ymm9,288(%rdi)

        ret


        .p2align 5
        .globl secp256k1_fe_pack_10to4
secp256k1_fe_pack_10to4:

        vmovdqa   0(%rsi),%ymm0
        vmovdqa   32(%rsi),%ymm1
        vmovdqa   64(%rsi),%ymm2
        vmovdqa   96(%rsi),%ymm3
        vmovdqa   128(%rsi),%ymm4
        vmovdqa   160(%rsi),%ymm5
        vmovdqa   192(%rsi),%ymm6
        vmovdqa   224(%rsi),%ymm7
        vmovdqa   256(%rsi),%ymm8
        vmovdqa   288(%rsi),%ymm9

        vpand     upmask1(%rip),%ymm0,%ymm10
        vpand     upmask1(%rip),%ymm1,%ymm11
        vpsllq    $26,%ymm11,%ymm11
        vpor      %ymm10,%ymm11,%ymm10
        vpand     upmask2(%rip),%ymm2,%ymm11
        vpsllq    $52,%ymm11,%ymm11
        vpor      %ymm10,%ymm11,%ymm10
        vpand     upmask3(%rip),%ymm2,%ymm11
        vpsrlq    $12,%ymm11,%ymm11
        vpand     upmask1(%rip),%ymm3,%ymm12
        vpsllq    $14,%ymm12,%ymm12
        vpor      %ymm11,%ymm12,%ymm11
        vpand     upmask4(%rip),%ymm4,%ymm12
        vpsllq    $40,%ymm12,%ymm12
        vpor      %ymm11,%ymm12,%ymm11
        vpand     upmask5(%rip),%ymm4,%ymm12
        vpsrlq    $24,%ymm12,%ymm12
        vpand     upmask1(%rip),%ymm5,%ymm13
        vpsllq    $2,%ymm13,%ymm13
        vpor      %ymm12,%ymm13,%ymm12
        vpand     upmask1(%rip),%ymm6,%ymm13
        vpsllq    $28,%ymm13,%ymm13
        vpor      %ymm12,%ymm13,%ymm12
        vpand     upmask6(%rip),%ymm7,%ymm13
        vpsllq    $54,%ymm13,%ymm13
        vpor      %ymm12,%ymm13,%ymm12
        vpand     upmask7(%rip),%ymm7,%ymm13
        vpsrlq    $10,%ymm13,%ymm13
        vpand     upmask1(%rip),%ymm8,%ymm14
        vpsllq    $16,%ymm14,%ymm14
        vpor      %ymm13,%ymm14,%ymm13
        vpand     upmask1(%rip),%ymm9,%ymm14
        vpsllq    $42,%ymm14,%ymm14
        vpor      %ymm13,%ymm14,%ymm13

        vmovdqa   %ymm10,0(%rdi)
        vmovdqa   %ymm11,32(%rdi)
        vmovdqa   %ymm12,64(%rdi)
        vmovdqa   %ymm13,96(%rdi)

        ret

        
