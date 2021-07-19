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
 * Major assembly instructions used in the assemblies: mulx/add/adc.
 */

.att_syntax
.text

.p2align 4
.global secp256k1_fe_mul_inner
.type	secp256k1_fe_mul_inner, %function
secp256k1_fe_mul_inner:
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

movq    0(%rsi),%r8
movq    8(%rsi),%r9
movq    16(%rsi),%r10
movq    24(%rsi),%r11
movq    0(%rdx),%r12
movq    8(%rdx),%r13
movq    16(%rdx),%rdi
movq    24(%rdx),%r15
movq    32(%rdx),%rax

movq    $0x1000003D1,%rdx
xorq    %rcx,%rcx
mulx    32(%rsi),%rbx,%rbp
addq    %rbx,%r8
adcq    %rbp,%r9
adcq    $0,%r10
adcq    $0,%r11
cmovc   %rdx,%rcx
addq    %rcx,%r8
adcq    $0,%r9

xorq    %rcx,%rcx
mulx    %rax,%rax,%rbx
addq    %rax,%r12
adcq    %rbx,%r13
adcq    $0,%rdi
adcq    $0,%r15
cmovc   %rdx,%rcx
addq    %rcx,%r12
adcq    $0,%r13
movq    %r15,%rsi

movq    %r8,64(%rsp)
movq    %r9,72(%rsp)
movq    %r10,80(%rsp)
movq    %r11,88(%rsp)
movq    %r12,96(%rsp)
movq    %r13,104(%rsp)

movq    64(%rsp),%rdx
mulx    96(%rsp),%r8,%r9
mulx    104(%rsp),%rcx,%r10
addq    %rcx,%r9
mulx    %rdi,%rcx,%r11
adcq    %rcx,%r10
mulx    %rsi,%rcx,%r12
adcq    %rcx,%r11
adcq    $0,%r12

movq    72(%rsp),%rdx    
mulx    96(%rsp),%rax,%rbx
mulx    104(%rsp),%rcx,%rbp
addq    %rcx,%rbx
mulx    %rdi,%rcx,%r15
adcq    %rcx,%rbp
mulx    %rsi,%rcx,%r13
adcq    %rcx,%r15
adcq    $0,%r13
addq    %rax,%r9
adcq    %rbx,%r10
adcq    %rbp,%r11
adcq    %r15,%r12
adcq    $0,%r13

movq    80(%rsp),%rdx
mulx    96(%rsp),%rax,%rbx
mulx    104(%rsp),%rcx,%rbp
addq    %rcx,%rbx
mulx    %rdi,%rcx,%r15
adcq    %rcx,%rbp
mulx    %rsi,%rcx,%r14
adcq    %rcx,%r15
adcq    $0,%r14
addq    %rax,%r10
adcq    %rbx,%r11
adcq    %rbp,%r12
adcq    %r15,%r13
adcq    $0,%r14

movq    88(%rsp),%rdx
mulx    96(%rsp),%rax,%rbx
mulx    104(%rsp),%rcx,%rbp
addq    %rcx,%rbx
mulx    %rdi,%rcx,%r15
adcq    %rcx,%rbp
mulx    %rsi,%rcx,%rsi
adcq    %rcx,%r15
adcq    $0,%rsi
addq    %rax,%r11
adcq    %rbx,%r12
adcq    %rbp,%r13
adcq    %r15,%r14
adcq    $0,%rsi

movq    $0x1000003D1,%rdx
mulx    %r12,%r12,%rbx
mulx    %r13,%r13,%rcx
addq    %rbx,%r13
mulx    %r14,%r14,%rbx
adcq    %rcx,%r14
mulx    %rsi,%r15,%rcx
adcq    %rbx,%r15
adcq    $0,%rcx
addq    %r12,%r8
adcq    %r13,%r9
adcq    %r14,%r10
adcq    %r15,%r11
adcq    $0,%rcx

movq 	56(%rsp),%rdi
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
.size secp256k1_fe_mul_inner, .-secp256k1_fe_mul_inner

.p2align 4
.global secp256k1_fe_sqr_inner
.type secp256k1_fe_sqr_inner, %function
secp256k1_fe_sqr_inner:
movq    %rsp,%r11
subq    $56,%rsp

movq 	%r11,0(%rsp)
movq 	%r12,8(%rsp)
movq 	%r13,16(%rsp)
movq 	%r14,24(%rsp)
movq 	%r15,32(%rsp)
movq 	%rbp,40(%rsp)
movq 	%rbx,48(%rsp)

movq    0(%rsi),%rbx  
movq    8(%rsi),%rbp  
movq    16(%rsi),%rax

movq    $0x1000003D1,%rdx
xorq    %r15,%r15
mulx    32(%rsi),%r13,%r14
movq    24(%rsi),%rsi
addq    %r13,%rbx
adcq    %r14,%rbp
adcq    $0,%rax
adcq    $0,%rsi
cmovc   %rdx,%r15
addq    %r15,%rbx
adcq    $0,%rbp

xorq    %r13,%r13
movq    %rbx,%rdx
mulx    %rbp,%r9,%r10
mulx    %rax,%rcx,%r11
adcx    %rcx,%r10
mulx    %rsi,%rcx,%r12
adcx    %rcx,%r11
adcx    %r13,%r12

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

xorq    %r15,%r15
movq    %rax,%rdx
mulx    %rsi,%rcx,%r14
adcx    %rcx,%r13
adcx    %r15,%r14

shld    $1,%r14,%r15
shld    $1,%r13,%r14
shld    $1,%r12,%r13
shld    $1,%r11,%r12
shld    $1,%r10,%r11
shld    $1,%r9,%r10
addq    %r9,%r9
     
xorq    %rdx,%rdx
movq    %rbx,%rdx
mulx    %rdx,%r8,%rdx
adcx    %rdx,%r9

movq    %rbp,%rdx
mulx    %rdx,%rcx,%rdx
adcx    %rcx,%r10
adcx    %rdx,%r11

movq    %rax,%rdx
mulx    %rdx,%rcx,%rdx
adcx    %rcx,%r12
adcx    %rdx,%r13

movq    %rsi,%rdx
mulx    %rdx,%rcx,%rdx
adcx    %rcx,%r14
adcx    %rdx,%r15	

xorq    %rbx,%rbx
movq    $0x1000003D1,%rdx
mulx    %r12,%r12,%rbp
adcx    %r8,%r12
adox    %r9,%rbp
mulx    %r13,%rcx,%rax
adcx    %rcx,%rbp
adox    %r10,%rax
mulx    %r14,%rcx,%rsi
adcx    %rcx,%rax
adox    %r11,%rsi
mulx    %r15,%rcx,%r15
adcx    %rcx,%rsi
adox    %rbx,%r15
adcx    %rbx,%r15	

movq    %r12,0(%rdi)
movq    %rbp,8(%rdi)
movq    %rax,16(%rdi)
movq    %rsi,24(%rdi)
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
.size secp256k1_fe_sqr_inner, .-secp256k1_fe_sqr_inner
