/*
**  INTmem benchmarks for RAMspeed (amd64)
**
**  (UNIX release)
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2005 Paul V. Bolotoff <walter@alasir.com>
**
**  All rights reserved.
**
*/

.globl intcp
intcp:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	shlq	$10, %rbx
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r12
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r13
/* prefill */
	movq	%rbx, %rcx
	shrq	$5, %rcx
	movq	%r12, %rdi
	movq	$33, %rax
.precp:
	movq	%rax, 0(%rdi)
	movq	%rax, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%rax, 24(%rdi)
	addq	$32, %rdi
	loopq	.precp
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	%r13, %rsi
.maincp:
	movq	0(%rdi), %rax
	movq	8(%rdi), %rdx
	movq	16(%rdi), %r8
	movq	24(%rdi), %r9
	movq	32(%rdi), %r10
	movq	40(%rdi), %r11
	movq	48(%rdi), %r14
	movq	56(%rdi), %r15
	movq	%rax, 0(%rsi)
	movq	%rdx, 8(%rsi)
	movq	%r8, 16(%rsi)
	movq	%r9, 24(%rsi)
	movq	%r10, 32(%rsi)
	movq	%r11, 40(%rsi)
	movq	%r14, 48(%rsi)
	movq	%r15, 56(%rsi)
	movq	64(%rdi), %rax
	movq	72(%rdi), %rdx
	movq	80(%rdi), %r8
	movq	88(%rdi), %r9
	movq	96(%rdi), %r10
	movq	104(%rdi), %r11
	movq	112(%rdi), %r14
	movq	120(%rdi), %r15
	movq	%rax, 64(%rsi)
	movq	%rdx, 72(%rsi)
	movq	%r8, 80(%rsi)
	movq	%r9, 88(%rsi)
	movq	%r10, 96(%rsi)
	movq	%r11, 104(%rsi)
	movq	%r14, 112(%rsi)
	movq	%r15, 120(%rsi)
	movq	128(%rdi), %rax
	movq	136(%rdi), %rdx
	movq	144(%rdi), %r8
	movq	152(%rdi), %r9
	movq	160(%rdi), %r10
	movq	168(%rdi), %r11
	movq	176(%rdi), %r14
	movq	184(%rdi), %r15
	movq	%rax, 128(%rsi)
	movq	%rdx, 136(%rsi)
	movq	%r8, 144(%rsi)
	movq	%r9, 152(%rsi)
	movq	%r10, 160(%rsi)
	movq	%r11, 168(%rsi)
	movq	%r14, 176(%rsi)
	movq	%r15, 184(%rsi)
	movq	192(%rdi), %rax
	movq	200(%rdi), %rdx
	movq	208(%rdi), %r8
	movq	216(%rdi), %r9
	movq	224(%rdi), %r10
	movq	232(%rdi), %r11
	movq	240(%rdi), %r14
	movq	248(%rdi), %r15
	movq	%rax, 192(%rsi)
	movq	%rdx, 200(%rsi)
	movq	%r8, 208(%rsi)
	movq	%r9, 216(%rsi)
	movq	%r10, 224(%rsi)
	movq	%r11, 232(%rsi)
	movq	%r14, 240(%rsi)
	movq	%r15, 248(%rsi)
	addq	$256, %rdi
	addq	$256, %rsi
	decq	%rcx
	jnz	.maincp

	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.maincp

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free */
	movq	%r13, %rdi
	call	free
/* free */
	movq	%r12, %rdi
	call	free
/* calculate */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$32, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl intsc
intsc:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	shlq	$10, %rbx
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r12
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r13
/* prefill */
	movq	%rbx, %rcx
	shrq	$5, %rcx
	movq	%r12, %rdi
	movq	$33, %rax
.presc:
	movq	%rax, 0(%rdi)
	movq	%rax, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%rax, 24(%rdi)
	addq	$32, %rdi
	loopq	.presc
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	%r13, %rsi
.mainsc:
	imulq	$77, 0(%rdi), %rax
	imulq	$77, 8(%rdi), %rdx
	imulq	$77, 16(%rdi), %r8
	imulq	$77, 24(%rdi), %r9
	imulq	$77, 32(%rdi), %r10
	imulq	$77, 40(%rdi), %r11
	imulq	$77, 48(%rdi), %r14
	imulq	$77, 56(%rdi), %r15
	movq	%rax, 0(%rsi)
	movq	%rdx, 8(%rsi)
	movq	%r8, 16(%rsi)
	movq	%r9, 24(%rsi)
	movq	%r10, 32(%rsi)
	movq	%r11, 40(%rsi)
	movq	%r14, 48(%rsi)
	movq	%r15, 56(%rsi)
	imulq	$77, 64(%rdi), %rax
	imulq	$77, 72(%rdi), %rdx
	imulq	$77, 80(%rdi), %r8
	imulq	$77, 88(%rdi), %r9
	imulq	$77, 96(%rdi), %r10
	imulq	$77, 104(%rdi), %r11
	imulq	$77, 112(%rdi), %r14
	imulq	$77, 120(%rdi), %r15
	movq	%rax, 64(%rsi)
	movq	%rdx, 72(%rsi)
	movq	%r8, 80(%rsi)
	movq	%r9, 88(%rsi)
	movq	%r10, 96(%rsi)
	movq	%r11, 104(%rsi)
	movq	%r14, 112(%rsi)
	movq	%r15, 120(%rsi)
	imulq	$77, 128(%rdi), %rax
	imulq	$77, 136(%rdi), %rdx
	imulq	$77, 144(%rdi), %r8
	imulq	$77, 152(%rdi), %r9
	imulq	$77, 160(%rdi), %r10
	imulq	$77, 168(%rdi), %r11
	imulq	$77, 176(%rdi), %r14
	imulq	$77, 184(%rdi), %r15
	movq	%rax, 128(%rsi)
	movq	%rdx, 136(%rsi)
	movq	%r8, 144(%rsi)
	movq	%r9, 152(%rsi)
	movq	%r10, 160(%rsi)
	movq	%r11, 168(%rsi)
	movq	%r14, 176(%rsi)
	movq	%r15, 184(%rsi)
	imulq	$77, 192(%rdi), %rax
	imulq	$77, 200(%rdi), %rdx
	imulq	$77, 208(%rdi), %r8
	imulq	$77, 216(%rdi), %r9
	imulq	$77, 224(%rdi), %r10
	imulq	$77, 232(%rdi), %r11
	imulq	$77, 240(%rdi), %r14
	imulq	$77, 248(%rdi), %r15
	movq	%rax, 192(%rsi)
	movq	%rdx, 200(%rsi)
	movq	%r8, 208(%rsi)
	movq	%r9, 216(%rsi)
	movq	%r10, 224(%rsi)
	movq	%r11, 232(%rsi)
	movq	%r14, 240(%rsi)
	movq	%r15, 248(%rsi)
	addq	$256, %rdi
	addq	$256, %rsi
	decq	%rcx
	jnz	.mainsc

	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainsc

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free */
	movq	%r13, %rdi
	call	free
/* free */
	movq	%r12, %rdi
	call	free
/* calculate */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$32, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl intad
intad:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	movq	%rsi, %r15
	shlq	$10, %rbx
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r12
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r13
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r14
/* prefill */
	movq	%rbx, %rcx
	shrq	$5, %rcx
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	$33, %rax
	movq	$55, %rdx
.pread:
	movq	%rax, 0(%rdi)
	movq	%rax, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%rax, 24(%rdi)
	movq	%rdx, 0(%rsi)
	movq	%rdx, 8(%rsi)
	movq	%rdx, 16(%rsi)
	movq	%rdx, 24(%rsi)
	addq	$32, %rdi
	addq	$32, %rsi
	loopq	.pread
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%r14, %rbp
.mainad:
	movq	0(%rdi), %rax
	movq	8(%rdi), %rdx
	movq	16(%rdi), %r8
	movq	24(%rdi), %r9
	addq	0(%rsi), %rax
	addq	8(%rsi), %rdx
	addq	16(%rsi), %r8
	addq	24(%rsi), %r9
	movq	%rax, 0(%rbp)
	movq	%rdx, 8(%rbp)
	movq	%r8, 16(%rbp)
	movq	%r9, 24(%rbp)
	movq	32(%rdi), %rax
	movq	40(%rdi), %rdx
	movq	48(%rdi), %r8
	movq	56(%rdi), %r9
	addq	32(%rsi), %rax
	addq	40(%rsi), %rdx
	addq	48(%rsi), %r8
	addq	56(%rsi), %r9
	movq	%rax, 32(%rbp)
	movq	%rdx, 40(%rbp)
	movq	%r8, 48(%rbp)
	movq	%r9, 56(%rbp)
	movq	64(%rdi), %rax
	movq	72(%rdi), %rdx
	movq	80(%rdi), %r8
	movq	88(%rdi), %r9
	addq	64(%rsi), %rax
	addq	72(%rsi), %rdx
	addq	80(%rsi), %r8
	addq	88(%rsi), %r9
	movq	%rax, 64(%rbp)
	movq	%rdx, 72(%rbp)
	movq	%r8, 80(%rbp)
	movq	%r9, 88(%rbp)
	movq	96(%rdi), %rax
	movq	104(%rdi), %rdx
	movq	112(%rdi), %r8
	movq	120(%rdi), %r9
	addq	96(%rsi), %rax
	addq	104(%rsi), %rdx
	addq	112(%rsi), %r8
	addq	120(%rsi), %r9
	movq	%rax, 96(%rbp)
	movq	%rdx, 104(%rbp)
	movq	%r8, 112(%rbp)
	movq	%r9, 120(%rbp)
	movq	128(%rdi), %rax
	movq	136(%rdi), %rdx
	movq	144(%rdi), %r8
	movq	152(%rdi), %r9
	addq	128(%rsi), %rax
	addq	136(%rsi), %rdx
	addq	144(%rsi), %r8
	addq	152(%rsi), %r9
	movq	%rax, 128(%rbp)
	movq	%rdx, 136(%rbp)
	movq	%r8, 144(%rbp)
	movq	%r9, 152(%rbp)
	movq	160(%rdi), %rax
	movq	168(%rdi), %rdx
	movq	176(%rdi), %r8
	movq	184(%rdi), %r9
	addq	160(%rsi), %rax
	addq	168(%rsi), %rdx
	addq	176(%rsi), %r8
	addq	184(%rsi), %r9
	movq	%rax, 160(%rbp)
	movq	%rdx, 168(%rbp)
	movq	%r8, 176(%rbp)
	movq	%r9, 184(%rbp)
	movq	192(%rdi), %rax
	movq	200(%rdi), %rdx
	movq	208(%rdi), %r8
	movq	216(%rdi), %r9
	addq	192(%rsi), %rax
	addq	200(%rsi), %rdx
	addq	208(%rsi), %r8
	addq	216(%rsi), %r9
	movq	%rax, 192(%rsi)
	movq	%rdx, 200(%rsi)
	movq	%r8, 208(%rsi)
	movq	%r9, 216(%rsi)
	movq	224(%rdi), %rax
	movq	232(%rdi), %rdx
	movq	240(%rdi), %r8
	movq	248(%rdi), %r9
	addq	224(%rsi), %rax
	addq	232(%rsi), %rdx
	addq	240(%rsi), %r8
	addq	248(%rsi), %r9
	movq	%rax, 224(%rsi)
	movq	%rdx, 232(%rsi)
	movq	%r8, 240(%rsi)
	movq	%r9, 248(%rsi)
	addq	$256, %rdi
	addq	$256, %rsi
	addq	$256, %rbp
	decq	%rcx
	jnz	.mainad

	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%r14, %rbp
	movq	%rbx, %rcx
	decq	%r15
	jnz	.mainad

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free */
	movq	%r14, %rdi
	call	free
/* free */
	movq	%r13, %rdi
	call	free
/* free */
	movq	%r12, %rdi
	call	free
/* calculate */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$32, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl inttr
inttr:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	movq	%rsi, %r15
	shlq	$10, %rbx
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r12
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r13
/* allocate */
	movq	%rbx, %rdi
	call	malloc
	movq	%rax, %r14
/* prefill */
	movq	%rbx, %rcx
	shrq	$5, %rcx
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	$33, %rax
	movq	$55, %rdx
