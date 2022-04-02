/************************************************************************
 * Field multiplication and squaring assemblies using representation of *
 * field elements in base 2^{64}.				        *
 * Major instructions used in the assemblies are mulx/add/adc.          *
 *									*
 * Copyright (c) 2021 Kaushik Nath                                      *
 * Distributed under the MIT software license, see the accompanying     *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php. *
 ***********************************************************************/

/************************************************************************
 *									*
 * D = 2^{32} + 977, p = 2^{256} - D, x = 2^{64}. 			*
 * 									*
 ***********************************************************************/

	.att_syntax
	.text

/************************************************************************
 * 64-bit field multiplication and squaring using the bottom 4-limbs of *
 * two field elements having 5-limb representation such that the fifth  *
 * limb is of at most 64 bits. The 5-limb inputs are fully reduced 	*  
 * first to 4-limb forms, then multiplied, after which a field element  *
 * in 5-limb form is reported as output. The fifth limb of the output   *
 * has at most 33 bits. 						*
 ************************************************************************/
	
	/* field multiplication */

	.p2align 4
	.global secp256k1_fe_mul_55to5
	.type	secp256k1_fe_mul_55to5, %function

secp256k1_fe_mul_55to5:

	movq 	%rsp,%r11
	subq 	$112,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)
	movq 	%rdi,56(%rsp)

	/* 
         * r8  = f0
	 * r9  = f1
         * r10 = f2
         * r11 = f3
         *
         * The 4-tuple (r8 : r9 : r10 : r11) represents the first four 
         * limbs of the field element f(x) = f0 + f1x + f2x^2 + f3x^3 + f4x^4.
	 */

	movq    0(%rsi),%r8
	movq    8(%rsi),%r9
	movq    16(%rsi),%r10
	movq    24(%rsi),%r11

	/* 
         * r12 = g0
	 * r13 = g1
         * rdi = g2
         * r15 = g3
         * rax = g4
         *
         * The 5-tuple (r12 : r13 : rdi : r15 : rax ) represents the field
         * element g(x) = g0 + g1x + g2x^2 + g3x^3 + g4x^4.
	 */

	movq    0(%rdx),%r12
	movq    8(%rdx),%r13
	movq    16(%rdx),%rdi
	movq    24(%rdx),%r15
	movq    32(%rdx),%rax

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* rcx = 0 */
	xorq    %rcx,%rcx

	/* (rbx : rbp) = D * f4 */
	mulx    32(%rsi),%rbx,%rbp

	/* Reduce f(x) by adding D * f4  to the f0 + f1x + f2x^2 + f3x^3. */
	addq    %rbx,%r8
	adcq    %rbp,%r9
	adcq    $0,%r10
	adcq    $0,%r11

	/* rcx = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%rcx

	/* Reduce f(x) further by adding D or 0 to f0 + f1x + f2x^2 + f3x^3. */
	addq    %rcx,%r8
	adcq    $0,%r9

	/* At this point the input f(x) is fully reduced. The limbs of the field 
         * element are stored in the registers r8, r9, r10, r11 respectively. 
         */

	/* rcx = 0 */
	xorq    %rcx,%rcx

	/* (rax : rbx) = D * g4 */
	mulx    %rax,%rax,%rbx

	/* Reduce f(x) by adding D * g4  to the g0 + g1x + g2x^2 + g3x^3. */
	addq    %rax,%r12
	adcq    %rbx,%r13
	adcq    $0,%rdi
	adcq    $0,%r15

	/* rcx = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%rcx

	/* Reduce g(x) further by adding D or 0 to g0 + g1x + g2x^2 + g3x^3. */
	addq    %rcx,%r12
	adcq    $0,%r13
	movq    %r15,%rsi

	/* At this point the input g(x) is fully reduced. The limbs of the field 
         * element are stored in the registers r12, r13, rdi, rsi respectively. 
         */

	/* Store f0, f1, f2, f3, g0, g1 */
	movq    %r8,64(%rsp)
	movq    %r9,72(%rsp)
	movq    %r10,80(%rsp)
	movq    %r11,88(%rsp)
	movq    %r12,96(%rsp)
	movq    %r13,104(%rsp)

	/* 
	 * Integer multiplication with the reduced field elements f(x) and g(x)
         * is performed and the product is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * rsp64 = f0
         * rsp72 = f1
         * rsp80 = f2
         * rsp88 = f3
         *
	 * rsp96  = g0
         * rsp104 = g1
         * rdi    = g2
         * rsi    = g3
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * rsi = h7
	 */

	/* h0 + h1x + h2x^2 + h3x^3 + h4x^4 = g0 * (f0 + f1x + f2x^2 + f3x^3) --- (1) */
	movq    64(%rsp),%rdx
	mulx    96(%rsp),%r8,%r9
	mulx    104(%rsp),%rcx,%r10
	addq    %rcx,%r9
	mulx    %rdi,%rcx,%r11
	adcq    %rcx,%r10
	mulx    %rsi,%rcx,%r12
	adcq    %rcx,%r11
	adcq    $0,%r12

	/* t1x + t2x^2 + t3x^3 + t4x^4 + t5x^5 = g1x * (f0 + f1x + f2x^2 + f3x^3) --- (2) */
	movq    72(%rsp),%rdx    
	mulx    96(%rsp),%rax,%rbx
	mulx    104(%rsp),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    %rdi,%rcx,%r15
	adcq    %rcx,%rbp
	mulx    %rsi,%rcx,%r13
	adcq    %rcx,%r15
	adcq    $0,%r13
	/* Add t1x + t2x^2 + t3x^3 + t4x^4 + t5x^5 in (2) to  h1x + h2x^2 + h3x^3 + h4x^4  in (1) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 --- (3)
	 */
	addq    %rax,%r9
	adcq    %rbx,%r10
	adcq    %rbp,%r11
	adcq    %r15,%r12
	adcq    $0,%r13

	/* t2x^2 + t3x^3 + t4x^4 + t5x^5 + t6x^6 = g2x^2 * (f0 + f1x + f2x^2 + f3x^3) --- (4) */
	movq    80(%rsp),%rdx
	mulx    96(%rsp),%rax,%rbx
	mulx    104(%rsp),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    %rdi,%rcx,%r15
	adcq    %rcx,%rbp
	mulx    %rsi,%rcx,%r14
	adcq    %rcx,%r15
	adcq    $0,%r14
	/* Add t2x^2 + t3x^3 + t4x^4 + t5x^5 + t6x^6 in (4) to  h2x^2 + h3x^3 + h4x^4 + h5x^5 in (3) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 --- (5)
	 */
	addq    %rax,%r10
	adcq    %rbx,%r11
	adcq    %rbp,%r12
	adcq    %r15,%r13
	adcq    $0,%r14

	/* t3x^3 + t4x^4 + t5x^5 + t6x^6 + t7x^7 = g3x^2 * (f0 + f1x + f2x^2 + f3x^3) --- (6) */
	movq    88(%rsp),%rdx
	mulx    96(%rsp),%rax,%rbx
	mulx    104(%rsp),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    %rdi,%rcx,%r15
	adcq    %rcx,%rbp
	mulx    %rsi,%rcx,%rsi
	adcq    %rcx,%r15
	adcq    $0,%rsi
	/* Add t3x^3 + t4x^4 + t5x^5 + t6x^6 + t7x^7 in (6) to  h3x^3 + h4x^4 + h5x^5 + h6x^6 in (5) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 --- (7)
	 */
	addq    %rax,%r11
	adcq    %rbx,%r12
	adcq    %rbp,%r13
	adcq    %r15,%r14
	adcq    $0,%rsi

	/* 
	 * At this point the product is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * rsi = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 */

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* t0 + t1x + t2x^2 + t3x^3 + t4x^4 = D * (h4 + h5x + h6x^2 + h7x^3) --- (8) */
	mulx    %r12,%r12,%rbx
	mulx    %r13,%r13,%rcx
	addq    %rbx,%r13
	mulx    %r14,%r14,%rbx
	adcq    %rcx,%r14
	mulx    %rsi,%r15,%rcx
	adcq    %rbx,%r15
	adcq    $0,%rcx
	/* Add t0 + t1x + t2x^2 + t3x^3 + t4x^4 in (8) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	addq    %r12,%r8
	adcq    %r13,%r9
	adcq    %r14,%r10
	adcq    %r15,%r11
	adcq    $0,%rcx

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * rcx = h4
	 *
	 */

	movq 	56(%rsp),%rdi

	/* Store h(x) */
	movq   	%r8,0(%rdi)
	movq   	%r9,8(%rdi)
	movq   	%r10,16(%rdi)
	movq   	%r11,24(%rdi)
	movq   	%rcx,32(%rdi)

	movq 	 0(%rsp),%r11
	movq 	 8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbp
	movq 	48(%rsp),%rbx

	movq 	%r11,%rsp

	ret

	/* field squaring */

	.p2align 4
	.global secp256k1_fe_sqr_5to5
	.type	secp256k1_fe_sqr_5to5, %function

