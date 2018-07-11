/*
**  SSEmem benchmarks for RAMspeed (amd64)
**
**  (UNIX release)
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2005-09 Paul V. Bolotoff <walter@alasir.com>
**
**  All rights reserved.
**
*/

.globl ssecp
ssecp:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r15
	subq	$88, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.precp:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.precp
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$512, %rax
.maincp:
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	movaps	%xmm0, 0(%r9)
	movaps	%xmm1, 16(%r9)
	movaps	%xmm2, 32(%r9)
	movaps	%xmm3, 48(%r9)
	movaps	%xmm4, 64(%r9)
	movaps	%xmm5, 80(%r9)
	movaps	%xmm6, 96(%r9)
	movaps	%xmm7, 112(%r9)
	movaps	128(%r8), %xmm8
	movaps	144(%r8), %xmm9
	movaps	160(%r8), %xmm10
	movaps	176(%r8), %xmm11
	movaps	192(%r8), %xmm12
	movaps	208(%r8), %xmm13
	movaps	224(%r8), %xmm14
	movaps	240(%r8), %xmm15
	movaps	%xmm8, 128(%r9)
	movaps	%xmm9, 144(%r9)
	movaps	%xmm10, 160(%r9)
	movaps	%xmm11, 176(%r9)
	movaps	%xmm12, 192(%r9)
	movaps	%xmm13, 208(%r9)
	movaps	%xmm14, 224(%r9)
	movaps	%xmm15, 240(%r9)
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	movaps	%xmm0, 256(%r9)
	movaps	%xmm1, 272(%r9)
	movaps	%xmm2, 288(%r9)
	movaps	%xmm3, 304(%r9)
	movaps	%xmm4, 320(%r9)
	movaps	%xmm5, 336(%r9)
	movaps	%xmm6, 352(%r9)
	movaps	%xmm7, 368(%r9)
	movaps	384(%r8), %xmm8
	movaps	400(%r8), %xmm9
	movaps	416(%r8), %xmm10
	movaps	432(%r8), %xmm11
	movaps	448(%r8), %xmm12
	movaps	464(%r8), %xmm13
	movaps	480(%r8), %xmm14
	movaps	496(%r8), %xmm15
	movaps	%xmm8, 384(%r9)
	movaps	%xmm9, 400(%r9)
	movaps	%xmm10, 416(%r9)
	movaps	%xmm11, 432(%r9)
	movaps	%xmm12, 448(%r9)
	movaps	%xmm13, 464(%r9)
	movaps	%xmm14, 480(%r9)
	movaps	%xmm15, 496(%r9)
	addq	%rax, %r8
	addq	%rax, %r9
	decq	%rcx
	jnz	.maincp

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.maincp

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssesc
ssesc:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r15
	subq	$88, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.presc:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.presc
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	16(%rsp)
	fst	20(%rsp)
	movlps	16(%rsp), %xmm8
	movlhps	%xmm8, %xmm8
	ffree	%st(0)
/* execute */
	shrq	$9, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$512, %rax
