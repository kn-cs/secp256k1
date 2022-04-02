/************************************************************************
 * Field multiplication and squaring assemblies using representation of *
 * field elements in base 2^{64}.				          *
 * Major instructions used in the assemblies are mul/add/adc.           *
 *									  *
 * Copyright (c) 2021 Kaushik Nath                                      *
 * Distributed under the MIT software license, see the accompanying     *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php. *
 ************************************************************************/


/************************************************************************
 *									*
 *	    Integer multiplication and squaring algorithm		*
 *									*
 ************************************************************************
 * Let D = 2^{32} + 977, p = 2^{256} - D, x = 2^{64}. A field element*
 * in F(p) is represented as 						*
 * 									*
 * f(x) = f0 + f1x + f2x^2 + f3x^3.					*
 * 									*
 * The schoolbook product of f(x) and g(x) modulo p can be written as*
 * h(x) = h0 + h1x + h2x^2 + h3x^3 such that,				*
 * 									*
 * h0 = f0g0 + D * (f1g3 + f2g2 + f3g1)				*
 * h1 = f0g1 + f1g0 + D * (f2g3 + f3g2)				*
 * h2 = f0g2 + f1g1 + f2g0 + D * f3g3					*
 * h3 = f0g3 + f1g2 + f2g1 + f3g0.					*
 *									*
 * Define figj = uij + vij * x. Then the coefficients of h(x) can be *
 * further written as							*
 *									*
 * h0 = u00 + D * (u13 + u22 + u31 + v03 + v12 + v21 + v30)		*
 * h1 = u01 + u10 + v00 + D * (u23 + u32 + v13 + v22 + v31)		*
 * h2 = u02 + u11 + u20 + v01 + v10 + D * (u33 + v23 + v32)		*
 * h3 = u03 + u12 + u21 + u30 + v02 + v11 + v20 + D * v33.		*
 *									*
 * The square of a field element f(x) modulo can be written as	*
 * h(x) = h0 + h1x + h2x^2 + h3x^3 such that,				*
 * 									*
 * h0 = f0^2 + D * (2f1f3 + f2^2)					*
 * h1 = 2f0f1 + D * (2f2f3)						*
 * h2 = 2f0f2 + f1^2 + D * f3^2					*
 * h3 = 2f0f3 + 2f1f2.							*
 *									*
 * In this case the coeffecients of h(x) can be further written as	*
 *									*
 * h0 = u00 + D * (2u13 + u22 + 2v03 + 2v12)				*
 * h1 = 2u01 + v00 + D * (2u23 + 2v13 + v22)				*
 * h2 = 2u02 + u11 + 2v01 + D * (u33 + 2v23)				*
 * h3 = 2u03 + 2u12 + 2v02 + v11 + D * v33.				*
 *									*
 ************************************************************************
 *									*
 *		   Field reduction algorithm				*
 *									*
 ************************************************************************
 * h(x) = h0 + h1x + h2x^2 + h3x^3					*
 *      = (h00 + h00x) + (h10 + h10x)x + 				*
 *        (h20 + h21x)x^2 + (h30 + h31x)x^3				*
 *	= h0 + h1x + h2x^2 + h3x^3 + h4x^4 (Partial reduction)	*
 *	= h0 + h1x + h2x^2 + h3x^3 + h4 * D, since x^4 = D mod p	*
 *	= h0 + h1x + h2x^2 + h3x^3 + h4x^4, h4 is either 0 or 1	*
 *	= h0 + h1x + h2x^2 + h3x^3 (Full reduction).			*
 *									*
 ************************************************************************/

	.att_syntax
	.text

/************************************************************************
 * 64-bit field multiplication and squaring using the bottom 4-limbs of *
 * two field elements having 5-limb representation such that the fifth  *
 * limb is of at most 64 bits. The 5-limb inputs are fully reduced      * 
 * first to 4-limb forms, then multiplied, after which a field element  *
 * in 5-limb form is reported as output. The fifth limb of the output   *
 * has at most 33 bits.						   *
 ************************************************************************/
	
	/* field multiplication */

	.p2align 4
	.global secp256k1_fe_mul_55to5
	.type	secp256k1_fe_mul_55to5, %function

secp256k1_fe_mul_55to5:

	movq   %rsp,%r11
	subq   $96,%rsp

	movq   %r11,0(%rsp)
	movq   %r12,8(%rsp)
	movq   %r13,16(%rsp)
	movq   %r14,24(%rsp)
	movq   %r15,32(%rsp)
	movq   %rbx,40(%rsp)
	movq   %rbp,48(%rsp)
	movq   %rdi,56(%rsp)

	/* rcx = D */
	movq   $0x1000003d1,%rcx

	/* 
         * r8  = g0
	 * r9  = g1
         * rbx = g2
         * rbp = g3
         * r13 = g4
         *
         * The 5-tuple (r8 : r9 : rbx : rbp : r13) represents the field
         * element g(x) = g0 + g1x + g2x^2 + g3x^3 + g4x^4.
	*/

	movq   0(%rdx),%r8
	movq   8(%rdx),%r9
	movq   16(%rdx),%rbx
	movq   24(%rdx),%rbp
	movq   32(%rdx),%r13

	/* 
         * r10 = f2
	 * r11 = f3
	 * rax = f4
	 *
         * The 3-tuple (r10 : r11 : rax) represents the last three limbs
         * of the field element f(x) = f0 + f1x + f2x^2 + f3x^3 + f4x^4.
	*/

	movq   16(%rsi),%r10
	movq   24(%rsi),%r11
	movq   32(%rsi),%rax
	
	/* (rax : rdx) = D * f4 */
	mulq   %rcx

	/* rdi = 0 */ 
	xorq   %rdi,%rdi

	/* Reduce f(x) by adding D * f4  to the f0 + f1x + f2x^2 + f3x^3. */
	addq   0(%rsi),%rax
	adcq   8(%rsi),%rdx
	adcq   $0,%r10
	movq   %r10,80(%rsp)
	adcq   $0,%r11
	movq   %r11,88(%rsp)

	/* rdi = D if the final carry is 1, else it is 0. */
	cmovc  %rcx,%rdi

	/* Reduce f(x) further by adding D or 0 to f0 + f1x + f2x^2 + f3x^3. */
	addq   %rax,%rdi
	movq   %rdi,64(%rsp)
	adcq   $0,%rdx
	movq   %rdx,72(%rsp)

	/* At this point the input f(x) is fully reduced. The limbs of the field 
         * element are stored at the memory locations rsp64, rsp72, rsp80, rsp88
         * respectively. 
        */

	/* rax = g4 */
	movq   %r13,%rax

	/* (rax : rdx) = D * g4 */
	mulq   %rcx 

	/* rdi = 0 */
	xorq   %rdi,%rdi

	/* Reduce g(x) by adding D * g4  to the g0 + g1x + g2x^2 + g3x^3. */
	addq   %r8,%rax
	adcq   %r9,%rdx
	adcq   $0,%rbx
	adcq   $0,%rbp

	/* rdi = D if the final carry is 1, else it is 0. */
	cmovc  %rcx,%rdi

	/* Reduce g(x) further by adding D or 0 to g0 + g1x + g2x^2 + g3x^3. */
	addq   %rax,%rdi
	adcq   $0,%rdx
	movq   %rdx,%rsi

	/* 
         * At this point the input g(x) is fully reduced. The limbs of the field 
         * element are stored in the registers rdi, rsi, rbx, rbp respectively.
	 * Integer multiplication with the reduced field elements f(x) and g(x)
         * is performed and the product is h(x).
         *
	 * rsp64 = f0
         * rsp72 = f1
         * rsp80 = f2
         * rsp88 = f3
         *
	 * rdi = g0
         * rsi = g1
         * rbx = g2
         * rbp = g3
         *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	*/

	/* rax = f1 */
	movq   72(%rsp),%rax
	/* (rax : rdx) = f1g3 = u13 + v13x */
	mulq   %rbp
	/* h0 = (r8 : r9) = u13 */
	movq   %rax,%r8
	xorq   %r9,%r9
	/* h1 = (r10 : r11) = v13 */
	movq   %rdx,%r10
	xorq   %r11,%r11

	/* rax = f2 */
	movq   80(%rsp),%rax
	/* (rax : rdx) = f2g2 = u22 + v22x */
	mulq   %rbx
	/* h0 = (r8 : r9) = u13 + u22 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v13 + v22 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f3 */
	movq   88(%rsp),%rax
	/* (rax : rdx) = f3g1 = u31 + v31x */
	mulq   %rsi
	/* h0 = (r8 : r9) = u13 + u22 + u31 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v13 + v22 + v31 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   80(%rsp),%rax
	/* (rax : rdx) = f2g3 = u23 + v23x */
	mulq   %rbp
	/* h1 = (r10 : r11) = u23 + v13 + v22 + v31 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 */
	movq   %rdx,%r12
	xorq   %r13,%r13

	/* rax = f3 */
	movq   88(%rsp),%rax
	/* (rax : rdx) = f3g2 = u32 + v32x */
	mulq   %rbx
	/* h1 = (r10 : r11) = u23 + u32 + v13 + v22 + v31 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 + v32 */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rcx,%rax
	/* h1 = (r10 : r11) = D * (u23 + u32 + v13 + v22 + v31) */
	mulq   %r10
	imul   %rcx,%r11
	movq   %rax,%r10
	addq   %rdx,%r11

	/* rax = f3 */
	movq   88(%rsp),%rax
	/* (rax : rdx) = f3g3 = u33 + v33x */
	mulq   %rbp
	/* h2 = (r12 : r13) = u33 + v23 + v32 */
	addq   %rax,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rcx,%rax
	/* h3 = (r14 : r15) = D * v33 */
	mulq   %rdx
	movq   %rax,%r14
	movq   %rdx,%r15

	/* rax = D */
	movq   %rcx,%rax
	/* h2 = (r12 : r13) = D * (u33 + v23 + v32) */
	mulq   %r12
	imul   %rcx,%r13
	movq   %rax,%r12
	addq   %rdx,%r13

	/* rax = f0 */
	movq   64(%rsp),%rax
	/* (rax : rdx) = f0g3 = u03 + v03x */
	mulq   %rbp
	/* h3 = (r14 : r15) = u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f1 */
	movq   72(%rsp),%rax
	/* (rax : rdx) = f1g2 = u12 + v12x */
	mulq   %rbx
	/* h3 = (r14 : r15) = u03 + u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f2 */
	movq   80(%rsp),%rax
	/* (rax : rdx) = f2g1 = u21 + v21x */
	mulq   %rsi
	/* h3 = (r14 : r15) = u03 + u12 + u21 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 + v21 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f3 */
	movq   88(%rsp),%rax
	/* (rax : rdx) = f3g0 = u30 + v30x */
	mulq   %rdi
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 + v21 + v30 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = D */
	movq   %rcx,%rax
	/* h0 = (r8 : r9) = D * (u13 + u22 + u31 + v03 + v12 + v21 + v30) */
	mulq   %r8
	imul   %rcx,%r9
	movq   %rax,%r8
	addq   %rdx,%r9

	/* rax = f0 */
	movq   64(%rsp),%rax
	/* (rax : rdx) = f0g0 = u00 + v00x */
	mulq   %rdi
	/* h0 = (r8 : r9) = u00 + D * (u13 + u22 + u31 + v03 + v12 + v21 + v30) */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f0 */
	movq   64(%rsp),%rax
	/* (rax : rdx) = f0g1 = u01 + v01x */
	mulq   %rsi
	/* h1 = (r10 : r11) = u01 + v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + D * (u33 + v23 + v32) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f1 */
	movq   72(%rsp),%rax
	/* (rax : rdx) = f1g0 = u10 + v10x */
	mulq   %rdi
	/* h1 = (r10 : r11) = u01 + u10 + v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f0 */
	movq   64(%rsp),%rax
	/* (rax : rdx) = f0g2 = u02 + v02x */
	mulq   %rbx
	/* h2 = (r12 : r13) = u02 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f1 */
	movq   72(%rsp),%rax
	/* (rax : rdx) = f1g1 = u11 + v11x */
	mulq   %rsi
	/* h2 = (r12 : r13) = u02 + u11 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + v11 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f2 */
	movq   80(%rsp),%rax
	/* (rax : rdx) = f2g0 = u20 + v20x */
	mulq   %rdi
	/* h2 = (r12 : r13) = u02 + u11 + u20 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + v11 + v20 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the product h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	 *
	*/

	/* Reduce h(x) to a 5-limb form. */
	addq   %r9,%r10
	adcq   $0,%r11
	addq   %r11,%r12
	adcq   $0,%r13
	addq   %r13,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r10 = h1
	 * r12 = h2
	 * r14 = h3
	 * r15 = h4
	 *
	 */

	movq   56(%rsp),%rdi

	/* Store h(x) */
	movq   %r8,0(%rdi)
	movq   %r10,8(%rdi)
	movq   %r12,16(%rdi)
	movq   %r14,24(%rdi)
	movq   %r15,32(%rdi)

	movq   0(%rsp),%r11
	movq   8(%rsp),%r12
	movq   16(%rsp),%r13
	movq   24(%rsp),%r14
	movq   32(%rsp),%r15
	movq   40(%rsp),%rbx
	movq   48(%rsp),%rbp

	movq   %r11,%rsp

	ret

	/* field squaring */

	.p2align 4
	.global secp256k1_fe_sqr_5to5
	.type	secp256k1_fe_sqr_5to5, %function

secp256k1_fe_sqr_5to5:

	movq   %rsp,%r11
	subq   $64,%rsp

	movq   %r11,0(%rsp)
	movq   %r12,8(%rsp)
	movq   %r13,16(%rsp)
	movq   %r14,24(%rsp)
	movq   %r15,32(%rsp)
	movq   %rbx,40(%rsp)
	movq   %rbp,48(%rsp)
	movq   %rdi,56(%rsp)

	/* 
         * rbx = f0
	 * rbp = f1
         * rcx = f2
         * rdi = f3
         * rax = f4
         *
         * The 5-tuple (rbx rbp rcx rdi rax) represents the field
         * element f(x) = f0 + f1x + f2x^2 + f3x^3 + f4x^4.
	*/

	movq   0(%rsi),%rbx
	movq   8(%rsi),%rbp
	movq   16(%rsi),%rcx
	movq   24(%rsi),%rdi
	movq   32(%rsi),%rax

	/* rsi = D */
	movq   $0x1000003d1,%rsi

	/* (rax : rdx) = D * f4 */
	mulq   %rsi

        /* r8 = 0 */
	movq   $0,%r8

	/* Reduce f(x) by adding D * f4  to the f0 + f1x + f2x^2 + f3x^3. */
	addq   %rax,%rbx
	adcq   %rdx,%rbp
	adcq   $0,%rcx
	adcq   $0,%rdi

	/* r8 = D if the final carry is 1, else it is 0. */	
	cmovc  %rsi,%r8

	/* Reduce f(x) further by adding D or 0 to f0 + f1x + f2x^2 + f3x^3. */
	addq   %r8,%rbx
	adcq   $0,%rbp

	/* 
         * At this point the input f(x) is fully reduced. The limbs of the field 
         * element are stored in the registers rbx, rbp, rcx, rdi respectively.
	 * Integer squaring with the reduced field element f(x) is performed and 
         * the square is h(x).
         *
	 * rbx = f0
         * rbp = f1
         * rcx = f2
         * rdi = f3
         *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	*/

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1f3 = u13 + v13x */
	mulq   %rdi
	/* h0 = (r8 : r9) = u13 */
	movq   %rax,%r8
	xorq   %r9,%r9
	/* h1 = (r10 : r11) = v13 */
	movq   %rdx,%r10
	xorq   %r11,%r11
	/* h0 = (r8 : r9) = 2u13 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = 2v13 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   %rcx,%rax
	/* (rax : rdx) = f2^2 = u22 + v22x */
	mulq   %rcx
	/* h0 = (r8 : r9) = 2u13 + u22 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = 2v13 + v22 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   %rcx,%rax
	/* (rax : rdx) = f2f3 = u23 + v23x */
	mulq   %rdi
	/* h1 = (r10 : r11) = u23 + 2v13 + v22 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 */
	movq   %rdx,%r12
	xorq   %r13,%r13
	/* h1 = (r10 : r11) = 2u23 + 2v13 + v22 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = 2v23 */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rsi,%rax
	/* h1 = (r10 : r11) = D * (2u23 + 2v13 + v22) */
	mulq   %r10
	imul   %rsi,%r11
	movq   %rax,%r10
	addq   %rdx,%r11

	/* rax = f3 */
	movq   %rdi,%rax
	/* (rax : rdx) = f3^2 = u33 + v33x */
	mulq   %rdi
	/* h2 = (r12 : r13) = u33 + 2v23 */
	addq   %rax,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rsi,%rax
	/* h3 = (r14 : r15) = D * v33 */
	mulq   %rdx
	movq   %rax,%r14
	movq   %rdx,%r15

	/* rax = D */
	movq   %rsi,%rax
	/* h2 = (r12 : r13) = D * (u33 + 2v23) */
	mulq   %r12
	imul   %rsi,%r13
	movq   %rax,%r12
	addq   %rdx,%r13

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f3 = u03 + v03x */
	mulq   %rdi
	/* h3 = (r14 : r15) = u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + v03 */
	addq   %rdx,%r8
	adcq   $0,%r9
	/* h3 = (r14 : r15) = 2u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1f2 = u12 + v12x */
	mulq   %rcx
	/* h3 = (r14 : r15) = 2u03 + u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 + v12 */
	addq   %rdx,%r8
	adcq   $0,%r9
	/* h3 = (r14 : r15) = 2u03 + 2u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 + 2v12 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = D */
	movq   %rsi,%rax
	/* h0 = (r8 : r9) = D * (2u13 + u22 + 2v03 + 2v12) */
	mulq   %r8
	imul   %rsi,%r9
	movq   %rax,%r8
	addq   %rdx,%r9

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0^2 = u00 + v00x */
	mulq   %rbx
	/* h0 = (r8 : r9) = u00 + D * (2u13 + u22 + 2v03 + 2v12) */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v00 + D * (2u23 + 2v13 + v22) */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f1 = u01 + v01x */
	mulq   %rbp
	/* h1 = (r10 : r11) = u01 + v00 + D * (2u23 + 2v13 + v22) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + D * (u33 + 2v23) */
	addq   %rdx,%r12
	adcq   $0,%r13
	/* h1 = (r10 : r11) = 2u01 + v00 + D * (2u23 + 2v13 + v22) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = 2v01 + D * (u33 + 2v23) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f2 = u02 + v02x */
	mulq   %rcx
	/* h2 = (r12 : r13) = u02 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15
	/* h2 = (r12 : r13) = 2u02 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + 2v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1^2 = u11 + v11x */
	mulq   %rbp
	/* h2 = (r12 : r13) = 2u02 + u11 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + 2v02 + v11 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the product h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	 *
	*/

	/* Reduce h(x) to a 5-limb form. */
	addq   %r9,%r10
	adcq   $0,%r11
	addq   %r11,%r12
	adcq   $0,%r13
	addq   %r13,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r10 = h1
	 * r12 = h2
	 * r14 = h3
	 * r15 = h4
	 *
	 */

	movq   56(%rsp),%rdi

	/* Store h(x) */
	movq   %r8,0(%rdi)
	movq   %r10,8(%rdi)
	movq   %r12,16(%rdi)
	movq   %r14,24(%rdi)
	movq   %r15,32(%rdi)

	movq   0(%rsp),%r11
	movq   8(%rsp),%r12
	movq   16(%rsp),%r13
	movq   24(%rsp),%r14
	movq   32(%rsp),%r15
	movq   40(%rsp),%rbx
	movq   48(%rsp),%rbp

	movq   %r11,%rsp

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

	movq   %rsp,%r11
	subq   $48,%rsp

	movq   %r11,0(%rsp)
	movq   %r12,8(%rsp)
	movq   %r13,16(%rsp)
	movq   %r14,24(%rsp)
	movq   %r15,32(%rsp)
	movq   %rbx,40(%rsp)

	/* f(x) is accessed through rsi and g(x) through rcx */
	movq   %rdx,%rcx

	/* rbx = D */
	movq   $0x1000003D1,%rbx

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g3 = u13 + v13x */
	mulq   24(%rcx)
	/* h0 = (r8 : r9) = u13 */
	movq   %rax,%r8
	xorq   %r9,%r9
	/* h1 = (r10 : r11) = v13 */
	movq   %rdx,%r10
	xorq   %r11,%r11

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g2 = u22 + v22x */
	mulq   16(%rcx)
	/* h0 = (r8 : r9) = u13 + u22 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v13 + v22 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g1 = u31 + v31x */
	mulq   8(%rcx)
	/* h0 = (r8 : r9) = u13 + u22 + u31 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v13 + v22 + v31 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g3 = u23 + v23x */
	mulq   24(%rcx)
	/* h1 = (r10 : r11) = u23 + v13 + v22 + v31 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 */
	movq   %rdx,%r12
	xorq   %r13,%r13

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g2 = u32 + v32x */
	mulq   16(%rcx)
	/* h1 = (r10 : r11) = u23 + u32 + v13 + v22 + v31 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 + v32 */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rbx,%rax
	/* h1 = (r10 : r11) = D * (u23 + u32 + v13 + v22 + v31) */
	mulq   %r10
	imul   %rbx,%r11
	movq   %rax,%r10
	addq   %rdx,%r11

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g3 = u33 + v33x */
	mulq   24(%rcx)
	/* h2 = (r12 : r13) = u33 + v23 + v32 */
	addq   %rax,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rbx,%rax
	/* h3 = (r14 : r15) = D * v33 */
	mulq   %rdx
	movq   %rax,%r14
	movq   %rdx,%r15

	/* rax = D */
	movq   %rbx,%rax
	/* h2 = (r12 : r13) = D * (u33 + v23 + v32) */
	mulq   %r12
	imul   %rbx,%r13
	movq   %rax,%r12
	addq   %rdx,%r13

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g3 = u03 + v03x */
	mulq   24(%rcx)
	/* h3 = (r14 : r15) = u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g2 = u12 + v12x */
	mulq   16(%rcx)
	/* h3 = (r14 : r15) = u03 + u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g1 = u21 + v21x */
	mulq   8(%rcx)
	/* h3 = (r14 : r15) = u03 + u12 + u21 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 + v21 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g0 = u30 + v30x */
	mulq   0(%rcx)
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 + v21 + v30 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = D */
	movq   %rbx,%rax
	/* h0 = (r8 : r9) = D * (u13 + u22 + u31 + v03 + v12 + v21 + v30) */
	mulq   %r8
	imul   %rbx,%r9
	movq   %rax,%r8
	addq   %rdx,%r9

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g0 = u00 + v00x */
	mulq   0(%rcx)
	/* h0 = (r8 : r9) = u00 + D * (u13 + u22 + u31 + v03 + v12 + v21 + v30) */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g1 = u01 + v01x */
	mulq   8(%rcx)
	/* h1 = (r10 : r11) = u01 + v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + D * (u33 + v23 + v32) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g0 = u10 + v10x */
	mulq   0(%rcx)
	/* h1 = (r10 : r11) = u01 + u10 + v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g2 = u02 + v02x */
	mulq   16(%rcx)
	/* h2 = (r12 : r13) = u02 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g1 = u11 + v11x */
	mulq   8(%rcx)
	/* h2 = (r12 : r13) = u02 + u11 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + v11 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g0 = u20 + v20x */
	mulq   0(%rcx)
	/* h2 = (r12 : r13) = u02 + u11 + u20 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + v11 + v20 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the product h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	 *
	*/

	/* Reduce h(x) to a 5-limb form. */
	addq   %r9,%r10
	adcq   $0,%r11
	addq   %r11,%r12
	adcq   $0,%r13
	addq   %r13,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the partially reduced field element  
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r10 = h1
	 * r12 = h2
	 * r14 = h3
	 * r15 = h4
	 *
	 */

	/* Store h(x) */
	movq   %r8,0(%rdi)
	movq   %r10,8(%rdi)
	movq   %r12,16(%rdi)
	movq   %r14,24(%rdi)
	movq   %r15,32(%rdi)

	movq   0(%rsp),%r11
	movq   8(%rsp),%r12
	movq   16(%rsp),%r13
	movq   24(%rsp),%r14
	movq   32(%rsp),%r15
	movq   40(%rsp),%rbx

	movq   %r11,%rsp

	ret

	/* field squaring */

	.p2align 4
	.global secp256k1_fe_sqr_4to5
	.type	secp256k1_fe_sqr_4to5, %function

secp256k1_fe_sqr_4to5:

	movq   %rsp,%r11
	subq   $64,%rsp

	movq   %r11,0(%rsp)
	movq   %r12,8(%rsp)
	movq   %r13,16(%rsp)
	movq   %r14,24(%rsp)
	movq   %r15,32(%rsp)
	movq   %rbx,40(%rsp)
	movq   %rbp,48(%rsp)
	movq   %rdi,56(%rsp)

	/* 
	 * rbx = f0
         * rbp = f1
         * rcx = f2
         * rdi = f3
         *
	*/

	movq   0(%rsi),%rbx
	movq   8(%rsi),%rbp
	movq   16(%rsi),%rcx
	movq   24(%rsi),%rdi

	/* rsi = D */
	movq   $0x1000003D1,%rsi

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1g3 = u13 + v13x */
	mulq   %rdi
	/* h0 = (r8 : r9) = u13 */
	movq   %rax,%r8
	xorq   %r9,%r9
	/* h1 = (r10 : r11) = v13 */
	movq   %rdx,%r10
	xorq   %r11,%r11
	/* h0 = (r8 : r9) = 2u13 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = 2v13 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   %rcx,%rax
	/* (rax : rdx) = f2^2 = u22 + v22x */
	mulq   %rcx
	/* h0 = (r8 : r9) = 2u13 + u22 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = 2v13 + v22 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   %rcx,%rax
	/* (rax : rdx) = f2f3 = u23 + v23x */
	mulq   %rdi
	/* h1 = (r10 : r11) = u23 + 2v13 + v22 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 */
	movq   %rdx,%r12
	xorq   %r13,%r13
	/* h1 = (r10 : r11) = 2u23 + 2v13 + v22 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = 2v23 */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rsi,%rax
	/* h1 = (r10 : r11) = D * (2u23 + 2v13 + v22) */
	mulq   %r10
	imul   %rsi,%r11
	movq   %rax,%r10
	addq   %rdx,%r11

	/* rax = f3 */
	movq   %rdi,%rax
	/* (rax : rdx) = f3^2 = u33 + v33x */
	mulq   %rdi
	/* h2 = (r12 : r13) = u33 + 2v23 */
	addq   %rax,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rsi,%rax
	/* h3 = (r14 : r15) = D * v33 */
	mulq   %rdx
	movq   %rax,%r14
	movq   %rdx,%r15

	/* rax = D */
	movq   %rsi,%rax
	/* h2 = (r12 : r13) = D * (u33 + 2v23) */
	mulq   %r12
	imul   %rsi,%r13
	movq   %rax,%r12
	addq   %rdx,%r13

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f3 = u03 + v03x */
	mulq   %rdi
	/* h3 = (r14 : r15) = u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + v03 */
	addq   %rdx,%r8
	adcq   $0,%r9
	/* h3 = (r14 : r15) = 2u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1f2 = u12 + v12x */
	mulq   %rcx
	/* h3 = (r14 : r15) = 2u03 + u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 + v12 */
	addq   %rdx,%r8
	adcq   $0,%r9
	/* h3 = (r14 : r15) = 2u03 + 2u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 + 2v12 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = D */
	movq   %rsi,%rax
	/* h0 = (r8 : r9) = D * (2u13 + u22 + 2v03 + 2v12) */
	mulq   %r8
	imul   %rsi,%r9
	movq   %rax,%r8
	addq   %rdx,%r9

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0^2 = u00 + v00x */
	mulq   %rbx
	/* h0 = (r8 : r9) = u00 + D * (2u13 + u22 + 2v03 + 2v12) */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v00 + D * (2u23 + 2v13 + v22) */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f1 = u01 + v01x */
	mulq   %rbp
	/* h1 = (r10 : r11) = u01 + v00 + D * (2u23 + 2v13 + v22) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + D * (u33 + 2v23) */
	addq   %rdx,%r12
	adcq   $0,%r13
	/* h1 = (r10 : r11) = 2u01 + v00 + D * (2u23 + 2v13 + v22) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = 2v01 + D * (u33 + 2v23) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f2 = u02 + v02x */
	mulq   %rcx
	/* h2 = (r12 : r13) = u02 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15
	/* h2 = (r12 : r13) = 2u02 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + 2v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1^2 = u11 + v11x */
	mulq   %rbp
	/* h2 = (r12 : r13) = 2u02 + u11 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + 2v02 + v11 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the product h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	 *
	*/

	/* Reduce h(x) to a 5-limb form. */
	addq   %r9,%r10
	adcq   $0,%r11
	addq   %r11,%r12
	adcq   $0,%r13
	addq   %r13,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r10 = h1
	 * r12 = h2
	 * r14 = h3
	 * r15 = h4
	 *
	 */

	movq   56(%rsp),%rdi

	/* Store h(x) */
	movq   %r8,0(%rdi)
	movq   %r10,8(%rdi)
	movq   %r12,16(%rdi)
	movq   %r14,24(%rdi)
	movq   %r15,32(%rdi)

	movq   0(%rsp),%r11
	movq   8(%rsp),%r12
	movq   16(%rsp),%r13
	movq   24(%rsp),%r14
	movq   32(%rsp),%r15
	movq   40(%rsp),%rbx
	movq   48(%rsp),%rbp

	movq   %r11,%rsp

	ret

/************************************************************************
 * 64-bit field multiplication in which the first argument has 4-limb   *
 * and the second argument has 5-limb representations such that the     *
 * fifth limb is of at most 64 bits. The second argument is fully       *
 * reduced to 4-limb form and then field multiplication is performed.   *
 * A field element in 5-limb form is reported as output such that the   *
 * fifth limb is of at most 33 bits.					   *
 ************************************************************************/

	.p2align 4
	.global secp256k1_fe_mul_45to5
	.type	secp256k1_fe_mul_45to5, %function

secp256k1_fe_mul_45to5:

	movq   %rsp,%r11
	subq   $72,%rsp

	movq   %r11,0(%rsp)
	movq   %r12,8(%rsp)
	movq   %r13,16(%rsp)
	movq   %r14,24(%rsp)
	movq   %r15,32(%rsp)
	movq   %rbx,40(%rsp)
	movq   %rbp,48(%rsp)
	movq   %rdi,56(%rsp)

	/* rcx = D */
	movq   $0x1000003d1,%rcx

	/* 
         * r8  = g0
	 * r9  = g1
         * rbx = g2
         * rbp = g3
         * rax = g4
         *
         * The 5-tuple (r8 : r9 : rbx : rbp : r13) represents the field
         * element g(x) = g0 + g1x + g2x^2 + g3x^3 + g4x^4.
	*/

	movq   0(%rdx),%r8
	movq   8(%rdx),%r9
	movq   16(%rdx),%rbx
	movq   24(%rdx),%rbp
	movq   32(%rdx),%rax

	/* (rax : rdx) = D * g4 */
	mulq   %rcx 

	/* rdi = 0 */
	xorq   %rdi,%rdi

	/* Reduce g(x) by adding D * f4  to the g0 + g1x + g2x^2 + g3x^3. */
	addq   %r8,%rax
	adcq   %r9,%rdx
	adcq   $0,%rbx
	adcq   $0,%rbp

	/* rdi = D if the final carry is 1, else it is 0. */
	cmovc  %rcx,%rdi

	/* Reduce g(x) further by adding D or 0 to g0 + g1x + g2x^2 + g3x^3. */
	addq   %rax,%rdi
	adcq   $0,%rdx
	movq   %rdx,64(%rsp)

	/* 
         * At this point the input g(x) is fully reduced. The limbs of the field 
         * element are stored in rdi, rsp64, rbx, rbp respectively. Integer 
         * multiplication with f(x) and reduced g(x) is performed and the product 
         * is h(x). 
         *
	 * f(x) is accessed through rsi.
         *
	 * rdi   = g0
         * rsp64 = g1
         * rbx   = g2
         * rbp   = g3
         *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	*/

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g3 = u13 + v13x */
	mulq   %rbp
	/* h0 = (r8 : r9) = u13 */
	movq   %rax,%r8
	xorq   %r9,%r9
	/* h1 = (r10 : r11) = v13 */
	movq   %rdx,%r10
	xorq   %r11,%r11

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g2 = u22 + v22x */
	mulq   %rbx
	/* h0 = (r8 : r9) = u13 + u22 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v13 + v22 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g1 = u31 + v31x */
	mulq   64(%rsp)
	/* h0 = (r8 : r9) = u13 + u22 + u31 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v13 + v22 + v31 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g3 = u23 + v23x */
	mulq   %rbp
	/* h1 = (r10 : r11) = u23 + v13 + v22 + v31 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 */
	movq   %rdx,%r12
	xorq   %r13,%r13

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g2 = u32 + v32x */
	mulq   %rbx
	/* h1 = (r10 : r11) = u23 + u32 + v13 + v22 + v31 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 + v32 */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rcx,%rax
	/* h1 = (r10 : r11) = D * (u23 + u32 + v13 + v22 + v31) */
	mulq   %r10
	imul   %rcx,%r11
	movq   %rax,%r10
	addq   %rdx,%r11

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g3 = u33 + v33x */
	mulq   %rbp
	/* h2 = (r12 : r13) = u33 + v23 + v32 */
	addq   %rax,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rcx,%rax
	/* h3 = (r14 : r15) = D * v33 */
	mulq   %rdx
	movq   %rax,%r14
	movq   %rdx,%r15

	/* rax = D */
	movq   %rcx,%rax
	/* h2 = (r12 : r13) = D * (u33 + v23 + v32) */
	mulq   %r12
	imul   %rcx,%r13
	movq   %rax,%r12
	addq   %rdx,%r13

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g3 = u03 + v03x */
	mulq   %rbp
	/* h3 = (r14 : r15) = u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g2 = u12 + v12x */
	mulq   %rbx
	/* h3 = (r14 : r15) = u03 + u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g1 = u21 + v21x */
	mulq   64(%rsp)
	/* h3 = (r14 : r15) = u03 + u12 + u21 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 + v21 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g0 = u30 + v30x */
	mulq   %rdi
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 + v21 + v30 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = D */
	movq   %rcx,%rax
	/* h0 = (r8 : r9) = D * (u13 + u22 + u31 + v03 + v12 + v21 + v30) */
	mulq   %r8
	imul   %rcx,%r9
	movq   %rax,%r8
	addq   %rdx,%r9

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g0 = u00 + v00x */
	mulq   %rdi
	/* h0 = (r8 : r9) = u00 + D * (u13 + u22 + u31 + v03 + v12 + v21 + v30) */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g1 = u01 + v01x */
	mulq   64(%rsp)
	/* h1 = (r10 : r11) = u01 + v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + D * (u33 + v23 + v32) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g0 = u10 + v10x */
	mulq   %rdi
	/* h1 = (r10 : r11) = u01 + u10 + v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g2 = u02 + v02x */
	mulq   %rbx
	/* h2 = (r12 : r13) = u02 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g1 = u11 + v11x */
	mulq   64(%rsp)
	/* h2 = (r12 : r13) = u02 + u11 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + v11 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g0 = u20 + v20x */
	mulq   %rdi
	/* h2 = (r12 : r13) = u02 + u11 + u20 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + v11 + v20 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the product h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	 *
	*/

	/* Reduce h(x) to a 5-limb form. */
	addq   %r9,%r10
	adcq   $0,%r11
	addq   %r11,%r12
	adcq   $0,%r13
	addq   %r13,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the partially reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3 + h4x^4. 
	 *
	 * r8  = h0
	 * r10 = h1
	 * r12 = h2
	 * r14 = h3
	 * r15 = h4
	 *
	 */

	movq   56(%rsp),%rdi

	/* Store h(x) */
	movq   %r8,0(%rdi)
	movq   %r10,8(%rdi)
	movq   %r12,16(%rdi)
	movq   %r14,24(%rdi)
	movq   %r15,32(%rdi)

	movq   0(%rsp),%r11
	movq   8(%rsp),%r12
	movq   16(%rsp),%r13
	movq   24(%rsp),%r14
	movq   32(%rsp),%r15
	movq   40(%rsp),%rbx
	movq   48(%rsp),%rbp

	movq   %r11,%rsp

	ret

/************************************************************************
 * 64-bit field multiplication and squaring using the bottom 4-limbs of *
 * two field elements having 5-limb representation such that the fifth  *
 * limb is zero. A field element in 5-limb form such that the fifth     *
 * limb is zero is reported as output.				   *
 ************************************************************************/

	/* field multiplication */

	.p2align 4
	.global secp256k1_fe_mul_44to4
	.type	secp256k1_fe_mul_44to4, %function

secp256k1_fe_mul_44to4:

	movq   %rsp,%r11
	subq   $48,%rsp

	movq   %r11,0(%rsp)
	movq   %r12,8(%rsp)
	movq   %r13,16(%rsp)
	movq   %r14,24(%rsp)
	movq   %r15,32(%rsp)
	movq   %rbx,40(%rsp)

	/* f(x) is accessed through rsi and g(x) through rcx */
	movq   %rdx,%rcx

	/* rbx = D */
	movq   $0x1000003D1,%rbx

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g3 = u13 + v13x */
	mulq   24(%rcx)
	/* h0 = (r8 : r9) = u13 */
	movq   %rax,%r8
	xorq   %r9,%r9
	/* h1 = (r10 : r11) = v13 */
	movq   %rdx,%r10
	xorq   %r11,%r11

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g2 = u22 + v22x */
	mulq   16(%rcx)
	/* h0 = (r8 : r9) = u13 + u22 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v13 + v22 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g1 = u31 + v31x */
	mulq   8(%rcx)
	/* h0 = (r8 : r9) = u13 + u22 + u31 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v13 + v22 + v31 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g3 = u23 + v23x */
	mulq   24(%rcx)
	/* h1 = (r10 : r11) = u23 + v13 + v22 + v31 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 */
	movq   %rdx,%r12
	xorq   %r13,%r13

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g2 = u32 + v32x */
	mulq   16(%rcx)
	/* h1 = (r10 : r11) = u23 + u32 + v13 + v22 + v31 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 + v32 */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rbx,%rax
	/* h1 = (r10 : r11) = D * (u23 + u32 + v13 + v22 + v31) */
	mulq   %r10
	imul   %rbx,%r11
	movq   %rax,%r10
	addq   %rdx,%r11

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g3 = u33 + v33x */
	mulq   24(%rcx)
	/* h2 = (r12 : r13) = u33 + v23 + v32 */
	addq   %rax,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rbx,%rax
	/* h3 = (r14 : r15) = D * v33 */
	mulq   %rdx
	movq   %rax,%r14
	movq   %rdx,%r15

	/* rax = D */
	movq   %rbx,%rax
	/* h2 = (r12 : r13) = D * (u33 + v23 + v32) */
	mulq   %r12
	imul   %rbx,%r13
	movq   %rax,%r12
	addq   %rdx,%r13

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g3 = u03 + v03x */
	mulq   24(%rcx)
	/* h3 = (r14 : r15) = u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g2 = u12 + v12x */
	mulq   16(%rcx)
	/* h3 = (r14 : r15) = u03 + u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g1 = u21 + v21x */
	mulq   8(%rcx)
	/* h3 = (r14 : r15) = u03 + u12 + u21 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 + v21 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f3 */
	movq   24(%rsi),%rax
	/* (rax : rdx) = f3g0 = u30 + v30x */
	mulq   0(%rcx)
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = u13 + u22 + u31 + v03 + v12 + v21 + v30 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = D */
	movq   %rbx,%rax
	/* h0 = (r8 : r9) = D * (u13 + u22 + u31 + v03 + v12 + v21 + v30) */
	mulq   %r8
	imul   %rbx,%r9
	movq   %rax,%r8
	addq   %rdx,%r9

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g0 = u00 + v00x */
	mulq   0(%rcx)
	/* h0 = (r8 : r9) = u00 + D * (u13 + u22 + u31 + v03 + v12 + v21 + v30) */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g1 = u01 + v01x */
	mulq   8(%rcx)
	/* h1 = (r10 : r11) = u01 + v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + D * (u33 + v23 + v32) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g0 = u10 + v10x */
	mulq   0(%rcx)
	/* h1 = (r10 : r11) = u01 + u10 + v00 + D * (u23 + u32 + v13 + v22 + v31) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f0 */
	movq   0(%rsi),%rax
	/* (rax : rdx) = f0g2 = u02 + v02x */
	mulq   16(%rcx)
	/* h2 = (r12 : r13) = u02 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f1 */
	movq   8(%rsi),%rax
	/* (rax : rdx) = f1g1 = u11 + v11x */
	mulq   8(%rcx)
	/* h2 = (r12 : r13) = u02 + u11 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + v11 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f2 */
	movq   16(%rsi),%rax
	/* (rax : rdx) = f2g0 = u20 + v20x */
	mulq   0(%rcx)
	/* h2 = (r12 : r13) = u02 + u11 + u20 + v01 + v10 + D * (u33 + v23 + v32) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = u03 + u12 + u21 + u30 + v02 + v11 + v20 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the product h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	 *
	*/

	/* Reduce h(x) to a 5-limb form. */
	addq   %r9,%r10
	adcq   $0,%r11
	addq   %r11,%r12
	adcq   $0,%r13
	addq   %r13,%r14
	adcq   $0,%r15

	/* Reduce h(x) by adding D * f4  to the h0 + h1x + h2x^2 + h3x^3. */
	movq   %rbx,%rax
	mulq   %r15
	xorq   %r11,%r11
	addq   %rax,%r8
	adcq   %rdx,%r10
	adcq   $0,%r12
	adcq   $0,%r14

	/* r11 = D if the final carry is 1, else it is 0. */
	cmovc  %rbx,%r11

	/* Reduce h(x) further by adding D or 0 to h0 + h1x + h2x^2 + h3x^3. */
	addq   %r11,%r8
	adcq   $0,%r10

	/* 
         * At this point we have the fully reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * r8  = h0
	 * r10 = h1
	 * r12 = h2
	 * r14 = h3
	 *
	 */

	/* Store h(x) */
	movq   %r8,0(%rdi)
	movq   %r10,8(%rdi)
	movq   %r12,16(%rdi)
	movq   %r14,24(%rdi)

	/* Set the 5th limb of h(x) to 0 */
	movq   $0,32(%rdi)

	movq   0(%rsp),%r11
	movq   8(%rsp),%r12
	movq   16(%rsp),%r13
	movq   24(%rsp),%r14
	movq   32(%rsp),%r15
	movq   40(%rsp),%rbx

	movq   %r11,%rsp

	ret

	/* field squaring */

	.p2align 4
	.global secp256k1_fe_sqr_4to4
	.type	secp256k1_fe_sqr_4to4, %function

secp256k1_fe_sqr_4to4:

	movq   %rsp,%r11
	subq   $64,%rsp

	movq   %r11,0(%rsp)
	movq   %r12,8(%rsp)
	movq   %r13,16(%rsp)
	movq   %r14,24(%rsp)
	movq   %r15,32(%rsp)
	movq   %rbx,40(%rsp)
	movq   %rbp,48(%rsp)
	movq   %rdi,56(%rsp)

	/* 
	 * rbx = f0
         * rbp = f1
         * rcx = f2
         * rdi = f3
         *
	*/

	movq   0(%rsi),%rbx
	movq   8(%rsi),%rbp
	movq   16(%rsi),%rcx
	movq   24(%rsi),%rdi

	/* rsi = D */
	movq   $0x1000003D1,%rsi

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1f3 = u13 + v13x */
	mulq   %rdi
	/* h0 = (r8 : r9) = u13 */
	movq   %rax,%r8
	xorq   %r9,%r9
	/* h1 = (r10 : r11) = v13 */
	movq   %rdx,%r10
	xorq   %r11,%r11
	/* h0 = (r8 : r9) = 2u13 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = 2v13 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   %rcx,%rax
	/* (rax : rdx) = f2^2 = u22 + v22x */
	mulq   %rcx
	/* h0 = (r8 : r9) = 2u13 + u22 */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = 2v13 + v22 */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f2 */
	movq   %rcx,%rax
	/* (rax : rdx) = f2f3 = u23 + v23x */
	mulq   %rdi
	/* h1 = (r10 : r11) = u23 + 2v13 + v22 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v23 */
	movq   %rdx,%r12
	xorq   %r13,%r13
	/* h1 = (r10 : r11) = 2u23 + 2v13 + v22 */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = 2v23 */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rsi,%rax
	/* h1 = (r10 : r11) = D * (2u23 + 2v13 + v22) */
	mulq   %r10
	imul   %rsi,%r11
	movq   %rax,%r10
	addq   %rdx,%r11

	/* rax = f3 */
	movq   %rdi,%rax
	/* (rax : rdx) = f3^2 = u33 + v33x */
	mulq   %rdi
	/* h2 = (r12 : r13) = u33 + 2v23 */
	addq   %rax,%r12
	adcq   $0,%r13

	/* rax = D */
	movq   %rsi,%rax
	/* h3 = (r14 : r15) = D * v33 */
	mulq   %rdx
	movq   %rax,%r14
	movq   %rdx,%r15

	/* rax = D */
	movq   %rsi,%rax
	/* h2 = (r12 : r13) = D * (u33 + 2v23) */
	mulq   %r12
	imul   %rsi,%r13
	movq   %rax,%r12
	addq   %rdx,%r13

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f3 = u03 + v03x */
	mulq   %rdi
	/* h3 = (r14 : r15) = u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + v03 */
	addq   %rdx,%r8
	adcq   $0,%r9
	/* h3 = (r14 : r15) = 2u03 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1f2 = u12 + v12x */
	mulq   %rcx
	/* h3 = (r14 : r15) = 2u03 + u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 + v12 */
	addq   %rdx,%r8
	adcq   $0,%r9
	/* h3 = (r14 : r15) = 2u03 + 2u12 + D * v33 */
	addq   %rax,%r14
	adcq   $0,%r15
	/* h0 = (r8 : r9) = 2u13 + u22 + 2v03 + 2v12 */
	addq   %rdx,%r8
	adcq   $0,%r9

	/* rax = D */
	movq   %rsi,%rax
	/* h0 = (r8 : r9) = D * (2u13 + u22 + 2v03 + 2v12) */
	mulq   %r8
	imul   %rsi,%r9
	movq   %rax,%r8
	addq   %rdx,%r9

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0^2 = u00 + v00x */
	mulq   %rbx
	/* h0 = (r8 : r9) = u00 + D * (2u13 + u22 + 2v03 + 2v12) */
	addq   %rax,%r8
	adcq   $0,%r9
	/* h1 = (r10 : r11) = v00 + D * (2u23 + 2v13 + v22) */
	addq   %rdx,%r10
	adcq   $0,%r11

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f1 = u01 + v01x */
	mulq   %rbp
	/* h1 = (r10 : r11) = u01 + v00 + D * (2u23 + 2v13 + v22) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = v01 + D * (u33 + 2v23) */
	addq   %rdx,%r12
	adcq   $0,%r13
	/* h1 = (r10 : r11) = 2u01 + v00 + D * (2u23 + 2v13 + v22) */
	addq   %rax,%r10
	adcq   $0,%r11
	/* h2 = (r12 : r13) = 2v01 + D * (u33 + 2v23) */
	addq   %rdx,%r12
	adcq   $0,%r13

	/* rax = f0 */
	movq   %rbx,%rax
	/* (rax : rdx) = f0f2 = u02 + v02x */
	mulq   %rcx
	/* h2 = (r12 : r13) = u02 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15
	/* h2 = (r12 : r13) = 2u02 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + 2v02 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* rax = f1 */
	movq   %rbp,%rax
	/* (rax : rdx) = f1^2 = u11 + v11x */
	mulq   %rbp
	/* h2 = (r12 : r13) = 2u02 + u11 + 2v01 + D * (u33 + 2v23) */
	addq   %rax,%r12
	adcq   $0,%r13
	/* h3 = (r14 : r15) = 2u03 + 2u12 + 2v02 + v11 + D * v33 */
	addq   %rdx,%r14
	adcq   $0,%r15

	/* 
         * At this point we have the product h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * (r8  : r9)  = h0
	 * (r10 : r11) = h1
	 * (r12 : r13) = h2
	 * (r14 : r15) = h3
	 *
	*/

	/* Reduce h(x) to a 5-limb form. */
	addq   %r9,%r10
	adcq   $0,%r11
	addq   %r11,%r12
	adcq   $0,%r13
	addq   %r13,%r14
	adcq   $0,%r15

	/* Reduce h(x) by adding D * f4  to the h0 + h1x + h2x^2 + h3x^3. */
	movq   %rsi,%rax
	mulq   %r15
	xorq   %r11,%r11
	addq   %rax,%r8
	adcq   %rdx,%r10
	adcq   $0,%r12
	adcq   $0,%r14

	/* r11 = D if the final carry is 1, else it is 0. */
	cmovc  %rsi,%r11

	/* Reduce h(x) further by adding D or 0 to h0 + h1x + h2x^2 + h3x^3. */
	addq   %r11,%r8
	adcq   $0,%r10

	/* 
         * At this point we have the fully reduced field element 
	 * h(x) = h0 + h1x + h2x^2 + h3x^3. 
	 *
	 * r8  = h0
	 * r10 = h1
	 * r12 = h2
	 * r14 = h3
	 *
	 */

	movq   56(%rsp),%rdi

	/* Store h(x) */
	movq   %r8,0(%rdi)
	movq   %r10,8(%rdi)
	movq   %r12,16(%rdi)
	movq   %r14,24(%rdi)

	/* Set the 5th limb of h(x) to 0 */
	movq   $0,32(%rdi)

	movq   0(%rsp),%r11
	movq   8(%rsp),%r12
	movq   16(%rsp),%r13
	movq   24(%rsp),%r14
	movq   32(%rsp),%r15
	movq   40(%rsp),%rbx
	movq   48(%rsp),%rbp

	movq   %r11,%rsp

	ret