secp256k1_fe_sqr_5to5:

	movq    %rsp,%r11
	subq    $64,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)
	movq 	%rdi,56(%rsp)

	/* 
         * rbp = g0
	 * rdi = g1
         * rcx = g2
         *
         * The 3-tuple (rbp : rdi : rcx) represents the first three limbs of 
         * the field element g(x) = g0 + g1x + g2x^2 + g3x^3 + g4x^4.
	 */

	movq    0(%rsi),%rbp
	movq    8(%rsi),%rdi
	movq    16(%rsi),%rcx

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* r15 = 0 */
	xorq    %r15,%r15

	/* (r13 : r14) = D * f4 */
	mulx    32(%rsi),%r13,%r14

	/* rsi = f3 */
	movq    24(%rsi),%rsi

	/* Reduce f(x) by adding D * f4  to the f0 + f1x + f2x^2 + f3x^3. */
	addq    %r13,%rbp
	adcq    %r14,%rdi
	adcq    $0,%rcx
	adcq    $0,%rsi

	/* rdx = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%r15

	/* Reduce f(x) further by adding D or 0 to f0 + f1x + f2x^2 + f3x^3. */
	addq    %r15,%rbp
	adcq    $0,%rdi

	/* At this point the input f(x) is fully reduced. The limbs of the field 
         * element are stored in the registers rbp, rdi, rcx, rsi respectively. 
         */

	/*
	 *  (f0 + f1x + f2x^2 + f3x^3)^2 
         *  = (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) +
         *    2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5)
	 */

	/* f0f1x + f0f2x^2 + f0f3x^3 */
	movq    %rbp,%rdx    
	mulx    %rdi,%r9,%r10
	mulx    %rcx,%r8,%r11
	addq    %r8,%r10
	mulx    %rsi,%rdx,%r12
	adcq    %rdx,%r11
	adcq    $0,%r12

	/* f0f1x + f0f2x^2 + f0f3x^3  + f1f2x^3 + f1f3x^4 */
	movq    %rdi,%rdx
	mulx    %rcx,%rax,%rbx
	mulx    %rsi,%rdx,%r13
	addq    %rdx,%rbx
	adcq    $0,%r13
	addq    %rax,%r11
	adcq    %rbx,%r12
	adcq    $0,%r13

	/* f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5 */
	movq    %rcx,%rdx
	mulx    %rsi,%rax,%r14
	addq    %rax,%r13
	adcq    $0,%r14

	/* 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    $0,%r15
	shld    $1,%r14,%r15
	shld    $1,%r13,%r14
	shld    $1,%r12,%r13
	shld    $1,%r11,%r12
	shld    $1,%r10,%r11
	shld    $1,%r9,%r10
	addq    %r9,%r9

	/* f0^2 + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rbp,%rdx
	mulx    %rdx,%r8,%rax
	addq    %rax,%r9

	/* (f0^2 + f1^2x^2) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rdi,%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r10
	adcq    %rbx,%r11

	/* (f0^2 + f1^2x^2 + f2^2x^4) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rcx,%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r12
	adcq    %rbx,%r13

	/* (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rsi,%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r14
	adcq    %rbx,%r15

	/* 
	 * At this point the square is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * r15 = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 */

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* t0 + t1x + t2x^2 + t3x^3 + t4x^4 = D * (h4 + h5x + h6x^2 + h7x^3) --- (9) */
	mulx    %r12,%r12,%rbx
	mulx    %r13,%r13,%rcx
	addq    %rbx,%r13
	mulx    %r14,%r14,%rbx
	adcq    %rcx,%r14
	mulx    %r15,%r15,%rcx
	adcq    %rbx,%r15
	adcq    $0,%rcx
	/* Add t0 + t1x + t2x^2 + t3x^3 + t4x^4 in (9) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	addq    %r12,%r8
	adcq    %r13,%r9
	adcq    %r14,%r10
	adcq    %r15,%r11
	adcq    $0,%rcx

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * rcx = h4
	 *
	 */

	movq 	56(%rsp),%rdi

	/* Store h(x) */
	movq   	%r8,0(%rdi)
	movq   	%r9,8(%rdi)
	movq   	%r10,16(%rdi)
	movq   	%r11,24(%rdi)
	movq   	%rcx,32(%rdi)

	movq 	 0(%rsp),%r11
	movq 	 8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbp
	movq 	48(%rsp),%rbx

	movq 	%r11,%rsp

	ret

/************************************************************************
 * 64-bit field multiplication and squaring using the bottom 4-limbs of *
 * two field elements having 5-limb representation such that the fifth  *
 * limb is zero. A field element in 5-limb form is reported as output   *
 * such that the fifth limb is of at most 33 bits. 			*
 ************************************************************************/

	/* field multiplication */

	.p2align 4
	.global secp256k1_fe_mul_44to5
	.type	secp256k1_fe_mul_44to5, %function

secp256k1_fe_mul_44to5:

	movq 	%rsp,%r11
	subq 	$64,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)
	movq 	%rdi,56(%rsp)

	/* f(x) is accessed through rsi and g(x) through rdi */
	movq    %rdx,%rdi

	/* h0 + h1x + h2x^2 + h3x^3 + h4x^4 = g0 * (f0 + f1x + f2x^2 + f3x^3) --- (10) */
	movq    0(%rdi),%rdx    
	mulx    0(%rsi),%r8,%r9
	mulx    8(%rsi),%rcx,%r10
	addq    %rcx,%r9
	mulx    16(%rsi),%rcx,%r11
	adcq    %rcx,%r10
	mulx    24(%rsi),%rcx,%r12
	adcq    %rcx,%r11
	adcq    $0,%r12

	/* t1x + t2x^2 + t3x^3 + t4x^4 + t5x^5 = g1x * (f0 + f1x + f2x^2 + f3x^3) --- (11) */
	movq    8(%rdi),%rdx    
	mulx    0(%rsi),%rax,%rbx
	mulx    8(%rsi),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    16(%rsi),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    24(%rsi),%rcx,%r13
	adcq    %rcx,%r15
	adcq    $0,%r13
	/* Add t1x + t2x^2 + t3x^3 + t4x^4 + t5x^5 in (11) to  h1x + h2x^2 + h3x^3 + h4x^4  in (10) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 --- (12)
	 */
	addq    %rax,%r9
	adcq    %rbx,%r10
	adcq    %rbp,%r11
	adcq    %r15,%r12
	adcq    $0,%r13

	/* t2x^2 + t3x^3 + t4x^4 + t5x^5 + t6x^6 = g2x^2 * (f0 + f1x + f2x^2 + f3x^3) --- (13) */
	movq    16(%rdi),%rdx
	mulx    0(%rsi),%rax,%rbx
	mulx    8(%rsi),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    16(%rsi),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    24(%rsi),%rcx,%r14
	adcq    %rcx,%r15
	adcq    $0,%r14
	/* Add t2x^2 + t3x^3 + t4x^4 + t5x^5 + t6x^6 in (13) to  h2x^2 + h3x^3 + h4x^4 + h5x^5 in (12) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 --- (14)
	 */
	addq    %rax,%r10
	adcq    %rbx,%r11
	adcq    %rbp,%r12
	adcq    %r15,%r13
	adcq    $0,%r14

	/* t3x^3 + t4x^4 + t5x^5 + t6x^6 + t7x^7 = g3x^2 * (f0 + f1x + f2x^2 + f3x^3) --- (15) */
	movq    24(%rdi),%rdx
	mulx    0(%rsi),%rax,%rbx
	mulx    8(%rsi),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    16(%rsi),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    24(%rsi),%rcx,%rsi
	adcq    %rcx,%r15
	adcq    $0,%rsi
	/* Add t3x^3 + t4x^4 + t5x^5 + t6x^6 + t7x^7 in (15) to  h3x^3 + h4x^4 + h5x^5 + h6x^6 in (14) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 --- (16)
	 */
	addq    %rax,%r11
	adcq    %rbx,%r12
	adcq    %rbp,%r13
	adcq    %r15,%r14
	adcq    $0,%rsi

	/* 
	 * At this point the product is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * rsi = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 */

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* t0 + t1x + t2x^2 + t3x^3 + t4x^4 = D * (h4 + h5x + h6x^2 + h7x^3) --- (17) */
	mulx    %r12,%r12,%rbx
	mulx    %r13,%r13,%rcx
	addq    %rbx,%r13
	mulx    %r14,%r14,%rbx
	adcq    %rcx,%r14
	mulx    %rsi,%r15,%rcx
	adcq    %rbx,%r15
	adcq    $0,%rcx
	/* Add t0 + t1x + t2x^2 + t3x^3 + t4x^4 in (17) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	addq    %r12,%r8
	adcq    %r13,%r9
	adcq    %r14,%r10
	adcq    %r15,%r11
	adcq    $0,%rcx

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * rcx = h4
	 *
	 */

	movq 	56(%rsp),%rdi

	/* Store h(x) */
	movq   	%r8,0(%rdi)
	movq   	%r9,8(%rdi)
	movq   	%r10,16(%rdi)
	movq   	%r11,24(%rdi)
	movq   	%rcx,32(%rdi)

	movq 	 0(%rsp),%r11
	movq 	 8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbp
	movq 	48(%rsp),%rbx

	movq 	%r11,%rsp

	ret

	/* field squaring */

	.p2align 4
	.global secp256k1_fe_sqr_4to5
	.type	secp256k1_fe_sqr_4to5, %function

secp256k1_fe_sqr_4to5:

	movq    %rsp,%r11
	subq    $56,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)

	/* f(x) is accessed through rsi */

	/*
	 *  (f0 + f1x + f2x^2 + f3x^3)^2 
         *  = (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) +
         *    2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5)
	 */

	/* f0f1x + f0f2x^2 + f0f3x^3 */
	movq    0(%rsi),%rdx    
	mulx    8(%rsi),%r9,%r10
	mulx    16(%rsi),%rcx,%r11
	addq    %rcx,%r10
	mulx    24(%rsi),%rcx,%r12
	adcq    %rcx,%r11
	adcq    $0,%r12

	/* f0f1x + f0f2x^2 + f0f3x^3  + f1f2x^3 + f1f3x^4 */
	movq    8(%rsi),%rdx
	mulx    16(%rsi),%rax,%rbx
	mulx    24(%rsi),%rcx,%r13
	addq    %rcx,%rbx
	adcq    $0,%r13
	addq    %rax,%r11
	adcq    %rbx,%r12
	adcq    $0,%r13

	/* f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5 */
	movq    16(%rsi),%rdx
	mulx    24(%rsi),%rax,%r14
	addq    %rax,%r13
	adcq    $0,%r14

	/* 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    $0,%r15
	shld    $1,%r14,%r15
	shld    $1,%r13,%r14
	shld    $1,%r12,%r13
	shld    $1,%r11,%r12
	shld    $1,%r10,%r11
	shld    $1,%r9,%r10
	addq    %r9,%r9

	/* f0^2 + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    0(%rsi),%rdx
	mulx    %rdx,%r8,%rax
	addq    %rax,%r9

	/* (f0^2 + f1^2x^2) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    8(%rsi),%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r10
	adcq    %rbx,%r11

	/* (f0^2 + f1^2x^2 + f2^2x^4) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    16(%rsi),%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r12
	adcq    %rbx,%r13

	/* (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    24(%rsi),%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r14
	adcq    %rbx,%r15

	/* 
	 * At this point the square is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * r15 = h7
	 */

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* t0 + t1x + t2x^2 + t3x^3 + t4x^4 = D * (h4 + h5x + h6x^2 + h7x^3) --- (18) */
	mulx    %r12,%r12,%rbx
	mulx    %r13,%r13,%rcx
	addq    %rbx,%r13
	mulx    %r14,%r14,%rbx
	adcq    %rcx,%r14
	mulx    %r15,%r15,%rcx
	adcq    %rbx,%r15
	adcq    $0,%rcx
	/* Add t0 + t1x + t2x^2 + t3x^3 + t4x^4 in (18) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	addq    %r12,%r8
	adcq    %r13,%r9
	adcq    %r14,%r10
	adcq    %r15,%r11
	adcq    $0,%rcx

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * rcx = h4
	 *
	 */

	/* Store h(x) */
	movq   	%r8,0(%rdi)
	movq   	%r9,8(%rdi)
	movq   	%r10,16(%rdi)
	movq   	%r11,24(%rdi)
	movq   	%rcx,32(%rdi)

	movq 	 0(%rsp),%r11
	movq 	 8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbp
	movq 	48(%rsp),%rbx

	movq 	%r11,%rsp

	ret

