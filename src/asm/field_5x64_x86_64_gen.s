/***********************************************************************
 * Copyright (c) 2021 Kaushik Nath                                     *
 * Distributed under the MIT software license, see the accompanying    *
 * file COPYING or https://www.opensource.org/licenses/mit-license.php.*
 ***********************************************************************/

/* 4-limb field multiplication and squaring using the bottom 4-limbs of 
 * a 5-limb representation. First reduce the 5-limb inputs to fully
 * reduced 4-limb forms, then multiply and finally output a half reduced
 * output in 5-limb form. The leading limb is of atmost 33 bits. 
 *
 * Major instructions used in the assemblies: mul/add/adc.
 */

.att_syntax
.text

.p2align 4
.global secp256k1_fe_mul_inner
secp256k1_fe_mul_inner:
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

movq   $0x1000003d1,%rcx

movq   0(%rdx),%r8
movq   8(%rdx),%r9
movq   16(%rdx),%rbx
movq   24(%rdx),%rbp
movq   32(%rdx),%r13

movq   16(%rsi),%r10
movq   24(%rsi),%r11
movq   32(%rsi),%rax
mulq   %rcx 
xorq   %rdi,%rdi
addq   0(%rsi),%rax
adcq   8(%rsi),%rdx
adcq   $0,%r10
movq   %r10,80(%rsp)
adcq   $0,%r11
movq   %r11,88(%rsp)
cmovc  %rcx,%rdi
addq   %rax,%rdi
movq   %rdi,64(%rsp)
adcq   $0,%rdx
movq   %rdx,72(%rsp)

movq   %r13,%rax
mulq   %rcx 
xorq   %rdi,%rdi
addq   %r8,%rax
adcq   %r9,%rdx
adcq   $0,%rbx
adcq   $0,%rbp
cmovc  %rcx,%rdi
addq   %rax,%rdi
adcq   $0,%rdx
movq   %rdx,%rsi

movq   72(%rsp),%rax
mulq   %rbp
movq   %rax,%r8
xorq   %r9,%r9
movq   %rdx,%r10
xorq   %r11,%r11

movq   80(%rsp),%rax
mulq   %rbx
addq   %rax,%r8
adcq   $0,%r9
addq   %rdx,%r10
adcq   $0,%r11

movq   88(%rsp),%rax
mulq   %rsi
addq   %rax,%r8
adcq   $0,%r9
addq   %rdx,%r10
adcq   $0,%r11

movq   80(%rsp),%rax
mulq   %rbp
addq   %rax,%r10
adcq   $0,%r11
movq   %rdx,%r12
xorq   %r13,%r13

movq   88(%rsp),%rax
mulq   %rbx
addq   %rax,%r10
adcq   $0,%r11
addq   %rdx,%r12
adcq   $0,%r13

movq   %rcx,%rax
mulq   %r10
imul   %rcx,%r11
movq   %rax,%r10
addq   %rdx,%r11

movq   88(%rsp),%rax
mulq   %rbp
addq   %rax,%r12
adcq   $0,%r13

movq   %rcx,%rax
mulq   %rdx
movq   %rax,%r14
movq   %rdx,%r15

movq   %rcx,%rax
mulq   %r12
imul   %rcx,%r13
movq   %rax,%r12
addq   %rdx,%r13

movq   64(%rsp),%rax
mulq   %rbp
addq   %rax,%r14
adcq   $0,%r15
addq   %rdx,%r8
adcq   $0,%r9

movq   72(%rsp),%rax
mulq   %rbx
addq   %rax,%r14
adcq   $0,%r15
addq   %rdx,%r8
adcq   $0,%r9

movq   80(%rsp),%rax
mulq   %rsi
addq   %rax,%r14
adcq   $0,%r15
addq   %rdx,%r8
adcq   $0,%r9

movq   88(%rsp),%rax
mulq   %rdi
addq   %rax,%r14
adcq   $0,%r15
addq   %rdx,%r8
adcq   $0,%r9

movq   %rcx,%rax
mulq   %r8
imul   %rcx,%r9
movq   %rax,%r8
addq   %rdx,%r9

movq   64(%rsp),%rax
mulq   %rdi
addq   %rax,%r8
adcq   $0,%r9
addq   %rdx,%r10
adcq   $0,%r11

movq   64(%rsp),%rax
mulq   %rsi
addq   %rax,%r10
adcq   $0,%r11
addq   %rdx,%r12
adcq   $0,%r13

