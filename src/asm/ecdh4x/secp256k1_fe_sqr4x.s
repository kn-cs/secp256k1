/***********************************************************************
 * Copyright (c) 2022 Kaushik Nath                                     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/
 
	.p2align 5
	.globl secp256k1_fe_sqr4x
secp256k1_fe_sqr4x:

	movq 	  %rsp,%r11
	andq 	  $-32,%rsp
	subq 	  $224,%rsp

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

	vpmuludq  %ymm1,%ymm9,%ymm15
	vpmuludq  %ymm2,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm3,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm4,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm10

	vpmuludq  %ymm2,%ymm9,%ymm15
	vpmuludq  %ymm3,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm4,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm11

	vpmuludq  %ymm0,%ymm0,%ymm12

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm11,%ymm11
	vpand     vecmask26,%ymm10,%ymm10
	vpsllq    $36,%ymm10,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm10,%ymm10
	vpaddq    %ymm14,%ymm10,%ymm10
	vmovdqa   %ymm10,0(%rsp)

	vpmuludq  %ymm3,%ymm9,%ymm15
	vpmuludq  %ymm4,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm15
	vpmuludq  %ymm6,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm10

	vpmuludq  %ymm0,%ymm1,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm12

	vpsrlq    $26,%ymm11,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm11,%ymm11
	vpsllq    $36,%ymm11,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm11,%ymm11
	vpaddq    %ymm14,%ymm11,%ymm11
	vmovdqa   %ymm11,32(%rsp)

	vpmuludq  %ymm4,%ymm9,%ymm15
	vpmuludq  %ymm5,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm6,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm11

	vpmuludq  %ymm0,%ymm2,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm15
	vpmuludq  %ymm1,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm12

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm11,%ymm11
	vpand     vecmask26,%ymm10,%ymm10
	vpsllq    $36,%ymm10,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm10,%ymm10
	vpaddq    %ymm14,%ymm10,%ymm10
	vmovdqa   %ymm10,64(%rsp)

	vpmuludq  %ymm5,%ymm9,%ymm15
	vpmuludq  %ymm6,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm15
	vpmuludq  %ymm7,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm10

	vpmuludq  %ymm0,%ymm3,%ymm15
	vpmuludq  %ymm1,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm12

	vpsrlq    $26,%ymm11,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm11,%ymm11
	vpsllq    $36,%ymm11,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm11,%ymm11
	vpaddq    %ymm14,%ymm11,%ymm11
	vmovdqa   %ymm11,96(%rsp)

	vpmuludq  %ymm6,%ymm9,%ymm15
	vpmuludq  %ymm7,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm11

	vpmuludq  %ymm0,%ymm4,%ymm15
	vpmuludq  %ymm1,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm15
	vpmuludq  %ymm2,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm12

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm11,%ymm11
	vpand     vecmask26,%ymm10,%ymm10
	vpsllq    $36,%ymm10,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm10,%ymm10
	vpaddq    %ymm14,%ymm10,%ymm10
	vmovdqa   %ymm10,128(%rsp)

	vpmuludq  %ymm7,%ymm9,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm15
	vpmuludq  %ymm8,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm10

	vpmuludq  %ymm0,%ymm5,%ymm15
	vpmuludq  %ymm1,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm2,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm12

	vpsrlq    $26,%ymm11,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm11,%ymm11
	vpsllq    $36,%ymm11,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm11,%ymm11
	vpaddq    %ymm14,%ymm11,%ymm11
	vmovdqa   %ymm11,160(%rsp)

	vpmuludq  %ymm8,%ymm9,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm11

	vpmuludq  %ymm0,%ymm6,%ymm15
	vpmuludq  %ymm1,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm2,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm15
	vpmuludq  %ymm3,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm12

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm11,%ymm11
	vpand     vecmask26,%ymm10,%ymm10
	vpsllq    $36,%ymm10,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm10,%ymm10
	vpaddq    %ymm14,%ymm10,%ymm10
	vmovdqa   %ymm10,192(%rsp)

	vpmuludq  %ymm9,%ymm9,%ymm10

	vpmuludq  %ymm0,%ymm7,%ymm15
	vpmuludq  %ymm1,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm2,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm3,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm12

	vpsrlq    $26,%ymm11,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm11,%ymm11
	vpsllq    $36,%ymm11,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm11,%ymm11
	vpaddq    %ymm14,%ymm11,%ymm13

	vpmuludq  %ymm0,%ymm8,%ymm15
	vpmuludq  %ymm1,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm2,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm3,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm15
	vpmuludq  %ymm4,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm12

	vpsrlq    $26,%ymm10,%ymm11
	vpand     vecmask26,%ymm10,%ymm10
	vpsllq    $36,%ymm10,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm10,%ymm10
	vpaddq    %ymm14,%ymm10,%ymm10

	vpmuludq  %ymm0,%ymm9,%ymm15
	vpmuludq  %ymm1,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm2,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm3,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm4,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm15,%ymm12

	vpsllq    $36,%ymm11,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm11,%ymm11
	vpaddq    %ymm14,%ymm11,%ymm9

	vmovdqa   0(%rsp),%ymm0
	vmovdqa   32(%rsp),%ymm1
	vmovdqa   64(%rsp),%ymm2
	vmovdqa   96(%rsp),%ymm3
	vmovdqa   128(%rsp),%ymm4
	vmovdqa   160(%rsp),%ymm5
	vmovdqa   192(%rsp),%ymm6

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm13,%ymm13
	vpand     vecmask26,%ymm6,%ymm6

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm12
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm13,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm13,%ymm2

	vpsrlq    $26,%ymm12,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm11
	vpand     vecmask26,%ymm12,%ymm12

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm10,%ymm3

	vpsrlq    $26,%ymm11,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm8
	vpand     vecmask26,%ymm11,%ymm13

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26,%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22,%ymm9,%ymm4

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977,%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm8,%ymm14

	vpsrlq    $26,%ymm0,%ymm15
	vpaddq    %ymm15,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm10

	vpsrlq    $26,%ymm1,%ymm15
	vpaddq    %ymm15,%ymm12,%ymm12
	vpand     vecmask26,%ymm1,%ymm11

	vpsrlq    $26,%ymm5,%ymm15
	vpaddq    %ymm15,%ymm6,%ymm1
	vpand     vecmask26,%ymm5,%ymm0

	vmovdqa   %ymm10,0(%rdi)
	vmovdqa   %ymm11,32(%rdi)
	vmovdqa   %ymm12,64(%rdi)
	vmovdqa   %ymm13,96(%rdi)
	vmovdqa   %ymm14,128(%rdi)
	vmovdqa   %ymm0,160(%rdi)
	vmovdqa   %ymm1,192(%rdi)
	vmovdqa   %ymm2,224(%rdi)
	vmovdqa   %ymm3,256(%rdi)
	vmovdqa   %ymm4,288(%rdi)

	movq 	  %r11,%rsp

	ret
