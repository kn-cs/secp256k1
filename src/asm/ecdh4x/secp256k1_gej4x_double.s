/***********************************************************************
 * Copyright (c) 2022 Kaushik Nath                                     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

        .p2align 5
        .globl secp256k1_gej4x_double
secp256k1_gej4x_double:

	movq 	  %rsp,%r11
	andq 	  $-32,%rsp
	subq 	  $2176,%rsp

        vmovdqa   960(%rsi),%ymm0
        vmovdqa   %ymm0,960(%rdi)
        
	vmovdqa   320(%rsi),%ymm10
	vmovdqa   352(%rsi),%ymm11
	vmovdqa   384(%rsi),%ymm12
	vmovdqa   416(%rsi),%ymm13
	vmovdqa   480(%rsi),%ymm0
	vmovdqa   512(%rsi),%ymm1
	vmovdqa   544(%rsi),%ymm2
	vmovdqa   576(%rsi),%ymm3
	vmovdqa   608(%rsi),%ymm4
	
	vmovdqa   800(%rsi),%ymm5
	vmovdqa   832(%rsi),%ymm6
	vmovdqa   864(%rsi),%ymm7
	vmovdqa   896(%rsi),%ymm8
	vmovdqa   928(%rsi),%ymm9

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
	vpaddq    448(%rsi),%ymm4,%ymm4

	vpaddq    640(%rsi),%ymm5,%ymm5
	vpaddq    672(%rsi),%ymm6,%ymm6
	vpaddq    704(%rsi),%ymm7,%ymm7
	vpaddq    736(%rsi),%ymm8,%ymm8
	vpaddq    768(%rsi),%ymm9,%ymm9

	vpmuludq  640(%rsi),%ymm10,%ymm15
	vmovdqa   %ymm15,288(%rsp)
	vpaddq    0(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,576(%rsp)

	vpmuludq  672(%rsi),%ymm10,%ymm15
	vpmuludq  640(%rsi),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,320(%rsp)
	vpaddq    32(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,608(%rsp)

	vpmuludq  704(%rsi),%ymm10,%ymm15
	vpmuludq  672(%rsi),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  640(%rsi),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,352(%rsp)
	vpaddq    64(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,640(%rsp)

	vpmuludq  736(%rsi),%ymm10,%ymm15
	vpmuludq  704(%rsi),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  672(%rsi),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  640(%rsi),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,384(%rsp)
	vpaddq    96(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,672(%rsp)

	vpmuludq  768(%rsi),%ymm10,%ymm15
	vpmuludq  736(%rsi),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  704(%rsi),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  672(%rsi),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   448(%rsi),%ymm10
	vpmuludq  640(%rsi),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,416(%rsp)
	vpaddq    128(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,704(%rsp)

	vpmuludq  768(%rsi),%ymm11,%ymm15
	vpmuludq  736(%rsi),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  704(%rsi),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  672(%rsi),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,448(%rsp)
	vpaddq    160(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,736(%rsp)

	vpmuludq  768(%rsi),%ymm12,%ymm15
	vpmuludq  736(%rsi),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  704(%rsi),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,480(%rsp)
	vpaddq    192(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,768(%rsp)

	vpmuludq  768(%rsi),%ymm13,%ymm15
	vpmuludq  736(%rsi),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,512(%rsp)
	vpaddq    224(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,800(%rsp)

	vpmuludq  768(%rsi),%ymm10,%ymm15
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
	vpand     vecmask26,%ymm0,%ymm0
	vpsllq    $36,%ymm0,%ymm14
	vpaddq    288(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm0,%ymm0
	vpaddq    %ymm14,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1
	vpsllq    $36,%ymm1,%ymm14
	vpaddq    320(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm1,%ymm1
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2
	vpsllq    $36,%ymm2,%ymm14
	vpaddq    352(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm2,%ymm2
	vpaddq    %ymm14,%ymm2,%ymm2

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    128(%rsp),%ymm14,%ymm4
	vpand     vecmask26,%ymm3,%ymm3
	vpsllq    $36,%ymm3,%ymm14
	vpaddq    384(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm3,%ymm3
	vpaddq    %ymm14,%ymm3,%ymm3

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    160(%rsp),%ymm14,%ymm5
	vpand     vecmask26,%ymm4,%ymm4
	vpsllq    $36,%ymm4,%ymm14
	vpaddq    416(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm4,%ymm4
	vpaddq    %ymm14,%ymm4,%ymm4

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    192(%rsp),%ymm14,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	vpsllq    $36,%ymm5,%ymm14
	vpaddq    %ymm9,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm5,%ymm5
	vpaddq    %ymm14,%ymm5,%ymm5

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    224(%rsp),%ymm14,%ymm7
	vpand     vecmask26,%ymm6,%ymm6
	vpsllq    $36,%ymm6,%ymm14
	vpaddq    %ymm10,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm6,%ymm6
	vpaddq    %ymm14,%ymm6,%ymm6

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    256(%rsp),%ymm14,%ymm8
	vpand     vecmask26,%ymm7,%ymm7
	vpsllq    $36,%ymm7,%ymm14
	vpaddq    %ymm11,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm7,%ymm7
	vpaddq    %ymm14,%ymm7,%ymm7

	vpsrlq    $26,%ymm8,%ymm9
	vpand     vecmask26,%ymm8,%ymm8
	vpsllq    $36,%ymm8,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm8,%ymm8
	vpaddq    %ymm14,%ymm8,%ymm8

	vpsllq    $36,%ymm9,%ymm14
	vpaddq    %ymm13,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm9,%ymm9
	vpaddq    %ymm14,%ymm9,%ymm9

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm7,%ymm7
	vpand     vecmask26,%ymm6,%ymm6

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm8,%ymm8
	vpand     vecmask26,%ymm7,%ymm7

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2

	vpsrlq    $26,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm8,%ymm8

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26,%ymm3,%ymm3

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26,%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22,%ymm9,%ymm9

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977,%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm4,%ymm4

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	
	vpaddq    %ymm0,%ymm0,%ymm0
	vpaddq    %ymm1,%ymm1,%ymm1
	vpaddq    %ymm2,%ymm2,%ymm2
	vpaddq    %ymm3,%ymm3,%ymm3
	vpaddq    %ymm4,%ymm4,%ymm4
	vpaddq    %ymm5,%ymm5,%ymm5
	vpaddq    %ymm6,%ymm6,%ymm6
	vpaddq    %ymm7,%ymm7,%ymm7
	vpaddq    %ymm8,%ymm8,%ymm8
	vpaddq    %ymm9,%ymm9,%ymm9

	vmovdqa   %ymm0,640(%rdi)
	vmovdqa   %ymm1,672(%rdi)
	vmovdqa   %ymm2,704(%rdi)
	vmovdqa   %ymm3,736(%rdi)
	vmovdqa   %ymm4,768(%rdi)
	vmovdqa   %ymm5,800(%rdi)
	vmovdqa   %ymm6,832(%rdi)
	vmovdqa   %ymm7,864(%rdi)
	vmovdqa   %ymm8,896(%rdi)
	vmovdqa   %ymm9,928(%rdi)
	
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
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm13,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm13,%ymm7

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm10,%ymm8

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26,%ymm3,%ymm3

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26,%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22,%ymm9,%ymm9

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977,%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm4,%ymm4

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	
	vpaddq    %ymm0,%ymm0,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpaddq    %ymm1,%ymm1,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1	
	vpaddq    %ymm2,%ymm2,%ymm10
	vpaddq    %ymm10,%ymm2,%ymm2
	vpaddq    %ymm3,%ymm3,%ymm10
	vpaddq    %ymm10,%ymm3,%ymm3	
	vpaddq    %ymm4,%ymm4,%ymm10
	vpaddq    %ymm10,%ymm4,%ymm4	
	vpaddq    %ymm5,%ymm5,%ymm10
	vpaddq    %ymm10,%ymm5,%ymm5	
	vpaddq    %ymm6,%ymm6,%ymm10
	vpaddq    %ymm10,%ymm6,%ymm6	
	vpaddq    %ymm7,%ymm7,%ymm10
	vpaddq    %ymm10,%ymm7,%ymm7	
	vpaddq    %ymm8,%ymm8,%ymm10
	vpaddq    %ymm10,%ymm8,%ymm8	
	vpaddq    %ymm9,%ymm9,%ymm10
	vpaddq    %ymm10,%ymm9,%ymm9
	
	vmovdqa   %ymm0,896(%rsp)
	vmovdqa   %ymm1,928(%rsp)
	vmovdqa   %ymm2,960(%rsp)
	vmovdqa   %ymm3,992(%rsp)
	vmovdqa   %ymm4,1024(%rsp)
	vmovdqa   %ymm5,1056(%rsp)
	vmovdqa   %ymm6,1088(%rsp)
	vmovdqa   %ymm7,1120(%rsp)
	vmovdqa   %ymm8,1152(%rsp)
	vmovdqa   %ymm9,1184(%rsp)	
	
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
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm13,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm13,%ymm7

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm10,%ymm8

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26,%ymm3,%ymm3

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26,%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22,%ymm9,%ymm9

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977,%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm4,%ymm4

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5

	vmovdqa   %ymm0,1216(%rsp)
	vmovdqa   %ymm1,1248(%rsp)
	vmovdqa   %ymm2,1280(%rsp)
	vmovdqa   %ymm3,1312(%rsp)
	vmovdqa   %ymm4,1344(%rsp)
	vmovdqa   %ymm5,1376(%rsp)
	vmovdqa   %ymm6,1408(%rsp)
	vmovdqa   %ymm7,1440(%rsp)
	vmovdqa   %ymm8,1472(%rsp)
	vmovdqa   %ymm9,1504(%rsp)
	
	vmovdqa   320(%rsi),%ymm0
	vmovdqa   352(%rsi),%ymm1
	vmovdqa   384(%rsi),%ymm2
	vmovdqa   416(%rsi),%ymm3
	vmovdqa   448(%rsi),%ymm4
	vmovdqa   480(%rsi),%ymm5
	vmovdqa   512(%rsi),%ymm6
	vmovdqa   544(%rsi),%ymm7
	vmovdqa   576(%rsi),%ymm8
	vmovdqa   608(%rsi),%ymm9
		
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
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm13,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm13,%ymm7

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm10,%ymm8

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26,%ymm3,%ymm3

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26,%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22,%ymm9,%ymm9

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977,%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm4,%ymm4

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	
	vpaddq    %ymm0,%ymm0,%ymm0
	vpaddq    %ymm1,%ymm1,%ymm1
	vpaddq    %ymm2,%ymm2,%ymm2
	vpaddq    %ymm3,%ymm3,%ymm3
	vpaddq    %ymm4,%ymm4,%ymm4
	vpaddq    %ymm5,%ymm5,%ymm5
	vpaddq    %ymm6,%ymm6,%ymm6
	vpaddq    %ymm7,%ymm7,%ymm7
	vpaddq    %ymm8,%ymm8,%ymm8
	vpaddq    %ymm9,%ymm9,%ymm9
	
	vmovdqa   %ymm0,1536(%rsp)
	vmovdqa   %ymm1,1568(%rsp)
	vmovdqa   %ymm2,1600(%rsp)
	vmovdqa   %ymm3,1632(%rsp)
	vmovdqa   %ymm4,1664(%rsp)
	vmovdqa   %ymm5,1696(%rsp)
	vmovdqa   %ymm6,1728(%rsp)
	vmovdqa   %ymm7,1760(%rsp)
	vmovdqa   %ymm8,1792(%rsp)
	vmovdqa   %ymm9,1824(%rsp)	
	
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
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm13,%ymm14
	vpaddq    %ymm14,%ymm10,%ymm10
	vpand     vecmask26,%ymm13,%ymm7

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2

	vpsrlq    $26,%ymm10,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm10,%ymm8

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26,%ymm3,%ymm3

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26,%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22,%ymm9,%ymm9

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977,%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm4,%ymm4

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	
	vpaddq    %ymm0,%ymm0,%ymm0
	vpaddq    %ymm1,%ymm1,%ymm1
	vpaddq    %ymm2,%ymm2,%ymm2
	vpaddq    %ymm3,%ymm3,%ymm3
	vpaddq    %ymm4,%ymm4,%ymm4
	vpaddq    %ymm5,%ymm5,%ymm5
	vpaddq    %ymm6,%ymm6,%ymm6
	vpaddq    %ymm7,%ymm7,%ymm7
	vpaddq    %ymm8,%ymm8,%ymm8
	vpaddq    %ymm9,%ymm9,%ymm9
	
	vmovdqa   %ymm0,1856(%rsp)
	vmovdqa   %ymm1,1888(%rsp)
	vmovdqa   %ymm2,1920(%rsp)
	vmovdqa   %ymm3,1952(%rsp)
	vmovdqa   %ymm4,1984(%rsp)
	vmovdqa   %ymm5,2016(%rsp)
	vmovdqa   %ymm6,2048(%rsp)
	vmovdqa   %ymm7,2080(%rsp)
	vmovdqa   %ymm8,2112(%rsp)
	vmovdqa   %ymm9,2144(%rsp)
	
	vmovdqa   1536(%rsp),%ymm10
	vmovdqa   1568(%rsp),%ymm11
	vmovdqa   1600(%rsp),%ymm12
	vmovdqa   1632(%rsp),%ymm13
	vmovdqa   1696(%rsp),%ymm0
	vmovdqa   1728(%rsp),%ymm1
	vmovdqa   1760(%rsp),%ymm2
	vmovdqa   1792(%rsp),%ymm3
	vmovdqa   1824(%rsp),%ymm4
	
	vmovdqa   160(%rsi),%ymm5
	vmovdqa   192(%rsi),%ymm6
	vmovdqa   224(%rsi),%ymm7
	vmovdqa   256(%rsi),%ymm8
	vmovdqa   288(%rsi),%ymm9

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
	vpaddq    1664(%rsp),%ymm4,%ymm4

	vpaddq    0(%rsi),%ymm5,%ymm5
	vpaddq    32(%rsi),%ymm6,%ymm6
	vpaddq    64(%rsi),%ymm7,%ymm7
	vpaddq    96(%rsi),%ymm8,%ymm8
	vpaddq    128(%rsi),%ymm9,%ymm9

	vpmuludq  0(%rsi),%ymm10,%ymm15
	vmovdqa   %ymm15,288(%rsp)
	vpaddq    0(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,576(%rsp)

	vpmuludq  32(%rsi),%ymm10,%ymm15
	vpmuludq  0(%rsi),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,320(%rsp)
	vpaddq    32(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,608(%rsp)

	vpmuludq  64(%rsi),%ymm10,%ymm15
	vpmuludq  32(%rsi),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  0(%rsi),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,352(%rsp)
	vpaddq    64(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,640(%rsp)

	vpmuludq  96(%rsi),%ymm10,%ymm15
	vpmuludq  64(%rsi),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  32(%rsi),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  0(%rsi),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,384(%rsp)
	vpaddq    96(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,672(%rsp)

	vpmuludq  128(%rsi),%ymm10,%ymm15
	vpmuludq  96(%rsi),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  64(%rsi),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  32(%rsi),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   1664(%rsp),%ymm10
	vpmuludq  0(%rsi),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,416(%rsp)
	vpaddq    128(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,704(%rsp)

	vpmuludq  128(%rsi),%ymm11,%ymm15
	vpmuludq  96(%rsi),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  64(%rsi),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  32(%rsi),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,448(%rsp)
	vpaddq    160(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,736(%rsp)

	vpmuludq  128(%rsi),%ymm12,%ymm15
	vpmuludq  96(%rsi),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  64(%rsi),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,480(%rsp)
	vpaddq    192(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,768(%rsp)

	vpmuludq  128(%rsi),%ymm13,%ymm15
	vpmuludq  96(%rsi),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,512(%rsp)
	vpaddq    224(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,800(%rsp)

	vpmuludq  128(%rsi),%ymm10,%ymm15
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
	vpand     vecmask26,%ymm0,%ymm0
	vpsllq    $36,%ymm0,%ymm14
	vpaddq    288(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm0,%ymm0
	vpaddq    %ymm14,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1
	vpsllq    $36,%ymm1,%ymm14
	vpaddq    320(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm1,%ymm1
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2
	vpsllq    $36,%ymm2,%ymm14
	vpaddq    352(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm2,%ymm2
	vpaddq    %ymm14,%ymm2,%ymm2

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    128(%rsp),%ymm14,%ymm4
	vpand     vecmask26,%ymm3,%ymm3
	vpsllq    $36,%ymm3,%ymm14
	vpaddq    384(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm3,%ymm3
	vpaddq    %ymm14,%ymm3,%ymm3

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    160(%rsp),%ymm14,%ymm5
	vpand     vecmask26,%ymm4,%ymm4
	vpsllq    $36,%ymm4,%ymm14
	vpaddq    416(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm4,%ymm4
	vpaddq    %ymm14,%ymm4,%ymm4

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    192(%rsp),%ymm14,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	vpsllq    $36,%ymm5,%ymm14
	vpaddq    %ymm9,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm5,%ymm5
	vpaddq    %ymm14,%ymm5,%ymm5

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    224(%rsp),%ymm14,%ymm7
	vpand     vecmask26,%ymm6,%ymm6
	vpsllq    $36,%ymm6,%ymm14
	vpaddq    %ymm10,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm6,%ymm6
	vpaddq    %ymm14,%ymm6,%ymm6

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    256(%rsp),%ymm14,%ymm8
	vpand     vecmask26,%ymm7,%ymm7
	vpsllq    $36,%ymm7,%ymm14
	vpaddq    %ymm11,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm7,%ymm7
	vpaddq    %ymm14,%ymm7,%ymm7

	vpsrlq    $26,%ymm8,%ymm9
	vpand     vecmask26,%ymm8,%ymm8
	vpsllq    $36,%ymm8,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm8,%ymm8
	vpaddq    %ymm14,%ymm8,%ymm8

	vpsllq    $36,%ymm9,%ymm14
	vpaddq    %ymm13,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm9,%ymm9
	vpaddq    %ymm14,%ymm9,%ymm9

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm7,%ymm7
	vpand     vecmask26,%ymm6,%ymm6

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm8,%ymm8
	vpand     vecmask26,%ymm7,%ymm7

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2

	vpsrlq    $26,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm8,%ymm8

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26,%ymm3,%ymm3

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26,%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22,%ymm9,%ymm9

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977,%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm4,%ymm4

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	
	vmovdqa   %ymm0,1536(%rsp)
	vmovdqa   %ymm1,1568(%rsp)
	vmovdqa   %ymm2,1600(%rsp)
	vmovdqa   %ymm3,1632(%rsp)
	vmovdqa   %ymm4,1664(%rsp)
	vmovdqa   %ymm5,1696(%rsp)
	vmovdqa   %ymm6,1728(%rsp)
	vmovdqa   %ymm7,1760(%rsp)
	vmovdqa   %ymm8,1792(%rsp)
	vmovdqa   %ymm9,1824(%rsp)
	
	vpsllq    $2,%ymm0,%ymm0
	vpsllq    $2,%ymm1,%ymm1
	vpsllq    $2,%ymm2,%ymm2
	vpsllq    $2,%ymm3,%ymm3
	vpsllq    $2,%ymm4,%ymm4
	vpsllq    $2,%ymm5,%ymm5
	vpsllq    $2,%ymm6,%ymm6
	vpsllq    $2,%ymm7,%ymm7
	vpsllq    $2,%ymm8,%ymm8
	vpsllq    $2,%ymm9,%ymm9
	
	vmovdqa   1216(%rsp),%ymm10
	vpaddq    _8p0,%ymm10,%ymm10
	vpsubq    %ymm0,%ymm10,%ymm10
	vmovdqa   %ymm10,0(%rdi)

	vmovdqa   1248(%rsp),%ymm10
	vpaddq    _8p1,%ymm10,%ymm10
	vpsubq    %ymm1,%ymm10,%ymm10
	vmovdqa   %ymm10,32(%rdi)
	
	vmovdqa   1280(%rsp),%ymm10
	vpaddq    _8p2_8,%ymm10,%ymm10
	vpsubq    %ymm2,%ymm10,%ymm10
	vmovdqa   %ymm10,64(%rdi)

	vmovdqa   1312(%rsp),%ymm10
	vpaddq    _8p2_8,%ymm10,%ymm10
	vpsubq    %ymm3,%ymm10,%ymm10
	vmovdqa   %ymm10,96(%rdi)

	vmovdqa   1344(%rsp),%ymm10
	vpaddq    _8p2_8,%ymm10,%ymm10
	vpsubq    %ymm4,%ymm10,%ymm10
	vmovdqa   %ymm10,128(%rdi)
	
	vmovdqa   1376(%rsp),%ymm10
	vpaddq    _8p2_8,%ymm10,%ymm10
	vpsubq    %ymm5,%ymm10,%ymm10
	vmovdqa   %ymm10,160(%rdi)
	
	vmovdqa   1408(%rsp),%ymm10
	vpaddq    _8p2_8,%ymm10,%ymm10
	vpsubq    %ymm6,%ymm10,%ymm10
	vmovdqa   %ymm10,192(%rdi)
	
	vmovdqa   1440(%rsp),%ymm10
	vpaddq    _8p2_8,%ymm10,%ymm10
	vpsubq    %ymm7,%ymm10,%ymm10
	vmovdqa   %ymm10,224(%rdi)
	
	vmovdqa   1472(%rsp),%ymm10
	vpaddq    _8p2_8,%ymm10,%ymm10
	vpsubq    %ymm8,%ymm10,%ymm10
	vmovdqa   %ymm10,256(%rdi)
	
	vmovdqa   1504(%rsp),%ymm10
	vpaddq    _8p9,%ymm10,%ymm10
	vpsubq    %ymm9,%ymm10,%ymm10
	vmovdqa   %ymm10,288(%rdi)
	
	vmovdqa   1536(%rsp),%ymm0
	vmovdqa   1568(%rsp),%ymm1
	vmovdqa   1600(%rsp),%ymm2
	vmovdqa   1632(%rsp),%ymm3
	vmovdqa   1664(%rsp),%ymm4
	vmovdqa   1696(%rsp),%ymm5
	vmovdqa   1728(%rsp),%ymm6
	vmovdqa   1760(%rsp),%ymm7
	vmovdqa   1792(%rsp),%ymm8
	vmovdqa   1824(%rsp),%ymm9
	
	vpsllq    $2,%ymm0,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpsllq    $2,%ymm1,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpsllq    $2,%ymm2,%ymm10
	vpaddq    %ymm10,%ymm2,%ymm2	
	vpsllq    $2,%ymm3,%ymm10
	vpaddq    %ymm10,%ymm3,%ymm3
	vpsllq    $2,%ymm4,%ymm4
	vpaddq    %ymm10,%ymm4,%ymm4
	vpsllq    $2,%ymm5,%ymm10
	vpaddq    %ymm10,%ymm5,%ymm5	
	vpsllq    $2,%ymm6,%ymm10
	vpaddq    %ymm10,%ymm6,%ymm6	
	vpsllq    $2,%ymm7,%ymm10
	vpaddq    %ymm10,%ymm7,%ymm7	
	vpsllq    $2,%ymm8,%ymm10
	vpaddq    %ymm10,%ymm8,%ymm8
	vpsllq    $2,%ymm9,%ymm10
	vpaddq    %ymm10,%ymm9,%ymm9
	
	vpaddq    _2p0,%ymm0,%ymm10
	vpaddq    _2p1,%ymm1,%ymm11
	vpaddq    _2p2_8,%ymm2,%ymm12
	vpaddq    _2p2_8,%ymm3,%ymm13
	vpaddq    _2p2_8,%ymm4,%ymm14
	vpaddq    _2p2_8,%ymm5,%ymm0
	vpaddq    _2p2_8,%ymm6,%ymm1
	vpaddq    _2p2_8,%ymm7,%ymm2
	vpaddq    _2p2_8,%ymm8,%ymm3
	vpaddq    _2p9,%ymm9,%ymm4
	
	vpsubq    1216(%rsp),%ymm10,%ymm10
	vpsubq    1248(%rsp),%ymm11,%ymm11
	vpsubq    1280(%rsp),%ymm12,%ymm12
	vpsubq    1312(%rsp),%ymm13,%ymm13
	vpsubq    1344(%rsp),%ymm14,%ymm14
	vpsubq    1376(%rsp),%ymm0,%ymm0
	vpsubq    1408(%rsp),%ymm1,%ymm1
	vpsubq    1440(%rsp),%ymm2,%ymm2
	vpsubq    1472(%rsp),%ymm3,%ymm3
	vpsubq    1504(%rsp),%ymm4,%ymm4
	
	vmovdqa   %ymm14,1664(%rsp)
	vmovdqa   1056(%rsp),%ymm5
	vmovdqa   1088(%rsp),%ymm6
	vmovdqa   1120(%rsp),%ymm7
	vmovdqa   1152(%rsp),%ymm8
	vmovdqa   1184(%rsp),%ymm9

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
	vpaddq    1664(%rsp),%ymm4,%ymm4

	vpaddq    896(%rsp),%ymm5,%ymm5
	vpaddq    928(%rsp),%ymm6,%ymm6
	vpaddq    960(%rsp),%ymm7,%ymm7
	vpaddq    992(%rsp),%ymm8,%ymm8
	vpaddq    1024(%rsp),%ymm9,%ymm9

	vpmuludq  896(%rsp),%ymm10,%ymm15
	vmovdqa   %ymm15,288(%rsp)
	vpaddq    0(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,576(%rsp)

	vpmuludq  928(%rsp),%ymm10,%ymm15
	vpmuludq  896(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,320(%rsp)
	vpaddq    32(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,608(%rsp)

	vpmuludq  960(%rsp),%ymm10,%ymm15
	vpmuludq  928(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  896(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,352(%rsp)
	vpaddq    64(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,640(%rsp)

	vpmuludq  992(%rsp),%ymm10,%ymm15
	vpmuludq  960(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  928(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  896(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,384(%rsp)
	vpaddq    96(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,672(%rsp)

	vpmuludq  1024(%rsp),%ymm10,%ymm15
	vpmuludq  992(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  960(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  928(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   1664(%rsp),%ymm10
	vpmuludq  896(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,416(%rsp)
	vpaddq    128(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,704(%rsp)

	vpmuludq  1024(%rsp),%ymm11,%ymm15
	vpmuludq  992(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  960(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  928(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,448(%rsp)
	vpaddq    160(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,736(%rsp)

	vpmuludq  1024(%rsp),%ymm12,%ymm15
	vpmuludq  992(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  960(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,480(%rsp)
	vpaddq    192(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,768(%rsp)

	vpmuludq  1024(%rsp),%ymm13,%ymm15
	vpmuludq  992(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,512(%rsp)
	vpaddq    224(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,800(%rsp)

	vpmuludq  1024(%rsp),%ymm10,%ymm15
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
	vpand     vecmask26,%ymm0,%ymm0
	vpsllq    $36,%ymm0,%ymm14
	vpaddq    288(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm0,%ymm0
	vpaddq    %ymm14,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1
	vpsllq    $36,%ymm1,%ymm14
	vpaddq    320(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm1,%ymm1
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2
	vpsllq    $36,%ymm2,%ymm14
	vpaddq    352(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm2,%ymm2
	vpaddq    %ymm14,%ymm2,%ymm2

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    128(%rsp),%ymm14,%ymm4
	vpand     vecmask26,%ymm3,%ymm3
	vpsllq    $36,%ymm3,%ymm14
	vpaddq    384(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm3,%ymm3
	vpaddq    %ymm14,%ymm3,%ymm3

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    160(%rsp),%ymm14,%ymm5
	vpand     vecmask26,%ymm4,%ymm4
	vpsllq    $36,%ymm4,%ymm14
	vpaddq    416(%rsp),%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm4,%ymm4
	vpaddq    %ymm14,%ymm4,%ymm4

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    192(%rsp),%ymm14,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	vpsllq    $36,%ymm5,%ymm14
	vpaddq    %ymm9,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm5,%ymm5
	vpaddq    %ymm14,%ymm5,%ymm5

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    224(%rsp),%ymm14,%ymm7
	vpand     vecmask26,%ymm6,%ymm6
	vpsllq    $36,%ymm6,%ymm14
	vpaddq    %ymm10,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm6,%ymm6
	vpaddq    %ymm14,%ymm6,%ymm6

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    256(%rsp),%ymm14,%ymm8
	vpand     vecmask26,%ymm7,%ymm7
	vpsllq    $36,%ymm7,%ymm14
	vpaddq    %ymm11,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm7,%ymm7
	vpaddq    %ymm14,%ymm7,%ymm7

	vpsrlq    $26,%ymm8,%ymm9
	vpand     vecmask26,%ymm8,%ymm8
	vpsllq    $36,%ymm8,%ymm14
	vpaddq    %ymm12,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm8,%ymm8
	vpaddq    %ymm14,%ymm8,%ymm8

	vpsllq    $36,%ymm9,%ymm14
	vpaddq    %ymm13,%ymm14,%ymm14
	vpmuludq  vec977x2e4,%ymm9,%ymm9
	vpaddq    %ymm14,%ymm9,%ymm9

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm7,%ymm7
	vpand     vecmask26,%ymm6,%ymm6

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm8,%ymm8
	vpand     vecmask26,%ymm7,%ymm7

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26,%ymm2,%ymm2

	vpsrlq    $26,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm8,%ymm8

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26,%ymm3,%ymm3

	vpsrlq    $22,%ymm9,%ymm14
	vpand     vecmask26,%ymm14,%ymm15
	vpsrlq    $26,%ymm14,%ymm14
	vpand     vecmask22,%ymm9,%ymm9

	vpsllq    $32,%ymm15,%ymm10
	vpaddq    %ymm10,%ymm0,%ymm0
	vpmuludq  vec977,%ymm15,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0

	vpsllq    $32,%ymm14,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1
	vpmuludq  vec977,%ymm14,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm4,%ymm4

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26,%ymm5,%ymm5
	
	vpaddq    _4p0,%ymm0,%ymm0
	vpaddq    _4p1,%ymm1,%ymm1
	vpaddq    _4p2_8,%ymm2,%ymm2
	vpaddq    _4p2_8,%ymm3,%ymm3
	vpaddq    _4p2_8,%ymm4,%ymm4
	vpaddq    _4p2_8,%ymm5,%ymm5
	vpaddq    _4p2_8,%ymm6,%ymm6
	vpaddq    _4p2_8,%ymm7,%ymm7
	vpaddq    _4p2_8,%ymm8,%ymm8
	vpaddq    _4p9,%ymm9,%ymm9
	
	vpsubq    1856(%rsp),%ymm0,%ymm0
	vpsubq    1888(%rsp),%ymm1,%ymm1
	vpsubq    1920(%rsp),%ymm2,%ymm2
	vpsubq    1952(%rsp),%ymm3,%ymm3
	vpsubq    1984(%rsp),%ymm4,%ymm4
	vpsubq    2016(%rsp),%ymm5,%ymm5
	vpsubq    2048(%rsp),%ymm6,%ymm6
	vpsubq    2080(%rsp),%ymm7,%ymm7
	vpsubq    2112(%rsp),%ymm8,%ymm8
	vpsubq    2144(%rsp),%ymm9,%ymm9
	
	vmovdqa   %ymm0,320(%rdi)
	vmovdqa   %ymm1,352(%rdi)
	vmovdqa   %ymm2,384(%rdi)
	vmovdqa   %ymm3,416(%rdi)
	vmovdqa   %ymm4,448(%rdi)
	vmovdqa   %ymm5,480(%rdi)
	vmovdqa   %ymm6,512(%rdi)
	vmovdqa   %ymm7,544(%rdi)
	vmovdqa   %ymm8,576(%rdi)
	vmovdqa   %ymm9,608(%rdi)
		
	movq 	  %r11,%rsp	
		
        ret
        