.mainsc:
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movaps	%xmm0, 0(%r9)
	movaps	%xmm1, 16(%r9)
	movaps	%xmm2, 32(%r9)
	movaps	%xmm3, 48(%r9)
	movaps	%xmm4, 64(%r9)
	movaps	%xmm5, 80(%r9)
	movaps	%xmm6, 96(%r9)
	movaps	%xmm7, 112(%r9)
	movaps	128(%r8), %xmm0
	movaps	144(%r8), %xmm1
	movaps	160(%r8), %xmm2
	movaps	176(%r8), %xmm3
	movaps	192(%r8), %xmm4
	movaps	208(%r8), %xmm5
	movaps	224(%r8), %xmm6
	movaps	240(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movaps	%xmm0, 128(%r9)
	movaps	%xmm1, 144(%r9)
	movaps	%xmm2, 160(%r9)
	movaps	%xmm3, 176(%r9)
	movaps	%xmm4, 192(%r9)
	movaps	%xmm5, 208(%r9)
	movaps	%xmm6, 224(%r9)
	movaps	%xmm7, 240(%r9)
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movaps	%xmm0, 256(%r9)
	movaps	%xmm1, 272(%r9)
	movaps	%xmm2, 288(%r9)
	movaps	%xmm3, 304(%r9)
	movaps	%xmm4, 320(%r9)
	movaps	%xmm5, 336(%r9)
	movaps	%xmm6, 352(%r9)
	movaps	%xmm7, 368(%r9)
	movaps	384(%r8), %xmm0
	movaps	400(%r8), %xmm1
	movaps	416(%r8), %xmm2
	movaps	432(%r8), %xmm3
	movaps	448(%r8), %xmm4
	movaps	464(%r8), %xmm5
	movaps	480(%r8), %xmm6
	movaps	496(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movaps	%xmm0, 384(%r9)
	movaps	%xmm1, 400(%r9)
	movaps	%xmm2, 416(%r9)
	movaps	%xmm3, 432(%r9)
	movaps	%xmm4, 448(%r9)
	movaps	%xmm5, 464(%r9)
	movaps	%xmm6, 480(%r9)
	movaps	%xmm7, 496(%r9)
	addq	%rax, %r8
	addq	%rax, %r9
	decq	%rcx
	jnz	.mainsc

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainsc

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssead
ssead:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$80, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%r13, %r14
	addq	%rbx, %r14
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	addq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.pread:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.pread
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$512, %rax
.mainad:
	movaps	0(%r9), %xmm0
	movaps	16(%r9), %xmm1
	movaps	32(%r9), %xmm2
	movaps	48(%r9), %xmm3
	movaps	64(%r9), %xmm4
	movaps	80(%r9), %xmm5
	movaps	96(%r9), %xmm6
	movaps	112(%r9), %xmm7
	addps	0(%r8), %xmm0
	addps	16(%r8), %xmm1
	addps	32(%r8), %xmm2
	addps	48(%r8), %xmm3
	addps	64(%r8), %xmm4
	addps	80(%r8), %xmm5
	addps	96(%r8), %xmm6
	addps	112(%r8), %xmm7
	movaps	%xmm0, 0(%r10)
	movaps	%xmm1, 16(%r10)
	movaps	%xmm2, 32(%r10)
	movaps	%xmm3, 48(%r10)
	movaps	%xmm4, 64(%r10)
	movaps	%xmm5, 80(%r10)
	movaps	%xmm6, 96(%r10)
	movaps	%xmm7, 112(%r10)
	movaps	128(%r9), %xmm8
	movaps	144(%r9), %xmm9
	movaps	160(%r9), %xmm10
	movaps	176(%r9), %xmm11
	movaps	192(%r9), %xmm12
	movaps	208(%r9), %xmm13
	movaps	224(%r9), %xmm14
	movaps	240(%r9), %xmm15
	addps	128(%r8), %xmm8
	addps	144(%r8), %xmm9
	addps	160(%r8), %xmm10
	addps	176(%r8), %xmm11
	addps	192(%r8), %xmm12
	addps	208(%r8), %xmm13
	addps	224(%r8), %xmm14
	addps	240(%r8), %xmm15
	movaps	%xmm8, 128(%r10)
	movaps	%xmm9, 144(%r10)
	movaps	%xmm10, 160(%r10)
	movaps	%xmm11, 176(%r10)
	movaps	%xmm12, 192(%r10)
	movaps	%xmm13, 208(%r10)
	movaps	%xmm14, 224(%r10)
	movaps	%xmm15, 240(%r10)
	movaps	256(%r9), %xmm0
	movaps	272(%r9), %xmm1
	movaps	288(%r9), %xmm2
	movaps	304(%r9), %xmm3
	movaps	320(%r9), %xmm4
	movaps	336(%r9), %xmm5
	movaps	352(%r9), %xmm6
	movaps	368(%r9), %xmm7
	addps	256(%r8), %xmm0
	addps	272(%r8), %xmm1
	addps	288(%r8), %xmm2
	addps	304(%r8), %xmm3
	addps	320(%r8), %xmm4
	addps	336(%r8), %xmm5
	addps	352(%r8), %xmm6
	addps	368(%r8), %xmm7
	movaps	%xmm0, 256(%r10)
	movaps	%xmm1, 272(%r10)
	movaps	%xmm2, 288(%r10)
	movaps	%xmm3, 304(%r10)
	movaps	%xmm4, 320(%r10)
	movaps	%xmm5, 336(%r10)
	movaps	%xmm6, 352(%r10)
	movaps	%xmm7, 368(%r10)
	movaps	384(%r9), %xmm8
	movaps	400(%r9), %xmm9
	movaps	416(%r9), %xmm10
	movaps	432(%r9), %xmm11
	movaps	448(%r9), %xmm12
	movaps	464(%r9), %xmm13
	movaps	480(%r9), %xmm14
	movaps	496(%r9), %xmm15
	addps	384(%r8), %xmm8
	addps	400(%r8), %xmm9
	addps	416(%r8), %xmm10
	addps	432(%r8), %xmm11
	addps	448(%r8), %xmm12
	addps	464(%r8), %xmm13
	addps	480(%r8), %xmm14
	addps	496(%r8), %xmm15
	movaps	%xmm8, 384(%r10)
	movaps	%xmm9, 400(%r10)
	movaps	%xmm10, 416(%r10)
	movaps	%xmm11, 432(%r10)
	movaps	%xmm12, 448(%r10)
	movaps	%xmm13, 464(%r10)
	movaps	%xmm14, 480(%r10)
	movaps	%xmm15, 496(%r10)
	addq	%rax, %r8
	addq	%rax, %r9
	addq	%rax, %r10
	decq	%rcx
	jnz	.mainad

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainad

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssetr
ssetr:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$80, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%r13, %r14
	addq	%rbx, %r14
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	addq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.pretr:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.pretr
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	16(%rsp)
	fst	20(%rsp)
	movlps	16(%rsp), %xmm8
	movlhps	%xmm8, %xmm8
	ffree	%st(0)
/* execute */
	shrq	$9, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$512, %rax
.maintr:
	movaps	0(%r9), %xmm0
	movaps	16(%r9), %xmm1
	movaps	32(%r9), %xmm2
	movaps	48(%r9), %xmm3
	movaps	64(%r9), %xmm4
	movaps	80(%r9), %xmm5
	movaps	96(%r9), %xmm6
	movaps	112(%r9), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	0(%r8), %xmm0
	addps	16(%r8), %xmm1
	addps	32(%r8), %xmm2
	addps	48(%r8), %xmm3
	addps	64(%r8), %xmm4
	addps	80(%r8), %xmm5
	addps	96(%r8), %xmm6
	addps	112(%r8), %xmm7
	movaps	%xmm0, 0(%r10)
	movaps	%xmm1, 16(%r10)
	movaps	%xmm2, 32(%r10)
	movaps	%xmm3, 48(%r10)
	movaps	%xmm4, 64(%r10)
	movaps	%xmm5, 80(%r10)
	movaps	%xmm6, 96(%r10)
	movaps	%xmm7, 112(%r10)
	movaps	128(%r9), %xmm0
	movaps	144(%r9), %xmm1
	movaps	160(%r9), %xmm2
	movaps	176(%r9), %xmm3
	movaps	192(%r9), %xmm4
	movaps	208(%r9), %xmm5
	movaps	224(%r9), %xmm6
	movaps	240(%r9), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	128(%r8), %xmm0
	addps	144(%r8), %xmm1
	addps	160(%r8), %xmm2
	addps	176(%r8), %xmm3
	addps	192(%r8), %xmm4
	addps	208(%r8), %xmm5
	addps	224(%r8), %xmm6
	addps	240(%r8), %xmm7
	movaps	%xmm0, 128(%r10)
	movaps	%xmm1, 144(%r10)
	movaps	%xmm2, 160(%r10)
	movaps	%xmm3, 176(%r10)
	movaps	%xmm4, 192(%r10)
	movaps	%xmm5, 208(%r10)
	movaps	%xmm6, 224(%r10)
	movaps	%xmm7, 240(%r10)
	movaps	256(%r9), %xmm0
	movaps	272(%r9), %xmm1
	movaps	288(%r9), %xmm2
	movaps	304(%r9), %xmm3
	movaps	320(%r9), %xmm4
	movaps	336(%r9), %xmm5
	movaps	352(%r9), %xmm6
	movaps	368(%r9), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	256(%r8), %xmm0
	addps	272(%r8), %xmm1
	addps	288(%r8), %xmm2
	addps	304(%r8), %xmm3
	addps	320(%r8), %xmm4
	addps	336(%r8), %xmm5
	addps	352(%r8), %xmm6
	addps	368(%r8), %xmm7
	movaps	%xmm0, 256(%r10)
	movaps	%xmm1, 272(%r10)
	movaps	%xmm2, 288(%r10)
	movaps	%xmm3, 304(%r10)
	movaps	%xmm4, 320(%r10)
	movaps	%xmm5, 336(%r10)
	movaps	%xmm6, 352(%r10)
	movaps	%xmm7, 368(%r10)
	movaps	384(%r9), %xmm0
	movaps	400(%r9), %xmm1
	movaps	416(%r9), %xmm2
	movaps	432(%r9), %xmm3
	movaps	448(%r9), %xmm4
	movaps	464(%r9), %xmm5
	movaps	480(%r9), %xmm6
	movaps	496(%r9), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	384(%r8), %xmm0
	addps	400(%r8), %xmm1
	addps	416(%r8), %xmm2
	addps	432(%r8), %xmm3
	addps	448(%r8), %xmm4
	addps	464(%r8), %xmm5
	addps	480(%r8), %xmm6
	addps	496(%r8), %xmm7
	movaps	%xmm0, 384(%r10)
	movaps	%xmm1, 400(%r10)
	movaps	%xmm2, 416(%r10)
	movaps	%xmm3, 432(%r10)
	movaps	%xmm4, 448(%r10)
	movaps	%xmm5, 464(%r10)
	movaps	%xmm6, 480(%r10)
	movaps	%xmm7, 496(%r10)
	addq	%rax, %r8
	addq	%rax, %r9
	addq	%rax, %r10
	decq	%rcx
	jnz	.maintr

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.maintr

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssecp_nt
ssecp_nt:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r15
	subq	$88, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.precp_nt:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.precp_nt
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$10, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$1024, %rax
.maincp_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	1024(%r8)
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	prefetchnta	1088(%r8)
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	prefetchnta	1152(%r8)
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	prefetchnta	1216(%r8)
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	movntps	%xmm0, 0(%r9)
	movntps	%xmm1, 16(%r9)
	movntps	%xmm2, 32(%r9)
	movntps	%xmm3, 48(%r9)
	movntps	%xmm4, 64(%r9)
	movntps	%xmm5, 80(%r9)
	movntps	%xmm6, 96(%r9)
	movntps	%xmm7, 112(%r9)
	prefetchnta	1280(%r8)
	movaps	128(%r8), %xmm8
	movaps	144(%r8), %xmm9
	prefetchnta	1344(%r8)
	movaps	160(%r8), %xmm10
	movaps	176(%r8), %xmm11
	prefetchnta	1408(%r8)
	movaps	192(%r8), %xmm12
	movaps	208(%r8), %xmm13
	prefetchnta	1472(%r8)
	movaps	224(%r8), %xmm14
	movaps	240(%r8), %xmm15
	movntps	%xmm8, 128(%r9)
	movntps	%xmm9, 144(%r9)
	movntps	%xmm10, 160(%r9)
	movntps	%xmm11, 176(%r9)
	movntps	%xmm12, 192(%r9)
	movntps	%xmm13, 208(%r9)
	movntps	%xmm14, 224(%r9)
	movntps	%xmm15, 240(%r9)
	prefetchnta	1536(%r8)
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	prefetchnta	1600(%r8)
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	prefetchnta	1664(%r8)
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	prefetchnta	1728(%r8)
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	movntps	%xmm0, 256(%r9)
	movntps	%xmm1, 272(%r9)
	movntps	%xmm2, 288(%r9)
	movntps	%xmm3, 304(%r9)
	movntps	%xmm4, 320(%r9)
	movntps	%xmm5, 336(%r9)
	movntps	%xmm6, 352(%r9)
	movntps	%xmm7, 368(%r9)
	prefetchnta	1792(%r8)
	movaps	384(%r8), %xmm8
	movaps	400(%r8), %xmm9
	prefetchnta	1856(%r8)
	movaps	416(%r8), %xmm10
	movaps	432(%r8), %xmm11
	prefetchnta	1920(%r8)
	movaps	448(%r8), %xmm12
	movaps	464(%r8), %xmm13
	prefetchnta	1984(%r8)
	movaps	480(%r8), %xmm14
	movaps	496(%r8), %xmm15
	movntps	%xmm8, 384(%r9)
	movntps	%xmm9, 400(%r9)
	movntps	%xmm10, 416(%r9)
	movntps	%xmm11, 432(%r9)
	movntps	%xmm12, 448(%r9)
	movntps	%xmm13, 464(%r9)
	movntps	%xmm14, 480(%r9)
	movntps	%xmm15, 496(%r9)
	movaps	512(%r8), %xmm0
	movaps	528(%r8), %xmm1
	movaps	544(%r8), %xmm2
	movaps	560(%r8), %xmm3
	movaps	576(%r8), %xmm4
	movaps	592(%r8), %xmm5
	movaps	608(%r8), %xmm6
	movaps	624(%r8), %xmm7
	movntps	%xmm0, 512(%r9)
	movntps	%xmm1, 528(%r9)
	movntps	%xmm2, 544(%r9)
	movntps	%xmm3, 560(%r9)
	movntps	%xmm4, 576(%r9)
	movntps	%xmm5, 592(%r9)
	movntps	%xmm6, 608(%r9)
	movntps	%xmm7, 624(%r9)
	movaps	640(%r8), %xmm0
	movaps	656(%r8), %xmm1
	movaps	672(%r8), %xmm2
	movaps	688(%r8), %xmm3
	movaps	704(%r8), %xmm4
	movaps	720(%r8), %xmm5
	movaps	736(%r8), %xmm6
	movaps	752(%r8), %xmm7
	movntps	%xmm0, 640(%r9)
	movntps	%xmm1, 656(%r9)
	movntps	%xmm2, 672(%r9)
	movntps	%xmm3, 688(%r9)
	movntps	%xmm4, 704(%r9)
	movntps	%xmm5, 720(%r9)
	movntps	%xmm6, 736(%r9)
	movntps	%xmm7, 752(%r9)
	movaps	768(%r8), %xmm0
	movaps	784(%r8), %xmm1
	movaps	800(%r8), %xmm2
	movaps	816(%r8), %xmm3
	movaps	832(%r8), %xmm4
	movaps	848(%r8), %xmm5
	movaps	864(%r8), %xmm6
	movaps	880(%r8), %xmm7
	movntps	%xmm0, 768(%r9)
	movntps	%xmm1, 784(%r9)
	movntps	%xmm2, 800(%r9)
	movntps	%xmm3, 816(%r9)
	movntps	%xmm4, 832(%r9)
	movntps	%xmm5, 848(%r9)
	movntps	%xmm6, 864(%r9)
	movntps	%xmm7, 880(%r9)
	movaps	896(%r8), %xmm0
	movaps	912(%r8), %xmm1
	movaps	928(%r8), %xmm2
	movaps	944(%r8), %xmm3
	movaps	960(%r8), %xmm4
	movaps	976(%r8), %xmm5
	movaps	992(%r8), %xmm6
	movaps	1008(%r8), %xmm7
	movntps	%xmm0, 896(%r9)
	movntps	%xmm1, 912(%r9)
	movntps	%xmm2, 928(%r9)
	movntps	%xmm3, 944(%r9)
	movntps	%xmm4, 960(%r9)
	movntps	%xmm5, 976(%r9)
	movntps	%xmm6, 992(%r9)
	movntps	%xmm7, 1008(%r9)
	addq	%rax, %r8
	addq	%rax, %r9
	decq	%rcx
	jnz	.maincp_nt

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.maincp_nt

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssesc_nt
ssesc_nt:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r15
	subq	$88, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.presc_nt:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.presc_nt
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	16(%rsp)
	fst	20(%rsp)
	movlps	16(%rsp), %xmm8
	movlhps	%xmm8, %xmm8
	ffree	%st(0)
/* execute */
	shrq	$10, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$1024, %rax
.mainsc_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	1024(%r8)
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	prefetchnta	1088(%r8)
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	prefetchnta	1152(%r8)
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	prefetchnta	1216(%r8)
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 0(%r9)
	movntps	%xmm1, 16(%r9)
	movntps	%xmm2, 32(%r9)
	movntps	%xmm3, 48(%r9)
	movntps	%xmm4, 64(%r9)
	movntps	%xmm5, 80(%r9)
	movntps	%xmm6, 96(%r9)
	movntps	%xmm7, 112(%r9)
	prefetchnta	1280(%r8)
	movaps	128(%r8), %xmm0
	movaps	144(%r8), %xmm1
	prefetchnta	1344(%r8)
	movaps	160(%r8), %xmm2
	movaps	176(%r8), %xmm3
	prefetchnta	1408(%r8)
	movaps	192(%r8), %xmm4
	movaps	208(%r8), %xmm5
	prefetchnta	1472(%r8)
	movaps	224(%r8), %xmm6
	movaps	240(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 128(%r9)
	movntps	%xmm1, 144(%r9)
	movntps	%xmm2, 160(%r9)
	movntps	%xmm3, 176(%r9)
	movntps	%xmm4, 192(%r9)
	movntps	%xmm5, 208(%r9)
	movntps	%xmm6, 224(%r9)
	movntps	%xmm7, 240(%r9)
	prefetchnta	1536(%r8)
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	prefetchnta	1600(%r8)
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	prefetchnta	1664(%r8)
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	prefetchnta	1728(%r8)
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 256(%r9)
	movntps	%xmm1, 272(%r9)
	movntps	%xmm2, 288(%r9)
	movntps	%xmm3, 304(%r9)
	movntps	%xmm4, 320(%r9)
	movntps	%xmm5, 336(%r9)
	movntps	%xmm6, 352(%r9)
	movntps	%xmm7, 368(%r9)
	prefetchnta	1792(%r8)
	movaps	384(%r8), %xmm0
	movaps	400(%r8), %xmm1
	prefetchnta	1856(%r8)
	movaps	416(%r8), %xmm2
	movaps	432(%r8), %xmm3
	prefetchnta	1920(%r8)
	movaps	448(%r8), %xmm4
	movaps	464(%r8), %xmm5
	prefetchnta	1984(%r8)
	movaps	480(%r8), %xmm6
	movaps	496(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 384(%r9)
	movntps	%xmm1, 400(%r9)
	movntps	%xmm2, 416(%r9)
	movntps	%xmm3, 432(%r9)
	movntps	%xmm4, 448(%r9)
	movntps	%xmm5, 464(%r9)
	movntps	%xmm6, 480(%r9)
	movntps	%xmm7, 496(%r9)
	movaps	512(%r8), %xmm0
	movaps	528(%r8), %xmm1
	movaps	544(%r8), %xmm2
	movaps	560(%r8), %xmm3
	movaps	576(%r8), %xmm4
	movaps	592(%r8), %xmm5
	movaps	608(%r8), %xmm6
	movaps	624(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 512(%r9)
	movntps	%xmm1, 528(%r9)
	movntps	%xmm2, 544(%r9)
	movntps	%xmm3, 560(%r9)
	movntps	%xmm4, 576(%r9)
	movntps	%xmm5, 592(%r9)
	movntps	%xmm6, 608(%r9)
	movntps	%xmm7, 624(%r9)
	movaps	640(%r8), %xmm0
	movaps	656(%r8), %xmm1
	movaps	672(%r8), %xmm2
	movaps	688(%r8), %xmm3
	movaps	704(%r8), %xmm4
	movaps	720(%r8), %xmm5
	movaps	736(%r8), %xmm6
	movaps	752(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 640(%r9)
	movntps	%xmm1, 656(%r9)
	movntps	%xmm2, 672(%r9)
	movntps	%xmm3, 688(%r9)
	movntps	%xmm4, 704(%r9)
	movntps	%xmm5, 720(%r9)
	movntps	%xmm6, 736(%r9)
	movntps	%xmm7, 752(%r9)
	movaps	768(%r8), %xmm0
	movaps	784(%r8), %xmm1
	movaps	800(%r8), %xmm2
	movaps	816(%r8), %xmm3
	movaps	832(%r8), %xmm4
	movaps	848(%r8), %xmm5
	movaps	864(%r8), %xmm6
	movaps	880(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 768(%r9)
	movntps	%xmm1, 784(%r9)
	movntps	%xmm2, 800(%r9)
	movntps	%xmm3, 816(%r9)
	movntps	%xmm4, 832(%r9)
	movntps	%xmm5, 848(%r9)
	movntps	%xmm6, 864(%r9)
	movntps	%xmm7, 880(%r9)
	movaps	896(%r8), %xmm0
	movaps	912(%r8), %xmm1
	movaps	928(%r8), %xmm2
	movaps	944(%r8), %xmm3
	movaps	960(%r8), %xmm4
	movaps	976(%r8), %xmm5
	movaps	992(%r8), %xmm6
	movaps	1008(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 896(%r9)
	movntps	%xmm1, 912(%r9)
	movntps	%xmm2, 928(%r9)
	movntps	%xmm3, 944(%r9)
	movntps	%xmm4, 960(%r9)
	movntps	%xmm5, 976(%r9)
	movntps	%xmm6, 992(%r9)
	movntps	%xmm7, 1008(%r9)
	addq	%rax, %r8
	addq	%rax, %r9
	decq	%rcx
	jnz	.mainsc_nt

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainsc_nt

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssead_nt
ssead_nt:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$80, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%r13, %r14
	addq	%rbx, %r14
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	addq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.pread_nt:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.pread_nt
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$10, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$1024, %rax
.mainad_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	1024(%r9)
	movaps	0(%r9), %xmm0
	movaps	16(%r9), %xmm1
	movaps	32(%r9), %xmm2
	movaps	48(%r9), %xmm3
	prefetchnta	1024(%r8)
	movaps	64(%r9), %xmm4
	movaps	80(%r9), %xmm5
	movaps	96(%r9), %xmm6
	movaps	112(%r9), %xmm7
	prefetchnta	1088(%r9)
	addps	0(%r8), %xmm0
	addps	16(%r8), %xmm1
	addps	32(%r8), %xmm2
	addps	48(%r8), %xmm3
	prefetchnta	1088(%r8)
	addps	64(%r8), %xmm4
	addps	80(%r8), %xmm5
	addps	96(%r8), %xmm6
	addps	112(%r8), %xmm7
	movntps	%xmm0, 0(%r10)
	movntps	%xmm1, 16(%r10)
	movntps	%xmm2, 32(%r10)
	movntps	%xmm3, 48(%r10)
	movntps	%xmm4, 64(%r10)
	movntps	%xmm5, 80(%r10)
	movntps	%xmm6, 96(%r10)
	movntps	%xmm7, 112(%r10)
	prefetchnta	1152(%r9)
	movaps	128(%r9), %xmm8
	movaps	144(%r9), %xmm9
	movaps	160(%r9), %xmm10
	movaps	176(%r9), %xmm11
	prefetchnta	1152(%r8)
	movaps	192(%r9), %xmm12
	movaps	208(%r9), %xmm13
	movaps	224(%r9), %xmm14
	movaps	240(%r9), %xmm15
	prefetchnta	1216(%r9)
	addps	128(%r8), %xmm8
	addps	144(%r8), %xmm9
	addps	160(%r8), %xmm10
	addps	176(%r8), %xmm11
	prefetchnta	1216(%r8)
	addps	192(%r8), %xmm12
	addps	208(%r8), %xmm13
	addps	224(%r8), %xmm14
	addps	240(%r8), %xmm15
	movntps	%xmm8, 128(%r10)
	movntps	%xmm9, 144(%r10)
	movntps	%xmm10, 160(%r10)
	movntps	%xmm11, 176(%r10)
	movntps	%xmm12, 192(%r10)
	movntps	%xmm13, 208(%r10)
	movntps	%xmm14, 224(%r10)
	movntps	%xmm15, 240(%r10)
	prefetchnta	1280(%r9)
	movaps	256(%r9), %xmm0
	movaps	272(%r9), %xmm1
	movaps	288(%r9), %xmm2
	movaps	304(%r9), %xmm3
	prefetchnta	1280(%r8)
	movaps	320(%r9), %xmm4
	movaps	336(%r9), %xmm5
	movaps	352(%r9), %xmm6
	movaps	368(%r9), %xmm7
	prefetchnta	1344(%r9)
	addps	256(%r8), %xmm0
	addps	272(%r8), %xmm1
	addps	288(%r8), %xmm2
	addps	304(%r8), %xmm3
	prefetchnta	1344(%r8)
	addps	320(%r8), %xmm4
	addps	336(%r8), %xmm5
	addps	352(%r8), %xmm6
	addps	368(%r8), %xmm7
	movntps	%xmm0, 256(%r10)
	movntps	%xmm1, 272(%r10)
	movntps	%xmm2, 288(%r10)
	movntps	%xmm3, 304(%r10)
	movntps	%xmm4, 320(%r10)
	movntps	%xmm5, 336(%r10)
	movntps	%xmm6, 352(%r10)
	movntps	%xmm7, 368(%r10)
	prefetchnta	1408(%r9)
	movaps	384(%r9), %xmm8
	movaps	400(%r9), %xmm9
	movaps	416(%r9), %xmm10
	movaps	432(%r9), %xmm11
	prefetchnta	1408(%r8)
	movaps	448(%r9), %xmm12
	movaps	464(%r9), %xmm13
	movaps	480(%r9), %xmm14
	movaps	496(%r9), %xmm15
	prefetchnta	1472(%r9)
	addps	384(%r8), %xmm8
	addps	400(%r8), %xmm9
	addps	416(%r8), %xmm10
	addps	432(%r8), %xmm11
	prefetchnta	1472(%r8)
	addps	448(%r8), %xmm12
	addps	464(%r8), %xmm13
	addps	480(%r8), %xmm14
	addps	496(%r8), %xmm15
	movntps	%xmm8, 384(%r10)
	movntps	%xmm9, 400(%r10)
	movntps	%xmm10, 416(%r10)
	movntps	%xmm11, 432(%r10)
	movntps	%xmm12, 448(%r10)
	movntps	%xmm13, 464(%r10)
	movntps	%xmm14, 480(%r10)
	movntps	%xmm15, 496(%r10)
	prefetchnta	1536(%r9)
	movaps	512(%r9), %xmm0
	movaps	528(%r9), %xmm1
	movaps	544(%r9), %xmm2
	movaps	560(%r9), %xmm3
	prefetchnta	1536(%r8)
	movaps	576(%r9), %xmm4
	movaps	592(%r9), %xmm5
	movaps	608(%r9), %xmm6
	movaps	624(%r9), %xmm7
	prefetchnta	1600(%r8)
	addps	512(%r8), %xmm0
	addps	528(%r8), %xmm1
	addps	544(%r8), %xmm2
	addps	560(%r8), %xmm3
	prefetchnta	1600(%r9)
	addps	576(%r8), %xmm4
	addps	592(%r8), %xmm5
	addps	608(%r8), %xmm6
	addps	624(%r8), %xmm7
	movntps	%xmm0, 512(%r10)
	movntps	%xmm1, 528(%r10)
	movntps	%xmm2, 544(%r10)
	movntps	%xmm3, 560(%r10)
	movntps	%xmm4, 576(%r10)
	movntps	%xmm5, 592(%r10)
	movntps	%xmm6, 608(%r10)
	movntps	%xmm7, 624(%r10)
	prefetchnta	1664(%r9)
	movaps	640(%r9), %xmm8
	movaps	656(%r9), %xmm9
	movaps	672(%r9), %xmm10
	movaps	688(%r9), %xmm11
	prefetchnta	1664(%r8)
	movaps	704(%r9), %xmm12
	movaps	720(%r9), %xmm13
	movaps	736(%r9), %xmm14
	movaps	752(%r9), %xmm15
	prefetchnta	1728(%r9)
	addps	640(%r8), %xmm8
	addps	656(%r8), %xmm9
	addps	672(%r8), %xmm10
	addps	688(%r8), %xmm11
	prefetchnta	1728(%r8)
	addps	704(%r8), %xmm12
	addps	720(%r8), %xmm13
	addps	736(%r8), %xmm14
	addps	752(%r8), %xmm15
	movntps	%xmm8, 640(%r10)
	movntps	%xmm9, 656(%r10)
	movntps	%xmm10, 672(%r10)
	movntps	%xmm11, 688(%r10)
	movntps	%xmm12, 704(%r10)
	movntps	%xmm13, 720(%r10)
	movntps	%xmm14, 736(%r10)
	movntps	%xmm15, 752(%r10)
	prefetchnta	1792(%r9)
	movaps	768(%r9), %xmm0
	movaps	784(%r9), %xmm1
	movaps	800(%r9), %xmm2
	movaps	816(%r9), %xmm3
	prefetchnta	1792(%r8)
	movaps	832(%r9), %xmm4
	movaps	848(%r9), %xmm5
	movaps	864(%r9), %xmm6
	movaps	880(%r9), %xmm7
	prefetchnta	1856(%r9)
	addps	768(%r8), %xmm0
	addps	784(%r8), %xmm1
	addps	800(%r8), %xmm2
	addps	816(%r8), %xmm3
	prefetchnta	1856(%r8)
	addps	832(%r8), %xmm4
	addps	848(%r8), %xmm5
	addps	864(%r8), %xmm6
	addps	880(%r8), %xmm7
	movntps	%xmm0, 768(%r10)
	movntps	%xmm1, 784(%r10)
	movntps	%xmm2, 800(%r10)
	movntps	%xmm3, 816(%r10)
	movntps	%xmm4, 832(%r10)
	movntps	%xmm5, 848(%r10)
	movntps	%xmm6, 864(%r10)
	movntps	%xmm7, 880(%r10)
	prefetchnta	1920(%r9)
	movaps	896(%r9), %xmm8
	movaps	912(%r9), %xmm9
	movaps	928(%r9), %xmm10
	movaps	944(%r9), %xmm11
	prefetchnta	1920(%r8)
	movaps	960(%r9), %xmm12
	movaps	976(%r9), %xmm13
	movaps	992(%r9), %xmm14
	movaps	1008(%r9), %xmm15
	prefetchnta	1984(%r9)
	addps	896(%r8), %xmm8
	addps	912(%r8), %xmm9
	addps	928(%r8), %xmm10
	addps	944(%r8), %xmm11
	prefetchnta	1984(%r8)
	addps	960(%r8), %xmm12
	addps	976(%r8), %xmm13
	addps	992(%r8), %xmm14
	addps	1008(%r8), %xmm15
	movntps	%xmm8, 896(%r10)
	movntps	%xmm9, 912(%r10)
	movntps	%xmm10, 928(%r10)
	movntps	%xmm11, 944(%r10)
	movntps	%xmm12, 960(%r10)
	movntps	%xmm13, 976(%r10)
	movntps	%xmm14, 992(%r10)
	movntps	%xmm15, 1008(%r10)
	addq	%rax, %r8
	addq	%rax, %r9
	addq	%rax, %r10
	decq	%rcx
	jnz	.mainad_nt

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainad_nt

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssetr_nt
ssetr_nt:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$80, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%r13, %r14
	addq	%rbx, %r14
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	addq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.pretr_nt:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.pretr_nt
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	16(%rsp)
	fst	20(%rsp)
	movlps	16(%rsp), %xmm8
	movlhps	%xmm8, %xmm8
	ffree	%st(0)
/* execute */
	shrq	$10, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$1024, %rax
.maintr_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	1024(%r9)
	movaps	0(%r9), %xmm0
	movaps	16(%r9), %xmm1
	movaps	32(%r9), %xmm2
	movaps	48(%r9), %xmm3
	prefetchnta	1024(%r8)
	movaps	64(%r9), %xmm4
	movaps	80(%r9), %xmm5
	movaps	96(%r9), %xmm6
	movaps	112(%r9), %xmm7
	prefetchnta	1088(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetchnta	1088(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	0(%r8), %xmm0
	addps	16(%r8), %xmm1
	addps	32(%r8), %xmm2
	addps	48(%r8), %xmm3
	addps	64(%r8), %xmm4
	addps	80(%r8), %xmm5
	addps	96(%r8), %xmm6
	addps	112(%r8), %xmm7
	movntps	%xmm0, 0(%r10)
	movntps	%xmm1, 16(%r10)
	movntps	%xmm2, 32(%r10)
	movntps	%xmm3, 48(%r10)
	movntps	%xmm4, 64(%r10)
	movntps	%xmm5, 80(%r10)
	movntps	%xmm6, 96(%r10)
	movntps	%xmm7, 112(%r10)
	prefetchnta	1152(%r9)
	movaps	128(%r9), %xmm0
	movaps	144(%r9), %xmm1
	movaps	160(%r9), %xmm2
	movaps	176(%r9), %xmm3
	prefetchnta	1152(%r8)
	movaps	192(%r9), %xmm4
	movaps	208(%r9), %xmm5
	movaps	224(%r9), %xmm6
	movaps	240(%r9), %xmm7
	prefetchnta	1216(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetchnta	1216(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	128(%r8), %xmm0
	addps	144(%r8), %xmm1
	addps	160(%r8), %xmm2
	addps	176(%r8), %xmm3
	addps	192(%r8), %xmm4
	addps	208(%r8), %xmm5
	addps	224(%r8), %xmm6
	addps	240(%r8), %xmm7
	movntps	%xmm0, 128(%r10)
	movntps	%xmm1, 144(%r10)
	movntps	%xmm2, 160(%r10)
	movntps	%xmm3, 176(%r10)
	movntps	%xmm4, 192(%r10)
	movntps	%xmm5, 208(%r10)
	movntps	%xmm6, 224(%r10)
	movntps	%xmm7, 240(%r10)
	prefetchnta	1280(%r9)
	movaps	256(%r9), %xmm0
	movaps	272(%r9), %xmm1
	movaps	288(%r9), %xmm2
	movaps	304(%r9), %xmm3
	prefetchnta	1280(%r8)
	movaps	320(%r9), %xmm4
	movaps	336(%r9), %xmm5
	movaps	352(%r9), %xmm6
	movaps	368(%r9), %xmm7
	prefetchnta	1344(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetchnta	1344(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	256(%r8), %xmm0
	addps	272(%r8), %xmm1
	addps	288(%r8), %xmm2
	addps	304(%r8), %xmm3
	addps	320(%r8), %xmm4
	addps	336(%r8), %xmm5
	addps	352(%r8), %xmm6
	addps	368(%r8), %xmm7
	movntps	%xmm0, 256(%r10)
	movntps	%xmm1, 272(%r10)
	movntps	%xmm2, 288(%r10)
	movntps	%xmm3, 304(%r10)
	movntps	%xmm4, 320(%r10)
	movntps	%xmm5, 336(%r10)
	movntps	%xmm6, 352(%r10)
	movntps	%xmm7, 368(%r10)
	prefetchnta	1408(%r9)
	movaps	384(%r9), %xmm0
	movaps	400(%r9), %xmm1
	movaps	416(%r9), %xmm2
	movaps	432(%r9), %xmm3
	prefetchnta	1408(%r8)
	movaps	448(%r9), %xmm4
	movaps	464(%r9), %xmm5
	movaps	480(%r9), %xmm6
	movaps	496(%r9), %xmm7
	prefetchnta	1472(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetchnta	1472(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	384(%r8), %xmm0
	addps	400(%r8), %xmm1
	addps	416(%r8), %xmm2
	addps	432(%r8), %xmm3
	addps	448(%r8), %xmm4
	addps	464(%r8), %xmm5
	addps	480(%r8), %xmm6
	addps	496(%r8), %xmm7
	movntps	%xmm0, 384(%r10)
	movntps	%xmm1, 400(%r10)
	movntps	%xmm2, 416(%r10)
	movntps	%xmm3, 432(%r10)
	movntps	%xmm4, 448(%r10)
	movntps	%xmm5, 464(%r10)
	movntps	%xmm6, 480(%r10)
	movntps	%xmm7, 496(%r10)
	prefetchnta	1536(%r9)
	movaps	512(%r9), %xmm0
	movaps	528(%r9), %xmm1
	movaps	544(%r9), %xmm2
	movaps	560(%r9), %xmm3
	prefetchnta	1536(%r8)
	movaps	576(%r9), %xmm4
	movaps	592(%r9), %xmm5
	movaps	608(%r9), %xmm6
	movaps	624(%r9), %xmm7
	prefetchnta	1600(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetchnta	1600(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	512(%r8), %xmm0
	addps	528(%r8), %xmm1
	addps	544(%r8), %xmm2
	addps	560(%r8), %xmm3
	addps	576(%r8), %xmm4
	addps	592(%r8), %xmm5
	addps	608(%r8), %xmm6
	addps	624(%r8), %xmm7
	movntps	%xmm0, 512(%r10)
	movntps	%xmm1, 528(%r10)
	movntps	%xmm2, 544(%r10)
	movntps	%xmm3, 560(%r10)
	movntps	%xmm4, 576(%r10)
	movntps	%xmm5, 592(%r10)
	movntps	%xmm6, 608(%r10)
	movntps	%xmm7, 624(%r10)
	prefetchnta	1664(%r9)
	movaps	640(%r9), %xmm0
	movaps	656(%r9), %xmm1
	movaps	672(%r9), %xmm2
	movaps	688(%r9), %xmm3
	prefetchnta	1664(%r8)
	movaps	704(%r9), %xmm4
	movaps	720(%r9), %xmm5
	movaps	736(%r9), %xmm6
	movaps	752(%r9), %xmm7
	prefetchnta	1728(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetchnta	1728(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	640(%r8), %xmm0
	addps	656(%r8), %xmm1
	addps	672(%r8), %xmm2
	addps	688(%r8), %xmm3
	addps	704(%r8), %xmm4
	addps	720(%r8), %xmm5
	addps	736(%r8), %xmm6
	addps	752(%r8), %xmm7
	movntps	%xmm0, 640(%r10)
	movntps	%xmm1, 656(%r10)
	movntps	%xmm2, 672(%r10)
	movntps	%xmm3, 688(%r10)
	movntps	%xmm4, 704(%r10)
	movntps	%xmm5, 720(%r10)
	movntps	%xmm6, 736(%r10)
	movntps	%xmm7, 752(%r10)
	prefetchnta	1792(%r9)
	movaps	768(%r9), %xmm0
	movaps	784(%r9), %xmm1
	movaps	800(%r9), %xmm2
	movaps	816(%r9), %xmm3
	prefetchnta	1792(%r8)
	movaps	832(%r9), %xmm4
	movaps	848(%r9), %xmm5
	movaps	864(%r9), %xmm6
	movaps	880(%r9), %xmm7
	prefetchnta	1856(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetchnta	1856(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	768(%r8), %xmm0
	addps	784(%r8), %xmm1
	addps	800(%r8), %xmm2
	addps	816(%r8), %xmm3
	addps	832(%r8), %xmm4
	addps	848(%r8), %xmm5
	addps	864(%r8), %xmm6
	addps	880(%r8), %xmm7
	movntps	%xmm0, 768(%r10)
	movntps	%xmm1, 784(%r10)
	movntps	%xmm2, 800(%r10)
	movntps	%xmm3, 816(%r10)
	movntps	%xmm4, 832(%r10)
	movntps	%xmm5, 848(%r10)
	movntps	%xmm6, 864(%r10)
	movntps	%xmm7, 880(%r10)
	prefetchnta	1920(%r9)
	movaps	896(%r9), %xmm0
	movaps	912(%r9), %xmm1
	movaps	928(%r9), %xmm2
	movaps	944(%r9), %xmm3
	prefetchnta	1920(%r8)
	movaps	960(%r9), %xmm4
	movaps	976(%r9), %xmm5
	movaps	992(%r9), %xmm6
	movaps	1008(%r9), %xmm7
	prefetchnta	1984(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetchnta	1984(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	896(%r8), %xmm0
	addps	912(%r8), %xmm1
	addps	928(%r8), %xmm2
	addps	944(%r8), %xmm3
	addps	960(%r8), %xmm4
	addps	976(%r8), %xmm5
	addps	992(%r8), %xmm6
	addps	1008(%r8), %xmm7
	movntps	%xmm0, 896(%r10)
	movntps	%xmm1, 912(%r10)
	movntps	%xmm2, 928(%r10)
	movntps	%xmm3, 944(%r10)
	movntps	%xmm4, 960(%r10)
	movntps	%xmm5, 976(%r10)
	movntps	%xmm6, 992(%r10)
	movntps	%xmm7, 1008(%r10)
	addq	%rax, %r8
	addq	%rax, %r9
	addq	%rax, %r10
	decq	%rcx
	jnz	.maintr_nt

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.maintr_nt

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret


.globl ssecp_nt_t0
ssecp_nt_t0:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r15
	subq	$88, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.precp_nt_t0:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.precp_nt_t0
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$10, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$1024, %rax
.maincp_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	1024(%r8)
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	prefetcht0	1088(%r8)
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	prefetcht0	1152(%r8)
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	prefetcht0	1216(%r8)
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	movntps	%xmm0, 0(%r9)
	movntps	%xmm1, 16(%r9)
	movntps	%xmm2, 32(%r9)
	movntps	%xmm3, 48(%r9)
	movntps	%xmm4, 64(%r9)
	movntps	%xmm5, 80(%r9)
	movntps	%xmm6, 96(%r9)
	movntps	%xmm7, 112(%r9)
	prefetcht0	1280(%r8)
	movaps	128(%r8), %xmm8
	movaps	144(%r8), %xmm9
	prefetcht0	1344(%r8)
	movaps	160(%r8), %xmm10
	movaps	176(%r8), %xmm11
	prefetcht0	1408(%r8)
	movaps	192(%r8), %xmm12
	movaps	208(%r8), %xmm13
	prefetcht0	1472(%r8)
	movaps	224(%r8), %xmm14
	movaps	240(%r8), %xmm15
	movntps	%xmm8, 128(%r9)
	movntps	%xmm9, 144(%r9)
	movntps	%xmm10, 160(%r9)
	movntps	%xmm11, 176(%r9)
	movntps	%xmm12, 192(%r9)
	movntps	%xmm13, 208(%r9)
	movntps	%xmm14, 224(%r9)
	movntps	%xmm15, 240(%r9)
	prefetcht0	1536(%r8)
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	prefetcht0	1600(%r8)
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	prefetcht0	1664(%r8)
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	prefetcht0	1728(%r8)
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	movntps	%xmm0, 256(%r9)
	movntps	%xmm1, 272(%r9)
	movntps	%xmm2, 288(%r9)
	movntps	%xmm3, 304(%r9)
	movntps	%xmm4, 320(%r9)
	movntps	%xmm5, 336(%r9)
	movntps	%xmm6, 352(%r9)
	movntps	%xmm7, 368(%r9)
	prefetcht0	1792(%r8)
	movaps	384(%r8), %xmm8
	movaps	400(%r8), %xmm9
	prefetcht0	1856(%r8)
	movaps	416(%r8), %xmm10
	movaps	432(%r8), %xmm11
	prefetcht0	1920(%r8)
	movaps	448(%r8), %xmm12
	movaps	464(%r8), %xmm13
	prefetcht0	1984(%r8)
	movaps	480(%r8), %xmm14
	movaps	496(%r8), %xmm15
	movntps	%xmm8, 384(%r9)
	movntps	%xmm9, 400(%r9)
	movntps	%xmm10, 416(%r9)
	movntps	%xmm11, 432(%r9)
	movntps	%xmm12, 448(%r9)
	movntps	%xmm13, 464(%r9)
	movntps	%xmm14, 480(%r9)
	movntps	%xmm15, 496(%r9)
	movaps	512(%r8), %xmm0
	movaps	528(%r8), %xmm1
	movaps	544(%r8), %xmm2
	movaps	560(%r8), %xmm3
	movaps	576(%r8), %xmm4
	movaps	592(%r8), %xmm5
	movaps	608(%r8), %xmm6
	movaps	624(%r8), %xmm7
	movntps	%xmm0, 512(%r9)
	movntps	%xmm1, 528(%r9)
	movntps	%xmm2, 544(%r9)
	movntps	%xmm3, 560(%r9)
	movntps	%xmm4, 576(%r9)
	movntps	%xmm5, 592(%r9)
	movntps	%xmm6, 608(%r9)
	movntps	%xmm7, 624(%r9)
	movaps	640(%r8), %xmm0
	movaps	656(%r8), %xmm1
	movaps	672(%r8), %xmm2
	movaps	688(%r8), %xmm3
	movaps	704(%r8), %xmm4
	movaps	720(%r8), %xmm5
	movaps	736(%r8), %xmm6
	movaps	752(%r8), %xmm7
	movntps	%xmm0, 640(%r9)
	movntps	%xmm1, 656(%r9)
	movntps	%xmm2, 672(%r9)
	movntps	%xmm3, 688(%r9)
	movntps	%xmm4, 704(%r9)
	movntps	%xmm5, 720(%r9)
	movntps	%xmm6, 736(%r9)
	movntps	%xmm7, 752(%r9)
	movaps	768(%r8), %xmm0
	movaps	784(%r8), %xmm1
	movaps	800(%r8), %xmm2
	movaps	816(%r8), %xmm3
	movaps	832(%r8), %xmm4
	movaps	848(%r8), %xmm5
	movaps	864(%r8), %xmm6
	movaps	880(%r8), %xmm7
	movntps	%xmm0, 768(%r9)
	movntps	%xmm1, 784(%r9)
	movntps	%xmm2, 800(%r9)
	movntps	%xmm3, 816(%r9)
	movntps	%xmm4, 832(%r9)
	movntps	%xmm5, 848(%r9)
	movntps	%xmm6, 864(%r9)
	movntps	%xmm7, 880(%r9)
	movaps	896(%r8), %xmm0
	movaps	912(%r8), %xmm1
	movaps	928(%r8), %xmm2
	movaps	944(%r8), %xmm3
	movaps	960(%r8), %xmm4
	movaps	976(%r8), %xmm5
	movaps	992(%r8), %xmm6
	movaps	1008(%r8), %xmm7
	movntps	%xmm0, 896(%r9)
	movntps	%xmm1, 912(%r9)
	movntps	%xmm2, 928(%r9)
	movntps	%xmm3, 944(%r9)
	movntps	%xmm4, 960(%r9)
	movntps	%xmm5, 976(%r9)
	movntps	%xmm6, 992(%r9)
	movntps	%xmm7, 1008(%r9)
	addq	%rax, %r8
	addq	%rax, %r9
	decq	%rcx
	jnz	.maincp_nt_t0

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.maincp_nt_t0

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssesc_nt_t0
ssesc_nt_t0:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r15
	subq	$88, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.presc_nt_t0:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.presc_nt_t0
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	16(%rsp)
	fst	20(%rsp)
	movlps	16(%rsp), %xmm8
	movlhps	%xmm8, %xmm8
	ffree	%st(0)
/* execute */
	shrq	$10, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$1024, %rax
.mainsc_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	1024(%r8)
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	prefetcht0	1088(%r8)
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	prefetcht0	1152(%r8)
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	prefetcht0	1216(%r8)
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 0(%r9)
	movntps	%xmm1, 16(%r9)
	movntps	%xmm2, 32(%r9)
	movntps	%xmm3, 48(%r9)
	movntps	%xmm4, 64(%r9)
	movntps	%xmm5, 80(%r9)
	movntps	%xmm6, 96(%r9)
	movntps	%xmm7, 112(%r9)
	prefetcht0	1280(%r8)
	movaps	128(%r8), %xmm0
	movaps	144(%r8), %xmm1
	prefetcht0	1344(%r8)
	movaps	160(%r8), %xmm2
	movaps	176(%r8), %xmm3
	prefetcht0	1408(%r8)
	movaps	192(%r8), %xmm4
	movaps	208(%r8), %xmm5
	prefetcht0	1472(%r8)
	movaps	224(%r8), %xmm6
	movaps	240(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 128(%r9)
	movntps	%xmm1, 144(%r9)
	movntps	%xmm2, 160(%r9)
	movntps	%xmm3, 176(%r9)
	movntps	%xmm4, 192(%r9)
	movntps	%xmm5, 208(%r9)
	movntps	%xmm6, 224(%r9)
	movntps	%xmm7, 240(%r9)
	prefetcht0	1536(%r8)
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	prefetcht0	1600(%r8)
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	prefetcht0	1664(%r8)
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	prefetcht0	1728(%r8)
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 256(%r9)
	movntps	%xmm1, 272(%r9)
	movntps	%xmm2, 288(%r9)
	movntps	%xmm3, 304(%r9)
	movntps	%xmm4, 320(%r9)
	movntps	%xmm5, 336(%r9)
	movntps	%xmm6, 352(%r9)
	movntps	%xmm7, 368(%r9)
	prefetcht0	1792(%r8)
	movaps	384(%r8), %xmm0
	movaps	400(%r8), %xmm1
	prefetcht0	1856(%r8)
	movaps	416(%r8), %xmm2
	movaps	432(%r8), %xmm3
	prefetcht0	1920(%r8)
	movaps	448(%r8), %xmm4
	movaps	464(%r8), %xmm5
	prefetcht0	1984(%r8)
	movaps	480(%r8), %xmm6
	movaps	496(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 384(%r9)
	movntps	%xmm1, 400(%r9)
	movntps	%xmm2, 416(%r9)
	movntps	%xmm3, 432(%r9)
	movntps	%xmm4, 448(%r9)
	movntps	%xmm5, 464(%r9)
	movntps	%xmm6, 480(%r9)
	movntps	%xmm7, 496(%r9)
	movaps	512(%r8), %xmm0
	movaps	528(%r8), %xmm1
	movaps	544(%r8), %xmm2
	movaps	560(%r8), %xmm3
	movaps	576(%r8), %xmm4
	movaps	592(%r8), %xmm5
	movaps	608(%r8), %xmm6
	movaps	624(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 512(%r9)
	movntps	%xmm1, 528(%r9)
	movntps	%xmm2, 544(%r9)
	movntps	%xmm3, 560(%r9)
	movntps	%xmm4, 576(%r9)
	movntps	%xmm5, 592(%r9)
	movntps	%xmm6, 608(%r9)
	movntps	%xmm7, 624(%r9)
	movaps	640(%r8), %xmm0
	movaps	656(%r8), %xmm1
	movaps	672(%r8), %xmm2
	movaps	688(%r8), %xmm3
	movaps	704(%r8), %xmm4
	movaps	720(%r8), %xmm5
	movaps	736(%r8), %xmm6
	movaps	752(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 640(%r9)
	movntps	%xmm1, 656(%r9)
	movntps	%xmm2, 672(%r9)
	movntps	%xmm3, 688(%r9)
	movntps	%xmm4, 704(%r9)
	movntps	%xmm5, 720(%r9)
	movntps	%xmm6, 736(%r9)
	movntps	%xmm7, 752(%r9)
	movaps	768(%r8), %xmm0
	movaps	784(%r8), %xmm1
	movaps	800(%r8), %xmm2
	movaps	816(%r8), %xmm3
	movaps	832(%r8), %xmm4
	movaps	848(%r8), %xmm5
	movaps	864(%r8), %xmm6
	movaps	880(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 768(%r9)
	movntps	%xmm1, 784(%r9)
	movntps	%xmm2, 800(%r9)
	movntps	%xmm3, 816(%r9)
	movntps	%xmm4, 832(%r9)
	movntps	%xmm5, 848(%r9)
	movntps	%xmm6, 864(%r9)
	movntps	%xmm7, 880(%r9)
	movaps	896(%r8), %xmm0
	movaps	912(%r8), %xmm1
	movaps	928(%r8), %xmm2
	movaps	944(%r8), %xmm3
	movaps	960(%r8), %xmm4
	movaps	976(%r8), %xmm5
	movaps	992(%r8), %xmm6
	movaps	1008(%r8), %xmm7
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	movntps	%xmm0, 896(%r9)
	movntps	%xmm1, 912(%r9)
	movntps	%xmm2, 928(%r9)
	movntps	%xmm3, 944(%r9)
	movntps	%xmm4, 960(%r9)
	movntps	%xmm5, 976(%r9)
	movntps	%xmm6, 992(%r9)
	movntps	%xmm7, 1008(%r9)
	addq	%rax, %r8
	addq	%rax, %r9
	decq	%rcx
	jnz	.mainsc_nt_t0

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainsc_nt_t0

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssead_nt_t0
ssead_nt_t0:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$80, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%r13, %r14
	addq	%rbx, %r14
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	addq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.pread_nt_t0:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.pread_nt_t0
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$10, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$1024, %rax
.mainad_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	1024(%r9)
	movaps	0(%r9), %xmm0
	movaps	16(%r9), %xmm1
	movaps	32(%r9), %xmm2
	movaps	48(%r9), %xmm3
	prefetcht0	1024(%r8)
	movaps	64(%r9), %xmm4
	movaps	80(%r9), %xmm5
	movaps	96(%r9), %xmm6
	movaps	112(%r9), %xmm7
	prefetcht0	1088(%r9)
	addps	0(%r8), %xmm0
	addps	16(%r8), %xmm1
	addps	32(%r8), %xmm2
	addps	48(%r8), %xmm3
	prefetcht0	1088(%r8)
	addps	64(%r8), %xmm4
	addps	80(%r8), %xmm5
	addps	96(%r8), %xmm6
	addps	112(%r8), %xmm7
	movntps	%xmm0, 0(%r10)
	movntps	%xmm1, 16(%r10)
	movntps	%xmm2, 32(%r10)
	movntps	%xmm3, 48(%r10)
	movntps	%xmm4, 64(%r10)
	movntps	%xmm5, 80(%r10)
	movntps	%xmm6, 96(%r10)
	movntps	%xmm7, 112(%r10)
	prefetcht0	1152(%r9)
	movaps	128(%r9), %xmm8
	movaps	144(%r9), %xmm9
	movaps	160(%r9), %xmm10
	movaps	176(%r9), %xmm11
	prefetcht0	1152(%r8)
	movaps	192(%r9), %xmm12
	movaps	208(%r9), %xmm13
	movaps	224(%r9), %xmm14
	movaps	240(%r9), %xmm15
	prefetcht0	1216(%r9)
	addps	128(%r8), %xmm8
	addps	144(%r8), %xmm9
	addps	160(%r8), %xmm10
	addps	176(%r8), %xmm11
	prefetcht0	1216(%r8)
	addps	192(%r8), %xmm12
	addps	208(%r8), %xmm13
	addps	224(%r8), %xmm14
	addps	240(%r8), %xmm15
	movntps	%xmm8, 128(%r10)
	movntps	%xmm9, 144(%r10)
	movntps	%xmm10, 160(%r10)
	movntps	%xmm11, 176(%r10)
	movntps	%xmm12, 192(%r10)
	movntps	%xmm13, 208(%r10)
	movntps	%xmm14, 224(%r10)
	movntps	%xmm15, 240(%r10)
	prefetcht0	1280(%r9)
	movaps	256(%r9), %xmm0
	movaps	272(%r9), %xmm1
	movaps	288(%r9), %xmm2
	movaps	304(%r9), %xmm3
	prefetcht0	1280(%r8)
	movaps	320(%r9), %xmm4
	movaps	336(%r9), %xmm5
	movaps	352(%r9), %xmm6
	movaps	368(%r9), %xmm7
	prefetcht0	1344(%r9)
	addps	256(%r8), %xmm0
	addps	272(%r8), %xmm1
	addps	288(%r8), %xmm2
	addps	304(%r8), %xmm3
	prefetcht0	1344(%r8)
	addps	320(%r8), %xmm4
	addps	336(%r8), %xmm5
	addps	352(%r8), %xmm6
	addps	368(%r8), %xmm7
	movntps	%xmm0, 256(%r10)
	movntps	%xmm1, 272(%r10)
	movntps	%xmm2, 288(%r10)
	movntps	%xmm3, 304(%r10)
	movntps	%xmm4, 320(%r10)
	movntps	%xmm5, 336(%r10)
	movntps	%xmm6, 352(%r10)
	movntps	%xmm7, 368(%r10)
	prefetcht0	1408(%r9)
	movaps	384(%r9), %xmm8
	movaps	400(%r9), %xmm9
	movaps	416(%r9), %xmm10
	movaps	432(%r9), %xmm11
	prefetcht0	1408(%r8)
	movaps	448(%r9), %xmm12
	movaps	464(%r9), %xmm13
	movaps	480(%r9), %xmm14
	movaps	496(%r9), %xmm15
	prefetcht0	1472(%r9)
	addps	384(%r8), %xmm8
	addps	400(%r8), %xmm9
	addps	416(%r8), %xmm10
	addps	432(%r8), %xmm11
	prefetcht0	1472(%r8)
	addps	448(%r8), %xmm12
	addps	464(%r8), %xmm13
	addps	480(%r8), %xmm14
	addps	496(%r8), %xmm15
	movntps	%xmm8, 384(%r10)
	movntps	%xmm9, 400(%r10)
	movntps	%xmm10, 416(%r10)
	movntps	%xmm11, 432(%r10)
	movntps	%xmm12, 448(%r10)
	movntps	%xmm13, 464(%r10)
	movntps	%xmm14, 480(%r10)
	movntps	%xmm15, 496(%r10)
	prefetcht0	1536(%r9)
	movaps	512(%r9), %xmm0
	movaps	528(%r9), %xmm1
	movaps	544(%r9), %xmm2
	movaps	560(%r9), %xmm3
	prefetcht0	1536(%r8)
	movaps	576(%r9), %xmm4
	movaps	592(%r9), %xmm5
	movaps	608(%r9), %xmm6
	movaps	624(%r9), %xmm7
	prefetcht0	1600(%r8)
	addps	512(%r8), %xmm0
	addps	528(%r8), %xmm1
	addps	544(%r8), %xmm2
	addps	560(%r8), %xmm3
	prefetcht0	1600(%r9)
	addps	576(%r8), %xmm4
	addps	592(%r8), %xmm5
	addps	608(%r8), %xmm6
	addps	624(%r8), %xmm7
	movntps	%xmm0, 512(%r10)
	movntps	%xmm1, 528(%r10)
	movntps	%xmm2, 544(%r10)
	movntps	%xmm3, 560(%r10)
	movntps	%xmm4, 576(%r10)
	movntps	%xmm5, 592(%r10)
	movntps	%xmm6, 608(%r10)
	movntps	%xmm7, 624(%r10)
	prefetcht0	1664(%r9)
	movaps	640(%r9), %xmm8
	movaps	656(%r9), %xmm9
	movaps	672(%r9), %xmm10
	movaps	688(%r9), %xmm11
	prefetcht0	1664(%r8)
	movaps	704(%r9), %xmm12
	movaps	720(%r9), %xmm13
	movaps	736(%r9), %xmm14
	movaps	752(%r9), %xmm15
	prefetcht0	1728(%r9)
	addps	640(%r8), %xmm8
	addps	656(%r8), %xmm9
	addps	672(%r8), %xmm10
	addps	688(%r8), %xmm11
	prefetcht0	1728(%r8)
	addps	704(%r8), %xmm12
	addps	720(%r8), %xmm13
	addps	736(%r8), %xmm14
	addps	752(%r8), %xmm15
	movntps	%xmm8, 640(%r10)
	movntps	%xmm9, 656(%r10)
	movntps	%xmm10, 672(%r10)
	movntps	%xmm11, 688(%r10)
	movntps	%xmm12, 704(%r10)
	movntps	%xmm13, 720(%r10)
	movntps	%xmm14, 736(%r10)
	movntps	%xmm15, 752(%r10)
	prefetcht0	1792(%r9)
	movaps	768(%r9), %xmm0
	movaps	784(%r9), %xmm1
	movaps	800(%r9), %xmm2
	movaps	816(%r9), %xmm3
	prefetcht0	1792(%r8)
	movaps	832(%r9), %xmm4
	movaps	848(%r9), %xmm5
	movaps	864(%r9), %xmm6
	movaps	880(%r9), %xmm7
	prefetcht0	1856(%r9)
	addps	768(%r8), %xmm0
	addps	784(%r8), %xmm1
	addps	800(%r8), %xmm2
	addps	816(%r8), %xmm3
	prefetcht0	1856(%r8)
	addps	832(%r8), %xmm4
	addps	848(%r8), %xmm5
	addps	864(%r8), %xmm6
	addps	880(%r8), %xmm7
	movntps	%xmm0, 768(%r10)
	movntps	%xmm1, 784(%r10)
	movntps	%xmm2, 800(%r10)
	movntps	%xmm3, 816(%r10)
	movntps	%xmm4, 832(%r10)
	movntps	%xmm5, 848(%r10)
	movntps	%xmm6, 864(%r10)
	movntps	%xmm7, 880(%r10)
	prefetcht0	1920(%r9)
	movaps	896(%r9), %xmm8
	movaps	912(%r9), %xmm9
	movaps	928(%r9), %xmm10
	movaps	944(%r9), %xmm11
	prefetcht0	1920(%r8)
	movaps	960(%r9), %xmm12
	movaps	976(%r9), %xmm13
	movaps	992(%r9), %xmm14
	movaps	1008(%r9), %xmm15
	prefetcht0	1984(%r9)
	addps	896(%r8), %xmm8
	addps	912(%r8), %xmm9
	addps	928(%r8), %xmm10
	addps	944(%r8), %xmm11
	prefetcht0	1984(%r8)
	addps	960(%r8), %xmm12
	addps	976(%r8), %xmm13
	addps	992(%r8), %xmm14
	addps	1008(%r8), %xmm15
	movntps	%xmm8, 896(%r10)
	movntps	%xmm9, 912(%r10)
	movntps	%xmm10, 928(%r10)
	movntps	%xmm11, 944(%r10)
	movntps	%xmm12, 960(%r10)
	movntps	%xmm13, 976(%r10)
	movntps	%xmm14, 992(%r10)
	movntps	%xmm15, 1008(%r10)
	addq	%rax, %r8
	addq	%rax, %r9
	addq	%rax, %r10
	decq	%rcx
	jnz	.mainad_nt_t0

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainad_nt_t0

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssetr_nt_t0
ssetr_nt_t0:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$80, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%r12, %r13
	addq	%rbx, %r13
	movq	%r13, %r14
	addq	%rbx, %r14
	movq	%rax, %r15
/* prefill */
	movq	%rbx, %rcx
	addq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	finit
	fldpi
.pretr_nt_t0:
	fst	0(%r8)
	fst	4(%r8)
	fst	8(%r8)
	fst	12(%r8)
	fst	16(%r8)
	fst	20(%r8)
	fst	24(%r8)
	fst	28(%r8)
	fst	32(%r8)
	fst	36(%r8)
	fst	40(%r8)
	fst	44(%r8)
	fst	48(%r8)
	fst	52(%r8)
	fst	56(%r8)
	fst	60(%r8)
	addq	$64, %r8
	loopq	.pretr_nt_t0
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	16(%rsp)
	fst	20(%rsp)
	movlps	16(%rsp), %xmm8
	movlhps	%xmm8, %xmm8
	ffree	%st(0)
/* execute */
	shrq	$10, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$1024, %rax
.maintr_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	1024(%r9)
	movaps	0(%r9), %xmm0
	movaps	16(%r9), %xmm1
	movaps	32(%r9), %xmm2
	movaps	48(%r9), %xmm3
	prefetcht0	1024(%r8)
	movaps	64(%r9), %xmm4
	movaps	80(%r9), %xmm5
	movaps	96(%r9), %xmm6
	movaps	112(%r9), %xmm7
	prefetcht0	1088(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetcht0	1088(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	0(%r8), %xmm0
	addps	16(%r8), %xmm1
	addps	32(%r8), %xmm2
	addps	48(%r8), %xmm3
	addps	64(%r8), %xmm4
	addps	80(%r8), %xmm5
	addps	96(%r8), %xmm6
	addps	112(%r8), %xmm7
	movntps	%xmm0, 0(%r10)
	movntps	%xmm1, 16(%r10)
	movntps	%xmm2, 32(%r10)
	movntps	%xmm3, 48(%r10)
	movntps	%xmm4, 64(%r10)
	movntps	%xmm5, 80(%r10)
	movntps	%xmm6, 96(%r10)
	movntps	%xmm7, 112(%r10)
	prefetcht0	1152(%r9)
	movaps	128(%r9), %xmm0
	movaps	144(%r9), %xmm1
	movaps	160(%r9), %xmm2
	movaps	176(%r9), %xmm3
	prefetcht0	1152(%r8)
	movaps	192(%r9), %xmm4
	movaps	208(%r9), %xmm5
	movaps	224(%r9), %xmm6
	movaps	240(%r9), %xmm7
	prefetcht0	1216(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetcht0	1216(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	128(%r8), %xmm0
	addps	144(%r8), %xmm1
	addps	160(%r8), %xmm2
	addps	176(%r8), %xmm3
	addps	192(%r8), %xmm4
	addps	208(%r8), %xmm5
	addps	224(%r8), %xmm6
	addps	240(%r8), %xmm7
	movntps	%xmm0, 128(%r10)
	movntps	%xmm1, 144(%r10)
	movntps	%xmm2, 160(%r10)
	movntps	%xmm3, 176(%r10)
	movntps	%xmm4, 192(%r10)
	movntps	%xmm5, 208(%r10)
	movntps	%xmm6, 224(%r10)
	movntps	%xmm7, 240(%r10)
	prefetcht0	1280(%r9)
	movaps	256(%r9), %xmm0
	movaps	272(%r9), %xmm1
	movaps	288(%r9), %xmm2
	movaps	304(%r9), %xmm3
	prefetcht0	1280(%r8)
	movaps	320(%r9), %xmm4
	movaps	336(%r9), %xmm5
	movaps	352(%r9), %xmm6
	movaps	368(%r9), %xmm7
	prefetcht0	1344(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetcht0	1344(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	256(%r8), %xmm0
	addps	272(%r8), %xmm1
	addps	288(%r8), %xmm2
	addps	304(%r8), %xmm3
	addps	320(%r8), %xmm4
	addps	336(%r8), %xmm5
	addps	352(%r8), %xmm6
	addps	368(%r8), %xmm7
	movntps	%xmm0, 256(%r10)
	movntps	%xmm1, 272(%r10)
	movntps	%xmm2, 288(%r10)
	movntps	%xmm3, 304(%r10)
	movntps	%xmm4, 320(%r10)
	movntps	%xmm5, 336(%r10)
	movntps	%xmm6, 352(%r10)
	movntps	%xmm7, 368(%r10)
	prefetcht0	1408(%r9)
	movaps	384(%r9), %xmm0
	movaps	400(%r9), %xmm1
	movaps	416(%r9), %xmm2
	movaps	432(%r9), %xmm3
	prefetcht0	1408(%r8)
	movaps	448(%r9), %xmm4
	movaps	464(%r9), %xmm5
	movaps	480(%r9), %xmm6
	movaps	496(%r9), %xmm7
	prefetcht0	1472(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetcht0	1472(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	384(%r8), %xmm0
	addps	400(%r8), %xmm1
	addps	416(%r8), %xmm2
	addps	432(%r8), %xmm3
	addps	448(%r8), %xmm4
	addps	464(%r8), %xmm5
	addps	480(%r8), %xmm6
	addps	496(%r8), %xmm7
	movntps	%xmm0, 384(%r10)
	movntps	%xmm1, 400(%r10)
	movntps	%xmm2, 416(%r10)
	movntps	%xmm3, 432(%r10)
	movntps	%xmm4, 448(%r10)
	movntps	%xmm5, 464(%r10)
	movntps	%xmm6, 480(%r10)
	movntps	%xmm7, 496(%r10)
	prefetcht0	1536(%r9)
	movaps	512(%r9), %xmm0
	movaps	528(%r9), %xmm1
	movaps	544(%r9), %xmm2
	movaps	560(%r9), %xmm3
	prefetcht0	1536(%r8)
	movaps	576(%r9), %xmm4
	movaps	592(%r9), %xmm5
	movaps	608(%r9), %xmm6
	movaps	624(%r9), %xmm7
	prefetcht0	1600(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetcht0	1600(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	512(%r8), %xmm0
	addps	528(%r8), %xmm1
	addps	544(%r8), %xmm2
	addps	560(%r8), %xmm3
	addps	576(%r8), %xmm4
	addps	592(%r8), %xmm5
	addps	608(%r8), %xmm6
	addps	624(%r8), %xmm7
	movntps	%xmm0, 512(%r10)
	movntps	%xmm1, 528(%r10)
	movntps	%xmm2, 544(%r10)
	movntps	%xmm3, 560(%r10)
	movntps	%xmm4, 576(%r10)
	movntps	%xmm5, 592(%r10)
	movntps	%xmm6, 608(%r10)
	movntps	%xmm7, 624(%r10)
	prefetcht0	1664(%r9)
	movaps	640(%r9), %xmm0
	movaps	656(%r9), %xmm1
	movaps	672(%r9), %xmm2
	movaps	688(%r9), %xmm3
	prefetcht0	1664(%r8)
	movaps	704(%r9), %xmm4
	movaps	720(%r9), %xmm5
	movaps	736(%r9), %xmm6
	movaps	752(%r9), %xmm7
	prefetcht0	1728(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetcht0	1728(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	640(%r8), %xmm0
	addps	656(%r8), %xmm1
	addps	672(%r8), %xmm2
	addps	688(%r8), %xmm3
	addps	704(%r8), %xmm4
	addps	720(%r8), %xmm5
	addps	736(%r8), %xmm6
	addps	752(%r8), %xmm7
	movntps	%xmm0, 640(%r10)
	movntps	%xmm1, 656(%r10)
	movntps	%xmm2, 672(%r10)
	movntps	%xmm3, 688(%r10)
	movntps	%xmm4, 704(%r10)
	movntps	%xmm5, 720(%r10)
	movntps	%xmm6, 736(%r10)
	movntps	%xmm7, 752(%r10)
	prefetcht0	1792(%r9)
	movaps	768(%r9), %xmm0
	movaps	784(%r9), %xmm1
	movaps	800(%r9), %xmm2
	movaps	816(%r9), %xmm3
	prefetcht0	1792(%r8)
	movaps	832(%r9), %xmm4
	movaps	848(%r9), %xmm5
	movaps	864(%r9), %xmm6
	movaps	880(%r9), %xmm7
	prefetcht0	1856(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetcht0	1856(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	768(%r8), %xmm0
	addps	784(%r8), %xmm1
	addps	800(%r8), %xmm2
	addps	816(%r8), %xmm3
	addps	832(%r8), %xmm4
	addps	848(%r8), %xmm5
	addps	864(%r8), %xmm6
	addps	880(%r8), %xmm7
	movntps	%xmm0, 768(%r10)
	movntps	%xmm1, 784(%r10)
	movntps	%xmm2, 800(%r10)
	movntps	%xmm3, 816(%r10)
	movntps	%xmm4, 832(%r10)
	movntps	%xmm5, 848(%r10)
	movntps	%xmm6, 864(%r10)
	movntps	%xmm7, 880(%r10)
	prefetcht0	1920(%r9)
	movaps	896(%r9), %xmm0
	movaps	912(%r9), %xmm1
	movaps	928(%r9), %xmm2
	movaps	944(%r9), %xmm3
	prefetcht0	1920(%r8)
	movaps	960(%r9), %xmm4
	movaps	976(%r9), %xmm5
	movaps	992(%r9), %xmm6
	movaps	1008(%r9), %xmm7
	prefetcht0	1984(%r9)
	mulps	%xmm8, %xmm0
	mulps	%xmm8, %xmm1
	mulps	%xmm8, %xmm2
	mulps	%xmm8, %xmm3
	prefetcht0	1984(%r8)
	mulps	%xmm8, %xmm4
	mulps	%xmm8, %xmm5
	mulps	%xmm8, %xmm6
	mulps	%xmm8, %xmm7
	addps	896(%r8), %xmm0
	addps	912(%r8), %xmm1
	addps	928(%r8), %xmm2
	addps	944(%r8), %xmm3
	addps	960(%r8), %xmm4
	addps	976(%r8), %xmm5
	addps	992(%r8), %xmm6
	addps	1008(%r8), %xmm7
	movntps	%xmm0, 896(%r10)
	movntps	%xmm1, 912(%r10)
	movntps	%xmm2, 928(%r10)
	movntps	%xmm3, 944(%r10)
	movntps	%xmm4, 960(%r10)
	movntps	%xmm5, 976(%r10)
	movntps	%xmm6, 992(%r10)
	movntps	%xmm7, 1008(%r10)
	addq	%rax, %r8
	addq	%rax, %r9
	addq	%rax, %r10
	decq	%rcx
	jnz	.maintr_nt_t0

	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.maintr_nt_t0

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free memory */
	movq	%r15, %rdi
	call	free
/* time calculation (in microseconds) */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret
