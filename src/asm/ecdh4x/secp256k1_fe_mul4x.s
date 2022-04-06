/***********************************************************************
 * Copyright (c) 2022 Kaushik Nath                                     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/
 
	.p2align 5
	.globl secp256k1_fe_mul4x
secp256k1_fe_mul4x:

	movq 	  %rsp,%r11
	andq 	  $-32,%rsp
	subq 	  $896,%rsp

	vmovdqa   0(%rsi),%ymm10
	vmovdqa   32(%rsi),%ymm11
	vmovdqa   64(%rsi),%ymm12
	vmovdqa   96(%rsi),%ymm13
	vmovdqa   160(%rsi),%ymm0
	vmovdqa   192(%rsi),%ymm1
	vmovdqa   224(%rsi),%ymm2
	vmovdqa   256(%rsi),%ymm3
	vmovdqa   288(%rsi),%ymm4
	vmovdqa   160(%rdx),%ymm5
	vmovdqa   192(%rdx),%ymm6
	vmovdqa   224(%rdx),%ymm7
	vmovdqa   256(%rdx),%ymm8
	vmovdqa   288(%rdx),%ymm9

	vpmuludq  %ymm5,%ymm0,%ymm15
	vmovdqa   %ymm15,0(%rsp)

	vpmuludq  %ymm6,%ymm0,%ymm15
	vpmuludq  %ymm5,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,32(%rsp)

	vpmuludq  %ymm7,%ymm0,%ymm15
	vpmuludq  %ymm6,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,64(%rsp)

	vpmuludq  %ymm8,%ymm0,%ymm15
	vpmuludq  %ymm7,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm6,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,96(%rsp)

	vpmuludq  %ymm9,%ymm0,%ymm15
	vpmuludq  %ymm8,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm7,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm6,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,128(%rsp)

	vpmuludq  %ymm9,%ymm1,%ymm15
	vpmuludq  %ymm8,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm7,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm6,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,160(%rsp)

	vpmuludq  %ymm9,%ymm2,%ymm15
	vpmuludq  %ymm8,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm7,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,192(%rsp)

	vpmuludq  %ymm9,%ymm3,%ymm15
	vpmuludq  %ymm8,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,224(%rsp)

	vpmuludq  %ymm9,%ymm4,%ymm15
	vmovdqa   %ymm15,256(%rsp)

	vpaddq    %ymm10,%ymm0,%ymm0
	vpaddq    %ymm11,%ymm1,%ymm1
	vpaddq    %ymm12,%ymm2,%ymm2
	vpaddq    %ymm13,%ymm3,%ymm3
	vpaddq    128(%rsi),%ymm4,%ymm4

	vpaddq    0(%rdx),%ymm5,%ymm5
	vpaddq    32(%rdx),%ymm6,%ymm6
	vpaddq    64(%rdx),%ymm7,%ymm7
	vpaddq    96(%rdx),%ymm8,%ymm8
	vpaddq    128(%rdx),%ymm9,%ymm9

	vpmuludq  0(%rdx),%ymm10,%ymm15
	vmovdqa   %ymm15,288(%rsp)
	vpaddq    0(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,576(%rsp)

	vpmuludq  32(%rdx),%ymm10,%ymm15
	vpmuludq  0(%rdx),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,320(%rsp)
	vpaddq    32(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,608(%rsp)

	vpmuludq  64(%rdx),%ymm10,%ymm15
	vpmuludq  32(%rdx),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  0(%rdx),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,352(%rsp)
	vpaddq    64(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,640(%rsp)

	vpmuludq  96(%rdx),%ymm10,%ymm15
	vpmuludq  64(%rdx),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  32(%rdx),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  0(%rdx),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,384(%rsp)
	vpaddq    96(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,672(%rsp)

	vpmuludq  128(%rdx),%ymm10,%ymm15
	vpmuludq  96(%rdx),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  64(%rdx),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  32(%rdx),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   128(%rsi),%ymm10
	vpmuludq  0(%rdx),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,416(%rsp)
	vpaddq    128(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,704(%rsp)

	vpmuludq  128(%rdx),%ymm11,%ymm15
	vpmuludq  96(%rdx),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  64(%rdx),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  32(%rdx),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,448(%rsp)
	vpaddq    160(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,736(%rsp)

	vpmuludq  128(%rdx),%ymm12,%ymm15
	vpmuludq  96(%rdx),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  64(%rdx),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,480(%rsp)
	vpaddq    192(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,768(%rsp)

	vpmuludq  128(%rdx),%ymm13,%ymm15
	vpmuludq  96(%rdx),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,512(%rsp)
	vpaddq    224(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,800(%rsp)

	vpmuludq  128(%rdx),%ymm10,%ymm15
	vmovdqa   %ymm15,544(%rsp)
	vpaddq    256(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,832(%rsp)

	vpmuludq  %ymm5,%ymm0,%ymm15
	vmovdqa   %ymm15,864(%rsp)

	vpmuludq  %ymm6,%ymm0,%ymm15
	vpmuludq  %ymm5,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm10

	vpmuludq  %ymm7,%ymm0,%ymm15
	vpmuludq  %ymm6,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm11

	vpmuludq  %ymm8,%ymm0,%ymm15
	vpmuludq  %ymm7,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm6,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm12

	vpmuludq  %ymm9,%ymm0,%ymm15
	vpmuludq  %ymm8,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm7,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm6,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm5,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm13

	vpmuludq  %ymm9,%ymm1,%ymm15
	vpmuludq  %ymm8,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm7,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm6,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm0

	vpmuludq  %ymm9,%ymm2,%ymm15
	vpmuludq  %ymm8,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  %ymm7,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm1

	vpmuludq  %ymm9,%ymm3,%ymm15
	vpmuludq  %ymm8,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm2

	vpmuludq  %ymm9,%ymm4,%ymm3

	vmovdqa   864(%rsp),%ymm9

	vpsubq    576(%rsp),%ymm9,%ymm9
	vpsubq    608(%rsp),%ymm10,%ymm10
	vpsubq    640(%rsp),%ymm11,%ymm11
	vpsubq    672(%rsp),%ymm12,%ymm12
	vpsubq    704(%rsp),%ymm13,%ymm13
	vpsubq    736(%rsp),%ymm0,%ymm0
	vpsubq    768(%rsp),%ymm1,%ymm1
	vpsubq    800(%rsp),%ymm2,%ymm2
	vpsubq    832(%rsp),%ymm3,%ymm3

	vpaddq    448(%rsp),%ymm9,%ymm9
	vpaddq    480(%rsp),%ymm10,%ymm10
	vpaddq    512(%rsp),%ymm11,%ymm11
	vpaddq    544(%rsp),%ymm12,%ymm12
	vpaddq    0(%rsp),%ymm0,%ymm0
	vpaddq    32(%rsp),%ymm1,%ymm1
	vpaddq    64(%rsp),%ymm2,%ymm2
	vpaddq    96(%rsp),%ymm3,%ymm3

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26(%rip),%ymm0,%ymm0
	vpsllq    $36,%ymm0,%ymm14
	vpaddq    288(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm0,%ymm0
	vpaddq    %ymm14,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26(%rip),%ymm1,%ymm1
	vpsllq    $36,%ymm1,%ymm14
	vpaddq    320(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm1,%ymm1
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26(%rip),%ymm2,%ymm2
	vpsllq    $36,%ymm2,%ymm14
	vpaddq    352(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm2,%ymm2
	vpaddq    %ymm14,%ymm2,%ymm2

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    128(%rsp),%ymm14,%ymm4
	vpand     vecmask26(%rip),%ymm3,%ymm3
	vpsllq    $36,%ymm3,%ymm14
	vpaddq    384(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm3,%ymm3
	vpaddq    %ymm14,%ymm3,%ymm3

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    160(%rsp),%ymm14,%ymm5
	vpand     vecmask26(%rip),%ymm4,%ymm4
	vpsllq    $36,%ymm4,%ymm14
	vpaddq    416(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm4,%ymm4
	vpaddq    %ymm14,%ymm4,%ymm4

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    192(%rsp),%ymm14,%ymm6
	vpand     vecmask26(%rip),%ymm5,%ymm5
	vpsllq    $36,%ymm5,%ymm14
	vpaddq    %ymm9,%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm5,%ymm5
	vpaddq    %ymm14,%ymm5,%ymm5

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    224(%rsp),%ymm14,%ymm7
	vpand     vecmask26(%rip),%ymm6,%ymm6
	vpsllq    $36,%ymm6,%ymm14
	vpaddq    %ymm10,%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm6,%ymm6
	vpaddq    %ymm14,%ymm6,%ymm6

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    256(%rsp),%ymm14,%ymm8
	vpand     vecmask26(%rip),%ymm7,%ymm7
	vpsllq    $36,%ymm7,%ymm14
	vpaddq    %ymm11,%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm7,%ymm7
	vpaddq    %ymm14,%ymm7,%ymm7

	vpsrlq    $26,%ymm8,%ymm9
	vpand     vecmask26(%rip),%ymm8,%ymm8
	vpsllq    $36,%ymm8,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm8,%ymm8
	vpaddq    %ymm14,%ymm8,%ymm8

	vpsllq    $36,%ymm9,%ymm14
	vpaddq    %ymm13,%ymm14,%ymm14
	vpmuludq  vec977x2e4(%rip),%ymm9,%ymm9
	vpaddq    %ymm14,%ymm9,%ymm9

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26(%rip),%ymm5,%ymm5

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26(%rip),%ymm0,%ymm0

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm7,%ymm7
	vpand     vecmask26(%rip),%ymm6,%ymm6

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26(%rip),%ymm1,%ymm1

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm8,%ymm8
	vpand     vecmask26(%rip),%ymm7,%ymm7

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26(%rip),%ymm2,%ymm2

	vpsrlq    $26,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26(%rip),%ymm8,%ymm8

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26(%rip),%ymm3,%ymm3

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26(%rip),%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22(%rip),%ymm9,%ymm9

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977(%rip),%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977(%rip),%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26(%rip),%ymm4,%ymm4

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26(%rip),%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26(%rip),%ymm1,%ymm1

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26(%rip),%ymm5,%ymm5

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

	movq 	  %r11,%rsp

	ret
	
