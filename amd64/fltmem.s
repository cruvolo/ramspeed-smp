/*
**  FLOATmem benchmarks for RAMspeed (amd64)
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

.globl floatcp
floatcp:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
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
	finit
	fldpi
.precp:
	fstl	0(%rdi)
	fstl	8(%rdi)
	fstl	16(%rdi)
	fstl	24(%rdi)
	addq	$32, %rdi
	loopq	.precp
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	$256, %rax
.maincp:
	fldl	0(%rdi)
	fldl	8(%rdi)
	fldl	16(%rdi)
	fldl	24(%rdi)
	fstpl	24(%rsi)
	fstpl	16(%rsi)
	fstpl	8(%rsi)
	fstpl	0(%rsi)
	fldl	32(%rdi)
	fldl	40(%rdi)
	fldl	48(%rdi)
	fldl	56(%rdi)
	fstpl	56(%rsi)
	fstpl	48(%rsi)
	fstpl	40(%rsi)
	fstpl	32(%rsi)
	fldl	64(%rdi)
	fldl	72(%rdi)
	fldl	80(%rdi)
	fldl	88(%rdi)
	fstpl	88(%rsi)
	fstpl	80(%rsi)
	fstpl	72(%rsi)
	fstpl	64(%rsi)
	fldl	96(%rdi)
	fldl	104(%rdi)
	fldl	112(%rdi)
	fldl	120(%rdi)
	fstpl	120(%rsi)
	fstpl	112(%rsi)
	fstpl	104(%rsi)
	fstpl	96(%rsi)
	fldl	128(%rdi)
	fldl	136(%rdi)
	fldl	144(%rdi)
	fldl	152(%rdi)
	fstpl	152(%rsi)
	fstpl	144(%rsi)
	fstpl	136(%rsi)
	fstpl	128(%rsi)
	fldl	160(%rdi)
	fldl	168(%rdi)
	fldl	176(%rdi)
	fldl	184(%rdi)
	fstpl	184(%rsi)
	fstpl	176(%rsi)
	fstpl	168(%rsi)
	fstpl	160(%rsi)
	fldl	192(%rdi)
	fldl	200(%rdi)
	fldl	208(%rdi)
	fldl	216(%rdi)
	fstpl	216(%rsi)
	fstpl	208(%rsi)
	fstpl	200(%rsi)
	fstpl	192(%rsi)
	fldl	224(%rdi)
	fldl	232(%rdi)
	fldl	240(%rdi)
	fldl	248(%rdi)
	fstpl	248(%rsi)
	fstpl	240(%rsi)
	fstpl	232(%rsi)
	fstpl	224(%rsi)
	addq	%rax, %rdi
	addq	%rax, %rsi
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
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl floatsc
floatsc:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
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
	finit
	fldpi
.presc:
	fstl	0(%rdi)
	fstl	8(%rdi)
	fstl	16(%rdi)
	fstl	24(%rdi)
	addq	$32, %rdi
	loopq	.presc
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	$256, %rax
	fldln2
.mainsc:
	fldl	0(%rdi)
	fmul	%st(1), %st(0)
	fldl	8(%rdi)
	fmul	%st(2), %st(0)
	fldl	16(%rdi)
	fmul	%st(3), %st(0)
	fldl	24(%rdi)
	fmul	%st(4), %st(0)
	fstpl	24(%rsi)
	fstpl	16(%rsi)
	fstpl	8(%rsi)
	fstpl	0(%rsi)
	fldl	32(%rdi)
	fmul	%st(1), %st(0)
	fldl	40(%rdi)
	fmul	%st(2), %st(0)
	fldl	48(%rdi)
	fmul	%st(3), %st(0)
	fldl	56(%rdi)
	fmul	%st(4), %st(0)
	fstpl	56(%rsi)
	fstpl	48(%rsi)
	fstpl	40(%rsi)
	fstpl	32(%rsi)
	fldl	64(%rdi)
	fmul	%st(1), %st(0)
	fldl	72(%rdi)
	fmul	%st(2), %st(0)
	fldl	80(%rdi)
	fmul	%st(3), %st(0)
	fldl	88(%rdi)
	fmul	%st(4), %st(0)
	fstpl	88(%rsi)
	fstpl	80(%rsi)
	fstpl	72(%rsi)
	fstpl	64(%rsi)
	fldl	96(%rdi)
	fmul	%st(1), %st(0)
	fldl	104(%rdi)
	fmul	%st(2), %st(0)
	fldl	112(%rdi)
	fmul	%st(3), %st(0)
	fldl	120(%rdi)
	fmul	%st(4), %st(0)
	fstpl	120(%rsi)
	fstpl	112(%rsi)
	fstpl	104(%rsi)
	fstpl	96(%rsi)
	fldl	128(%rdi)
	fmul	%st(1), %st(0)
	fldl	136(%rdi)
	fmul	%st(2), %st(0)
	fldl	144(%rdi)
	fmul	%st(3), %st(0)
	fldl	152(%rdi)
	fmul	%st(4), %st(0)
	fstpl	152(%rsi)
	fstpl	144(%rsi)
	fstpl	136(%rsi)
	fstpl	128(%rsi)
	fldl	160(%rdi)
	fmul	%st(1), %st(0)
	fldl	168(%rdi)
	fmul	%st(2), %st(0)
	fldl	176(%rdi)
	fmul	%st(3), %st(0)
	fldl	184(%rdi)
	fmul	%st(4), %st(0)
	fstpl	184(%rsi)
	fstpl	176(%rsi)
	fstpl	168(%rsi)
	fstpl	160(%rsi)
	fldl	192(%rdi)
	fmul	%st(1), %st(0)
	fldl	200(%rdi)
	fmul	%st(2), %st(0)
	fldl	208(%rdi)
	fmul	%st(3), %st(0)
	fldl	216(%rdi)
	fmul	%st(4), %st(0)
	fstpl	216(%rsi)
	fstpl	208(%rsi)
	fstpl	200(%rsi)
	fstpl	192(%rsi)
	fldl	224(%rdi)
	fmul	%st(1), %st(0)
	fldl	232(%rdi)
	fmul	%st(2), %st(0)
	fldl	240(%rdi)
	fmul	%st(3), %st(0)
	fldl	248(%rdi)
	fmul	%st(4), %st(0)
	fstpl	248(%rsi)
	fstpl	240(%rsi)
	fstpl	232(%rsi)
	fstpl	224(%rsi)
	addq	%rax, %rdi
	addq	%rax, %rsi
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
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl floatad
floatad:
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
	finit
	fldpi
.pread:
	fstl	0(%rdi)
	fstl	8(%rdi)
	fstl	16(%rdi)
	fstl	24(%rdi)
	fstl	0(%rsi)
	fstl	8(%rsi)
	fstl	16(%rsi)
	fstl	24(%rsi)
	addq	$32, %rdi
	addq	$32, %rsi
	loopq	.pread
	ffree	%st(0)
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
	movq	$256, %rax
.mainad:
	fldl	0(%rdi)
	faddl	0(%rsi)
	fldl	8(%rdi)
	faddl	8(%rsi)
	fldl	16(%rdi)
	faddl	16(%rsi)
	fldl	24(%rdi)
	faddl	24(%rsi)
	fstpl	24(%rbp)
	fstpl	16(%rbp)
	fstpl	8(%rbp)
	fstpl	0(%rbp)
	fldl	32(%rdi)
	faddl	32(%rsi)
	fldl	40(%rdi)
	faddl	40(%rsi)
	fldl	48(%rdi)
	faddl	48(%rsi)
	fldl	56(%rdi)
	faddl	56(%rsi)
	fstpl	56(%rbp)
	fstpl	48(%rbp)
	fstpl	40(%rbp)
	fstpl	32(%rbp)
	fldl	64(%rdi)
	faddl	64(%rsi)
	fldl	72(%rdi)
	faddl	72(%rsi)
	fldl	80(%rdi)
	faddl	80(%rsi)
	fldl	88(%rdi)
	faddl	88(%rsi)
	fstpl	88(%rbp)
	fstpl	80(%rbp)
	fstpl	72(%rbp)
	fstpl	64(%rbp)
	fldl	96(%rdi)
	faddl	96(%rsi)
	fldl	104(%rdi)
	faddl	104(%rsi)
	fldl	112(%rdi)
	faddl	112(%rsi)
	fldl	120(%rdi)
	faddl	120(%rsi)
	fstpl	120(%rbp)
	fstpl	112(%rbp)
	fstpl	104(%rbp)
	fstpl	96(%rbp)
	fldl	128(%rdi)
	faddl	128(%rsi)
	fldl	136(%rdi)
	faddl	136(%rsi)
	fldl	144(%rdi)
	faddl	144(%rsi)
	fldl	152(%rdi)
	faddl	152(%rsi)
	fstpl	152(%rbp)
	fstpl	144(%rbp)
	fstpl	136(%rbp)
	fstpl	128(%rbp)
	fldl	160(%rdi)
	faddl	160(%rsi)
	fldl	168(%rdi)
	faddl	168(%rsi)
	fldl	176(%rdi)
	faddl	176(%rsi)
	fldl	184(%rdi)
	faddl	184(%rsi)
	fstpl	184(%rbp)
	fstpl	176(%rbp)
	fstpl	168(%rbp)
	fstpl	160(%rbp)
	fldl	192(%rdi)
	faddl	192(%rsi)
	fldl	200(%rdi)
	faddl	200(%rsi)
	fldl	208(%rdi)
	faddl	208(%rsi)
	fldl	216(%rdi)
	faddl	216(%rsi)
	fstpl	216(%rbp)
	fstpl	208(%rbp)
	fstpl	200(%rbp)
	fstpl	192(%rbp)
	fldl	224(%rdi)
	faddl	224(%rsi)
	fldl	232(%rdi)
	faddl	232(%rsi)
	fldl	240(%rdi)
	faddl	240(%rsi)
	fldl	248(%rdi)
	faddl	248(%rsi)
	fstpl	248(%rbp)
	fstpl	240(%rbp)
	fstpl	232(%rbp)
	fstpl	224(%rbp)
	addq	%rax, %rdi
	addq	%rax, %rsi
	addq	%rax, %rbp
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

.globl floattr
floattr:
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
	finit
	fldpi
.pretr:
	fstl	0(%rdi)
	fstl	8(%rdi)
	fstl	16(%rdi)
	fstl	24(%rdi)
	fstl	0(%rsi)
	fstl	8(%rsi)
	fstl	16(%rsi)
	fstl	24(%rsi)
	addq	$32, %rdi
	addq	$32, %rsi
	loopq	.pretr
	ffree	%st(0)
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
	movq	$256, %rax
	fldln2
.maintr:
	fldl	0(%rsi)
	fmul	%st(1), %st(0)
	faddl	0(%rdi)
	fldl	8(%rsi)
	fmul	%st(2), %st(0)
	faddl	8(%rdi)
	fldl	16(%rsi)
	fmul	%st(3), %st(0)
	faddl	16(%rdi)
	fldl	24(%rsi)
	fmul	%st(4), %st(0)
	faddl	24(%rdi)
	fstpl	24(%rbp)
	fstpl	16(%rbp)
	fstpl	8(%rbp)
	fstpl	0(%rbp)
	fldl	32(%rsi)
	fmul	%st(1), %st(0)
	faddl	32(%rdi)
	fldl	40(%rsi)
	fmul	%st(2), %st(0)
	faddl	40(%rdi)
	fldl	48(%rsi)
	fmul	%st(3), %st(0)
	faddl	48(%rdi)
	fldl	56(%rsi)
	fmul	%st(4), %st(0)
	faddl	56(%rdi)
	fstpl	56(%rbp)
	fstpl	48(%rbp)
	fstpl	40(%rbp)
	fstpl	32(%rbp)
	fldl	64(%rsi)
	fmul	%st(1), %st(0)
	faddl	64(%rdi)
	fldl	72(%rsi)
	fmul	%st(2), %st(0)
	faddl	72(%rdi)
	fldl	80(%rsi)
	fmul	%st(3), %st(0)
	faddl	80(%rdi)
	fldl	88(%rsi)
	fmul	%st(4), %st(0)
	faddl	88(%rdi)
	fstpl	88(%rbp)
	fstpl	80(%rbp)
	fstpl	72(%rbp)
	fstpl	64(%rbp)
	fldl	96(%rsi)
	fmul	%st(1), %st(0)
	faddl	96(%rdi)
	fldl	104(%rsi)
	fmul	%st(2), %st(0)
	faddl	104(%rdi)
	fldl	112(%rsi)
	fmul	%st(3), %st(0)
	faddl	112(%rdi)
	fldl	120(%rsi)
	fmul	%st(4), %st(0)
	faddl	120(%rdi)
	fstpl	120(%rbp)
	fstpl	112(%rbp)
	fstpl	104(%rbp)
	fstpl	96(%rbp)
	fldl	128(%rsi)
	fmul	%st(1), %st(0)
	faddl	128(%rdi)
	fldl	136(%rsi)
	fmul	%st(2), %st(0)
	faddl	136(%rdi)
	fldl	144(%rsi)
	fmul	%st(3), %st(0)
	faddl	144(%rdi)
	fldl	152(%rsi)
	fmul	%st(4), %st(0)
	faddl	152(%rdi)
	fstpl	152(%rbp)
	fstpl	144(%rbp)
	fstpl	136(%rbp)
	fstpl	128(%rbp)
	fldl	160(%rsi)
	fmul	%st(1), %st(0)
	faddl	160(%rdi)
	fldl	168(%rsi)
	fmul	%st(2), %st(0)
	faddl	168(%rdi)
	fldl	176(%rsi)
	fmul	%st(3), %st(0)
	faddl	176(%rdi)
	fldl	184(%rsi)
	fmul	%st(4), %st(0)
	faddl	184(%rdi)
	fstpl	184(%rbp)
	fstpl	176(%rbp)
	fstpl	168(%rbp)
	fstpl	160(%rbp)
	fldl	192(%rsi)
	fmul	%st(1), %st(0)
	faddl	192(%rdi)
	fldl	200(%rsi)
	fmul	%st(2), %st(0)
	faddl	200(%rdi)
	fldl	208(%rsi)
	fmul	%st(3), %st(0)
	faddl	208(%rdi)
	fldl	216(%rsi)
	fmul	%st(4), %st(0)
	faddl	216(%rdi)
	fstpl	216(%rbp)
	fstpl	208(%rbp)
	fstpl	200(%rbp)
	fstpl	192(%rbp)
	fldl	224(%rsi)
	fmul	%st(1), %st(0)
	faddl	224(%rdi)
	fldl	232(%rsi)
	fmul	%st(2), %st(0)
	faddl	232(%rdi)
	fldl	240(%rsi)
	fmul	%st(3), %st(0)
	faddl	240(%rdi)
	fldl	248(%rsi)
	fmul	%st(4), %st(0)
	faddl	248(%rdi)
	fstpl	248(%rbp)
	fstpl	240(%rbp)
	fstpl	232(%rbp)
	fstpl	224(%rbp)
	addq	%rax, %rdi
	addq	%rax, %rsi
	addq	%rax, %rbp
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