/************************************************************************
 * 64-bit field multiplication in which the first argument has 4-limb 	*
 * and the second argument has 5-limb representations such that the 	*
 * fifth limb is of at most 64 bits. The second argument is fully 	*
 * reduced to 4-limb form and then field multiplication is performed. 	*
 * A field element in 5-limb form is reported as output such that the 	*
 * fifth limb is of at most 33 bits.					*
 ************************************************************************/

	/* field multiplication */

	.p2align 4
	.global secp256k1_fe_mul_45to5
	.type	secp256k1_fe_mul_45to5, %function

secp256k1_fe_mul_45to5:

	movq 	%rsp,%r11
	subq 	$88,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)

	/* 
         * r12 = g0
	 * r13 = g1
         * r14 = g2
         * r15 = g3
         * rax = g4
         *
         * The 5-tuple (r12 : r13 : r14 : r15 : rax ) represents the field
         * element g(x) = g0 + g1x + g2x^2 + g3x^3 + g4x^4.
	 */

	movq    0(%rdx),%r12
	movq    8(%rdx),%r13
	movq    16(%rdx),%r14
	movq    24(%rdx),%r15
	movq    32(%rdx),%rax

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* rcx = 0 */
	xorq    %rcx,%rcx

	/* (rax : rbx) = D * g4 */
	mulx    %rax,%rax,%rbx

	/* Reduce g(x) by adding D * g4  to the g0 + g1x + g2x^2 + g3x^3. */
	addq    %rax,%r12
	adcq    %rbx,%r13
	adcq    $0,%r14
	adcq    $0,%r15

	/* rcx = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%rcx

	/* Reduce g(x) further by adding D or 0 to g0 + g1x + g2x^2 + g3x^3. */
	addq    %rcx,%r12
	adcq    $0,%r13

	/* At this point the input g(x) is fully reduced. The limbs of the field 
         * element are stored in the registers r12, r13, r14, r15 respectively. 
         */

	/* Store g0, g1, g2, g3 */
	movq    %r12,56(%rsp)
	movq    %r13,64(%rsp)
	movq    %r14,72(%rsp)
	movq    %r15,80(%rsp)

	/* 
	 * Integer multiplication with the reduced field elements f(x) and g(x) 
         * is performed and the product is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * f(x) is accessed through rsi
         *
	 * rsp56 = g0
         * rsp64 = g1
         * rsp72 = g2
         * rsp80 = g3
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * rsi = h7
	 */

	/* h0 + h1x + h2x^2 + h3x^3 + h4x^4 = g0 * (f0 + f1x + f2x^2 + f3x^3) --- (19) */
	movq    0(%rsi),%rdx
	mulx    56(%rsp),%r8,%r9
	mulx    64(%rsp),%rcx,%r10
	addq    %rcx,%r9
	mulx    72(%rsp),%rcx,%r11
	adcq    %rcx,%r10
	mulx    80(%rsp),%rcx,%r12
	adcq    %rcx,%r11
	adcq    $0,%r12

	/* t1x + t2x^2 + t3x^3 + t4x^4 + t5x^5 = g1x * (f0 + f1x + f2x^2 + f3x^3) --- (20) */
	movq    8(%rsi),%rdx    
	mulx    56(%rsp),%rax,%rbx
	mulx    64(%rsp),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    72(%rsp),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    80(%rsp),%rcx,%r13
	adcq    %rcx,%r15
	adcq    $0,%r13
	/* Add t1x + t2x^2 + t3x^3 + t4x^4 + t5x^5 in (20) to  h1x + h2x^2 + h3x^3 + h4x^4  in (19) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 --- (21)
	 */
	addq    %rax,%r9
	adcq    %rbx,%r10
	adcq    %rbp,%r11
	adcq    %r15,%r12
	adcq    $0,%r13

	/* t2x^2 + t3x^3 + t4x^4 + t5x^5 + t6x^6 = g2x^2 * (f0 + f1x + f2x^2 + f3x^3) --- (22) */
	movq    16(%rsi),%rdx
	mulx    56(%rsp),%rax,%rbx
	mulx    64(%rsp),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    72(%rsp),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    80(%rsp),%rcx,%r14
	adcq    %rcx,%r15
	adcq    $0,%r14
	/* Add t2x^2 + t3x^3 + t4x^4 + t5x^5 + t6x^6 in (22) to  h2x^2 + h3x^3 + h4x^4 + h5x^5 in (21) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 --- (23)
	 */
	addq    %rax,%r10
	adcq    %rbx,%r11
	adcq    %rbp,%r12
	adcq    %r15,%r13
	adcq    $0,%r14

	/* t3x^3 + t4x^4 + t5x^5 + t6x^6 + t7x^7 = g3x^2 * (f0 + f1x + f2x^2 + f3x^3) --- (24) */
	movq    24(%rsi),%rdx
	mulx    56(%rsp),%rax,%rbx
	mulx    64(%rsp),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    72(%rsp),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    80(%rsp),%rcx,%rsi
	adcq    %rcx,%r15
	adcq    $0,%rsi
	/* Add t3x^3 + t4x^4 + t5x^5 + t6x^6 + t7x^7 in (24) to  h3x^3 + h4x^4 + h5x^5 + h6x^6 in (23) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 --- (25)
	 */
	addq    %rax,%r11
	adcq    %rbx,%r12
	adcq    %rbp,%r13
	adcq    %r15,%r14
	adcq    $0,%rsi

	/* 
	 * At this point the product is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * rsi = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 */

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* t0 + t1x + t2x^2 + t3x^3 + t4x^4 = D * (h4 + h5x + h6x^2 + h7x^3) --- (26) */
	mulx    %r12,%r12,%rbx
	mulx    %r13,%r13,%rcx
	addq    %rbx,%r13
	mulx    %r14,%r14,%rbx
	adcq    %rcx,%r14
	mulx    %rsi,%r15,%rcx
	adcq    %rbx,%r15
	adcq    $0,%rcx
	/* Add t0 + t1x + t2x^2 + t3x^3 + t4x^4 in (26) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	addq    %r12,%r8
	adcq    %r13,%r9
	adcq    %r14,%r10
	adcq    %r15,%r11
	adcq    $0,%rcx

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * rcx = h4
	 *
	 */

	/* Store h(x) */
	movq   	%r8,0(%rdi)
	movq   	%r9,8(%rdi)
	movq   	%r10,16(%rdi)
	movq   	%r11,24(%rdi)
	movq   	%rcx,32(%rdi)

	movq 	 0(%rsp),%r11
	movq 	 8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbp
	movq 	48(%rsp),%rbx

	movq 	%r11,%rsp

	ret

/************************************************************************
 * 64-bit field multiplication and squaring using the bottom 4-limbs of *
 * two field elements having 5-limb representation such that the fifth	*
 * limb is zero. A field element in 5-limb form is reported as output	*
 * such that the fifth limb is zero. 					*
 ************************************************************************/

	/* field multiplication */

	.p2align 4
	.global secp256k1_fe_mul_44to4
	.type	secp256k1_fe_mul_44to4, %function

secp256k1_fe_mul_44to4:

	movq 	%rsp,%r11
	subq 	$64,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)
	movq 	%rdi,56(%rsp)

	/* f(x) is accessed through rsi and g(x) through rdi */
	movq    %rdx,%rdi

	/* h0 + h1x + h2x^2 + h3x^3 + h4x^4 = g0 * (f0 + f1x + f2x^2 + f3x^3) --- (27) */
	movq    0(%rdi),%rdx    
	mulx    0(%rsi),%r8,%r9
	mulx    8(%rsi),%rcx,%r10
	addq    %rcx,%r9
	mulx    16(%rsi),%rcx,%r11
	adcq    %rcx,%r10
	mulx    24(%rsi),%rcx,%r12
	adcq    %rcx,%r11
	adcq    $0,%r12

	/* t1x + t2x^2 + t3x^3 + t4x^4 + t5x^5 = g1x * (f0 + f1x + f2x^2 + f3x^3) --- (28) */
	movq    8(%rdi),%rdx    
	mulx    0(%rsi),%rax,%rbx
	mulx    8(%rsi),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    16(%rsi),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    24(%rsi),%rcx,%r13
	adcq    %rcx,%r15
	adcq    $0,%r13
	/* Add t1x + t2x^2 + t3x^3 + t4x^4 + t5x^5 in (28) to  h1x + h2x^2 + h3x^3 + h4x^4  in (27) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 --- (29)
	 */
	addq    %rax,%r9
	adcq    %rbx,%r10
	adcq    %rbp,%r11
	adcq    %r15,%r12
	adcq    $0,%r13

	/* t2x^2 + t3x^3 + t4x^4 + t5x^5 + t6x^6 = g2x^2 * (f0 + f1x + f2x^2 + f3x^3) --- (30) */
	movq    16(%rdi),%rdx
	mulx    0(%rsi),%rax,%rbx
	mulx    8(%rsi),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    16(%rsi),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    24(%rsi),%rcx,%r14
	adcq    %rcx,%r15
	adcq    $0,%r14
	/* Add t2x^2 + t3x^3 + t4x^4 + t5x^5 + t6x^6 in (30) to  h2x^2 + h3x^3 + h4x^4 + h5x^5 in (29) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 --- (31)
	 */
	addq    %rax,%r10
	adcq    %rbx,%r11
	adcq    %rbp,%r12
	adcq    %r15,%r13
	adcq    $0,%r14

	/* t3x^3 + t4x^4 + t5x^5 + t6x^6 + t7x^7 = g3x^2 * (f0 + f1x + f2x^2 + f3x^3) --- (32) */
	movq    24(%rdi),%rdx
	mulx    0(%rsi),%rax,%rbx
	mulx    8(%rsi),%rcx,%rbp
	addq    %rcx,%rbx
	mulx    16(%rsi),%rcx,%r15
	adcq    %rcx,%rbp
	mulx    24(%rsi),%rcx,%rsi
	adcq    %rcx,%r15
	adcq    $0,%rsi
	/* Add t3x^3 + t4x^4 + t5x^5 + t6x^6 + t7x^7 in (32) to  h3x^3 + h4x^4 + h5x^5 + h6x^6 in (31) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 --- (33)
	 */
	addq    %rax,%r11
	adcq    %rbx,%r12
	adcq    %rbp,%r13
	adcq    %r15,%r14
	adcq    $0,%rsi

	/* 
	 * At this point the product is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * rsi = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 *	       = h0 + h1x + h2x^2 + h3x^3 + h4x^4
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * h4, since x^4 = D mod p
	 *	       = h0 + h1x + h2x^2 + h3x^3.
	 */

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* t0 + t1x + t2x^2 + t3x^3 + t4x^4 = D * (h4 + h5x + h6x^2 + h7x^3) --- (34) */
	mulx    %r12,%r12,%rbx
	mulx    %r13,%r13,%rcx
	addq    %rbx,%r13
	mulx    %r14,%r14,%rbx
	adcq    %rcx,%r14
	mulx    %rsi,%r15,%rcx
	adcq    %rbx,%r15
	adcq    $0,%rcx
	/* Add t0 + t1x + t2x^2 + t3x^3 + t4x^4 in (34) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	addq    %r12,%r8
	adcq    %r13,%r9
	adcq    %r14,%r10
	adcq    %r15,%r11
	adcq    $0,%rcx

	/* r15 = 0 */
	xorq    %r15,%r15

	/* (r13 : r14) = D * h4 */
	mulx    %rcx,%r13,%r14

	/* Reduce h(x) by adding D * h4  to the h0 + h1x + h2x^2 + h3x^3. */
	addq    %r13,%r8
	adcq    %r14,%r9
	adcq    $0,%r10
	adcq    $0,%r11

	/* r15 = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%r15

	/* Reduce h(x) further by adding D or 0 to h0 + h1x + h2x^2 + h3x^3. */
	addq    %r15,%r8
	adcq    $0,%r9

	/* 
         * At this point we have the fully reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 *
	 */

	movq 	56(%rsp),%rdi

	/* Store h(x) */
	movq   	%r8,0(%rdi)
	movq   	%r9,8(%rdi)
	movq   	%r10,16(%rdi)
	movq   	%r11,24(%rdi)

	/* Set the 5th limb of h(x) to 0 */
	movq   	$0,32(%rdi)

	movq 	 0(%rsp),%r11
	movq 	 8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbp
	movq 	48(%rsp),%rbx

	movq 	%r11,%rsp

	ret

	/* field squaring */

	.p2align 4
	.global secp256k1_fe_sqr_4to4
	.type	secp256k1_fe_sqr_4to4, %function