movq   72(%rsp),%rax
mulq   %rdi
addq   %rax,%r10
adcq   $0,%r11
addq   %rdx,%r12
adcq   $0,%r13

movq   64(%rsp),%rax
mulq   %rbx
addq   %rax,%r12
adcq   $0,%r13
addq   %rdx,%r14
adcq   $0,%r15

movq   72(%rsp),%rax
mulq   %rsi
addq   %rax,%r12
adcq   $0,%r13
addq   %rdx,%r14
adcq   $0,%r15

movq   80(%rsp),%rax
mulq   %rdi
addq   %rax,%r12
adcq   $0,%r13
addq   %rdx,%r14
adcq   $0,%r15

addq   %r9,%r10
adcq   $0,%r11
addq   %r11,%r12
adcq   $0,%r13
addq   %r13,%r14
adcq   $0,%r15

movq   56(%rsp),%rdi

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

.p2align 4
.global secp256k1_fe_sqr_inner
secp256k1_fe_sqr_inner:
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

movq   0(%rsi),%rbx
movq   8(%rsi),%rbp
movq   16(%rsi),%rcx
movq   24(%rsi),%rdi
movq   32(%rsi),%rax

movq   $0x1000003d1,%rsi

mulq   %rsi
movq   $0,%r8
addq   %rax,%rbx
adcq   %rdx,%rbp
adcq   $0,%rcx
adcq   $0,%rdi
cmovc  %rsi,%r8
addq   %r8,%rbx
adcq   $0,%rbp

movq   %rbp,%rax
mulq   %rdi
movq   %rax,%r8
xorq   %r9,%r9
movq   %rdx,%r10
xorq   %r11,%r11
addq   %rax,%r8
adcq   $0,%r9
addq   %rdx,%r10
adcq   $0,%r11

movq   %rcx,%rax
mulq   %rcx
addq   %rax,%r8
adcq   $0,%r9
addq   %rdx,%r10
adcq   $0,%r11

movq   %rcx,%rax
mulq   %rdi
addq   %rax,%r10
adcq   $0,%r11
movq   %rdx,%r12
xorq   %r13,%r13
addq   %rax,%r10
adcq   $0,%r11
addq   %rdx,%r12
adcq   $0,%r13

movq   %rsi,%rax
mulq   %r10
imul   %rsi,%r11
movq   %rax,%r10
addq   %rdx,%r11

movq   %rdi,%rax
mulq   %rdi
addq   %rax,%r12
adcq   $0,%r13

movq   %rsi,%rax
mulq   %rdx
movq   %rax,%r14
movq   %rdx,%r15

movq   %rsi,%rax
mulq   %r12
imul   %rsi,%r13
movq   %rax,%r12
addq   %rdx,%r13

movq   %rbx,%rax
mulq   %rdi
addq   %rax,%r14
adcq   $0,%r15
addq   %rdx,%r8
adcq   $0,%r9
addq   %rax,%r14
adcq   $0,%r15
addq   %rdx,%r8
adcq   $0,%r9

movq   %rbp,%rax
mulq   %rcx
addq   %rax,%r14
adcq   $0,%r15
addq   %rdx,%r8
adcq   $0,%r9
addq   %rax,%r14
adcq   $0,%r15
addq   %rdx,%r8
adcq   $0,%r9

movq   %rsi,%rax
mulq   %r8
imul   %rsi,%r9
movq   %rax,%r8
addq   %rdx,%r9

movq   %rbx,%rax
mulq   %rbx
addq   %rax,%r8
adcq   $0,%r9
addq   %rdx,%r10
adcq   $0,%r11

movq   %rbx,%rax
mulq   %rbp
addq   %rax,%r10
adcq   $0,%r11
addq   %rdx,%r12
adcq   $0,%r13
addq   %rax,%r10
adcq   $0,%r11
addq   %rdx,%r12
adcq   $0,%r13

movq   %rbx,%rax
mulq   %rcx
addq   %rax,%r12
adcq   $0,%r13
addq   %rdx,%r14
adcq   $0,%r15
addq   %rax,%r12
adcq   $0,%r13
addq   %rdx,%r14
adcq   $0,%r15

movq   %rbp,%rax
mulq   %rbp
addq   %rax,%r12
adcq   $0,%r13
addq   %rdx,%r14
adcq   $0,%r15

addq   %r9,%r10
adcq   $0,%r11
addq   %r11,%r12
adcq   $0,%r13
addq   %r13,%r14
adcq   $0,%r15

movq   56(%rsp),%rdi

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
