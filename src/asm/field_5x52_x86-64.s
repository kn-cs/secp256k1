	.att_syntax
	.text

	.p2align 4
	.global secp256k1_fe_mul_inner
	.type	secp256k1_fe_mul_inner, %function
secp256k1_fe_mul_inner:
	pushq %r15
	pushq %r14
	pushq %r13
	pushq %r12
	pushq %rbx
	movq %rdx, %rbx
	movq 0(%rsi),%r10
	movq 8(%rsi),%r11
	movq 16(%rsi),%r12
	movq 24(%rsi),%r13
	movq 32(%rsi),%r14
	movq 0(%rbx),%rax
	mulq %r13
	movq %rax,%rcx
	movq %rdx,%r15
	movq 8(%rbx),%rax
	mulq %r12
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 16(%rbx),%rax
	mulq %r11
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 24(%rbx),%rax
	mulq %r10
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 32(%rbx),%rax
	mulq %r14
	movq %rax,%r8
	movq %rdx,%r9
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%rcx
	adcq %rdx,%r15
	shrdq $52,%r9,%r8
	movq %rcx,%rsi
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rsi
	movq %rsi,-24(%rsp)
	shrdq $52,%r15,%rcx
	xorq %r15,%r15
	movq 0(%rbx),%rax
	mulq %r14
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 8(%rbx),%rax
	mulq %r13
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 16(%rbx),%rax
	mulq %r12
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 24(%rbx),%rax
	mulq %r11
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 32(%rbx),%rax
	mulq %r10
	addq %rax,%rcx
	adcq %rdx,%r15
	movq %r8,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%rcx
	adcq %rdx,%r15
	movq %rcx,%rsi
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rsi
	shrdq $52,%r15,%rcx
	xorq %r15,%r15
	movq %rsi,%rax
	shrq $48,%rax
	movq %rax,-8(%rsp)
	movq $0xffffffffffff,%rax
	andq %rax,%rsi
	movq %rsi,-16(%rsp)
	movq 0(%rbx),%rax
	mulq %r10
	movq %rax,%r8
	movq %rdx,%r9
	movq 8(%rbx),%rax
	mulq %r14
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 16(%rbx),%rax
	mulq %r13
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 24(%rbx),%rax
	mulq %r12
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 32(%rbx),%rax
	mulq %r11
	addq %rax,%rcx
	adcq %rdx,%r15
	movq %rcx,%rsi
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rsi
	shrdq $52,%r15,%rcx
	xorq %r15,%r15
	shlq $4,%rsi
	movq -8(%rsp),%rax
	orq %rax,%rsi
	movq $0x1000003d1,%rax
	mulq %rsi
	addq %rax,%r8
	adcq %rdx,%r9
	movq %r8,%rax
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rax
	movq %rax,0(%rdi)
	shrdq $52,%r9,%r8
	xorq %r9,%r9
	movq 0(%rbx),%rax
	mulq %r11
	addq %rax,%r8
	adcq %rdx,%r9
	movq 8(%rbx),%rax
	mulq %r10
	addq %rax,%r8
	adcq %rdx,%r9
	movq 16(%rbx),%rax
	mulq %r14
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 24(%rbx),%rax
	mulq %r13
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 32(%rbx),%rax
	mulq %r12
	addq %rax,%rcx
	adcq %rdx,%r15
	movq %rcx,%rax
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%r8
	adcq %rdx,%r9
	shrdq $52,%r15,%rcx
	xorq %r15,%r15
	movq %r8,%rax
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rax
	movq %rax,8(%rdi)
	shrdq $52,%r9,%r8
	xorq %r9,%r9
	movq 0(%rbx),%rax
	mulq %r12
	addq %rax,%r8
	adcq %rdx,%r9
	movq 8(%rbx),%rax
	mulq %r11
	addq %rax,%r8
	adcq %rdx,%r9
	movq 16(%rbx),%rax
	mulq %r10
	addq %rax,%r8
	adcq %rdx,%r9
	movq -16(%rsp),%rsi
	movq -24(%rsp),%r10
	movq 24(%rbx),%rax
	mulq %r14
	addq %rax,%rcx
	adcq %rdx,%r15
	movq 32(%rbx),%rax
	mulq %r13
	addq %rax,%rcx
	adcq %rdx,%r15
	movq %rcx,%rax
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%r8
	adcq %rdx,%r9
	shrdq $52,%r15,%rcx
	movq %r8,%rax
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rax
	movq %rax,16(%rdi)
	shrdq $52,%r9,%r8
	xorq %r9,%r9
	addq %r10,%r8
	movq %rcx,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%r8
	adcq %rdx,%r9
	movq %r8,%rax
	movq $0xfffffffffffff,%rdx
	andq %rdx,%rax
	movq %rax,24(%rdi)
	shrdq $52,%r9,%r8
	addq %rsi,%r8
	movq %r8,32(%rdi)
	popq %rbx
	popq %r12
	popq %r13
	popq %r14
	popq %r15
	ret
	.size secp256k1_fe_mul_inner, .-secp256k1_fe_mul_inner

	.p2align 4
	.global secp256k1_fe_sqr_inner
	.type secp256k1_fe_sqr_inner, %function
secp256k1_fe_sqr_inner:
	pushq %r15
	pushq %r14
	pushq %r13
	pushq %r12
	pushq %rbx
	movq 0(%rsi),%r10
	movq 8(%rsi),%r11
	movq 16(%rsi),%r12
	movq 24(%rsi),%r13
	movq 32(%rsi),%r14
	movq $0xfffffffffffff,%r15
	leaq (%r10,%r10,1),%rax
	mulq %r13
	movq %rax,%rbx
	movq %rdx,%rcx
	leaq (%r11,%r11,1),%rax
	mulq %r12
	addq %rax,%rbx
	adcq %rdx,%rcx
	movq %r14,%rax
	mulq %r14
	movq %rax,%r8
	movq %rdx,%r9
	andq %r15,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%rbx
	adcq %rdx,%rcx
	shrdq $52,%r9,%r8
	movq %rbx,%rsi
	andq %r15,%rsi
	movq %rsi,-24(%rsp)
	shrdq $52,%rcx,%rbx
	xorq %rcx,%rcx
	addq %r14,%r14
	movq %r10,%rax
	mulq %r14
	addq %rax,%rbx
	adcq %rdx,%rcx
	leaq (%r11,%r11,1),%rax
	mulq %r13
	addq %rax,%rbx
	adcq %rdx,%rcx
	movq %r12,%rax
	mulq %r12
	addq %rax,%rbx
	adcq %rdx,%rcx
	movq %r8,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%rbx
	adcq %rdx,%rcx
	movq %rbx,%rsi
	andq %r15,%rsi
	shrdq $52,%rcx,%rbx
	xorq %rcx,%rcx
	movq %rsi,%rax
	shrq $48,%rax
	movq %rax,-8(%rsp)
	movq $0xffffffffffff,%rax
	andq %rax,%rsi
	movq %rsi,-16(%rsp)
	movq %r10,%rax
	mulq %r10
	movq %rax,%r8
	movq %rdx,%r9
	movq %r11,%rax
	mulq %r14
	addq %rax,%rbx
	adcq %rdx,%rcx
	leaq (%r12,%r12,1),%rax
	mulq %r13
	addq %rax,%rbx
	adcq %rdx,%rcx
	movq %rbx,%rsi
	andq %r15,%rsi
	shrdq $52,%rcx,%rbx
	xorq %rcx,%rcx
	shlq $4,%rsi
	movq -8(%rsp),%rax
	orq %rax,%rsi
	movq $0x1000003d1,%rax
	mulq %rsi
	addq %rax,%r8
	adcq %rdx,%r9
	movq %r8,%rax
	andq %r15,%rax
	movq %rax,0(%rdi)
	shrdq $52,%r9,%r8
	xorq %r9,%r9
	addq %r10,%r10
	movq %r10,%rax
	mulq %r11
	addq %rax,%r8
	adcq %rdx,%r9
	movq %r12,%rax
	mulq %r14
	addq %rax,%rbx
	adcq %rdx,%rcx
	movq %r13,%rax
	mulq %r13
	addq %rax,%rbx
	adcq %rdx,%rcx
	movq %rbx,%rax
	andq %r15,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%r8
	adcq %rdx,%r9
	shrdq $52,%rcx,%rbx
	xorq %rcx,%rcx
	movq %r8,%rax
	andq %r15,%rax
	movq %rax,8(%rdi)
	shrdq $52,%r9,%r8
	xorq %r9,%r9
	movq %r10,%rax
	mulq %r12
	addq %rax,%r8
	adcq %rdx,%r9
	movq -16(%rsp),%rsi
	movq -24(%rsp),%r10
	movq %r11,%rax
	mulq %r11
	addq %rax,%r8
	adcq %rdx,%r9
	movq %r13,%rax
	mulq %r14
	addq %rax,%rbx
	adcq %rdx,%rcx
	movq %rbx,%rax
	andq %r15,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%r8
	adcq %rdx,%r9
	shrdq $52,%rcx,%rbx
	movq %r8,%rax
	andq %r15,%rax
	movq %rax,16(%rdi)
	shrdq $52,%r9,%r8
	xorq %r9,%r9
	addq %r10,%r8
	movq %rbx,%rax
	movq $0x1000003d10,%rdx
	mulq %rdx
	addq %rax,%r8
	adcq %rdx,%r9
	movq %r8,%rax
	andq %r15,%rax
	movq %rax,24(%rdi)
	shrdq $52,%r9,%r8
	addq %rsi,%r8
	movq %r8,32(%rdi)
	popq %rbx
	popq %r12
	popq %r13
	popq %r14
	popq %r15
	ret
	.size secp256k1_fe_sqr_inner, .-secp256k1_fe_sqr_inner
