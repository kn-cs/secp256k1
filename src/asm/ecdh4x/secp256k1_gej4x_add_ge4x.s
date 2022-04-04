/***********************************************************************
 * Copyright (c) 2022 Kaushik Nath                                     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

        .p2align 5
        .globl secp256k1_gej4x_add_ge4x
secp256k1_gej4x_add_ge4x:

	movq 	  %rsp,%r11
	andq 	  $-32,%rsp
	subq 	  $4448,%rsp
	
	vmovdqa   640(%rsi),%ymm0
	vmovdqa   672(%rsi),%ymm1
	vmovdqa   704(%rsi),%ymm2
	vmovdqa   736(%rsi),%ymm3
	vmovdqa   768(%rsi),%ymm4
	vmovdqa   800(%rsi),%ymm5
	vmovdqa   832(%rsi),%ymm6
	vmovdqa   864(%rsi),%ymm7
	vmovdqa   896(%rsi),%ymm8
	vmovdqa   928(%rsi),%ymm9	
		
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
	
	vmovdqa   %ymm10,896(%rsp)
	vmovdqa   %ymm11,928(%rsp)
	vmovdqa   %ymm12,960(%rsp)
	vmovdqa   %ymm13,992(%rsp)
	vmovdqa   %ymm14,1024(%rsp)
	vmovdqa   %ymm0,1056(%rsp)
	vmovdqa   %ymm1,1088(%rsp)
	vmovdqa   %ymm2,1120(%rsp)
	vmovdqa   %ymm3,1152(%rsp)
	vmovdqa   %ymm4,1184(%rsp)
		
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
	vpaddq    896(%rsp),%ymm4,%ymm4

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
	vmovdqa   896(%rsp),%ymm10
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
	
	vmovdqa   896(%rsp),%ymm10
	vmovdqa   928(%rsp),%ymm11
	vmovdqa   960(%rsp),%ymm12
	vmovdqa   992(%rsp),%ymm13
	vmovdqa   1024(%rsp),%ymm14
	vmovdqa   1056(%rsp),%ymm0
	vmovdqa   1088(%rsp),%ymm1
	vmovdqa   1120(%rsp),%ymm2
	vmovdqa   1152(%rsp),%ymm3
	vmovdqa   1184(%rsp),%ymm4
	
	vmovdqa   480(%rdx),%ymm5
	vmovdqa   512(%rdx),%ymm6
	vmovdqa   544(%rdx),%ymm7
	vmovdqa   576(%rdx),%ymm8
	vmovdqa   608(%rdx),%ymm9

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
	vpaddq    896(%rsp),%ymm4,%ymm4

	vpaddq    320(%rdx),%ymm5,%ymm5
	vpaddq    352(%rdx),%ymm6,%ymm6
	vpaddq    384(%rdx),%ymm7,%ymm7
	vpaddq    416(%rdx),%ymm8,%ymm8
	vpaddq    448(%rdx),%ymm9,%ymm9

	vpmuludq  320(%rdx),%ymm10,%ymm15
	vmovdqa   %ymm15,288(%rsp)
	vpaddq    0(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,576(%rsp)

	vpmuludq  352(%rdx),%ymm10,%ymm15
	vpmuludq  320(%rdx),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,320(%rsp)
	vpaddq    32(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,608(%rsp)

	vpmuludq  384(%rdx),%ymm10,%ymm15
	vpmuludq  352(%rdx),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  320(%rdx),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,352(%rsp)
	vpaddq    64(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,640(%rsp)

	vpmuludq  416(%rdx),%ymm10,%ymm15
	vpmuludq  384(%rdx),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  352(%rdx),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  320(%rdx),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,384(%rsp)
	vpaddq    96(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,672(%rsp)

	vpmuludq  448(%rdx),%ymm10,%ymm15
	vpmuludq  416(%rdx),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  384(%rdx),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  352(%rdx),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   896(%rsp),%ymm10
	vpmuludq  320(%rdx),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,416(%rsp)
	vpaddq    128(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,704(%rsp)

	vpmuludq  448(%rdx),%ymm11,%ymm15
	vpmuludq  416(%rdx),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  384(%rdx),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  352(%rdx),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,448(%rsp)
	vpaddq    160(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,736(%rsp)

	vpmuludq  448(%rdx),%ymm12,%ymm15
	vpmuludq  416(%rdx),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  384(%rdx),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,480(%rsp)
	vpaddq    192(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,768(%rsp)

	vpmuludq  448(%rdx),%ymm13,%ymm15
	vpmuludq  416(%rdx),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,512(%rsp)
	vpaddq    224(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,800(%rsp)

	vpmuludq  448(%rdx),%ymm10,%ymm15
	vmovdqa   %ymm15,544(%rsp)
	vpaddq    256(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,832(%rsp)

	vpmuludq  %ymm5,%ymm0,%ymm15
	vmovdqa   %ymm15,864(%rsp)

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
	vpaddq    %ymm14,%ymm2,%ymm12
	vpand     vecmask26,%ymm1,%ymm1

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm8,%ymm8
	vpand     vecmask26,%ymm7,%ymm2

	vpsrlq    $26,%ymm12,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm13
	vpand     vecmask26,%ymm12,%ymm12

	vpsrlq    $26,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26,%ymm8,%ymm3

	vpsrlq    $26,%ymm13,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm11
	vpand     vecmask26,%ymm13,%ymm13

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

	vpsrlq    $26,%ymm11,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26,%ymm11,%ymm14

	vpsrlq    $26,%ymm0,%ymm15
	vpaddq    %ymm15,%ymm1,%ymm1
	vpand     vecmask26,%ymm0,%ymm10

	vpsrlq    $26,%ymm1,%ymm15
	vpaddq    %ymm15,%ymm12,%ymm12
	vpand     vecmask26,%ymm1,%ymm11

	vpsrlq    $26,%ymm5,%ymm15
	vpaddq    %ymm15,%ymm6,%ymm1
	vpand     vecmask26,%ymm5,%ymm0
	
	vmovdqa   %ymm10,1536(%rsp)
	vmovdqa   %ymm11,1568(%rsp)
	vmovdqa   %ymm12,1600(%rsp)
	vmovdqa   %ymm13,1632(%rsp)
	vmovdqa   %ymm14,1664(%rsp)
	vmovdqa   %ymm0,1696(%rsp)
	vmovdqa   %ymm1,1728(%rsp)
	vmovdqa   %ymm2,1760(%rsp)
	vmovdqa   %ymm3,1792(%rsp)
	vmovdqa   %ymm4,1824(%rsp)
	
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
	vpaddq    1536(%rsp),%ymm4,%ymm4

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
	vmovdqa   1536(%rsp),%ymm10
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
	
	vpaddq    320(%rsi),%ymm0,%ymm0
	vpaddq    352(%rsi),%ymm1,%ymm1
	vpaddq    384(%rsi),%ymm2,%ymm2
	vpaddq    416(%rsi),%ymm3,%ymm3
	vpaddq    448(%rsi),%ymm4,%ymm4
	vpaddq    480(%rsi),%ymm5,%ymm5
	vpaddq    512(%rsi),%ymm6,%ymm6
	vpaddq    544(%rsi),%ymm7,%ymm7
	vpaddq    576(%rsi),%ymm8,%ymm8
	vpaddq    608(%rsi),%ymm9,%ymm9
	
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
	
	vmovdqa   1216(%rsp),%ymm0
	vmovdqa   1248(%rsp),%ymm1
	vmovdqa   1280(%rsp),%ymm2
	vmovdqa   1312(%rsp),%ymm3
	vmovdqa   1344(%rsp),%ymm4
	vmovdqa   1376(%rsp),%ymm5
	vmovdqa   1408(%rsp),%ymm6
	vmovdqa   1440(%rsp),%ymm7
	vmovdqa   1472(%rsp),%ymm8
	vmovdqa   1504(%rsp),%ymm9									
	
	vpaddq    0(%rsi),%ymm0,%ymm0
	vpaddq    32(%rsi),%ymm1,%ymm1
	vpaddq    64(%rsi),%ymm2,%ymm2
	vpaddq    96(%rsi),%ymm3,%ymm3
	vpaddq    128(%rsi),%ymm4,%ymm4
	vpaddq    160(%rsi),%ymm5,%ymm5
	vpaddq    192(%rsi),%ymm6,%ymm6
	vpaddq    224(%rsi),%ymm7,%ymm7
	vpaddq    256(%rsi),%ymm8,%ymm8
	vpaddq    288(%rsi),%ymm9,%ymm9

	vmovdqa   %ymm0,2176(%rsp)
	vmovdqa   %ymm1,2208(%rsp)
	vmovdqa   %ymm2,2240(%rsp)
	vmovdqa   %ymm3,2272(%rsp)
	vmovdqa   %ymm4,2304(%rsp)
	vmovdqa   %ymm5,2336(%rsp)
	vmovdqa   %ymm6,2368(%rsp)
	vmovdqa   %ymm7,2400(%rsp)
	vmovdqa   %ymm8,2432(%rsp)
	vmovdqa   %ymm9,2464(%rsp)
	
	vmovdqa   1216(%rsp),%ymm10
	vmovdqa   1248(%rsp),%ymm11
	vmovdqa   1280(%rsp),%ymm12
	vmovdqa   1312(%rsp),%ymm13
	vmovdqa   1344(%rsp),%ymm14
	vmovdqa   1376(%rsp),%ymm0
	vmovdqa   1408(%rsp),%ymm1
	vmovdqa   1440(%rsp),%ymm2
	vmovdqa   1472(%rsp),%ymm3
	vmovdqa   1504(%rsp),%ymm4
	
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
	vpaddq    1216(%rsp),%ymm4,%ymm4

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
	vmovdqa   1216(%rsp),%ymm10
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
				
	vmovdqa   %ymm0,2496(%rsp)
	vmovdqa   %ymm1,2528(%rsp)
	vmovdqa   %ymm2,2560(%rsp)
	vmovdqa   %ymm3,2592(%rsp)
	vmovdqa   %ymm4,2624(%rsp)
	vmovdqa   %ymm5,2656(%rsp)
	vmovdqa   %ymm6,2688(%rsp)
	vmovdqa   %ymm7,2720(%rsp)
	vmovdqa   %ymm8,2752(%rsp)
	vmovdqa   %ymm9,2784(%rsp)
	
	vmovdqa   2176(%rsp),%ymm0
	vmovdqa   2208(%rsp),%ymm1
	vmovdqa   2240(%rsp),%ymm2
	vmovdqa   2272(%rsp),%ymm3
	vmovdqa   2304(%rsp),%ymm4
	vmovdqa   2336(%rsp),%ymm5
	vmovdqa   2368(%rsp),%ymm6
	vmovdqa   2400(%rsp),%ymm7
	vmovdqa   2432(%rsp),%ymm8
	vmovdqa   2464(%rsp),%ymm9
		
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
	
	vpaddq    _2p0,%ymm0,%ymm0
	vpaddq    _2p1,%ymm1,%ymm1
	vpaddq    _2p2_8,%ymm2,%ymm2
	vpaddq    _2p2_8,%ymm3,%ymm3
	vpaddq    _2p2_8,%ymm4,%ymm4
	vpaddq    _2p2_8,%ymm5,%ymm5
	vpaddq    _2p2_8,%ymm6,%ymm6
	vpaddq    _2p2_8,%ymm7,%ymm7
	vpaddq    _2p2_8,%ymm8,%ymm8
	vpaddq    _2p9,%ymm9,%ymm9
	
	vpsubq    2496(%rsp),%ymm0,%ymm0
	vpsubq    2528(%rsp),%ymm1,%ymm1
	vpsubq    2560(%rsp),%ymm2,%ymm2
	vpsubq    2592(%rsp),%ymm3,%ymm3
	vpsubq    2624(%rsp),%ymm4,%ymm4
	vpsubq    2656(%rsp),%ymm5,%ymm5
	vpsubq    2688(%rsp),%ymm6,%ymm6
	vpsubq    2720(%rsp),%ymm7,%ymm7
	vpsubq    2752(%rsp),%ymm8,%ymm8
	vpsubq    2784(%rsp),%ymm9,%ymm9
	
	vmovdqa   %ymm0,2816(%rsp)
	vmovdqa   %ymm1,2848(%rsp)
	vmovdqa   %ymm2,2880(%rsp)
	vmovdqa   %ymm3,2912(%rsp)
	vmovdqa   %ymm4,2944(%rsp)
	vmovdqa   %ymm5,2976(%rsp)
	vmovdqa   %ymm6,3008(%rsp)
	vmovdqa   %ymm7,3040(%rsp)
	vmovdqa   %ymm8,3072(%rsp)
	vmovdqa   %ymm9,3104(%rsp)		
			
	vpsrlq    $22,%ymm9,%ymm10
	vpand     vecmask22,%ymm9,%ymm9
	
	vpmuludq  vec977,%ymm10,%ymm11
	vpaddq    %ymm11,%ymm0,%ymm0
	vpsllq    $6,%ymm10,%ymm11
	vpaddq    %ymm11,%ymm1,%ymm1
		
	vpsrlq    $26,%ymm0,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1	
	vpand     vecmask26,%ymm0,%ymm0
	vmovdqa   %ymm0,%ymm14
	vpxorq    vec976,%ymm0,%ymm15
	
	vpsrlq    $26,%ymm1,%ymm10
	vpaddq    %ymm10,%ymm2,%ymm2	
	vpand     vecmask26,%ymm1,%ymm1
	vpor      %ymm1,%ymm14,%ymm14
	vpxorq    vec64,%ymm1,%ymm13
	vpand     %ymm13,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm2,%ymm10
	vpaddq    %ymm10,%ymm3,%ymm3	
	vpand     vecmask26,%ymm2,%ymm2
	vpor      %ymm2,%ymm14,%ymm14
	vpand     %ymm2,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm3,%ymm10
	vpaddq    %ymm10,%ymm4,%ymm4	
	vpand     vecmask26,%ymm3,%ymm3
	vpor      %ymm3,%ymm14,%ymm14
	vpand     %ymm3,%ymm15,%ymm15	
	
	vpsrlq    $26,%ymm4,%ymm10
	vpaddq    %ymm10,%ymm5,%ymm5	
	vpand     vecmask26,%ymm4,%ymm4
	vpor      %ymm4,%ymm14,%ymm14
	vpand     %ymm4,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm5,%ymm10
	vpaddq    %ymm10,%ymm6,%ymm6	
	vpand     vecmask26,%ymm5,%ymm5
	vpor      %ymm5,%ymm14,%ymm14
	vpand     %ymm5,%ymm15,%ymm15

	vpsrlq    $26,%ymm6,%ymm10
	vpaddq    %ymm10,%ymm7,%ymm7	
	vpand     vecmask26,%ymm6,%ymm6
	vpor      %ymm6,%ymm14,%ymm14
	vpand     %ymm6,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm7,%ymm10
	vpaddq    %ymm10,%ymm8,%ymm8	
	vpand     vecmask26,%ymm7,%ymm7
	vpor      %ymm7,%ymm14,%ymm14
	vpand     %ymm7,%ymm15,%ymm15

	vpsrlq    $26,%ymm8,%ymm10
	vpaddq    %ymm10,%ymm9,%ymm9	
	vpand     vecmask26,%ymm8,%ymm8
	vpor      %ymm8,%ymm14,%ymm14
	vpand     %ymm8,%ymm15,%ymm15
	
	vpor      %ymm9,%ymm14,%ymm14
	vpxorq    vec2exp22x15,%ymm9,%ymm13	
	vpand     %ymm13,%ymm15,%ymm15
	
	vpcmpeqq  vec0,%ymm14,%ymm14
	vpcmpeqq  vec26,%ymm15,%ymm15
	vpor      %ymm14,%ymm15,%ymm12
	
	vmovdqa   1856(%rsp),%ymm0
	vmovdqa   1888(%rsp),%ymm1
	vmovdqa   1920(%rsp),%ymm2
	vmovdqa   1952(%rsp),%ymm3
	vmovdqa   1984(%rsp),%ymm4
	vmovdqa   2016(%rsp),%ymm5
	vmovdqa   2048(%rsp),%ymm6
	vmovdqa   2080(%rsp),%ymm7
	vmovdqa   2112(%rsp),%ymm8
	vmovdqa   2144(%rsp),%ymm9	
	
	vpsrlq    $22,%ymm9,%ymm10
	vpand     vecmask22,%ymm9,%ymm9
	
	vpmuludq  vec977,%ymm10,%ymm11
	vpaddq    %ymm11,%ymm0,%ymm0
	vpsllq    $6,%ymm10,%ymm11
	vpaddq    %ymm11,%ymm1,%ymm1
		
	vpsrlq    $26,%ymm0,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1	
	vpand     vecmask26,%ymm0,%ymm0
	vmovdqa   %ymm0,%ymm14
	vpxorq    vec976,%ymm0,%ymm15
	
	vpsrlq    $26,%ymm1,%ymm10
	vpaddq    %ymm10,%ymm2,%ymm2	
	vpand     vecmask26,%ymm1,%ymm1
	vpor      %ymm1,%ymm14,%ymm14
	vpxorq    vec64,%ymm1,%ymm13
	vpand     %ymm13,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm2,%ymm10
	vpaddq    %ymm10,%ymm3,%ymm3	
	vpand     vecmask26,%ymm2,%ymm2
	vpor      %ymm2,%ymm14,%ymm14
	vpand     %ymm2,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm3,%ymm10
	vpaddq    %ymm10,%ymm4,%ymm4	
	vpand     vecmask26,%ymm3,%ymm3
	vpor      %ymm3,%ymm14,%ymm14
	vpand     %ymm3,%ymm15,%ymm15	
	
	vpsrlq    $26,%ymm4,%ymm10
	vpaddq    %ymm10,%ymm5,%ymm5	
	vpand     vecmask26,%ymm4,%ymm4
	vpor      %ymm4,%ymm14,%ymm14
	vpand     %ymm4,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm5,%ymm10
	vpaddq    %ymm10,%ymm6,%ymm6	
	vpand     vecmask26,%ymm5,%ymm5
	vpor      %ymm5,%ymm14,%ymm14
	vpand     %ymm5,%ymm15,%ymm15

	vpsrlq    $26,%ymm6,%ymm10
	vpaddq    %ymm10,%ymm7,%ymm7	
	vpand     vecmask26,%ymm6,%ymm6
	vpor      %ymm6,%ymm14,%ymm14
	vpand     %ymm6,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm7,%ymm10
	vpaddq    %ymm10,%ymm8,%ymm8	
	vpand     vecmask26,%ymm7,%ymm7
	vpor      %ymm7,%ymm14,%ymm14
	vpand     %ymm7,%ymm15,%ymm15

	vpsrlq    $26,%ymm8,%ymm10
	vpaddq    %ymm10,%ymm9,%ymm9	
	vpand     vecmask26,%ymm8,%ymm8
	vpor      %ymm8,%ymm14,%ymm14
	vpand     %ymm8,%ymm15,%ymm15
	
	vpor      %ymm9,%ymm14,%ymm14
	vpxorq    vec2exp22x15,%ymm9,%ymm13	
	vpand     %ymm13,%ymm15,%ymm15
	
	vpcmpeqq  vec0,%ymm14,%ymm14
	vpcmpeqq  vec26,%ymm15,%ymm15
	vpor      %ymm14,%ymm15,%ymm11
	
	vpand     %ymm11,%ymm12,%ymm12
	vmovdqa   %ymm12,4416(%rsp) 
	
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
	
	vmovdqa   %ymm0,3136(%rsp)
	vmovdqa   %ymm1,3168(%rsp)
	vmovdqa   %ymm2,3200(%rsp)
	vmovdqa   %ymm3,3232(%rsp)
	vmovdqa   %ymm4,3264(%rsp)
	vmovdqa   %ymm5,3296(%rsp)
	vmovdqa   %ymm6,3328(%rsp)
	vmovdqa   %ymm7,3360(%rsp)
	vmovdqa   %ymm8,3392(%rsp)
	vmovdqa   %ymm9,3424(%rsp)
	
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
	
	vpaddq    _2p0,%ymm0,%ymm0
	vpaddq    _2p1,%ymm1,%ymm1
	vpaddq    _2p2_8,%ymm2,%ymm2
	vpaddq    _2p2_8,%ymm3,%ymm3
	vpaddq    _2p2_8,%ymm4,%ymm4
	vpaddq    _2p2_8,%ymm5,%ymm5
	vpaddq    _2p2_8,%ymm6,%ymm6
	vpaddq    _2p2_8,%ymm7,%ymm7
	vpaddq    _2p2_8,%ymm8,%ymm8
	vpaddq    _2p9,%ymm9,%ymm9
	
	vpsubq    1216(%rsp),%ymm0,%ymm0
	vpsubq    1248(%rsp),%ymm1,%ymm1
	vpsubq    1280(%rsp),%ymm2,%ymm2
	vpsubq    1312(%rsp),%ymm3,%ymm3
	vpsubq    1344(%rsp),%ymm4,%ymm4
	vpsubq    1376(%rsp),%ymm5,%ymm5
	vpsubq    1408(%rsp),%ymm6,%ymm6
	vpsubq    1440(%rsp),%ymm7,%ymm7
	vpsubq    1472(%rsp),%ymm8,%ymm8
	vpsubq    1504(%rsp),%ymm9,%ymm9
	
	vpandn    vecone,%ymm12,%ymm12	
	
	vmovdqa   3136(%rsp),%ymm0
	vmovdqa   3168(%rsp),%ymm1
	vmovdqa   3200(%rsp),%ymm2
	vmovdqa   3232(%rsp),%ymm3
	vmovdqa   3264(%rsp),%ymm4
	vmovdqa   3296(%rsp),%ymm5
	vmovdqa   3328(%rsp),%ymm6
	vmovdqa   3360(%rsp),%ymm7
	vmovdqa   3392(%rsp),%ymm8
	vmovdqa   3424(%rsp),%ymm9        
        
        vpxor	  2816(%rsp),%ymm0,%ymm0
        vpxor	  2848(%rsp),%ymm1,%ymm1
        vpxor	  2880(%rsp),%ymm2,%ymm2
        vpxor	  2912(%rsp),%ymm3,%ymm3
        vpxor	  2944(%rsp),%ymm4,%ymm4
        vpxor	  2976(%rsp),%ymm5,%ymm5
        vpxor	  3008(%rsp),%ymm6,%ymm6
        vpxor	  3040(%rsp),%ymm7,%ymm7
        vpxor	  3072(%rsp),%ymm8,%ymm8
        vpxor	  3104(%rsp),%ymm9,%ymm9

        vpand	  %ymm12,%ymm0,%ymm0
        vpand	  %ymm12,%ymm1,%ymm1
        vpand	  %ymm12,%ymm2,%ymm2
        vpand	  %ymm12,%ymm3,%ymm3
        vpand	  %ymm12,%ymm4,%ymm4
        vpand	  %ymm12,%ymm5,%ymm5
        vpand	  %ymm12,%ymm6,%ymm6
        vpand	  %ymm12,%ymm7,%ymm7
        vpand	  %ymm12,%ymm8,%ymm8
        vpand	  %ymm12,%ymm9,%ymm9

        vpxor	  3136(%rsp),%ymm0,%ymm0
        vpxor	  3168(%rsp),%ymm1,%ymm1
        vpxor	  3200(%rsp),%ymm2,%ymm2
        vpxor	  3232(%rsp),%ymm3,%ymm3
        vpxor	  3264(%rsp),%ymm4,%ymm4
        vpxor	  3296(%rsp),%ymm5,%ymm5
        vpxor	  3328(%rsp),%ymm6,%ymm6
        vpxor	  3360(%rsp),%ymm7,%ymm7
        vpxor	  3392(%rsp),%ymm8,%ymm8
        vpxor	  3424(%rsp),%ymm9,%ymm9

	vmovdqa   %ymm0,3136(%rsp)
	vmovdqa   %ymm1,3168(%rsp)
	vmovdqa   %ymm2,3200(%rsp)
	vmovdqa   %ymm3,3232(%rsp)
	vmovdqa   %ymm4,3264(%rsp)
	vmovdqa   %ymm5,3296(%rsp)
	vmovdqa   %ymm6,3328(%rsp)
	vmovdqa   %ymm7,3360(%rsp)
	vmovdqa   %ymm8,3392(%rsp)
	vmovdqa   %ymm9,3424(%rsp)
	
	vmovdqa   3456(%rsp),%ymm0
	vmovdqa   3488(%rsp),%ymm1
	vmovdqa   3520(%rsp),%ymm2
	vmovdqa   3552(%rsp),%ymm3
	vmovdqa   3584(%rsp),%ymm4
	vmovdqa   3616(%rsp),%ymm5
	vmovdqa   3648(%rsp),%ymm6
	vmovdqa   3680(%rsp),%ymm7
	vmovdqa   3712(%rsp),%ymm8
	vmovdqa   3744(%rsp),%ymm9
		
        vpxor	  1856(%rsp),%ymm0,%ymm0
        vpxor	  1888(%rsp),%ymm1,%ymm1
        vpxor	  1920(%rsp),%ymm2,%ymm2
        vpxor	  1952(%rsp),%ymm3,%ymm3
        vpxor	  1984(%rsp),%ymm4,%ymm4
        vpxor	  2016(%rsp),%ymm5,%ymm5
        vpxor	  2048(%rsp),%ymm6,%ymm6
        vpxor	  2080(%rsp),%ymm7,%ymm7
        vpxor	  2112(%rsp),%ymm8,%ymm8
        vpxor	  2144(%rsp),%ymm9,%ymm9

        vpand	  %ymm12,%ymm0,%ymm0
        vpand	  %ymm12,%ymm1,%ymm1
        vpand	  %ymm12,%ymm2,%ymm2
        vpand	  %ymm12,%ymm3,%ymm3
        vpand	  %ymm12,%ymm4,%ymm4
        vpand	  %ymm12,%ymm5,%ymm5
        vpand	  %ymm12,%ymm6,%ymm6
        vpand	  %ymm12,%ymm7,%ymm7
        vpand	  %ymm12,%ymm8,%ymm8
        vpand	  %ymm12,%ymm9,%ymm9

        vpxor	  3456(%rsp),%ymm0,%ymm0
        vpxor	  3488(%rsp),%ymm1,%ymm1
        vpxor	  3520(%rsp),%ymm2,%ymm2
        vpxor	  3552(%rsp),%ymm3,%ymm3
        vpxor	  3584(%rsp),%ymm4,%ymm4
        vpxor	  3616(%rsp),%ymm5,%ymm5
        vpxor	  3648(%rsp),%ymm6,%ymm6
        vpxor	  3680(%rsp),%ymm7,%ymm7
        vpxor	  3712(%rsp),%ymm8,%ymm8
        vpxor	  3744(%rsp),%ymm9,%ymm9

	vmovdqa   %ymm0,3456(%rsp)
	vmovdqa   %ymm1,3488(%rsp)
	vmovdqa   %ymm2,3520(%rsp)
	vmovdqa   %ymm3,3552(%rsp)
	vmovdqa   %ymm4,3584(%rsp)
	vmovdqa   %ymm5,3616(%rsp)
	vmovdqa   %ymm6,3648(%rsp)
	vmovdqa   %ymm7,3680(%rsp)
	vmovdqa   %ymm8,3712(%rsp)
	vmovdqa   %ymm9,3744(%rsp)	
	
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
	
	vmovdqa   %ymm10,3776(%rsp)
	vmovdqa   %ymm11,3808(%rsp)
	vmovdqa   %ymm12,3840(%rsp)
	vmovdqa   %ymm13,3872(%rsp)
	vmovdqa   %ymm14,3904(%rsp)
	vmovdqa   %ymm0,3936(%rsp)
	vmovdqa   %ymm1,3968(%rsp)
	vmovdqa   %ymm2,4000(%rsp)
	vmovdqa   %ymm3,4032(%rsp)
	vmovdqa   %ymm4,4064(%rsp)
	
	vmovdqa   2336(%rsp),%ymm5
	vmovdqa   2368(%rsp),%ymm6
	vmovdqa   2400(%rsp),%ymm7
	vmovdqa   2432(%rsp),%ymm8
	vmovdqa   2464(%rsp),%ymm9

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
	vpaddq    3776(%rsp),%ymm4,%ymm4

	vpaddq    2176(%rsp),%ymm5,%ymm5
	vpaddq    2208(%rsp),%ymm6,%ymm6
	vpaddq    2240(%rsp),%ymm7,%ymm7
	vpaddq    2272(%rsp),%ymm8,%ymm8
	vpaddq    2304(%rsp),%ymm9,%ymm9

	vpmuludq  2176(%rsp),%ymm10,%ymm15
	vmovdqa   %ymm15,288(%rsp)
	vpaddq    0(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,576(%rsp)

	vpmuludq  2208(%rsp),%ymm10,%ymm15
	vpmuludq  2176(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,320(%rsp)
	vpaddq    32(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,608(%rsp)

	vpmuludq  2240(%rsp),%ymm10,%ymm15
	vpmuludq  2208(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  2176(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,352(%rsp)
	vpaddq    64(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,640(%rsp)

	vpmuludq  2272(%rsp),%ymm10,%ymm15
	vpmuludq  2240(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  2208(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  2176(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,384(%rsp)
	vpaddq    96(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,672(%rsp)

	vpmuludq  2304(%rsp),%ymm10,%ymm15
	vpmuludq  2272(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  2240(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  2208(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   3776(%rsp),%ymm10
	vpmuludq  2176(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,416(%rsp)
	vpaddq    128(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,704(%rsp)

	vpmuludq  2304(%rsp),%ymm11,%ymm15
	vpmuludq  2272(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  2240(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  2208(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,448(%rsp)
	vpaddq    160(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,736(%rsp)

	vpmuludq  2304(%rsp),%ymm12,%ymm15
	vpmuludq  2272(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  2240(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,480(%rsp)
	vpaddq    192(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,768(%rsp)

	vpmuludq  2304(%rsp),%ymm13,%ymm15
	vpmuludq  2272(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,512(%rsp)
	vpaddq    224(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,800(%rsp)

	vpmuludq  2304(%rsp),%ymm10,%ymm15
	vmovdqa   %ymm15,544(%rsp)
	vpaddq    256(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,832(%rsp)

	vpmuludq  %ymm5,%ymm0,%ymm15
	vmovdqa   %ymm15,864(%rsp)

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
	
	vmovdqa   %ymm0,4096(%rsp)
	vmovdqa   %ymm1,4128(%rsp)
	vmovdqa   %ymm2,4160(%rsp)
	vmovdqa   %ymm3,4192(%rsp)
	vmovdqa   %ymm4,4224(%rsp)
	vmovdqa   %ymm5,4256(%rsp)
	vmovdqa   %ymm6,4288(%rsp)
	vmovdqa   %ymm7,4320(%rsp)
	vmovdqa   %ymm8,4352(%rsp)
	vmovdqa   %ymm9,4384(%rsp)
	
	vmovdqa   3776(%rsp),%ymm0
	vmovdqa   3808(%rsp),%ymm1
	vmovdqa   3840(%rsp),%ymm2
	vmovdqa   3872(%rsp),%ymm3
	vmovdqa   3904(%rsp),%ymm4
	vmovdqa   3936(%rsp),%ymm5
	vmovdqa   3968(%rsp),%ymm6
	vmovdqa   4000(%rsp),%ymm7
	vmovdqa   4032(%rsp),%ymm8
	vmovdqa   4064(%rsp),%ymm9
		
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
	
	vmovdqa   %ymm0,3776(%rsp)
	vmovdqa   %ymm1,3808(%rsp)
	vmovdqa   %ymm2,3840(%rsp)
	vmovdqa   %ymm3,3872(%rsp)
	vmovdqa   %ymm4,3904(%rsp)
	vmovdqa   %ymm5,3936(%rsp)
	vmovdqa   %ymm6,3968(%rsp)
	vmovdqa   %ymm7,4000(%rsp)
	vmovdqa   %ymm8,4032(%rsp)
	vmovdqa   %ymm9,4064(%rsp)
	
        vpxor	  1856(%rsp),%ymm0,%ymm0
        vpxor	  1888(%rsp),%ymm1,%ymm1
        vpxor	  1920(%rsp),%ymm2,%ymm2
        vpxor	  1952(%rsp),%ymm3,%ymm3
        vpxor	  1984(%rsp),%ymm4,%ymm4
        vpxor	  2016(%rsp),%ymm5,%ymm5
        vpxor	  2048(%rsp),%ymm6,%ymm6
        vpxor	  2080(%rsp),%ymm7,%ymm7
        vpxor	  2112(%rsp),%ymm8,%ymm8
        vpxor	  2144(%rsp),%ymm9,%ymm9

        vpand	  4416(%rsp),%ymm0,%ymm0
        vpand	  4416(%rsp),%ymm1,%ymm1
        vpand	  4416(%rsp),%ymm2,%ymm2
        vpand	  4416(%rsp),%ymm3,%ymm3
        vpand	  4416(%rsp),%ymm4,%ymm4
        vpand	  4416(%rsp),%ymm5,%ymm5
        vpand	  4416(%rsp),%ymm6,%ymm6
        vpand	  4416(%rsp),%ymm7,%ymm7
        vpand	  4416(%rsp),%ymm8,%ymm8
        vpand	  4416(%rsp),%ymm9,%ymm9

        vpxor	  3776(%rsp),%ymm0,%ymm0
        vpxor	  3808(%rsp),%ymm1,%ymm1
        vpxor	  3840(%rsp),%ymm2,%ymm2
        vpxor	  3872(%rsp),%ymm3,%ymm3
        vpxor	  3904(%rsp),%ymm4,%ymm4
        vpxor	  3936(%rsp),%ymm5,%ymm5
        vpxor	  3968(%rsp),%ymm6,%ymm6
        vpxor	  4000(%rsp),%ymm7,%ymm7
        vpxor	  4032(%rsp),%ymm8,%ymm8
        vpxor	  4064(%rsp),%ymm9,%ymm9

	vmovdqa   %ymm0,3776(%rsp)
	vmovdqa   %ymm1,3808(%rsp)
	vmovdqa   %ymm2,3840(%rsp)
	vmovdqa   %ymm3,3872(%rsp)
	vmovdqa   %ymm4,3904(%rsp)
	vmovdqa   %ymm5,3936(%rsp)
	vmovdqa   %ymm6,3968(%rsp)
	vmovdqa   %ymm7,4000(%rsp)
	vmovdqa   %ymm8,4032(%rsp)
	vmovdqa   %ymm9,4064(%rsp)
	
	vmovdqa   3136(%rsp),%ymm0
	vmovdqa   3168(%rsp),%ymm1
	vmovdqa   3200(%rsp),%ymm2
	vmovdqa   3232(%rsp),%ymm3
	vmovdqa   3264(%rsp),%ymm4
	vmovdqa   3296(%rsp),%ymm5
	vmovdqa   3328(%rsp),%ymm6
	vmovdqa   3360(%rsp),%ymm7
	vmovdqa   3392(%rsp),%ymm8
	vmovdqa   3424(%rsp),%ymm9
		
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
	
	vmovdqa   %ymm0,2176(%rsp)
	vmovdqa   %ymm1,2208(%rsp)
	vmovdqa   %ymm2,2240(%rsp)
	vmovdqa   %ymm3,2272(%rsp)
	vmovdqa   %ymm4,2304(%rsp)
	vmovdqa   %ymm5,2336(%rsp)
	vmovdqa   %ymm6,2368(%rsp)
	vmovdqa   %ymm7,2400(%rsp)
	vmovdqa   %ymm8,2432(%rsp)
	vmovdqa   %ymm9,2464(%rsp)
	
	vmovdqa   3456(%rsp),%ymm10
	vmovdqa   3488(%rsp),%ymm11
	vmovdqa   3520(%rsp),%ymm12
	vmovdqa   3552(%rsp),%ymm13
	vmovdqa   3584(%rsp),%ymm14
	vmovdqa   3616(%rsp),%ymm0
	vmovdqa   3648(%rsp),%ymm1
	vmovdqa   3680(%rsp),%ymm2
	vmovdqa   3712(%rsp),%ymm3
	vmovdqa   3744(%rsp),%ymm4

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
	vpaddq    3456(%rsp),%ymm4,%ymm4

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
	vmovdqa   3456(%rsp),%ymm10
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
	
	vpsrlq    $22,%ymm9,%ymm10
	vpand     vecmask22,%ymm9,%ymm9
	
	vpmuludq  vec977,%ymm10,%ymm11
	vpaddq    %ymm11,%ymm0,%ymm0
	vpsllq    $6,%ymm10,%ymm11
	vpaddq    %ymm11,%ymm1,%ymm1
		
	vpsrlq    $26,%ymm0,%ymm10
	vpaddq    %ymm10,%ymm1,%ymm1	
	vpand     vecmask26,%ymm0,%ymm0
	vmovdqa   %ymm0,%ymm14
	vpxorq    vec976,%ymm0,%ymm15
	
	vpsrlq    $26,%ymm1,%ymm10
	vpaddq    %ymm10,%ymm2,%ymm2	
	vpand     vecmask26,%ymm1,%ymm1
	vpor      %ymm1,%ymm14,%ymm14
	vpxorq    vec64,%ymm1,%ymm13
	vpand     %ymm13,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm2,%ymm10
	vpaddq    %ymm10,%ymm3,%ymm3	
	vpand     vecmask26,%ymm2,%ymm2
	vpor      %ymm2,%ymm14,%ymm14
	vpand     %ymm2,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm3,%ymm10
	vpaddq    %ymm10,%ymm4,%ymm4	
	vpand     vecmask26,%ymm3,%ymm3
	vpor      %ymm3,%ymm14,%ymm14
	vpand     %ymm3,%ymm15,%ymm15	
	
	vpsrlq    $26,%ymm4,%ymm10
	vpaddq    %ymm10,%ymm5,%ymm5	
	vpand     vecmask26,%ymm4,%ymm4
	vpor      %ymm4,%ymm14,%ymm14
	vpand     %ymm4,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm5,%ymm10
	vpaddq    %ymm10,%ymm6,%ymm6	
	vpand     vecmask26,%ymm5,%ymm5
	vpor      %ymm5,%ymm14,%ymm14
	vpand     %ymm5,%ymm15,%ymm15

	vpsrlq    $26,%ymm6,%ymm10
	vpaddq    %ymm10,%ymm7,%ymm7	
	vpand     vecmask26,%ymm6,%ymm6
	vpor      %ymm6,%ymm14,%ymm14
	vpand     %ymm6,%ymm15,%ymm15
	
	vpsrlq    $26,%ymm7,%ymm10
	vpaddq    %ymm10,%ymm8,%ymm8	
	vpand     vecmask26,%ymm7,%ymm7
	vpor      %ymm7,%ymm14,%ymm14
	vpand     %ymm7,%ymm15,%ymm15

	vpsrlq    $26,%ymm8,%ymm10
	vpaddq    %ymm10,%ymm9,%ymm9	
	vpand     vecmask26,%ymm8,%ymm8
	vpor      %ymm8,%ymm14,%ymm14
	vpand     %ymm8,%ymm15,%ymm15
	
	vpor      %ymm9,%ymm14,%ymm14
	vpxorq    vec2exp22x15,%ymm9,%ymm13	
	vpand     %ymm13,%ymm15,%ymm15
	
	vpcmpeqq   vec0,%ymm14,%ymm14
	vpcmpeqq   vec26,%ymm15,%ymm15
	vpor      %ymm14,%ymm15,%ymm12	
	
	vmovdqa   960(%rsi),%ymm13
	vpandn    vecone,%ymm13,%ymm13
	vpand     %ymm13,%ymm12,%ymm12
	vmovdqa   %ymm12,4416(%rsp) 
	
        vmovdqa   640(%rdi),%ymm0
        vmovdqa   672(%rdi),%ymm1
        vmovdqa   704(%rdi),%ymm2
        vmovdqa   736(%rdi),%ymm3
        vmovdqa   768(%rdi),%ymm4
        vmovdqa   800(%rdi),%ymm5
        vmovdqa   832(%rdi),%ymm6
        vmovdqa   864(%rdi),%ymm7
        vmovdqa   896(%rdi),%ymm8
        vmovdqa   928(%rdi),%ymm9
        
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
        
        vpxor	  vec1,%ymm0,%ymm0
        vpxor	  vec0,%ymm1,%ymm1
        vpxor	  vec0,%ymm2,%ymm2
        vpxor	  vec0,%ymm3,%ymm3
        vpxor	  vec0,%ymm4,%ymm4
        vpxor	  vec0,%ymm5,%ymm5
        vpxor	  vec0,%ymm6,%ymm6
        vpxor	  vec0,%ymm7,%ymm7
        vpxor	  vec0,%ymm8,%ymm8
        vpxor	  vec0,%ymm9,%ymm9  
                
        vpand	  960(%rsi),%ymm0,%ymm0
        vpand	  960(%rsi),%ymm1,%ymm1
        vpand	  960(%rsi),%ymm2,%ymm2
        vpand	  960(%rsi),%ymm3,%ymm3
        vpand	  960(%rsi),%ymm4,%ymm4
        vpand	  960(%rsi),%ymm5,%ymm5
        vpand	  960(%rsi),%ymm6,%ymm6
        vpand	  960(%rsi),%ymm7,%ymm7
        vpand	  960(%rsi),%ymm8,%ymm8
        vpand	  960(%rsi),%ymm9,%ymm9
        
        vpxor	  640(%rdi),%ymm0,%ymm0
        vpxor	  672(%rdi),%ymm1,%ymm1
        vpxor	  704(%rdi),%ymm2,%ymm2
        vpxor	  736(%rdi),%ymm3,%ymm3
        vpxor	  768(%rdi),%ymm4,%ymm4
        vpxor	  800(%rdi),%ymm5,%ymm5
        vpxor	  832(%rdi),%ymm6,%ymm6
        vpxor	  864(%rdi),%ymm7,%ymm7
        vpxor	  896(%rdi),%ymm8,%ymm8
        vpxor	  928(%rdi),%ymm9,%ymm9      

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
	
	vmovdqa   2176(%rsp),%ymm0
	vmovdqa   2208(%rsp),%ymm1
	vmovdqa   2240(%rsp),%ymm2
	vmovdqa   2272(%rsp),%ymm3
	vmovdqa   2304(%rsp),%ymm4	
	vmovdqa   2336(%rsp),%ymm5
	vmovdqa   2368(%rsp),%ymm6
	vmovdqa   2400(%rsp),%ymm7
	vmovdqa   2432(%rsp),%ymm8
	vmovdqa   2464(%rsp),%ymm9
	
	vpaddq    _2p0,%ymm0,%ymm0
	vpaddq    _2p1,%ymm1,%ymm1
	vpaddq    _2p2_8,%ymm2,%ymm2
	vpaddq    _2p2_8,%ymm3,%ymm3
	vpaddq    _2p2_8,%ymm4,%ymm4
	vpaddq    _2p2_8,%ymm5,%ymm5
	vpaddq    _2p2_8,%ymm6,%ymm6
	vpaddq    _2p2_8,%ymm7,%ymm7
	vpaddq    _2p2_8,%ymm8,%ymm8
	vpaddq    _2p9,%ymm9,%ymm9
	
	vpsubq    4096(%rsp),%ymm0,%ymm0
	vpsubq    4128(%rsp),%ymm1,%ymm1
	vpsubq    4160(%rsp),%ymm2,%ymm2
	vpsubq    4192(%rsp),%ymm3,%ymm3
	vpsubq    4224(%rsp),%ymm4,%ymm4
	vpsubq    4256(%rsp),%ymm5,%ymm5
	vpsubq    4288(%rsp),%ymm6,%ymm6
	vpsubq    4320(%rsp),%ymm7,%ymm7
	vpsubq    4352(%rsp),%ymm8,%ymm8
	vpsubq    4384(%rsp),%ymm9,%ymm9
	
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

	vmovdqa   %ymm0,2176(%rsp)
	vmovdqa   %ymm1,2208(%rsp)
	vmovdqa   %ymm2,2240(%rsp)
	vmovdqa   %ymm3,2272(%rsp)
	vmovdqa   %ymm4,2304(%rsp)
	vmovdqa   %ymm5,2336(%rsp)
	vmovdqa   %ymm6,2368(%rsp)
	vmovdqa   %ymm7,2400(%rsp)
	vmovdqa   %ymm8,2432(%rsp)
	vmovdqa   %ymm9,2464(%rsp)
	
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
	
	vmovdqa   4096(%rsp),%ymm10
	vmovdqa   4128(%rsp),%ymm11
	vmovdqa   4160(%rsp),%ymm12
	vmovdqa   4192(%rsp),%ymm13
	vmovdqa   4224(%rsp),%ymm14
	
	vpaddq    _4p0,%ymm10,%ymm10
	vpaddq    _4p1,%ymm11,%ymm11
	vpaddq    _4p2_8,%ymm12,%ymm12
	vpaddq    _4p2_8,%ymm13,%ymm13
	vpaddq    _4p2_8,%ymm14,%ymm14
	
	vpsubq    %ymm0,%ymm10,%ymm10
	vpsubq    %ymm1,%ymm11,%ymm11
	vpsubq    %ymm2,%ymm12,%ymm12
	vpsubq    %ymm3,%ymm13,%ymm13
	vpsubq    %ymm4,%ymm14,%ymm14
	
	vmovdqa   4256(%rsp),%ymm0
	vmovdqa   4288(%rsp),%ymm1
	vmovdqa   4320(%rsp),%ymm2
	vmovdqa   4352(%rsp),%ymm3
	vmovdqa   4384(%rsp),%ymm4	
	
	vpaddq    _4p2_8,%ymm0,%ymm0
	vpaddq    _4p2_8,%ymm1,%ymm1
	vpaddq    _4p2_8,%ymm2,%ymm2
	vpaddq    _4p2_8,%ymm3,%ymm3
	vpaddq    _4p9,%ymm4,%ymm4
	
	vpsubq    %ymm5,%ymm0,%ymm0
	vpsubq    %ymm6,%ymm1,%ymm1
	vpsubq    %ymm7,%ymm2,%ymm2
	vpsubq    %ymm8,%ymm3,%ymm3
	vpsubq    %ymm9,%ymm4,%ymm4
	
	vmovdqa   %ymm10,2176(%rsp)
	vmovdqa   3296(%rsp),%ymm5
	vmovdqa   3328(%rsp),%ymm6
	vmovdqa   3360(%rsp),%ymm7
	vmovdqa   3392(%rsp),%ymm8
	vmovdqa   3424(%rsp),%ymm9

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
	vpaddq    2176(%rsp),%ymm4,%ymm4

	vpaddq    3136(%rsp),%ymm5,%ymm5
	vpaddq    3168(%rsp),%ymm6,%ymm6
	vpaddq    3200(%rsp),%ymm7,%ymm7
	vpaddq    3232(%rsp),%ymm8,%ymm8
	vpaddq    3264(%rsp),%ymm9,%ymm9

	vpmuludq  3136(%rsp),%ymm10,%ymm15
	vmovdqa   %ymm15,288(%rsp)
	vpaddq    0(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,576(%rsp)

	vpmuludq  3168(%rsp),%ymm10,%ymm15
	vpmuludq  3136(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,320(%rsp)
	vpaddq    32(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,608(%rsp)

	vpmuludq  3200(%rsp),%ymm10,%ymm15
	vpmuludq  3168(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  3136(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,352(%rsp)
	vpaddq    64(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,640(%rsp)

	vpmuludq  3232(%rsp),%ymm10,%ymm15
	vpmuludq  3200(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  3168(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  3136(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,384(%rsp)
	vpaddq    96(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,672(%rsp)

	vpmuludq  3264(%rsp),%ymm10,%ymm15
	vpmuludq  3232(%rsp),%ymm11,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  3200(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  3168(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   2176(%rsp),%ymm10
	vpmuludq  3136(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,416(%rsp)
	vpaddq    128(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,704(%rsp)

	vpmuludq  3264(%rsp),%ymm11,%ymm15
	vpmuludq  3232(%rsp),%ymm12,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  3200(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  3168(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,448(%rsp)
	vpaddq    160(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,736(%rsp)

	vpmuludq  3264(%rsp),%ymm12,%ymm15
	vpmuludq  3232(%rsp),%ymm13,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vpmuludq  3200(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,480(%rsp)
	vpaddq    192(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,768(%rsp)

	vpmuludq  3264(%rsp),%ymm13,%ymm15
	vpmuludq  3232(%rsp),%ymm10,%ymm14
	vpaddq    %ymm14,%ymm15,%ymm15
	vmovdqa   %ymm15,512(%rsp)
	vpaddq    224(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,800(%rsp)

	vpmuludq  3264(%rsp),%ymm10,%ymm15
	vmovdqa   %ymm15,544(%rsp)
	vpaddq    256(%rsp),%ymm15,%ymm15
	vmovdqa   %ymm15,832(%rsp)

	vpmuludq  %ymm5,%ymm0,%ymm15
	vmovdqa   %ymm15,864(%rsp)

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
	
	vpaddq    _2p0,%ymm0,%ymm0
	vpaddq    _2p1,%ymm1,%ymm1
	vpaddq    _2p2_8,%ymm2,%ymm2
	vpaddq    _2p2_8,%ymm3,%ymm3
	vpaddq    _2p2_8,%ymm4,%ymm4
	vpaddq    _2p2_8,%ymm5,%ymm5
	vpaddq    _2p2_8,%ymm6,%ymm6
	vpaddq    _2p2_8,%ymm7,%ymm7
	vpaddq    _2p2_8,%ymm8,%ymm8
	vpaddq    _2p9,%ymm9,%ymm9
	
	vpsubq    3776(%rsp),%ymm0,%ymm0
	vpsubq    3808(%rsp),%ymm1,%ymm1
	vpsubq    3840(%rsp),%ymm2,%ymm2
	vpsubq    3872(%rsp),%ymm3,%ymm3
	vpsubq    3904(%rsp),%ymm4,%ymm4
	vpsubq    3936(%rsp),%ymm5,%ymm5
	vpsubq    3968(%rsp),%ymm6,%ymm6
	vpsubq    4000(%rsp),%ymm7,%ymm7
	vpsubq    4032(%rsp),%ymm8,%ymm8
	vpsubq    4064(%rsp),%ymm9,%ymm9
	
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
	
        vpxor	  320(%rdx),%ymm0,%ymm0
        vpxor	  352(%rdx),%ymm1,%ymm1
        vpxor	  384(%rdx),%ymm2,%ymm2
        vpxor	  416(%rdx),%ymm3,%ymm3
        vpxor	  448(%rdx),%ymm4,%ymm4
        vpxor	  480(%rdx),%ymm5,%ymm5
        vpxor	  512(%rdx),%ymm6,%ymm6
        vpxor	  544(%rdx),%ymm7,%ymm7
        vpxor	  576(%rdx),%ymm8,%ymm8
        vpxor	  608(%rdx),%ymm9,%ymm9

        vpand	  960(%rsi),%ymm0,%ymm0
        vpand	  960(%rsi),%ymm1,%ymm1
        vpand	  960(%rsi),%ymm2,%ymm2
        vpand	  960(%rsi),%ymm3,%ymm3
        vpand	  960(%rsi),%ymm4,%ymm4
        vpand	  960(%rsi),%ymm5,%ymm5
        vpand	  960(%rsi),%ymm6,%ymm6
        vpand	  960(%rsi),%ymm7,%ymm7
        vpand	  960(%rsi),%ymm8,%ymm8
        vpand	  960(%rsi),%ymm9,%ymm9
        
        vpxor	  320(%rdi),%ymm0,%ymm0
        vpxor	  352(%rdi),%ymm1,%ymm1
        vpxor	  384(%rdi),%ymm2,%ymm2
        vpxor	  416(%rdi),%ymm3,%ymm3
        vpxor	  448(%rdi),%ymm4,%ymm4
        vpxor	  480(%rdi),%ymm5,%ymm5
        vpxor	  512(%rdi),%ymm6,%ymm6
        vpxor	  544(%rdi),%ymm7,%ymm7
        vpxor	  576(%rdi),%ymm8,%ymm8
        vpxor	  608(%rdi),%ymm9,%ymm9        

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
	
	vmovdqa   0(%rdi),%ymm0
	vmovdqa   32(%rdi),%ymm1
	vmovdqa   64(%rdi),%ymm2
	vmovdqa   96(%rdi),%ymm3
	vmovdqa   128(%rdi),%ymm4
	vmovdqa   160(%rdi),%ymm5
	vmovdqa   192(%rdi),%ymm6
	vmovdqa   224(%rdi),%ymm7
	vmovdqa   256(%rdi),%ymm8
	vmovdqa   288(%rdi),%ymm9
	
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
	
        vpxor	  0(%rdx),%ymm0,%ymm0
        vpxor	  32(%rdx),%ymm1,%ymm1
        vpxor	  64(%rdx),%ymm2,%ymm2
        vpxor	  96(%rdx),%ymm3,%ymm3
        vpxor	  128(%rdx),%ymm4,%ymm4
        vpxor	  160(%rdx),%ymm5,%ymm5
        vpxor	  192(%rdx),%ymm6,%ymm6
        vpxor	  224(%rdx),%ymm7,%ymm7
        vpxor	  256(%rdx),%ymm8,%ymm8
        vpxor	  288(%rdx),%ymm9,%ymm9 

        vpand	  960(%rsi),%ymm0,%ymm0
        vpand	  960(%rsi),%ymm1,%ymm1
        vpand	  960(%rsi),%ymm2,%ymm2
        vpand	  960(%rsi),%ymm3,%ymm3
        vpand	  960(%rsi),%ymm4,%ymm4
        vpand	  960(%rsi),%ymm5,%ymm5
        vpand	  960(%rsi),%ymm6,%ymm6
        vpand	  960(%rsi),%ymm7,%ymm7
        vpand	  960(%rsi),%ymm8,%ymm8
        vpand	  960(%rsi),%ymm9,%ymm9 

	vpxor	  0(%rdi),%ymm0,%ymm0
        vpxor	  32(%rdi),%ymm1,%ymm1
        vpxor	  64(%rdi),%ymm2,%ymm2
        vpxor	  96(%rdi),%ymm3,%ymm3
        vpxor	  128(%rdi),%ymm4,%ymm4
        vpxor	  160(%rdi),%ymm5,%ymm5
        vpxor	  192(%rdi),%ymm6,%ymm6
        vpxor	  224(%rdi),%ymm7,%ymm7
        vpxor	  256(%rdi),%ymm8,%ymm8
        vpxor	  288(%rdi),%ymm9,%ymm9              

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
	
	vmovdqa   4416(%rsp),%ymm0
	vmovdqa   %ymm0,960(%rdi)
	
	
	movq 	  %r11,%rsp
		
        ret