secp256k1_fe_sqr_4to4:

	movq    %rsp,%r11
	subq    $56,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)

	/* f(x) is accessed through rsi */

	/*
	 *  (f0 + f1x + f2x^2 + f3x^3)^2 
         *  = (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) +
         *    2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5)
	 */

	/* f0f1x + f0f2x^2 + f0f3x^3 */
	movq    0(%rsi),%rdx    
	mulx    8(%rsi),%r9,%r10
	mulx    16(%rsi),%rcx,%r11
	addq    %rcx,%r10
	mulx    24(%rsi),%rcx,%r12
	adcq    %rcx,%r11
	adcq    $0,%r12

	/* f0f1x + f0f2x^2 + f0f3x^3  + f1f2x^3 + f1f3x^4 */
	movq    8(%rsi),%rdx
	mulx    16(%rsi),%rax,%rbx
	mulx    24(%rsi),%rcx,%r13
	addq    %rcx,%rbx
	adcq    $0,%r13
	addq    %rax,%r11
	adcq    %rbx,%r12
	adcq    $0,%r13

	/* f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5 */
	movq    16(%rsi),%rdx
	mulx    24(%rsi),%rax,%r14
	addq    %rax,%r13
	adcq    $0,%r14

	/* 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    $0,%r15
	shld    $1,%r14,%r15
	shld    $1,%r13,%r14
	shld    $1,%r12,%r13
	shld    $1,%r11,%r12
	shld    $1,%r10,%r11
	shld    $1,%r9,%r10
	addq    %r9,%r9

	/* f0^2 + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    0(%rsi),%rdx
	mulx    %rdx,%r8,%rax
	addq    %rax,%r9

	/* (f0^2 + f1^2x^2) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    8(%rsi),%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r10
	adcq    %rbx,%r11

	/* (f0^2 + f1^2x^2 + f2^2x^4) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    16(%rsi),%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r12
	adcq    %rbx,%r13

	/* (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    24(%rsi),%rdx
	mulx    %rdx,%rax,%rbx
	adcq    %rax,%r14
	adcq    %rbx,%r15

	/* 
	 * At this point the square is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r12 = h4
	 * r13 = h5
	 * r14 = h6
	 * r15 = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 *	       = h0 + h1x + h2x^2 + h3x^3 + h4x^4
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * h4, since x^4 = D mod p
	 *	       = h0 + h1x + h2x^2 + h3x^3.
	 */

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* t0 + t1x + t2x^2 + t3x^3 + t4x^4 = D * (h4 + h5x + h6x^2 + h7x^3) --- (35) */
	mulx    %r12,%r12,%rbx
	mulx    %r13,%r13,%rcx
	addq    %rbx,%r13
	mulx    %r14,%r14,%rbx
	adcq    %rcx,%r14
	mulx    %r15,%r15,%rcx
	adcq    %rbx,%r15
	adcq    $0,%rcx
	/* Add t0 + t1x + t2x^2 + t3x^3 + t4x^4 in (35) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	addq    %r12,%r8
	adcq    %r13,%r9
	adcq    %r14,%r10
	adcq    %r15,%r11
	adcq    $0,%rcx

	/* r15 = 0 */
	xorq    %r15,%r15

	/* (r13 : r14) = D * h4 */
	mulx    %rcx,%r13,%r14

	/* Reduce h(x) by adding D * h4  to the h0 + h1x + h2x^2 + h3x^3. */
	addq    %r13,%r8
	adcq    %r14,%r9
	adcq    $0,%r10
	adcq    $0,%r11

	/* r15 = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%r15

	/* Reduce h(x) further by adding D or 0 to h0 + h1x + h2x^2 + h3x^3. */
	addq    %r15,%r8
	adcq    $0,%r9

	/* 
         * At this point we have the fully reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 *
	 */

	/* Store h(x) */
	movq   	%r8,0(%rdi)
	movq   	%r9,8(%rdi)
	movq   	%r10,16(%rdi)
	movq   	%r11,24(%rdi)

	/* Set the 5th limb of h(x) to 0 */
	movq   	$0,32(%rdi)

	movq 	 0(%rsp),%r11
	movq 	 8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbp
	movq 	48(%rsp),%rbx

	movq 	%r11,%rsp

	ret
