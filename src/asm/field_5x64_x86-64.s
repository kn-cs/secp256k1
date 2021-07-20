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
 * Major instructions used in the assemblies: mulx/adcx/adox.
 */

.att_syntax
.text

.p2align 4
.global secp256k1_fe_mul_inner
.type	secp256k1_fe_mul_inner, %function
secp256k1_fe_mul_inner:
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

movq    0(%rsi),%rax
movq    8(%rsi),%rbx
movq    16(%rsi),%rdi

movq    0(%rdx),%r8
movq    8(%rdx),%r9
movq    16(%rdx),%r10
movq    24(%rdx),%r11
movq    32(%rdx),%r12

movq    $0x1000003D1,%rdx
xorq    %rcx,%rcx
mulx    32(%rsi),%rbp,%rcx
movq    24(%rsi),%rsi
addq    %rbp,%rax
adcq    %rcx,%rbx
adcq    $0,%rdi
adcq    $0,%rsi
cmovc   %rdx,%rcx
addq    %rcx,%rax
adcq    $0,%rbx

xorq    %rcx,%rcx
mulx    %r12,%r13,%r14
addq    %r13,%r8
adcq    %r14,%r9
adcq    $0,%r10
adcq    $0,%r11
cmovc   %rdx,%rcx
addq    %rcx,%r8
adcq    $0,%r9

movq    %r8,64(%rsp)
movq    %r9,72(%rsp)
movq    %r10,80(%rsp)
movq    %r11,88(%rsp)

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
  
xorq    %rbp,%rbp
movq    $0x1000003D1,%rdx
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

movq    56(%rsp),%rdi

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
