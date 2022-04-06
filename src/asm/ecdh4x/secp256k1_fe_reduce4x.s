/***********************************************************************
 * Copyright (c) 2022 Kaushik Nath                                     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

	.p2align 5
	.globl secp256k1_fe_reduce4x
secp256k1_fe_reduce4x:

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

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26(%rip),%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26(%rip),%ymm1,%ymm1

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26(%rip),%ymm2,%ymm2

	vpsrlq    $26,%ymm3,%ymm14
	vpaddq    %ymm14,%ymm4,%ymm4
	vpand     vecmask26(%rip),%ymm3,%ymm3

	vpsrlq    $26,%ymm4,%ymm14
	vpaddq    %ymm14,%ymm5,%ymm5
	vpand     vecmask26(%rip),%ymm4,%ymm4

	vpsrlq    $26,%ymm5,%ymm14
	vpaddq    %ymm14,%ymm6,%ymm6
	vpand     vecmask26(%rip),%ymm5,%ymm5

	vpsrlq    $26,%ymm6,%ymm14
	vpaddq    %ymm14,%ymm7,%ymm7
	vpand     vecmask26(%rip),%ymm6,%ymm6

	vpsrlq    $26,%ymm7,%ymm14
	vpaddq    %ymm14,%ymm8,%ymm8
	vpand     vecmask26(%rip),%ymm7,%ymm7

	vpsrlq    $26,%ymm8,%ymm14
	vpaddq    %ymm14,%ymm9,%ymm9
	vpand     vecmask26(%rip),%ymm8,%ymm8

	vpsrlq    $22,%ymm9,%ymm14
	vpsllq    $32,%ymm14,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0
	vpmuludq  vec977(%rip),%ymm14,%ymm15
	vpaddq    %ymm15,%ymm0,%ymm0
	vpand     vecmask22(%rip),%ymm9,%ymm9

	vpsrlq    $26,%ymm0,%ymm14
	vpaddq    %ymm14,%ymm1,%ymm1
	vpand     vecmask26(%rip),%ymm0,%ymm0

	vpsrlq    $26,%ymm1,%ymm14
	vpaddq    %ymm14,%ymm2,%ymm2
	vpand     vecmask26(%rip),%ymm1,%ymm1

	vpsrlq    $26,%ymm2,%ymm14
	vpaddq    %ymm14,%ymm3,%ymm3
	vpand     vecmask26(%rip),%ymm2,%ymm2

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
	
	