.pretr:
	movq	%rax, 0(%rdi)
	movq	%rax, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%rax, 24(%rdi)
	movq	%rdx, 0(%rsi)
	movq	%rdx, 8(%rsi)
	movq	%rdx, 16(%rsi)
	movq	%rdx, 24(%rsi)	
	addq	$32, %rdi
	addq	$32, %rsi
	loopq	.pretr
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%r14, %rbp
.maintr:
	imulq	$77, 0(%rsi), %rax
	imulq	$77, 8(%rsi), %rdx
	imulq	$77, 16(%rsi), %r8
	imulq	$77, 24(%rsi), %r9
	addq	0(%rdi), %rax
	addq	8(%rdi), %rdx
	addq	16(%rdi), %r8
	addq	24(%rdi), %r9
	movq	%rax, 0(%rbp)
	movq	%rdx, 8(%rbp)
	movq	%r8, 16(%rbp)
	movq	%r9, 24(%rbp)
	imulq	$77, 32(%rsi), %rax
	imulq	$77, 40(%rsi), %rdx
	imulq	$77, 48(%rsi), %r8
	imulq	$77, 56(%rsi), %r9
	addq	32(%rdi), %rax
	addq	40(%rdi), %rdx
	addq	48(%rdi), %r8
	addq	56(%rdi), %r9
	movq	%rax, 32(%rbp)
	movq	%rdx, 40(%rbp)
	movq	%r8, 48(%rbp)
	movq	%r9, 56(%rbp)
	imulq	$77, 64(%rsi), %rax
	imulq	$77, 72(%rsi), %rdx
	imulq	$77, 80(%rsi), %r8
	imulq	$77, 88(%rsi), %r9
	addq	64(%rdi), %rax
	addq	72(%rdi), %rdx
	addq	80(%rdi), %r8
	addq	88(%rdi), %r9
	movq	%rax, 64(%rbp)
	movq	%rdx, 72(%rbp)
	movq	%r8, 80(%rbp)
	movq	%r9, 88(%rbp)
	imulq	$77, 96(%rsi), %rax
	imulq	$77, 104(%rsi), %rdx
	imulq	$77, 112(%rsi), %r8
	imulq	$77, 120(%rsi), %r9
	addq	96(%rdi), %rax
	addq	104(%rdi), %rdx
	addq	112(%rdi), %r8
	addq	120(%rdi), %r9
	movq	%rax, 96(%rbp)
	movq	%rdx, 104(%rbp)
	movq	%r8, 112(%rbp)
	movq	%r9, 120(%rbp)
	imulq	$77, 128(%rsi), %rax
	imulq	$77, 136(%rsi), %rdx
	imulq	$77, 144(%rsi), %r8
	imulq	$77, 152(%rsi), %r9
	addq	128(%rdi), %rax
	addq	136(%rdi), %rdx
	addq	144(%rdi), %r8
	addq	152(%rdi), %r9
	movq	%rax, 128(%rbp)
	movq	%rdx, 136(%rbp)
	movq	%r8, 144(%rbp)
	movq	%r9, 152(%rbp)
	imulq	$77, 160(%rsi), %rax
	imulq	$77, 168(%rsi), %rdx
	imulq	$77, 176(%rsi), %r8
	imulq	$77, 184(%rsi), %r9
	addq	160(%rdi), %rax
	addq	168(%rdi), %rdx
	addq	176(%rdi), %r8
	addq	184(%rdi), %r9
	movq	%rax, 160(%rbp)
	movq	%rdx, 168(%rbp)
	movq	%r8, 176(%rbp)
	movq	%r9, 184(%rbp)
	imulq	$77, 192(%rsi), %rax
	imulq	$77, 200(%rsi), %rdx
	imulq	$77, 208(%rsi), %r8
	imulq	$77, 216(%rsi), %r9
	addq	192(%rdi), %rax
	addq	200(%rdi), %rdx
	addq	208(%rdi), %r8
	addq	216(%rdi), %r9
	movq	%rax, 192(%rsi)
	movq	%rdx, 200(%rsi)
	movq	%r8, 208(%rsi)
	movq	%r9, 216(%rsi)
	imulq	$77, 224(%rsi), %rax
	imulq	$77, 232(%rsi), %rdx
	imulq	$77, 240(%rsi), %r8
	imulq	$77, 248(%rsi), %r9
	addq	224(%rdi), %rax
	addq	232(%rdi), %rdx
	addq	240(%rdi), %r8
	addq	248(%rdi), %r9
	movq	%rax, 224(%rsi)
	movq	%rdx, 232(%rsi)
	movq	%r8, 240(%rsi)
	movq	%r9, 248(%rsi)
	addq	$256, %rdi
	addq	$256, %rsi
	addq	$256, %rbp
	decq	%rcx
	jnz	.maintr

	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%r14, %rbp
	movq	%rbx, %rcx
	decq	%r15
	jnz	.maintr

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* free */
	movq	%r14, %rdi
	call	free
/* free */
	movq	%r13, %rdi
	call	free
/* free */
	movq	%r12, %rdi
	call	free
/* calculate */
	movq	16(%rsp), %rax
	subq	0(%rsp), %rax
	movq	$1000000, %rdx
	mulq	%rdx
	addq	24(%rsp), %rax
	subq	8(%rsp), %rax
/* restore and return */
	addq	$32, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret
