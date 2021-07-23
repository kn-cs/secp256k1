/* Aarch64 assembly, created by disassembling the output of GCC 10.3.0 from the C __int128
 * based implementation in src/field_5x64_impl.h. */

	.text

	.p2align 4
	.global secp256k1_fe_mul_inner
	.type	secp256k1_fe_mul_inner, %function
secp256k1_fe_mul_inner:
	stp	x29, x30, [sp, #-48]!
	mov	x5, #0x3d1                 	// #977
	movk	x5, #0x1, lsl #32
	mov	x29, sp
	ldp	x12, x3, [x1]
	stp	x19, x20, [sp, #16]
	ldr	x4, [x1, #32]
	ldp	x10, x14, [x1, #16]
	mul	x6, x4, x5
	umulh	x4, x4, x5
	adds	x12, x12, x6
	cset	x6, cs  // cs = hs, nlast
	adds	x4, x4, x3
	cset	x3, cs  // cs = hs, nlast
	adds	x4, x4, x6
	cinc	x3, x3, cs  // cs = hs, nlast
	adds	x10, x10, x3
	cset	x1, cs  // cs = hs, nlast
	adds	x14, x14, x1
	csetm	x1, cs  // cs = hs, nlast
	and	x1, x1, x5
	adds	x12, x1, x12
	cset	x1, cs  // cs = hs, nlast
	adds	x4, x4, x1
	ldp	x15, x9, [x2, #24]
	cset	x1, cs  // cs = hs, nlast
	adds	x10, x10, x1
	ldp	x11, x1, [x2]
	cset	x13, cs  // cs = hs, nlast
	mul	x3, x9, x5
	umulh	x9, x9, x5
	adds	x11, x11, x3
	cset	x6, cs  // cs = hs, nlast
	adds	x9, x9, x1
	ldr	x3, [x2, #16]
	cset	x1, cs  // cs = hs, nlast
	adds	x9, x9, x6
	str	x21, [sp, #32]
	cinc	x1, x1, cs  // cs = hs, nlast
	adds	x3, x3, x1
	cset	x8, cs  // cs = hs, nlast
	adds	x8, x15, x8
	csetm	x1, cs  // cs = hs, nlast
	and	x1, x1, x5
	adds	x11, x1, x11
	cset	x1, cs  // cs = hs, nlast
	adds	x9, x9, x1
	cset	x2, cs  // cs = hs, nlast
	umulh	x1, x12, x11
	adds	x3, x3, x2
	mul	x6, x4, x11
	mul	x2, x9, x12
	cset	x15, cs  // cs = hs, nlast
	umulh	x7, x9, x12
	adds	x1, x1, x2
	umulh	x2, x4, x11
	cinc	x7, x7, cs  // cs = hs, nlast
	adds	x6, x1, x6
	mul	x16, x12, x3
	cinc	x1, x2, cs  // cs = hs, nlast
	adds	x7, x7, x1
	umulh	x1, x12, x3
	cset	x2, cs  // cs = hs, nlast
	adds	x7, x7, x16
	mul	x17, x9, x4
	cinc	x1, x1, cs  // cs = hs, nlast
	adds	x2, x2, x1
	umulh	x1, x9, x4
	cset	x16, cs  // cs = hs, nlast
	adds	x7, x7, x17
	cinc	x1, x1, cs  // cs = hs, nlast
	mul	x17, x10, x11
	adds	x2, x2, x1
	umulh	x1, x10, x11
	cinc	x19, x16, cs  // cs = hs, nlast
	adds	x7, x7, x17
	cinc	x1, x1, cs  // cs = hs, nlast
	mul	x21, x4, x3
	adds	x2, x2, x1
	umulh	x1, x4, x3
	cset	x16, cs  // cs = hs, nlast
	adds	x15, x15, x8
	mul	x20, x9, x10
	umulh	x17, x9, x10
	mul	x8, x12, x15
	umulh	x18, x12, x15
	adds	x2, x2, x8
	mul	x30, x4, x15
	cinc	x18, x18, cs  // cs = hs, nlast
	adds	x2, x2, x21
	add	x16, x16, x18
	cinc	x1, x1, cs  // cs = hs, nlast
	add	x16, x16, x19
	umulh	x19, x4, x15
	adds	x1, x16, x1
	mul	x12, x12, x11
	cset	x4, cs  // cs = hs, nlast
	cmp	x18, x16
	cinc	x8, x4, hi  // hi = pmore
	adds	x2, x2, x20
	cinc	x4, x17, cs  // cs = hs, nlast
	mul	x18, x10, x3
	adds	x1, x1, x4
	umulh	x17, x10, x3
	cset	x4, cs  // cs = hs, nlast
	adds	x13, x13, x14
	mul	x16, x10, x15
	umulh	x10, x10, x15
	mul	x14, x11, x13
	umulh	x11, x11, x13
	adds	x2, x2, x14
	mul	x20, x9, x13
	cinc	x11, x11, cs  // cs = hs, nlast
	umulh	x21, x9, x13
	adds	x1, x1, x11
	mul	x11, x3, x13
	adc	x4, x8, x4
	adds	x1, x1, x30
	cinc	x19, x19, cs  // cs = hs, nlast
	umulh	x3, x3, x13
	adds	x4, x4, x19
	umulh	x9, x15, x13
	cset	x8, cs  // cs = hs, nlast
	adds	x1, x1, x18
	cinc	x17, x17, cs  // cs = hs, nlast
	mul	x13, x15, x13
	adds	x4, x4, x17
	cinc	x14, x8, cs  // cs = hs, nlast
	adds	x1, x1, x20
	cinc	x21, x21, cs  // cs = hs, nlast
	adds	x4, x4, x21
	cset	x8, cs  // cs = hs, nlast
	adds	x4, x4, x16
	cinc	x10, x10, cs  // cs = hs, nlast
	adds	x4, x4, x11
	add	x8, x8, x10
	cinc	x3, x3, cs  // cs = hs, nlast
	add	x8, x8, x14
	mul	x11, x1, x5
	adds	x3, x8, x3
	umulh	x1, x1, x5
	cset	x14, cs  // cs = hs, nlast
	cmp	x10, x8
	cinc	x9, x9, hi  // hi = pmore
	adds	x3, x3, x13
	adc	x9, x9, x14
	mul	x8, x4, x5
	adds	x11, x11, x12
	umulh	x4, x4, x5
	cinc	x1, x1, cs  // cs = hs, nlast
	mul	x10, x3, x5
	adds	x1, x1, x8
	umulh	x3, x3, x5
	cset	x8, cs  // cs = hs, nlast
	adds	x1, x1, x6
	adc	x4, x8, x4
	mul	x8, x9, x5
	adds	x4, x4, x10
	umulh	x5, x9, x5
	cset	x6, cs  // cs = hs, nlast
	adds	x4, x4, x7
	adc	x3, x6, x3
	stp	x11, x1, [x0]
	adds	x3, x3, x8
	cset	x9, cs  // cs = hs, nlast
	adds	x2, x3, x2
	adc	x5, x9, x5
	stp	x4, x2, [x0, #16]
	str	x5, [x0, #32]
	ldp	x19, x20, [sp, #16]
	ldr	x21, [sp, #32]
	ldp	x29, x30, [sp], #48
	ret
	.size secp256k1_fe_mul_inner, .-secp256k1_fe_mul_inner

	.p2align 4
	.global secp256k1_fe_sqr_inner
	.type secp256k1_fe_sqr_inner, %function
secp256k1_fe_sqr_inner:
	stp	x29, x30, [sp, #-32]!
	mov	x5, #0x3d1                 	// #977
	movk	x5, #0x1, lsl #32
	mov	x29, sp
	ldp	x3, x4, [x1]
	ldr	x2, [x1, #32]
	ldp	x10, x9, [x1, #16]
	str	x19, [sp, #16]
	mul	x6, x2, x5
	umulh	x2, x2, x5
	adds	x3, x3, x6
	cset	x6, cs  // cs = hs, nlast
	adds	x2, x2, x4
	cset	x4, cs  // cs = hs, nlast
	adds	x2, x2, x6
	cinc	x4, x4, cs  // cs = hs, nlast
	adds	x10, x10, x4
	cset	x11, cs  // cs = hs, nlast
	adds	x9, x9, x11
	csetm	x1, cs  // cs = hs, nlast
	and	x1, x1, x5
	adds	x3, x1, x3
	cset	x1, cs  // cs = hs, nlast
	adds	x2, x2, x1
	cset	x4, cs  // cs = hs, nlast
	umulh	x1, x3, x3
	adds	x10, x10, x4
	mul	x8, x3, x3
	mul	x4, x3, x2
	cset	x11, cs  // cs = hs, nlast
	umulh	x16, x3, x2
	mul	x12, x3, x10
	lsl	x6, x4, #1
	umulh	x14, x3, x10
	lsl	x13, x16, #1
	cmp	x4, x6
	cinc	x7, x13, hi  // hi = pmore
	adds	x6, x1, x6
	cinc	x7, x7, cs  // cs = hs, nlast
	cset	w4, cs  // cs = hs, nlast
	cmp	x7, #0x0
	lsl	x1, x12, #1
	ccmp	w4, #0x0, #0x4, eq  // eq = none
	lsl	x15, x14, #1
	cset	x4, ne  // ne = any
	cmp	x16, x13
	cinc	x4, x4, hi  // hi = pmore
	cmp	x12, x1
	cinc	x12, x15, hi  // hi = pmore
	adds	x7, x7, x1
	cinc	x12, x12, cs  // cs = hs, nlast
	cset	w13, cs  // cs = hs, nlast
	adds	x4, x4, x12
	mul	x16, x2, x2
	cset	x1, cs  // cs = hs, nlast
	cmp	x12, #0x0
	ccmp	w13, #0x0, #0x4, eq  // eq = none
	umulh	x12, x2, x2
	cinc	x13, x1, ne  // ne = any
	adds	x7, x7, x16
	cinc	x12, x12, cs  // cs = hs, nlast
	umulh	x17, x2, x10
	adds	x4, x4, x12
	mul	x18, x2, x10
	cset	x1, cs  // cs = hs, nlast
	cmp	x14, x15
	cinc	x1, x1, hi  // hi = pmore
	adds	x11, x11, x9
	add	x1, x1, x13
	lsl	x12, x17, #1
	lsl	x30, x18, #1
	mul	x13, x10, x10
	mul	x15, x3, x11
	umulh	x3, x3, x11
	mul	x16, x2, x11
	lsl	x14, x15, #1
	umulh	x9, x2, x11
	cmp	x15, x14
	lsl	x19, x3, #1
	cinc	x2, x19, hi  // hi = pmore
	adds	x4, x4, x14
	cinc	x2, x2, cs  // cs = hs, nlast
	cset	w15, cs  // cs = hs, nlast
	adds	x1, x2, x1
	cset	x14, cs  // cs = hs, nlast
	cmp	x2, #0x0
	ccmp	w15, #0x0, #0x4, eq  // eq = none
	lsl	x15, x16, #1
	cinc	x14, x14, ne  // ne = any
	cmp	x3, x19
	cset	x2, hi  // hi = pmore
	cmp	x17, x12
	cinc	x3, x2, hi  // hi = pmore
	cmp	x18, x30
	cinc	x2, x12, hi  // hi = pmore
	adds	x4, x4, x30
	cinc	x2, x2, cs  // cs = hs, nlast
	cset	w18, cs  // cs = hs, nlast
	adds	x1, x1, x2
	lsl	x17, x9, #1
	cset	x12, cs  // cs = hs, nlast
	cmp	x2, #0x0
	ccmp	w18, #0x0, #0x4, eq  // eq = none
	add	x2, x14, x3
	cinc	x12, x12, ne  // ne = any
	cmp	x16, x15
	cinc	x3, x17, hi  // hi = pmore
	adds	x1, x1, x15
	cinc	x3, x3, cs  // cs = hs, nlast
	cset	w14, cs  // cs = hs, nlast
	cmp	x3, #0x0
	add	x12, x12, x2
	ccmp	w14, #0x0, #0x4, eq  // eq = none
	mul	x16, x10, x11
	cset	x2, ne  // ne = any
	cmp	x9, x17
	umulh	x14, x10, x10
	cinc	x2, x2, hi  // hi = pmore
	adds	x3, x3, x12
	umulh	x15, x10, x11
	cset	x10, cs  // cs = hs, nlast
	adds	x1, x1, x13
	cinc	x9, x14, cs  // cs = hs, nlast
	lsl	x12, x16, #1
	adds	x3, x3, x9
	lsl	x14, x15, #1
	adc	x2, x2, x10
	cmp	x16, x12
	cinc	x9, x14, hi  // hi = pmore
	adds	x3, x3, x12
	cinc	x9, x9, cs  // cs = hs, nlast
	cset	w12, cs  // cs = hs, nlast
	adds	x2, x9, x2
	umulh	x13, x11, x11
	cset	x10, cs  // cs = hs, nlast
	cmp	x9, #0x0
	ccmp	w12, #0x0, #0x4, eq  // eq = none
	mul	x9, x11, x11
	mul	x12, x1, x5
	cinc	x11, x10, ne  // ne = any
	cmp	x15, x14
	umulh	x1, x1, x5
	cinc	x10, x13, hi  // hi = pmore
	adds	x2, x2, x9
	adc	x10, x11, x10
	mul	x9, x3, x5
	adds	x8, x12, x8
	umulh	x3, x3, x5
	cinc	x1, x1, cs  // cs = hs, nlast
	mul	x11, x2, x5
	adds	x1, x1, x9
	umulh	x2, x2, x5
	cset	x9, cs  // cs = hs, nlast
	adds	x1, x1, x6
	adc	x3, x9, x3
	mul	x9, x10, x5
	adds	x3, x3, x11
	umulh	x5, x10, x5
	cset	x6, cs  // cs = hs, nlast
	adds	x3, x3, x7
	adc	x2, x6, x2
	stp	x8, x1, [x0]
	adds	x2, x2, x9
	cset	x10, cs  // cs = hs, nlast
	adds	x4, x2, x4
	adc	x5, x10, x5
	stp	x3, x4, [x0, #16]
	str	x5, [x0, #32]
	ldr	x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	ret
	.size secp256k1_fe_sqr_inner, .-secp256k1_fe_sqr_inner
