/************************************************************************
 * Field multiplication and squaring assemblies using representation of *
 * field elements in base 2^{64}.				        *
 * Major instructions used in the assemblies are mulx/adcx/adox.        *
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
 * limb is of at most 64 bits. The 5-limb inputs are fully reduced      *  
 * first to 4-limb forms, then multiplied, after which a field element 	*
 * in 5-limb form is reported as output. The fifth limb of the output 	*
 * has at most 33 bits. 						*
 ************************************************************************/
	
	/* field multiplication */

	.p2align 4
	.global secp256k1_fe_mul_55to5
	.type	secp256k1_fe_mul_55to5, %function

secp256k1_fe_mul_55to5:

	movq 	%rsp,%r11
	subq 	$96,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)
	movq 	%rdi,56(%rsp)

	/* 
         * rax = f0
	 * rbx = f1
         * rdi = f2
         *
         * The 3-tuple (rax : rbx : rdi) represents the first three 
         * limbs of the field element f(x) = f0 + f1x + f2x^2 + f3x^3 + f4x^4.
	 */

	movq    0(%rsi),%rax
	movq    8(%rsi),%rbx
	movq    16(%rsi),%rdi

	/* 
         * r8  = g0
	 * r9  = g1
         * r10 = g2
         * r11 = g3
         * r12 = g4
         *
         * The 5-tuple (r8 : r9 : r10 : r11 : r12 ) represents the field
         * element g(x) = g0 + g1x + g2x^2 + g3x^3 + g4x^4.
	 */

	movq    0(%rdx),%r8
	movq    8(%rdx),%r9
	movq    16(%rdx),%r10
	movq    24(%rdx),%r11
	movq    32(%rdx),%r12

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* clear flags, rcx = 0*/
	xorq    %rcx,%rcx

	/* (r13 : r14) = D * f4 */
	mulx    32(%rsi),%r13,%r14

	/* rsi = f3 */
	movq    24(%rsi),%rsi

	/* Reduce f(x) by adding D * f4  to the f0 + f1x + f2x^2 + f3x^3. */
	adcx    %r13,%rax
	adcx    %r14,%rbx
	adcx    %rcx,%rdi
	adcx    %rcx,%rsi

	/* rcx = D if the final carry is 1, else it is 0. */	
	cmovc   %rdx,%rcx

	/* clear flags, r13 = 0*/
	xorq    %r13,%r13

	/* Reduce f(x) further by adding D or 0 to f0 + f1x + f2x^2 + f3x^3. */
	adcx    %rcx,%rax
	adcx    %r13,%rbx

	/* At this point the input f(x) is fully reduced. The limbs of the field 
         * element are stored in the registers rax, rbx, rdi, rsi respectively. 
         */

	/* clear flags, rcx = 0*/
	xorq    %rcx,%rcx

	/* (r13 : r14) = D * g4 */
	mulx    %r12,%r13,%r14

	/* Reduce g(x) by adding D * g4 to g0 + g1x + g2x^2 + g3x^3. */
	adcx    %r13,%r8
	adcx    %r14,%r9
	adcx    %rcx,%r10
	adcx    %rcx,%r11

	/* rcx = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%rcx

	/* clear flags, r13 = 0*/
	xorq    %r13,%r13

	/* Reduce g(x) further by adding D or 0 to g0 + g1x + g2x^2 + g3x^3. */
	adcx    %rcx,%r8
	adcx    %r13,%r9

	/* At this point the input g(x) is fully reduced. The limbs of the field 
         * element are stored in the registers r8, r9, r10, r11 respectively. 
         */

	/* Store g0, g1, g2, g3 */
	movq    %r8,64(%rsp)
	movq    %r9,72(%rsp)
	movq    %r10,80(%rsp)
	movq    %r11,88(%rsp)

	/* 
	 * Integer multiplication with the reduced field elements f(x) and g(x)
         * is performed and the product is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * rax = f0
         * rbx = f1
         * rdi = f2
         * rsi = f3
         *
	 * rsp64 = g0
         * rsp72 = g1
         * rsp80 = g2
         * rsp88 = g3
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

	/* h0 + h1x + h2x^2 + h3x^3 + h4x^4 = g0 * (f0 + f1x + f2x^2 + f3x^3) --- (1) */
	xorq    %r13,%r13
	movq    64(%rsp),%rdx    
	mulx    %rax,%r8,%r9
	mulx    %rbx,%rcx,%r10
	adcx    %rcx,%r9     
	mulx    %rdi,%rcx,%r11
	adcx    %rcx,%r10    
	mulx    %rsi,%rcx,%r12
	adcx    %rcx,%r11
	adcx    %r13,%r12

	/* Add g1x * (f0 + f1x + f2x^2 + f3x^3) to  h1x + h2x^2 + h3x^3 + h4x^4  in (1) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 --- (2)
	 */
	xorq    %r14,%r14
	movq    72(%rsp),%rdx
	mulx    %rax,%rcx,%rbp
	adcx    %rcx,%r9
	adox    %rbp,%r10
	mulx    %rbx,%rcx,%rbp
	adcx    %rcx,%r10
	adox    %rbp,%r11
	mulx    %rdi,%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    %rsi,%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13	
	adcx    %r14,%r13

	/* Add g2x^2 * (f0 + f1x + f2x^2 + f3x^3) to  h2x^2 + h3x^3 + h4x^4 + h5x^5 in (2) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 --- (3)
	 */
	xorq    %r15,%r15
	movq    80(%rsp),%rdx
	mulx    %rax,%rcx,%rbp
	adcx    %rcx,%r10
	adox    %rbp,%r11
	mulx    %rbx,%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    %rdi,%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13
	mulx    %rsi,%rcx,%rbp
	adcx    %rcx,%r13
	adox    %rbp,%r14
	adcx    %r15,%r14

	/* Add g3x^3 * (f0 + f1x + f2x^2 + f3x^3) to  h3x^3 + h4x^4 + h5x^5 + h6x^6 in (3) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 --- (4)
	 */
	xorq    %rdx,%rdx
	movq    88(%rsp),%rdx
	mulx    %rax,%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    %rbx,%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13
	mulx    %rdi,%rcx,%rbp
	adcx    %rcx,%r13
	adox    %rbp,%r14
	mulx    %rsi,%rcx,%rbp
	adcx    %rcx,%r14
	adox    %rbp,%r15			
	adcq    $0,%r15

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
	 * r15 = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 */

	/* clear flags, rbp = 0 */
	xorq    %rbp,%rbp

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* Add D * (h4 + h5x + h6x^2 + h7x^3) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	mulx    %r12,%rax,%r12 
	adcx    %rax,%r8
	adox    %r12,%r9
	mulx    %r13,%rcx,%r13
	adcx    %rcx,%r9
	adox    %r13,%r10
	mulx    %r14,%rcx,%r14
	adcx    %rcx,%r10
	adox    %r14,%r11
	mulx    %r15,%rcx,%r15
	adcx    %rcx,%r11
	adox    %rbp,%r15
	adcx    %rbp,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r15 = h4
	 *
	 */

	movq    56(%rsp),%rdi

	/* Store h(x) */
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)
	movq    %r10,16(%rdi)
	movq    %r11,24(%rdi)
	movq    %r15,32(%rdi)

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
	subq    $56,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)

	/* 
         * rbx = f0
	 * rbp = f1
         * rax = f2
         *
         * The 3-tuple (rbx : rbp : rax) represents the first three limbs of 
         * the field element f(x) = f0 + f1x + f2x^2 + f3x^3 + f4x^4.
	 */

	movq    0(%rsi),%rbx  
	movq    8(%rsi),%rbp  
	movq    16(%rsi),%rax

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* clear flags, r15 = 0*/
	xorq    %r15,%r15

	/* (r13 : r14) = D * f4 */
	mulx    32(%rsi),%r13,%r14

	/* rsi = f3 */
	movq    24(%rsi),%rsi

	/* Reduce f(x) by adding D * f4  to the f0 + f1x + f2x^2 + f3x^3. */
	adcx    %r13,%rbx
	adcx    %r14,%rbp
	adcx    %r15,%rax
	adcx    %r15,%rsi

	/* r15 = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%r15

	/* clear flags, r13 = 0 */
	xorq    %r13,%r13

	/* Reduce f(x) further by adding D or 0 to f0 + f1x + f2x^2 + f3x^3. */
	adcx    %r15,%rbx
	adcx    %r13,%rbp

	/* At this point the input f(x) is fully reduced. The limbs of the field 
         * element are stored in the registers rbx, rbp, rax, rsi respectively. 
         */

	/*
	 *  (f0 + f1x + f2x^2 + f3x^3)^2 
         *  = (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) +
         *    2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5)
	 */

	/* f0f1x + f0f2x^2 + f0f3x^3 */
	xorq    %r13,%r13
	movq    %rbx,%rdx
	mulx    %rbp,%r9,%r10
	mulx    %rax,%rcx,%r11
	adcx    %rcx,%r10
	mulx    %rsi,%rcx,%r12
	adcx    %rcx,%r11
	adcx    %r13,%r12

	/* f0f1x + f0f2x^2 + f0f3x^3  + f1f2x^3 + f1f3x^4 */
	xorq    %r14,%r14
	movq    %rbp,%rdx
	mulx    %rax,%rcx,%rdx
	adcx    %rcx,%r11
	adox    %rdx,%r12
	movq    %rbp,%rdx
	mulx    %rsi,%rcx,%rdx
	adcx    %rcx,%r12
	adox    %rdx,%r13
	adcx    %r14,%r13

	/* f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5 */
	xorq    %r15,%r15
	movq    %rax,%rdx
	mulx    %rsi,%rcx,%r14
	adcx    %rcx,%r13
	adcx    %r15,%r14

	/* 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	shld    $1,%r14,%r15
	shld    $1,%r13,%r14
	shld    $1,%r12,%r13
	shld    $1,%r11,%r12
	shld    $1,%r10,%r11
	shld    $1,%r9,%r10
	addq    %r9,%r9

	/* f0^2 + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */	     
	xorq    %rdx,%rdx
	movq    %rbx,%rdx
	mulx    %rdx,%r8,%rdx
	adcx    %rdx,%r9

	/* (f0^2 + f1^2x^2) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rbp,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r10
	adcx    %rdx,%r11

	/* (f0^2 + f1^2x^2 + f2^2x^4) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rax,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r12
	adcx    %rdx,%r13

	/* (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rsi,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r14
	adcx    %rdx,%r15

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

	/* clear flags, rbp = 0 */
	xorq    %rbp,%rbp

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* Add D * (h4 + h5x + h6x^2 + h7x^3) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	mulx    %r12,%rax,%r12 
	adcx    %rax,%r8
	adox    %r12,%r9
	mulx    %r13,%rcx,%r13
	adcx    %rcx,%r9
	adox    %r13,%r10
	mulx    %r14,%rcx,%r14
	adcx    %rcx,%r10
	adox    %r14,%r11
	mulx    %r15,%rcx,%r15
	adcx    %rcx,%r11
	adox    %rbp,%r15
	adcx    %rbp,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r15 = h4
	 *
	 */

	/* Store h(x) */
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)
	movq    %r10,16(%rdi)
	movq    %r11,24(%rdi)
	movq    %r15,32(%rdi)

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
 * such that the fifth limb is of at most 33 bits. 			*
 ************************************************************************/
	
	/* field multiplication */

	.p2align 4
	.global secp256k1_fe_mul_44to5
	.type	secp256k1_fe_mul_44to5, %function

secp256k1_fe_mul_44to5:

	push    %rbp
	push    %rbx
	push    %r12
	push    %r13
	push    %r14
	push    %r15

	/* f(x) is accessed through rsi and g(x) through rbx */	    
	movq    %rdx,%rbx

	/* h0 + h1x + h2x^2 + h3x^3 + h4x^4 = g0 * (f0 + f1x + f2x^2 + f3x^3) --- (5) */
	xorq    %r13,%r13    
	movq    0(%rbx),%rdx    
	mulx    0(%rsi),%r8,%r9
	mulx    8(%rsi),%rcx,%r10
	adcx    %rcx,%r9     
	mulx    16(%rsi),%rcx,%r11
	adcx    %rcx,%r10    
	mulx    24(%rsi),%rcx,%r12
	adcx    %rcx,%r11
	adcx    %r13,%r12

	/* Add g1x * (f0 + f1x + f2x^2 + f3x^3) to  h1x + h2x^2 + h3x^3 + h4x^4  in (5) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 --- (6)
	 */
	xorq    %r14,%r14
	movq    8(%rbx),%rdx
	mulx    0(%rsi),%rcx,%rbp
	adcx    %rcx,%r9
	adox    %rbp,%r10
	mulx    8(%rsi),%rcx,%rbp
	adcx    %rcx,%r10
	adox    %rbp,%r11
	mulx    16(%rsi),%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    24(%rsi),%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13	
	adcx    %r14,%r13

	/* Add g2x^2 * (f0 + f1x + f2x^2 + f3x^3) to  h2x^2 + h3x^3 + h4x^4 + h5x^5 in (6) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 --- (7)
	 */
	xorq    %r15,%r15
	movq    16(%rbx),%rdx
	mulx    0(%rsi),%rcx,%rbp
	adcx    %rcx,%r10
	adox    %rbp,%r11
	mulx    8(%rsi),%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    16(%rsi),%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13
	mulx    24(%rsi),%rcx,%rbp
	adcx    %rcx,%r13
	adox    %rbp,%r14
	adcx    %r15,%r14

	/* Add g3x^3 * (f0 + f1x + f2x^2 + f3x^3) to  h3x^3 + h4x^4 + h5x^5 + h6x^6 in (7) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 --- (8)
	 */
	xorq    %rax,%rax
	movq    24(%rbx),%rdx
	mulx    0(%rsi),%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    8(%rsi),%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13
	mulx    16(%rsi),%rcx,%rbp
	adcx    %rcx,%r13
	adox    %rbp,%r14
	mulx    24(%rsi),%rcx,%rbp
	adcx    %rcx,%r14
	adox    %rbp,%r15			
	adcx    %rax,%r15

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

	/* clear flags, rbp = 0 */	  
	xorq    %rbp,%rbp

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* Add D * (h4 + h5x + h6x^2 + h7x^3) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	mulx    %r12,%rax,%r12 
	adcx    %rax,%r8
	adox    %r12,%r9
	mulx    %r13,%rcx,%r13
	adcx    %rcx,%r9
	adox    %r13,%r10
	mulx    %r14,%rcx,%r14
	adcx    %rcx,%r10
	adox    %r14,%r11
	mulx    %r15,%rcx,%r15
	adcx    %rcx,%r11
	adox    %rbp,%r15
	adcx    %rbp,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r15 = h4
	 *
	 */

	/* Store h(x) */
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)
	movq    %r10,16(%rdi)
	movq    %r11,24(%rdi)
	movq    %r15,32(%rdi)

	pop     %r15
	pop     %r14
	pop     %r13
	pop     %r12
	pop     %rbx
	pop     %rbp

	ret

	/* field squaring */

	.p2align 4
	.global secp256k1_fe_sqr_4to5
	.type	secp256k1_fe_sqr_4to5, %function

secp256k1_fe_sqr_4to5:

	push    %rbp
	push    %rbx
	push    %r12
	push    %r13
	push    %r14
	push    %r15

	/* 
         * rbx = f0
	 * rbp = f1
         * rax = f2
         * rsi = f3
         *
         * The 4-tuple (rbx : rbp : rax : rsi) represents the first four limbs of 
         * the field element f(x) = f0 + f1x + f2x^2 + f3x^3 + f4x^4.
	 */

	movq    0(%rsi),%rbx  
	movq    8(%rsi),%rbp  
	movq    16(%rsi),%rax
	movq    24(%rsi),%rsi

	/*
	 *  (f0 + f1x + f2x^2 + f3x^3)^2 
         *  = (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) +
         *    2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5)
	 */

	/* f0f1x + f0f2x^2 + f0f3x^3 */
	xorq    %r13,%r13
	movq    %rbx,%rdx
	mulx    %rbp,%r9,%r10
	mulx    %rax,%rcx,%r11
	adcx    %rcx,%r10
	mulx    %rsi,%rcx,%r12
	adcx    %rcx,%r11
	adcx    %r13,%r12

	/* f0f1x + f0f2x^2 + f0f3x^3  + f1f2x^3 + f1f3x^4 */
	xorq    %r14,%r14
	movq    %rbp,%rdx
	mulx    %rax,%rcx,%rdx
	adcx    %rcx,%r11
	adox    %rdx,%r12
	movq    %rbp,%rdx
	mulx    %rsi,%rcx,%rdx
	adcx    %rcx,%r12
	adox    %rdx,%r13
	adcx    %r14,%r13

	/* f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5 */
	xorq    %r15,%r15
	movq    %rax,%rdx
	mulx    %rsi,%rcx,%r14
	adcx    %rcx,%r13
	adcx    %r15,%r14

	/* 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	shld    $1,%r14,%r15
	shld    $1,%r13,%r14
	shld    $1,%r12,%r13
	shld    $1,%r11,%r12
	shld    $1,%r10,%r11
	shld    $1,%r9,%r10
	addq    %r9,%r9

	/* f0^2 + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	xorq    %rdx,%rdx
	movq    %rbx,%rdx
	mulx    %rdx,%r8,%rdx
	adcx    %rdx,%r9

	/* (f0^2 + f1^2x^2) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rbp,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r10
	adcx    %rdx,%r11

	/* (f0^2 + f1^2x^2 + f2^2x^4) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rax,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r12
	adcx    %rdx,%r13

	/* (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rsi,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r14
	adcx    %rdx,%r15

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

	/* clear flags, rbp = 0 */
	xorq    %rbp,%rbp

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* Add D * (h4 + h5x + h6x^2 + h7x^3) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	mulx    %r12,%rax,%rbx
	adcx    %rax,%r8
	adox    %rbx,%r9
	mulx    %r13,%rax,%rbx
	adcx    %rax,%r9
	adox    %rbx,%r10
	mulx    %r14,%rax,%rbx
	adcx    %rax,%r10
	adox    %rbx,%r11
	mulx    %r15,%rax,%r15
	adcx    %rax,%r11
	adox    %rbp,%r15
	adcx    %rbp,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r15 = h4
	 *
	 */

	/* Store h(x) */
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)
	movq    %r10,16(%rdi)
	movq    %r11,24(%rdi)
	movq    %r15,32(%rdi)

	pop     %r15
	pop     %r14
	pop     %r13
	pop     %r12
	pop     %rbx
	pop     %rbp

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
	subq 	$72,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbp,40(%rsp)
	movq 	%rbx,48(%rsp)
	movq 	%rdi,56(%rsp)

	/* 
         * rax = g0
	 * rbx = g1
         * r8  = g2
         * rdi = g3
         *
         * The 4-tuple (rax : rbx : r8 : rdi) represents the first four limbs 
	 * of the field element g(x) = g0 + g1x + g2x^2 + g3x^3 + g4x^4.
	 */

	movq    0(%rdx),%rax
	movq    8(%rdx),%rbx
	movq    16(%rdx),%r8
	movq    24(%rdx),%rdi

	/* access the last limb of g(x) through r15 */
	movq    %rdx,%r15

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* clear flags, rcx = 0*/
	xorq    %rcx,%rcx

	/* (r13 : r14) = D * f4 */
	mulx    32(%r15),%r13,%r14

	/* Reduce f(x) by adding D * f4  to the f0 + f1x + f2x^2 + f3x^3. */
	adcx    %r13,%rax
	adcx    %r14,%rbx
	adcx    %rcx,%r8
	adcx    %rcx,%rdi

	/* rcx = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%rcx

	/* clear flags, r13 = 0*/
	xorq    %r13,%r13

	/* Reduce f(x) further by adding D or 0 to f0 + f1x + f2x^2 + f3x^3. */
	adcx    %rcx,%rax
	adcx    %r13,%rbx

	/* At this point the input f(x) is fully reduced. The limbs of the field 
         * element are stored in the registers rax, rbx, r8, rdi respectively. 
         */

	/* Store f3 */
	movq    %r8,64(%rsp)

	/* 
	 * Integer multiplication with the reduced field elements f(x) and g(x)
         * is performed and the product is
	 *	
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7.
         *
	 * f(x) is accessed through rsi
	 *
	 * rax   = g0
         * rbx   = g1
         * rsp64 = g2
         * rdi   = g3
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

	/* h0 + h1x + h2x^2 + h3x^3 + h4x^4 = g0 * (f0 + f1x + f2x^2 + f3x^3) --- (9) */
	xorq    %r13,%r13
	movq    0(%rsi),%rdx    
	mulx    %rax,%r8,%r9
	mulx    %rbx,%rcx,%r10
	adcx    %rcx,%r9     
	mulx    64(%rsp),%rcx,%r11
	adcx    %rcx,%r10    
	mulx    %rdi,%rcx,%r12
	adcx    %rcx,%r11
	adcx    %r13,%r12

	/* Add g1x * (f0 + f1x + f2x^2 + f3x^3) to  h1x + h2x^2 + h3x^3 + h4x^4  in (9) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 --- (10)
	 */
	xorq    %r14,%r14
	movq    8(%rsi),%rdx
	mulx    %rax,%rcx,%rbp
	adcx    %rcx,%r9
	adox    %rbp,%r10
	mulx    %rbx,%rcx,%rbp
	adcx    %rcx,%r10
	adox    %rbp,%r11
	mulx    64(%rsp),%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    %rdi,%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13	
	adcx    %r14,%r13

	/* Add g2x^2 * (f0 + f1x + f2x^2 + f3x^3) to  h2x^2 + h3x^3 + h4x^4 + h5x^5 in (10) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 --- (11)
	 */
	xorq    %r15,%r15
	movq    16(%rsi),%rdx
	mulx    %rax,%rcx,%rbp
	adcx    %rcx,%r10
	adox    %rbp,%r11
	mulx    %rbx,%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    64(%rsp),%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13
	mulx    %rdi,%rcx,%rbp
	adcx    %rcx,%r13
	adox    %rbp,%r14
	adcx    %r15,%r14

	/* Add g3x^3 * (f0 + f1x + f2x^2 + f3x^3) to  h3x^3 + h4x^4 + h5x^5 + h6x^6 in (11) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 --- (12)
	 */
	xorq    %rdx,%rdx
	movq    24(%rsi),%rdx
	mulx    %rax,%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    %rbx,%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13
	mulx    64(%rsp),%rcx,%rbp
	adcx    %rcx,%r13
	adox    %rbp,%r14
	mulx    %rdi,%rcx,%rbp
	adcx    %rcx,%r14
	adox    %rbp,%r15			
	adcq    $0,%r15

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
	 * r15 = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 */

	/* clear flags, rbp = 0 */	  
	xorq    %rbp,%rbp

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* Add D * (h4 + h5x + h6x^2 + h7x^3) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	mulx    %r12,%rax,%r12 
	adcx    %rax,%r8
	adox    %r12,%r9
	mulx    %r13,%rcx,%r13
	adcx    %rcx,%r9
	adox    %r13,%r10
	mulx    %r14,%rcx,%r14
	adcx    %rcx,%r10
	adox    %r14,%r11
	mulx    %r15,%rcx,%r15
	adcx    %rcx,%r11
	adox    %rbp,%r15
	adcx    %rbp,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r9  = h1
	 * r10 = h2
	 * r11 = h3
	 * r15 = h4
	 *
	 */

	movq    56(%rsp),%rdi

	/* Store h(x) */
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)
	movq    %r10,16(%rdi)
	movq    %r11,24(%rdi)
	movq    %r15,32(%rdi)

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

	push    %rbp
	push    %rbx
	push    %r12
	push    %r13
	push    %r14
	push    %r15

	/* f(x) is accessed through rsi and g(x) through rbx */
	movq    %rdx,%rbx

	/* h0 + h1x + h2x^2 + h3x^3 + h4x^4 = g0 * (f0 + f1x + f2x^2 + f3x^3) --- (13) */
	xorq    %r13,%r13    
	movq    0(%rbx),%rdx    
	mulx    0(%rsi),%r8,%r9
	mulx    8(%rsi),%rcx,%r10
	adcx    %rcx,%r9     
	mulx    16(%rsi),%rcx,%r11
	adcx    %rcx,%r10    
	mulx    24(%rsi),%rcx,%r12
	adcx    %rcx,%r11
	adcx    %r13,%r12

	/* Add g1x * (f0 + f1x + f2x^2 + f3x^3) to  h1x + h2x^2 + h3x^3 + h4x^4  in (13) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 --- (14)
	 */
	xorq    %r14,%r14
	movq    8(%rbx),%rdx
	mulx    0(%rsi),%rcx,%rbp
	adcx    %rcx,%r9
	adox    %rbp,%r10
	mulx    8(%rsi),%rcx,%rbp
	adcx    %rcx,%r10
	adox    %rbp,%r11
	mulx    16(%rsi),%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    24(%rsi),%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13	
	adcx    %r14,%r13

	/* Add g2x^2 * (f0 + f1x + f2x^2 + f3x^3) to  h2x^2 + h3x^3 + h4x^4 + h5x^5 in (14) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 --- (15)
	 */
	xorq    %r15,%r15
	movq    16(%rbx),%rdx
	mulx    0(%rsi),%rcx,%rbp
	adcx    %rcx,%r10
	adox    %rbp,%r11
	mulx    8(%rsi),%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    16(%rsi),%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13
	mulx    24(%rsi),%rcx,%rbp
	adcx    %rcx,%r13
	adox    %rbp,%r14
	adcx    %r15,%r14

	/* Add g3x^3 * (f0 + f1x + f2x^2 + f3x^3) to  h3x^3 + h4x^4 + h5x^5 + h6x^6 in (15) 
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 --- (16)
	 */
	xorq    %rax,%rax
	movq    24(%rbx),%rdx
	mulx    0(%rsi),%rcx,%rbp
	adcx    %rcx,%r11
	adox    %rbp,%r12
	mulx    8(%rsi),%rcx,%rbp
	adcx    %rcx,%r12
	adox    %rbp,%r13
	mulx    16(%rsi),%rcx,%rbp
	adcx    %rcx,%r13
	adox    %rbp,%r14
	mulx    24(%rsi),%rcx,%rbp
	adcx    %rcx,%r14
	adox    %rbp,%r15			
	adcx    %rax,%r15

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
	 * r15 = h7
	 */

	/* Reduce h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4 + h5x^5 + h6x^6 + h7x^7 
	 *	       = h0 + h1x + h2x^2 + h3x^3 + x^4 * (h4 + h5x + h6x^2 + h7x^3)
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * (h4 + h5x + h6x^2 + h7x^3), since x^4 = D mod p
	 *	       = h0 + h1x + h2x^2 + h3x^3 + h4x^4
	 *	       = h0 + h1x + h2x^2 + h3x^3 + D * h4, since x^4 = D mod p
	 *	       = h0 + h1x + h2x^2 + h3x^3.
	 */

	/* clear flags, rbp = 0 */	  
	xorq    %rbp,%rbp

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* Add D * (h4 + h5x + h6x^2 + h7x^3) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	mulx    %r12,%rax,%r12 
	adcx    %rax,%r8
	adox    %r12,%r9
	mulx    %r13,%rcx,%r13
	adcx    %rcx,%r9
	adox    %r13,%r10
	mulx    %r14,%rcx,%r14
	adcx    %rcx,%r10
	adox    %r14,%r11
	mulx    %r15,%rcx,%r15
	adcx    %rcx,%r11
	adox    %rbp,%r15
	adcx    %rbp,%r15

	/* clear flags, rbp = 0 */
	xorq    %rbp,%rbp

	/* (r14 : r15) = D * h4 */
	mulx    %r15,%r14,%r15

	/* Reduce h(x) by adding D * h4 to the h0 + h1x + h2x^2 + h3x^3. */
	adcx    %r14,%r8	
	adcx    %r15,%r9
	adcx    %rbp,%r10
	adcx    %rbp,%r11

	/* rbp = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%rbp

	/* Reduce h(x) further by adding D or 0 to h0 + h1x + h2x^2 + h3x^3. */
	/* clear flags, rbx = 0 */
	xorq    %rbx,%rbx
	adcx    %rbp,%r8
	adcx    %rbx,%r9

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

	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)
	movq    %r10,16(%rdi)
	movq    %r11,24(%rdi)

	/* Set the 5th limb of h(x) to 0 */
	movq    $0,32(%rdi)

	pop     %r15
	pop     %r14
	pop     %r13
	pop     %r12
	pop     %rbx
	pop     %rbp

	ret

	/* field squaring */

	.p2align 4
	.global secp256k1_fe_sqr_4to4
	.type	secp256k1_fe_sqr_4to4, %function

secp256k1_fe_sqr_4to4:

	push    %rbp
	push    %rbx
	push    %r12
	push    %r13
	push    %r14
	push    %r15

	/* 
         * rbx = f0
	 * rbp = f1
         * rax = f2
         * rsi = f3
         *
         * The 4-tuple (rbx : rbp : rax : rsi) represents the field
         * element f(x) = f0 + f1x + f2x^2 + f3x^3.
	 */

	movq    0(%rsi),%rbx  
	movq    8(%rsi),%rbp  
	movq    16(%rsi),%rax
	movq    24(%rsi),%rsi

	/*
	 *  (f0 + f1x + f2x^2 + f3x^3)^2 
         *  = (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) +
         *    2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5)
	 */

	/* f0f1x + f0f2x^2 + f0f3x^3 */
	xorq    %r13,%r13
	movq    %rbx,%rdx
	mulx    %rbp,%r9,%r10
	mulx    %rax,%rcx,%r11
	adcx    %rcx,%r10
	mulx    %rsi,%rcx,%r12
	adcx    %rcx,%r11
	adcx    %r13,%r12

	/* f0f1x + f0f2x^2 + f0f3x^3  + f1f2x^3 + f1f3x^4 */
	xorq    %r14,%r14
	movq    %rbp,%rdx
	mulx    %rax,%rcx,%rdx
	adcx    %rcx,%r11
	adox    %rdx,%r12
	movq    %rbp,%rdx
	mulx    %rsi,%rcx,%rdx
	adcx    %rcx,%r12
	adox    %rdx,%r13
	adcx    %r14,%r13

	/* f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5 */
	xorq    %r15,%r15
	movq    %rax,%rdx
	mulx    %rsi,%rcx,%r14
	adcx    %rcx,%r13
	adcx    %r15,%r14

	/* 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	shld    $1,%r14,%r15
	shld    $1,%r13,%r14
	shld    $1,%r12,%r13
	shld    $1,%r11,%r12
	shld    $1,%r10,%r11
	shld    $1,%r9,%r10
	addq    %r9,%r9

	/* f0^2 + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */	     
	xorq    %rdx,%rdx
	movq    %rbx,%rdx
	mulx    %rdx,%r8,%rdx
	adcx    %rdx,%r9

	/* (f0^2 + f1^2x^2) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rbp,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r10
	adcx    %rdx,%r11

	/* (f0^2 + f1^2x^2 + f2^2x^4) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rax,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r12
	adcx    %rdx,%r13

	/* (f0^2 + f1^2x^2 + f2^2x^4 + f3^2x^6) + 2(f0f1x + f0f2x^2 + f0f3x^3 + f1f2x^3 + f1f3x^4 + f2f3x^5) */
	movq    %rsi,%rdx
	mulx    %rdx,%rcx,%rdx
	adcx    %rcx,%r14
	adcx    %rdx,%r15

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

	/* clear flags, rbp = 0*/
	xorq    %rbp,%rbp

	/* rdx = D */
	movq    $0x1000003D1,%rdx

	/* Add D * (h4 + h5x + h6x^2 + h7x^3) to  h0 + h1x + h2x^2 + h3x^3
	 * to obtain h0 + h1x + h2x^2 + h3x^3 + h4x^4.
	 */
	mulx    %r12,%rax,%rbx
	adcx    %rax,%r8
	adox    %rbx,%r9
	mulx    %r13,%rax,%rbx
	adcx    %rax,%r9
	adox    %rbx,%r10
	mulx    %r14,%rax,%rbx
	adcx    %rax,%r10
	adox    %rbx,%r11
	mulx    %r15,%rax,%r15
	adcx    %rax,%r11
	adox    %rbp,%r15
	adcx    %rbp,%r15

	/* clear flags, rbp = 0 */
	xorq    %rbp,%rbp

	/* (r14 : r15) = D * h4 */
	mulx    %r15,%r14,%r15

	/* Reduce h(x) by adding D * h4  to the h0 + h1x + h2x^2 + h3x^3. */
	adcx    %r14,%r8	
	adcx    %r15,%r9
	adcx    %rbp,%r10
	adcx    %rbp,%r11

	/* rbp = D if the final carry is 1, else it is 0. */
	cmovc   %rdx,%rbp

	/* Reduce h(x) further by adding D or 0 to h0 + h1x + h2x^2 + h3x^3. */
	/* clear flags, rbx = 0 */
	xorq    %rbx,%rbx
	adcx    %rbp,%r8
	adcx    %rbx,%r9

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
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)
	movq    %r10,16(%rdi)
	movq    %r11,24(%rdi)

	/* Set the 5th limb of h(x) to 0 */
	movq    $0,32(%rdi)

	pop     %r15
	pop     %r14
	pop     %r13
	pop     %r12
	pop     %rbx
	pop     %rbp

	ret

