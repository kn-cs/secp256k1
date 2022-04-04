/***********************************************************************
 * Copyright (c) 2022 Kaushik Nath                                     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/
 
	.p2align 4
	.global secp256k1_fe_reduce
	.type	secp256k1_fe_reduce, %function

secp256k1_fe_reduce:

	movq    0(%rsi),%r8
	movq    8(%rsi),%r9
	movq    16(%rsi),%r10
	movq    24(%rsi),%r11
	movq    32(%rsi),%rax

	movq    $0x1000003D1,%rdx
	xorq    %rcx,%rcx

	mulx    %rax,%rax,%rsi

	addq    %rax,%r8
	adcq    %rsi,%r9
	adcq    $0,%r10
	adcq    $0,%r11

	cmovc   %rdx,%rcx

	addq    %rcx,%r8
	adcq    $0,%r9
       
	movq   %r8, 0(%rdi)
	movq   %r9, 8(%rdi)
	movq   %r10, 16(%rdi)
	movq   %r11, 24(%rdi)

	ret         
