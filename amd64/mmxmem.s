/*
**  MMXmem benchmarks for RAMspeed (amd64)
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

.globl mmxcp
mmxcp:
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
	movq	$0x0021002100210021, %rax
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
.precp:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	addq	$64, %r8
	loopq	.precp
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$256, %rax
.maincp:
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	movq	%mm0, 0(%r9)
	movq	%mm1, 8(%r9)
	movq	%mm2, 16(%r9)
	movq	%mm3, 24(%r9)
	movq	32(%r8), %mm0
	movq	40(%r8), %mm1
	movq	48(%r8), %mm2
	movq	56(%r8), %mm3
	movq	%mm0, 32(%r9)
	movq	%mm1, 40(%r9)
	movq	%mm2, 48(%r9)
	movq	%mm3, 56(%r9)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	movq	%mm0, 64(%r9)
	movq	%mm1, 72(%r9)
	movq	%mm2, 80(%r9)
	movq	%mm3, 88(%r9)
	movq	96(%r8), %mm0
	movq	104(%r8), %mm1
	movq	112(%r8), %mm2
	movq	120(%r8), %mm3
	movq	%mm0, 96(%r9)
	movq	%mm1, 104(%r9)
	movq	%mm2, 112(%r9)
	movq	%mm3, 120(%r9)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	movq	%mm0, 128(%r9)
	movq	%mm1, 136(%r9)
	movq	%mm2, 144(%r9)
	movq	%mm3, 152(%r9)
	movq	160(%r8), %mm0
	movq	168(%r8), %mm1
	movq	176(%r8), %mm2
	movq	184(%r8), %mm3
	movq	%mm0, 160(%r9)
	movq	%mm1, 168(%r9)
	movq	%mm2, 176(%r9)
	movq	%mm3, 184(%r9)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	movq	%mm0, 192(%r9)
	movq	%mm1, 200(%r9)
	movq	%mm2, 208(%r9)
	movq	%mm3, 216(%r9)
	movq	224(%r8), %mm0
	movq	232(%r8), %mm1
	movq	240(%r8), %mm2
	movq	248(%r8), %mm3
	movq	%mm0, 224(%r9)
	movq	%mm1, 232(%r9)
	movq	%mm2, 240(%r9)
	movq	%mm3, 248(%r9)
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
	emms
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxsc
mmxsc:
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
	movq	$0x0021002100210021, %rax
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
.presc:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	addq	$64, %r8
	loopq	.presc
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	movw	$77, 16(%rsp)
	movw	$77, 18(%rsp)
	movw	$77, 20(%rsp)
	movw	$77, 22(%rsp)
	movq	16(%rsp), %mm4
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$256, %rax
.mainsc:
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 0(%r9)
	movq	%mm1, 8(%r9)
	movq	%mm2, 16(%r9)
	movq	%mm3, 24(%r9)
	movq	32(%r8), %mm0
	movq	40(%r8), %mm1
	movq	48(%r8), %mm2
	movq	56(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 32(%r9)
	movq	%mm1, 40(%r9)
	movq	%mm2, 48(%r9)
	movq	%mm3, 56(%r9)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 64(%r9)
	movq	%mm1, 72(%r9)
	movq	%mm2, 80(%r9)
	movq	%mm3, 88(%r9)
	movq	96(%r8), %mm0
	movq	104(%r8), %mm1
	movq	112(%r8), %mm2
	movq	120(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 96(%r9)
	movq	%mm1, 104(%r9)
	movq	%mm2, 112(%r9)
	movq	%mm3, 120(%r9)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 128(%r9)
	movq	%mm1, 136(%r9)
	movq	%mm2, 144(%r9)
	movq	%mm3, 152(%r9)
	movq	160(%r8), %mm0
	movq	168(%r8), %mm1
	movq	176(%r8), %mm2
	movq	184(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 160(%r9)
	movq	%mm1, 168(%r9)
	movq	%mm2, 176(%r9)
	movq	%mm3, 184(%r9)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 192(%r9)
	movq	%mm1, 200(%r9)
	movq	%mm2, 208(%r9)
	movq	%mm3, 216(%r9)
	movq	224(%r8), %mm0
	movq	232(%r8), %mm1
	movq	240(%r8), %mm2
	movq	248(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 224(%r9)
	movq	%mm1, 232(%r9)
	movq	%mm2, 240(%r9)
	movq	%mm3, 248(%r9)
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
	emms
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxad
mmxad:
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
	movq	$0x0021002100210021, %rax
	movq	$0x0037003700370037, %rdx
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
.pread:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	movq	%rdx, 0(%r9)
	movq	%rdx, 8(%r9)
	movq	%rdx, 16(%r9)
	movq	%rdx, 24(%r9)
	movq	%rdx, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rdx, 48(%r9)
	movq	%rdx, 56(%r9)
	addq	$64, %r8
	addq	$64, %r9
	loopq	.pread
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$256, %rax
.mainad:
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	paddusw	0(%r9), %mm0
	paddusw	8(%r9), %mm1
	paddusw	16(%r9), %mm2
	paddusw	24(%r9), %mm3
	movq	%mm0, 0(%r10)
	movq	%mm1, 8(%r10)
	movq	%mm2, 16(%r10)
	movq	%mm3, 24(%r10)
	movq	32(%r8), %mm0
	movq	40(%r8), %mm1
	movq	48(%r8), %mm2
	movq	56(%r8), %mm3
	paddusw	32(%r9), %mm0
	paddusw	40(%r9), %mm1
	paddusw	48(%r9), %mm2
	paddusw	56(%r9), %mm3
	movq	%mm0, 32(%r10)
	movq	%mm1, 40(%r10)
	movq	%mm2, 48(%r10)
	movq	%mm3, 56(%r10)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	paddusw	64(%r9), %mm0
	paddusw	72(%r9), %mm1
	paddusw	80(%r9), %mm2
	paddusw	88(%r9), %mm3
	movq	%mm0, 64(%r10)
	movq	%mm1, 72(%r10)
	movq	%mm2, 80(%r10)
	movq	%mm3, 88(%r10)
	movq	96(%r8), %mm0
	movq	104(%r8), %mm1
	movq	112(%r8), %mm2
	movq	120(%r8), %mm3
	paddusw	96(%r9), %mm0
	paddusw	104(%r9), %mm1
	paddusw	112(%r9), %mm2
	paddusw	120(%r9), %mm3
	movq	%mm0, 96(%r10)
	movq	%mm1, 104(%r10)
	movq	%mm2, 112(%r10)
	movq	%mm3, 120(%r10)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	paddusw	128(%r9), %mm0
	paddusw	136(%r9), %mm1
	paddusw	144(%r9), %mm2
	paddusw	152(%r9), %mm3
	movq	%mm0, 128(%r10)
	movq	%mm1, 136(%r10)
	movq	%mm2, 144(%r10)
	movq	%mm3, 152(%r10)
	movq	160(%r8), %mm0
	movq	168(%r8), %mm1
	movq	176(%r8), %mm2
	movq	184(%r8), %mm3
	paddusw	160(%r9), %mm0
	paddusw	168(%r9), %mm1
	paddusw	176(%r9), %mm2
	paddusw	184(%r9), %mm3
	movq	%mm0, 160(%r10)
	movq	%mm1, 168(%r10)
	movq	%mm2, 176(%r10)
	movq	%mm3, 184(%r10)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	paddusw	192(%r9), %mm0
	paddusw	200(%r9), %mm1
	paddusw	208(%r9), %mm2
	paddusw	216(%r9), %mm3
	movq	%mm0, 192(%r10)
	movq	%mm1, 200(%r10)
	movq	%mm2, 208(%r10)
	movq	%mm3, 216(%r10)
	movq	224(%r8), %mm0
	movq	232(%r8), %mm1
	movq	240(%r8), %mm2
	movq	248(%r8), %mm3
	paddusw	224(%r9), %mm0
	paddusw	232(%r9), %mm1
	paddusw	240(%r9), %mm2
	paddusw	248(%r9), %mm3
	movq	%mm0, 224(%r10)
	movq	%mm1, 232(%r10)
	movq	%mm2, 240(%r10)
	movq	%mm3, 248(%r10)
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
	emms
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxtr
mmxtr:
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
	movq	$0x0021002100210021, %rax
	movq	$0x0037003700370037, %rdx
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
.pretr:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	movq	%rdx, 0(%r9)
	movq	%rdx, 8(%r9)
	movq	%rdx, 16(%r9)
	movq	%rdx, 24(%r9)
	movq	%rdx, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rdx, 48(%r9)
	movq	%rdx, 56(%r9)
	addq	$64, %r8
	addq	$64, %r9
	loopq	.pretr
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	movw	$77, 16(%rsp)
	movw	$77, 18(%rsp)
	movw	$77, 20(%rsp)
	movw	$77, 22(%rsp)
	movq	16(%rsp), %mm4
/* execute */
	shrq	$8, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$256, %rax
.maintr:
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	0(%r9), %mm0
	paddusw	8(%r9), %mm1
	paddusw	16(%r9), %mm2
	paddusw	24(%r9), %mm3
	movq	%mm0, 0(%r10)
	movq	%mm1, 8(%r10)
	movq	%mm2, 16(%r10)
	movq	%mm3, 24(%r10)
	movq	32(%r8), %mm0
	movq	40(%r8), %mm1
	movq	48(%r8), %mm2
	movq	56(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	32(%r9), %mm0
	paddusw	40(%r9), %mm1
	paddusw	48(%r9), %mm2
	paddusw	56(%r9), %mm3
	movq	%mm0, 32(%r10)
	movq	%mm1, 40(%r10)
	movq	%mm2, 48(%r10)
	movq	%mm3, 56(%r10)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	64(%r9), %mm0
	paddusw	72(%r9), %mm1
	paddusw	80(%r9), %mm2
	paddusw	88(%r9), %mm3
	movq	%mm0, 64(%r10)
	movq	%mm1, 72(%r10)
	movq	%mm2, 80(%r10)
	movq	%mm3, 88(%r10)
	movq	96(%r8), %mm0
	movq	104(%r8), %mm1
	movq	112(%r8), %mm2
	movq	120(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	96(%r9), %mm0
	paddusw	104(%r9), %mm1
	paddusw	112(%r9), %mm2
	paddusw	120(%r9), %mm3
	movq	%mm0, 96(%r10)
	movq	%mm1, 104(%r10)
	movq	%mm2, 112(%r10)
	movq	%mm3, 120(%r10)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	128(%r9), %mm0
	paddusw	136(%r9), %mm1
	paddusw	144(%r9), %mm2
	paddusw	152(%r9), %mm3
	movq	%mm0, 128(%r10)
	movq	%mm1, 136(%r10)
	movq	%mm2, 144(%r10)
	movq	%mm3, 152(%r10)
	movq	160(%r8), %mm0
	movq	168(%r8), %mm1
	movq	176(%r8), %mm2
	movq	184(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	160(%r9), %mm0
	paddusw	168(%r9), %mm1
	paddusw	176(%r9), %mm2
	paddusw	184(%r9), %mm3
	movq	%mm0, 160(%r10)
	movq	%mm1, 168(%r10)
	movq	%mm2, 176(%r10)
	movq	%mm3, 184(%r10)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	192(%r9), %mm0
	paddusw	200(%r9), %mm1
	paddusw	208(%r9), %mm2
	paddusw	216(%r9), %mm3
	movq	%mm0, 192(%r10)
	movq	%mm1, 200(%r10)
	movq	%mm2, 208(%r10)
	movq	%mm3, 216(%r10)
	movq	224(%r8), %mm0
	movq	232(%r8), %mm1
	movq	240(%r8), %mm2
	movq	248(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	224(%r9), %mm0
	paddusw	232(%r9), %mm1
	paddusw	240(%r9), %mm2
	paddusw	248(%r9), %mm3
	movq	%mm0, 224(%r10)
	movq	%mm1, 232(%r10)
	movq	%mm2, 240(%r10)
	movq	%mm3, 248(%r10)
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
	emms
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxcp_nt
mmxcp_nt:
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
	movq	$0x0021002100210021, %rax
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
.precp_nt:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	addq	$64, %r8
	loopq	.precp_nt
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$512, %rax
.maincp_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	512(%r8)
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	prefetchnta	576(%r8)
	movq	32(%r8), %mm4
	movq	40(%r8), %mm5
	movq	48(%r8), %mm6
	movq	56(%r8), %mm7
	movntq	%mm0, 0(%r9)
	movntq	%mm1, 8(%r9)
	movntq	%mm2, 16(%r9)
	movntq	%mm3, 24(%r9)
	movntq	%mm4, 32(%r9)
	movntq	%mm5, 40(%r9)
	movntq	%mm6, 48(%r9)
	movntq	%mm7, 56(%r9)
	prefetchnta	640(%r8)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	prefetchnta	704(%r8)
	movq	96(%r8), %mm4
	movq	104(%r8), %mm5
	movq	112(%r8), %mm6
	movq	120(%r8), %mm7
	movntq	%mm0, 64(%r9)
	movntq	%mm1, 72(%r9)
	movntq	%mm2, 80(%r9)
	movntq	%mm3, 88(%r9)
	movntq	%mm4, 96(%r9)
	movntq	%mm5, 104(%r9)
	movntq	%mm6, 112(%r9)
	movntq	%mm7, 120(%r9)
	prefetchnta	768(%r8)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	prefetchnta	832(%r8)
	movq	160(%r8), %mm4
	movq	168(%r8), %mm5
	movq	176(%r8), %mm6
	movq	184(%r8), %mm7
	movntq	%mm0, 128(%r9)
	movntq	%mm1, 136(%r9)
	movntq	%mm2, 144(%r9)
	movntq	%mm3, 152(%r9)
	movntq	%mm4, 160(%r9)
	movntq	%mm5, 168(%r9)
	movntq	%mm6, 176(%r9)
	movntq	%mm7, 184(%r9)
	prefetchnta	896(%r8)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	prefetchnta	960(%r8)
	movq	224(%r8), %mm4
	movq	232(%r8), %mm5
	movq	240(%r8), %mm6
	movq	248(%r8), %mm7
	movntq	%mm0, 192(%r9)
	movntq	%mm1, 200(%r9)
	movntq	%mm2, 208(%r9)
	movntq	%mm3, 216(%r9)
	movntq	%mm4, 224(%r9)
	movntq	%mm5, 232(%r9)
	movntq	%mm6, 240(%r9)
	movntq	%mm7, 248(%r9)
	movq	256(%r8), %mm0
	movq	264(%r8), %mm1
	movq	272(%r8), %mm2
	movq	280(%r8), %mm3
	movq	288(%r8), %mm4
	movq	296(%r8), %mm5
	movq	304(%r8), %mm6
	movq	312(%r8), %mm7
	movntq	%mm0, 256(%r9)
	movntq	%mm1, 264(%r9)
	movntq	%mm2, 272(%r9)
	movntq	%mm3, 280(%r9)
	movntq	%mm4, 288(%r9)
	movntq	%mm5, 296(%r9)
	movntq	%mm6, 304(%r9)
	movntq	%mm7, 312(%r9)
	movq	320(%r8), %mm0
	movq	328(%r8), %mm1
	movq	336(%r8), %mm2
	movq	344(%r8), %mm3
	movq	352(%r8), %mm4
	movq	360(%r8), %mm5
	movq	368(%r8), %mm6
	movq	376(%r8), %mm7
	movntq	%mm0, 320(%r9)
	movntq	%mm1, 328(%r9)
	movntq	%mm2, 336(%r9)
	movntq	%mm3, 344(%r9)
	movntq	%mm4, 352(%r9)
	movntq	%mm5, 360(%r9)
	movntq	%mm6, 368(%r9)
	movntq	%mm7, 376(%r9)
	movq	384(%r8), %mm0
	movq	392(%r8), %mm1
	movq	400(%r8), %mm2
	movq	408(%r8), %mm3
	movq	416(%r8), %mm4
	movq	424(%r8), %mm5
	movq	432(%r8), %mm6
	movq	440(%r8), %mm7
	movntq	%mm0, 384(%r9)
	movntq	%mm1, 392(%r9)
	movntq	%mm2, 400(%r9)
	movntq	%mm3, 408(%r9)
	movntq	%mm4, 416(%r9)
	movntq	%mm5, 424(%r9)
	movntq	%mm6, 432(%r9)
	movntq	%mm7, 440(%r9)
	movq	448(%r8), %mm0
	movq	456(%r8), %mm1
	movq	464(%r8), %mm2
	movq	472(%r8), %mm3
	movq	480(%r8), %mm4
	movq	488(%r8), %mm5
	movq	496(%r8), %mm6
	movq	504(%r8), %mm7
	movntq	%mm0, 448(%r9)
	movntq	%mm1, 456(%r9)
	movntq	%mm2, 464(%r9)
	movntq	%mm3, 472(%r9)
	movntq	%mm4, 480(%r9)
	movntq	%mm5, 488(%r9)
	movntq	%mm6, 496(%r9)
	movntq	%mm7, 504(%r9)
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
	emms
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxsc_nt
mmxsc_nt:
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
	movq	$0x0021002100210021, %rax
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
.presc_nt:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	addq	$64, %r8
	loopq	.presc_nt
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	movw	$77, 16(%rsp)
	movw	$77, 18(%rsp)
	movw	$77, 20(%rsp)
	movw	$77, 22(%rsp)
	movq	16(%rsp), %mm4
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$512, %rax
.mainsc_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	512(%r8)
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 0(%r9)
	movntq	%mm1, 8(%r9)
	movntq	%mm2, 16(%r9)
	movntq	%mm3, 24(%r9)
	prefetchnta	576(%r8)
	movq	32(%r8), %mm0
	movq	40(%r8), %mm1
	movq	48(%r8), %mm2
	movq	56(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 32(%r9)
	movntq	%mm1, 40(%r9)
	movntq	%mm2, 48(%r9)
	movntq	%mm3, 56(%r9)
	prefetchnta	640(%r8)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 64(%r9)
	movntq	%mm1, 72(%r9)
	movntq	%mm2, 80(%r9)
	movntq	%mm3, 88(%r9)
	prefetchnta	704(%r8)
	movq	96(%r8), %mm0
	movq	104(%r8), %mm1
	movq	112(%r8), %mm2
	movq	120(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 96(%r9)
	movntq	%mm1, 104(%r9)
	movntq	%mm2, 112(%r9)
	movntq	%mm3, 120(%r9)
	prefetchnta	768(%r8)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 128(%r9)
	movntq	%mm1, 136(%r9)
	movntq	%mm2, 144(%r9)
	movntq	%mm3, 152(%r9)
	prefetchnta	832(%r8)
	movq	160(%r8), %mm0
	movq	168(%r8), %mm1
	movq	176(%r8), %mm2
	movq	184(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 160(%r9)
	movntq	%mm1, 168(%r9)
	movntq	%mm2, 176(%r9)
	movntq	%mm3, 184(%r9)
	prefetchnta	896(%r8)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 192(%r9)
	movntq	%mm1, 200(%r9)
	movntq	%mm2, 208(%r9)
	movntq	%mm3, 216(%r9)
	prefetchnta	960(%r8)
	movq	224(%r8), %mm0
	movq	232(%r8), %mm1
	movq	240(%r8), %mm2
	movq	248(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 224(%r9)
	movntq	%mm1, 232(%r9)
	movntq	%mm2, 240(%r9)
	movntq	%mm3, 248(%r9)
	movq	256(%r8), %mm0
	movq	264(%r8), %mm1
	movq	272(%r8), %mm2
	movq	280(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 256(%r9)
	movntq	%mm1, 264(%r9)
	movntq	%mm2, 272(%r9)
	movntq	%mm3, 280(%r9)
	movq	288(%r8), %mm0
	movq	296(%r8), %mm1
	movq	304(%r8), %mm2
	movq	312(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 288(%r9)
	movntq	%mm1, 296(%r9)
	movntq	%mm2, 304(%r9)
	movntq	%mm3, 312(%r9)
	movq	320(%r8), %mm0
	movq	328(%r8), %mm1
	movq	336(%r8), %mm2
	movq	344(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 320(%r9)
	movntq	%mm1, 328(%r9)
	movntq	%mm2, 336(%r9)
	movntq	%mm3, 344(%r9)
	movq	352(%r8), %mm0
	movq	360(%r8), %mm1
	movq	368(%r8), %mm2
	movq	376(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 352(%r9)
	movntq	%mm1, 360(%r9)
	movntq	%mm2, 368(%r9)
	movntq	%mm3, 376(%r9)
	movq	384(%r8), %mm0
	movq	392(%r8), %mm1
	movq	400(%r8), %mm2
	movq	408(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 384(%r9)
	movntq	%mm1, 392(%r9)
	movntq	%mm2, 400(%r9)
	movntq	%mm3, 408(%r9)
	movq	416(%r8), %mm0
	movq	424(%r8), %mm1
	movq	432(%r8), %mm2
	movq	440(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 416(%r9)
	movntq	%mm1, 424(%r9)
	movntq	%mm2, 432(%r9)
	movntq	%mm3, 440(%r9)
	movq	448(%r8), %mm0
	movq	456(%r8), %mm1
	movq	464(%r8), %mm2
	movq	472(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 448(%r9)
	movntq	%mm1, 456(%r9)
	movntq	%mm2, 464(%r9)
	movntq	%mm3, 472(%r9)
	movq	480(%r8), %mm0
	movq	488(%r8), %mm1
	movq	496(%r8), %mm2
	movq	504(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 480(%r9)
	movntq	%mm1, 488(%r9)
	movntq	%mm2, 496(%r9)
	movntq	%mm3, 504(%r9)
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
	emms
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxad_nt
mmxad_nt:
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
	movq	$0x0021002100210021, %rax
	movq	$0x0037003700370037, %rdx
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
.pread_nt:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	movq	%rdx, 0(%r9)
	movq	%rdx, 8(%r9)
	movq	%rdx, 16(%r9)
	movq	%rdx, 24(%r9)
	movq	%rdx, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rdx, 48(%r9)
	movq	%rdx, 56(%r9)
	addq	$64, %r8
	addq	$64, %r9
	loopq	.pread_nt
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$512, %rax
.mainad_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	512(%r9)
	movq	0(%r9), %mm0
	movq	8(%r9), %mm1
	movq	16(%r9), %mm2
	movq	24(%r9), %mm3
	prefetchnta	512(%r8)
	movq	32(%r9), %mm4
	movq	40(%r9), %mm5
	movq	48(%r9), %mm6
	movq	56(%r9), %mm7
	prefetchnta	576(%r9)
	paddusw	0(%r8), %mm0
	paddusw	8(%r8), %mm1
	paddusw	16(%r8), %mm2
	paddusw	24(%r8), %mm3
	prefetchnta	576(%r8)
	paddusw	32(%r8), %mm4
	paddusw	40(%r8), %mm5
	paddusw	48(%r8), %mm6
	paddusw	56(%r8), %mm7
	movntq	%mm0, 0(%r10)
	movntq	%mm1, 8(%r10)
	movntq	%mm2, 16(%r10)
	movntq	%mm3, 24(%r10)
	movntq	%mm4, 32(%r10)
	movntq	%mm5, 40(%r10)
	movntq	%mm6, 48(%r10)
	movntq	%mm7, 56(%r10)
	prefetchnta	640(%r9)
	movq	64(%r9), %mm0
	movq	72(%r9), %mm1
	movq	80(%r9), %mm2
	movq	88(%r9), %mm3
	prefetchnta	640(%r8)
	movq	96(%r9), %mm4
	movq	104(%r9), %mm5
	movq	112(%r9), %mm6
	movq	120(%r9), %mm7
	prefetchnta	704(%r9)
	paddusw	64(%r8), %mm0
	paddusw	72(%r8), %mm1
	paddusw	80(%r8), %mm2
	paddusw	88(%r8), %mm3
	prefetchnta	704(%r8)
	paddusw	96(%r8), %mm4
	paddusw	104(%r8), %mm5
	paddusw	112(%r8), %mm6
	paddusw	120(%r8), %mm7
	movntq	%mm0, 64(%r10)
	movntq	%mm1, 72(%r10)
	movntq	%mm2, 80(%r10)
	movntq	%mm3, 88(%r10)
	movntq	%mm4, 96(%r10)
	movntq	%mm5, 104(%r10)
	movntq	%mm6, 112(%r10)
	movntq	%mm7, 120(%r10)
	prefetchnta	768(%r9)
	movq	128(%r9), %mm0
	movq	136(%r9), %mm1
	movq	144(%r9), %mm2
	movq	152(%r9), %mm3
	prefetchnta	768(%r8)
	movq	160(%r9), %mm4
	movq	168(%r9), %mm5
	movq	176(%r9), %mm6
	movq	184(%r9), %mm7
	prefetchnta	832(%r9)
	paddusw	128(%r8), %mm0
	paddusw	136(%r8), %mm1
	paddusw	144(%r8), %mm2
	paddusw	152(%r8), %mm3
	prefetchnta	832(%r8)
	paddusw	160(%r8), %mm4
	paddusw	168(%r8), %mm5
	paddusw	176(%r8), %mm6
	paddusw	184(%r8), %mm7
	movntq	%mm0, 128(%r10)
	movntq	%mm1, 136(%r10)
	movntq	%mm2, 144(%r10)
	movntq	%mm3, 152(%r10)
	movntq	%mm4, 160(%r10)
	movntq	%mm5, 168(%r10)
	movntq	%mm6, 176(%r10)
	movntq	%mm7, 184(%r10)
	prefetchnta	896(%r9)
	movq	192(%r9), %mm0
	movq	200(%r9), %mm1
	movq	208(%r9), %mm2
	movq	216(%r9), %mm3
	prefetchnta	896(%r8)
	movq	224(%r9), %mm4
	movq	232(%r9), %mm5
	movq	240(%r9), %mm6
	movq	248(%r9), %mm7
	prefetchnta	960(%r9)
	paddusw	192(%r8), %mm0
	paddusw	200(%r8), %mm1
	paddusw	208(%r8), %mm2
	paddusw	216(%r8), %mm3
	prefetchnta	960(%r8)
	paddusw	224(%r8), %mm4
	paddusw	232(%r8), %mm5
	paddusw	240(%r8), %mm6
	paddusw	248(%r8), %mm7
	movntq	%mm0, 192(%r10)
	movntq	%mm1, 200(%r10)
	movntq	%mm2, 208(%r10)
	movntq	%mm3, 216(%r10)
	movntq	%mm4, 224(%r10)
	movntq	%mm5, 232(%r10)
	movntq	%mm6, 240(%r10)
	movntq	%mm7, 248(%r10)
	movq	256(%r9), %mm0
	movq	264(%r9), %mm1
	movq	272(%r9), %mm2
	movq	280(%r9), %mm3
	movq	288(%r9), %mm4
	movq	296(%r9), %mm5
	movq	304(%r9), %mm6
	movq	312(%r9), %mm7
	paddusw	256(%r8), %mm0
	paddusw	264(%r8), %mm1
	paddusw	272(%r8), %mm2
	paddusw	280(%r8), %mm3
	paddusw	288(%r8), %mm4
	paddusw	296(%r8), %mm5
	paddusw	304(%r8), %mm6
	paddusw	312(%r8), %mm7
	movntq	%mm0, 256(%r10)
	movntq	%mm1, 264(%r10)
	movntq	%mm2, 272(%r10)
	movntq	%mm3, 280(%r10)
	movntq	%mm4, 288(%r10)
	movntq	%mm5, 296(%r10)
	movntq	%mm6, 304(%r10)
	movntq	%mm7, 312(%r10)
	movq	320(%r9), %mm0
	movq	328(%r9), %mm1
	movq	336(%r9), %mm2
	movq	344(%r9), %mm3
	movq	352(%r9), %mm4
	movq	360(%r9), %mm5
	movq	368(%r9), %mm6
	movq	376(%r9), %mm7
	paddusw	320(%r8), %mm0
	paddusw	328(%r8), %mm1
	paddusw	336(%r8), %mm2
	paddusw	344(%r8), %mm3
	paddusw	352(%r8), %mm4
	paddusw	360(%r8), %mm5
	paddusw	368(%r8), %mm6
	paddusw	376(%r8), %mm7
	movntq	%mm0, 320(%r10)
	movntq	%mm1, 328(%r10)
	movntq	%mm2, 336(%r10)
	movntq	%mm3, 344(%r10)
	movntq	%mm4, 352(%r10)
	movntq	%mm5, 360(%r10)
	movntq	%mm6, 368(%r10)
	movntq	%mm7, 376(%r10)
	movq	384(%r9), %mm0
	movq	392(%r9), %mm1
	movq	400(%r9), %mm2
	movq	408(%r9), %mm3
	movq	416(%r9), %mm4
	movq	424(%r9), %mm5
	movq	432(%r9), %mm6
	movq	440(%r9), %mm7
	paddusw	384(%r8), %mm0
	paddusw	392(%r8), %mm1
	paddusw	400(%r8), %mm2
	paddusw	408(%r8), %mm3
	paddusw	416(%r8), %mm4
	paddusw	424(%r8), %mm5
	paddusw	432(%r8), %mm6
	paddusw	440(%r8), %mm7
	movntq	%mm0, 384(%r10)
	movntq	%mm1, 392(%r10)
	movntq	%mm2, 400(%r10)
	movntq	%mm3, 408(%r10)
	movntq	%mm4, 416(%r10)
	movntq	%mm5, 424(%r10)
	movntq	%mm6, 432(%r10)
	movntq	%mm7, 440(%r10)
	movq	448(%r9), %mm0
	movq	456(%r9), %mm1
	movq	464(%r9), %mm2
	movq	472(%r9), %mm3
	movq	480(%r9), %mm4
	movq	488(%r9), %mm5
	movq	496(%r9), %mm6
	movq	504(%r9), %mm7
	paddusw	448(%r8), %mm0
	paddusw	456(%r8), %mm1
	paddusw	464(%r8), %mm2
	paddusw	472(%r8), %mm3
	paddusw	480(%r8), %mm4
	paddusw	488(%r8), %mm5
	paddusw	496(%r8), %mm6
	paddusw	504(%r8), %mm7
	movntq	%mm0, 448(%r10)
	movntq	%mm1, 456(%r10)
	movntq	%mm2, 464(%r10)
	movntq	%mm3, 472(%r10)
	movntq	%mm4, 480(%r10)
	movntq	%mm5, 488(%r10)
	movntq	%mm6, 496(%r10)
	movntq	%mm7, 504(%r10)
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
	emms
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxtr_nt
mmxtr_nt:
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
	movq	$0x0021002100210021, %rax
	movq	$0x0037003700370037, %rdx
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
.pretr_nt:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	movq	%rdx, 0(%r9)
	movq	%rdx, 8(%r9)
	movq	%rdx, 16(%r9)
	movq	%rdx, 24(%r9)
	movq	%rdx, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rdx, 48(%r9)
	movq	%rdx, 56(%r9)
	addq	$64, %r8
	addq	$64, %r9
	loopq	.pretr_nt
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	movw	$77, 16(%rsp)
	movw	$77, 18(%rsp)
	movw	$77, 20(%rsp)
	movw	$77, 22(%rsp)
	movq	16(%rsp), %mm4
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$512, %rax
.maintr_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	512(%r9)
	movq	0(%r9), %mm0
	movq	8(%r9), %mm1
	movq	16(%r9), %mm2
	movq	24(%r9), %mm3
	prefetchnta	512(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	0(%r8), %mm0
	paddusw	8(%r8), %mm1
	paddusw	16(%r8), %mm2
	paddusw	24(%r8), %mm3
	movntq	%mm0, 0(%r10)
	movntq	%mm1, 8(%r10)
	movntq	%mm2, 16(%r10)
	movntq	%mm3, 24(%r10)
	prefetchnta	576(%r9)
	movq	32(%r9), %mm0
	movq	40(%r9), %mm1
	movq	48(%r9), %mm2
	movq	56(%r9), %mm3
	prefetchnta	576(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	32(%r8), %mm0
	paddusw	40(%r8), %mm1
	paddusw	48(%r8), %mm2
	paddusw	56(%r8), %mm3
	movntq	%mm0, 32(%r10)
	movntq	%mm1, 40(%r10)
	movntq	%mm2, 48(%r10)
	movntq	%mm3, 56(%r10)
	prefetchnta	640(%r9)
	movq	64(%r9), %mm0
	movq	72(%r9), %mm1
	movq	80(%r9), %mm2
	movq	88(%r9), %mm3
	prefetchnta	640(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	64(%r8), %mm0
	paddusw	72(%r8), %mm1
	paddusw	80(%r8), %mm2
	paddusw	88(%r8), %mm3
	movntq	%mm0, 64(%r10)
	movntq	%mm1, 72(%r10)
	movntq	%mm2, 80(%r10)
	movntq	%mm3, 88(%r10)
	prefetchnta	704(%r9)
	movq	96(%r9), %mm0
	movq	104(%r9), %mm1
	movq	112(%r9), %mm2
	movq	120(%r9), %mm3
	prefetchnta	704(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	96(%r8), %mm0
	paddusw	104(%r8), %mm1
	paddusw	112(%r8), %mm2
	paddusw	120(%r8), %mm3
	movntq	%mm0, 96(%r10)
	movntq	%mm1, 104(%r10)
	movntq	%mm2, 112(%r10)
	movntq	%mm3, 120(%r10)
	prefetchnta	768(%r9)
	movq	128(%r9), %mm0
	movq	136(%r9), %mm1
	movq	144(%r9), %mm2
	movq	152(%r9), %mm3
	prefetchnta	768(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	128(%r8), %mm0
	paddusw	136(%r8), %mm1
	paddusw	144(%r8), %mm2
	paddusw	152(%r8), %mm3
	movntq	%mm0, 128(%r10)
	movntq	%mm1, 136(%r10)
	movntq	%mm2, 144(%r10)
	movntq	%mm3, 152(%r10)
	prefetchnta	832(%r9)
	movq	160(%r9), %mm0
	movq	168(%r9), %mm1
	movq	176(%r9), %mm2
	movq	184(%r9), %mm3
	prefetchnta	832(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	160(%r8), %mm0
	paddusw	168(%r8), %mm1
	paddusw	176(%r8), %mm2
	paddusw	184(%r8), %mm3
	movntq	%mm0, 160(%r10)
	movntq	%mm1, 168(%r10)
	movntq	%mm2, 176(%r10)
	movntq	%mm3, 184(%r10)
	prefetchnta	896(%r9)
	movq	192(%r9), %mm0
	movq	200(%r9), %mm1
	movq	208(%r9), %mm2
	movq	216(%r9), %mm3
	prefetchnta	896(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	192(%r8), %mm0
	paddusw	200(%r8), %mm1
	paddusw	208(%r8), %mm2
	paddusw	216(%r8), %mm3
	movntq	%mm0, 192(%r10)
	movntq	%mm1, 200(%r10)
	movntq	%mm2, 208(%r10)
	movntq	%mm3, 216(%r10)
	prefetchnta	960(%r9)
	movq	224(%r9), %mm0
	movq	232(%r9), %mm1
	movq	240(%r9), %mm2
	movq	248(%r9), %mm3
	prefetchnta	960(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	224(%r8), %mm0
	paddusw	232(%r8), %mm1
	paddusw	240(%r8), %mm2
	paddusw	248(%r8), %mm3
	movntq	%mm0, 224(%r10)
	movntq	%mm1, 232(%r10)
	movntq	%mm2, 240(%r10)
	movntq	%mm3, 248(%r10)
	movq	256(%r9), %mm0
	movq	264(%r9), %mm1
	movq	272(%r9), %mm2
	movq	280(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	256(%r8), %mm0
	paddusw	264(%r8), %mm1
	paddusw	272(%r8), %mm2
	paddusw	280(%r8), %mm3
	movntq	%mm0, 256(%r10)
	movntq	%mm1, 264(%r10)
	movntq	%mm2, 272(%r10)
	movntq	%mm3, 280(%r10)
	movq	288(%r9), %mm0
	movq	296(%r9), %mm1
	movq	304(%r9), %mm2
	movq	312(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	288(%r8), %mm0
	paddusw	296(%r8), %mm1
	paddusw	304(%r8), %mm2
	paddusw	312(%r8), %mm3
	movntq	%mm0, 288(%r10)
	movntq	%mm1, 296(%r10)
	movntq	%mm2, 304(%r10)
	movntq	%mm3, 312(%r10)
	movq	320(%r9), %mm0
	movq	328(%r9), %mm1
	movq	336(%r9), %mm2
	movq	344(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	320(%r8), %mm0
	paddusw	328(%r8), %mm1
	paddusw	336(%r8), %mm2
	paddusw	344(%r8), %mm3
	movntq	%mm0, 320(%r10)
	movntq	%mm1, 328(%r10)
	movntq	%mm2, 336(%r10)
	movntq	%mm3, 344(%r10)
	movq	352(%r9), %mm0
	movq	360(%r9), %mm1
	movq	368(%r9), %mm2
	movq	376(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	352(%r8), %mm0
	paddusw	360(%r8), %mm1
	paddusw	368(%r8), %mm2
	paddusw	376(%r8), %mm3
	movntq	%mm0, 352(%r10)
	movntq	%mm1, 360(%r10)
	movntq	%mm2, 368(%r10)
	movntq	%mm3, 376(%r10)
	movq	384(%r9), %mm0
	movq	392(%r9), %mm1
	movq	400(%r9), %mm2
	movq	408(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	384(%r8), %mm0
	paddusw	392(%r8), %mm1
	paddusw	400(%r8), %mm2
	paddusw	408(%r8), %mm3
	movntq	%mm0, 384(%r10)
	movntq	%mm1, 392(%r10)
	movntq	%mm2, 400(%r10)
	movntq	%mm3, 408(%r10)
	movq	416(%r9), %mm0
	movq	424(%r9), %mm1
	movq	432(%r9), %mm2
	movq	440(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	416(%r8), %mm0
	paddusw	424(%r8), %mm1
	paddusw	432(%r8), %mm2
	paddusw	440(%r8), %mm3
	movntq	%mm0, 416(%r10)
	movntq	%mm1, 424(%r10)
	movntq	%mm2, 432(%r10)
	movntq	%mm3, 440(%r10)
	movq	448(%r9), %mm0
	movq	456(%r9), %mm1
	movq	464(%r9), %mm2
	movq	472(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	448(%r8), %mm0
	paddusw	456(%r8), %mm1
	paddusw	464(%r8), %mm2
	paddusw	472(%r8), %mm3
	movntq	%mm0, 448(%r10)
	movntq	%mm1, 456(%r10)
	movntq	%mm2, 464(%r10)
	movntq	%mm3, 472(%r10)
	movq	480(%r9), %mm0
	movq	488(%r9), %mm1
	movq	496(%r9), %mm2
	movq	504(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	480(%r8), %mm0
	paddusw	488(%r8), %mm1
	paddusw	496(%r8), %mm2
	paddusw	504(%r8), %mm3
	movntq	%mm0, 480(%r10)
	movntq	%mm1, 488(%r10)
	movntq	%mm2, 496(%r10)
	movntq	%mm3, 504(%r10)
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
	emms
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxcp_nt_t0
mmxcp_nt_t0:
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
	movq	$0x0021002100210021, %rax
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
.precp_nt_t0:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	addq	$64, %r8
	loopq	.precp_nt_t0
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$512, %rax
.maincp_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	512(%r8)
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	prefetcht0	576(%r8)
	movq	32(%r8), %mm4
	movq	40(%r8), %mm5
	movq	48(%r8), %mm6
	movq	56(%r8), %mm7
	movntq	%mm0, 0(%r9)
	movntq	%mm1, 8(%r9)
	movntq	%mm2, 16(%r9)
	movntq	%mm3, 24(%r9)
	movntq	%mm4, 32(%r9)
	movntq	%mm5, 40(%r9)
	movntq	%mm6, 48(%r9)
	movntq	%mm7, 56(%r9)
	prefetcht0	640(%r8)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	prefetcht0	704(%r8)
	movq	96(%r8), %mm4
	movq	104(%r8), %mm5
	movq	112(%r8), %mm6
	movq	120(%r8), %mm7
	movntq	%mm0, 64(%r9)
	movntq	%mm1, 72(%r9)
	movntq	%mm2, 80(%r9)
	movntq	%mm3, 88(%r9)
	movntq	%mm4, 96(%r9)
	movntq	%mm5, 104(%r9)
	movntq	%mm6, 112(%r9)
	movntq	%mm7, 120(%r9)
	prefetcht0	768(%r8)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	prefetcht0	832(%r8)
	movq	160(%r8), %mm4
	movq	168(%r8), %mm5
	movq	176(%r8), %mm6
	movq	184(%r8), %mm7
	movntq	%mm0, 128(%r9)
	movntq	%mm1, 136(%r9)
	movntq	%mm2, 144(%r9)
	movntq	%mm3, 152(%r9)
	movntq	%mm4, 160(%r9)
	movntq	%mm5, 168(%r9)
	movntq	%mm6, 176(%r9)
	movntq	%mm7, 184(%r9)
	prefetcht0	896(%r8)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	prefetcht0	960(%r8)
	movq	224(%r8), %mm4
	movq	232(%r8), %mm5
	movq	240(%r8), %mm6
	movq	248(%r8), %mm7
	movntq	%mm0, 192(%r9)
	movntq	%mm1, 200(%r9)
	movntq	%mm2, 208(%r9)
	movntq	%mm3, 216(%r9)
	movntq	%mm4, 224(%r9)
	movntq	%mm5, 232(%r9)
	movntq	%mm6, 240(%r9)
	movntq	%mm7, 248(%r9)
	movq	256(%r8), %mm0
	movq	264(%r8), %mm1
	movq	272(%r8), %mm2
	movq	280(%r8), %mm3
	movq	288(%r8), %mm4
	movq	296(%r8), %mm5
	movq	304(%r8), %mm6
	movq	312(%r8), %mm7
	movntq	%mm0, 256(%r9)
	movntq	%mm1, 264(%r9)
	movntq	%mm2, 272(%r9)
	movntq	%mm3, 280(%r9)
	movntq	%mm4, 288(%r9)
	movntq	%mm5, 296(%r9)
	movntq	%mm6, 304(%r9)
	movntq	%mm7, 312(%r9)
	movq	320(%r8), %mm0
	movq	328(%r8), %mm1
	movq	336(%r8), %mm2
	movq	344(%r8), %mm3
	movq	352(%r8), %mm4
	movq	360(%r8), %mm5
	movq	368(%r8), %mm6
	movq	376(%r8), %mm7
	movntq	%mm0, 320(%r9)
	movntq	%mm1, 328(%r9)
	movntq	%mm2, 336(%r9)
	movntq	%mm3, 344(%r9)
	movntq	%mm4, 352(%r9)
	movntq	%mm5, 360(%r9)
	movntq	%mm6, 368(%r9)
	movntq	%mm7, 376(%r9)
	movq	384(%r8), %mm0
	movq	392(%r8), %mm1
	movq	400(%r8), %mm2
	movq	408(%r8), %mm3
	movq	416(%r8), %mm4
	movq	424(%r8), %mm5
	movq	432(%r8), %mm6
	movq	440(%r8), %mm7
	movntq	%mm0, 384(%r9)
	movntq	%mm1, 392(%r9)
	movntq	%mm2, 400(%r9)
	movntq	%mm3, 408(%r9)
	movntq	%mm4, 416(%r9)
	movntq	%mm5, 424(%r9)
	movntq	%mm6, 432(%r9)
	movntq	%mm7, 440(%r9)
	movq	448(%r8), %mm0
	movq	456(%r8), %mm1
	movq	464(%r8), %mm2
	movq	472(%r8), %mm3
	movq	480(%r8), %mm4
	movq	488(%r8), %mm5
	movq	496(%r8), %mm6
	movq	504(%r8), %mm7
	movntq	%mm0, 448(%r9)
	movntq	%mm1, 456(%r9)
	movntq	%mm2, 464(%r9)
	movntq	%mm3, 472(%r9)
	movntq	%mm4, 480(%r9)
	movntq	%mm5, 488(%r9)
	movntq	%mm6, 496(%r9)
	movntq	%mm7, 504(%r9)
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
	emms
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxsc_nt_t0
mmxsc_nt_t0:
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
	movq	$0x0021002100210021, %rax
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
.presc_nt_t0:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	addq	$64, %r8
	loopq	.presc_nt_t0
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	movw	$77, 16(%rsp)
	movw	$77, 18(%rsp)
	movw	$77, 20(%rsp)
	movw	$77, 22(%rsp)
	movq	16(%rsp), %mm4
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	$512, %rax
.mainsc_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	512(%r8)
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 0(%r9)
	movntq	%mm1, 8(%r9)
	movntq	%mm2, 16(%r9)
	movntq	%mm3, 24(%r9)
	prefetcht0	576(%r8)
	movq	32(%r8), %mm0
	movq	40(%r8), %mm1
	movq	48(%r8), %mm2
	movq	56(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 32(%r9)
	movntq	%mm1, 40(%r9)
	movntq	%mm2, 48(%r9)
	movntq	%mm3, 56(%r9)
	prefetcht0	640(%r8)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 64(%r9)
	movntq	%mm1, 72(%r9)
	movntq	%mm2, 80(%r9)
	movntq	%mm3, 88(%r9)
	prefetcht0	704(%r8)
	movq	96(%r8), %mm0
	movq	104(%r8), %mm1
	movq	112(%r8), %mm2
	movq	120(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 96(%r9)
	movntq	%mm1, 104(%r9)
	movntq	%mm2, 112(%r9)
	movntq	%mm3, 120(%r9)
	prefetcht0	768(%r8)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 128(%r9)
	movntq	%mm1, 136(%r9)
	movntq	%mm2, 144(%r9)
	movntq	%mm3, 152(%r9)
	prefetcht0	832(%r8)
	movq	160(%r8), %mm0
	movq	168(%r8), %mm1
	movq	176(%r8), %mm2
	movq	184(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 160(%r9)
	movntq	%mm1, 168(%r9)
	movntq	%mm2, 176(%r9)
	movntq	%mm3, 184(%r9)
	prefetcht0	896(%r8)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 192(%r9)
	movntq	%mm1, 200(%r9)
	movntq	%mm2, 208(%r9)
	movntq	%mm3, 216(%r9)
	prefetcht0	960(%r8)
	movq	224(%r8), %mm0
	movq	232(%r8), %mm1
	movq	240(%r8), %mm2
	movq	248(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 224(%r9)
	movntq	%mm1, 232(%r9)
	movntq	%mm2, 240(%r9)
	movntq	%mm3, 248(%r9)
	movq	256(%r8), %mm0
	movq	264(%r8), %mm1
	movq	272(%r8), %mm2
	movq	280(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 256(%r9)
	movntq	%mm1, 264(%r9)
	movntq	%mm2, 272(%r9)
	movntq	%mm3, 280(%r9)
	movq	288(%r8), %mm0
	movq	296(%r8), %mm1
	movq	304(%r8), %mm2
	movq	312(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 288(%r9)
	movntq	%mm1, 296(%r9)
	movntq	%mm2, 304(%r9)
	movntq	%mm3, 312(%r9)
	movq	320(%r8), %mm0
	movq	328(%r8), %mm1
	movq	336(%r8), %mm2
	movq	344(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 320(%r9)
	movntq	%mm1, 328(%r9)
	movntq	%mm2, 336(%r9)
	movntq	%mm3, 344(%r9)
	movq	352(%r8), %mm0
	movq	360(%r8), %mm1
	movq	368(%r8), %mm2
	movq	376(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 352(%r9)
	movntq	%mm1, 360(%r9)
	movntq	%mm2, 368(%r9)
	movntq	%mm3, 376(%r9)
	movq	384(%r8), %mm0
	movq	392(%r8), %mm1
	movq	400(%r8), %mm2
	movq	408(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 384(%r9)
	movntq	%mm1, 392(%r9)
	movntq	%mm2, 400(%r9)
	movntq	%mm3, 408(%r9)
	movq	416(%r8), %mm0
	movq	424(%r8), %mm1
	movq	432(%r8), %mm2
	movq	440(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 416(%r9)
	movntq	%mm1, 424(%r9)
	movntq	%mm2, 432(%r9)
	movntq	%mm3, 440(%r9)
	movq	448(%r8), %mm0
	movq	456(%r8), %mm1
	movq	464(%r8), %mm2
	movq	472(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 448(%r9)
	movntq	%mm1, 456(%r9)
	movntq	%mm2, 464(%r9)
	movntq	%mm3, 472(%r9)
	movq	480(%r8), %mm0
	movq	488(%r8), %mm1
	movq	496(%r8), %mm2
	movq	504(%r8), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 480(%r9)
	movntq	%mm1, 488(%r9)
	movntq	%mm2, 496(%r9)
	movntq	%mm3, 504(%r9)
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
	emms
	addq	$88, %rsp
	popq	%r15
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxad_nt_t0
mmxad_nt_t0:
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
	movq	$0x0021002100210021, %rax
	movq	$0x0037003700370037, %rdx
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
.pread_nt_t0:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	movq	%rdx, 0(%r9)
	movq	%rdx, 8(%r9)
	movq	%rdx, 16(%r9)
	movq	%rdx, 24(%r9)
	movq	%rdx, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rdx, 48(%r9)
	movq	%rdx, 56(%r9)
	addq	$64, %r8
	addq	$64, %r9
	loopq	.pread_nt_t0
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$512, %rax
.mainad_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	512(%r9)
	movq	0(%r9), %mm0
	movq	8(%r9), %mm1
	movq	16(%r9), %mm2
	movq	24(%r9), %mm3
	prefetcht0	512(%r8)
	movq	32(%r9), %mm4
	movq	40(%r9), %mm5
	movq	48(%r9), %mm6
	movq	56(%r9), %mm7
	prefetcht0	576(%r9)
	paddusw	0(%r8), %mm0
	paddusw	8(%r8), %mm1
	paddusw	16(%r8), %mm2
	paddusw	24(%r8), %mm3
	prefetcht0	576(%r8)
	paddusw	32(%r8), %mm4
	paddusw	40(%r8), %mm5
	paddusw	48(%r8), %mm6
	paddusw	56(%r8), %mm7
	movntq	%mm0, 0(%r10)
	movntq	%mm1, 8(%r10)
	movntq	%mm2, 16(%r10)
	movntq	%mm3, 24(%r10)
	movntq	%mm4, 32(%r10)
	movntq	%mm5, 40(%r10)
	movntq	%mm6, 48(%r10)
	movntq	%mm7, 56(%r10)
	prefetcht0	640(%r9)
	movq	64(%r9), %mm0
	movq	72(%r9), %mm1
	movq	80(%r9), %mm2
	movq	88(%r9), %mm3
	prefetcht0	640(%r8)
	movq	96(%r9), %mm4
	movq	104(%r9), %mm5
	movq	112(%r9), %mm6
	movq	120(%r9), %mm7
	prefetcht0	704(%r9)
	paddusw	64(%r8), %mm0
	paddusw	72(%r8), %mm1
	paddusw	80(%r8), %mm2
	paddusw	88(%r8), %mm3
	prefetcht0	704(%r8)
	paddusw	96(%r8), %mm4
	paddusw	104(%r8), %mm5
	paddusw	112(%r8), %mm6
	paddusw	120(%r8), %mm7
	movntq	%mm0, 64(%r10)
	movntq	%mm1, 72(%r10)
	movntq	%mm2, 80(%r10)
	movntq	%mm3, 88(%r10)
	movntq	%mm4, 96(%r10)
	movntq	%mm5, 104(%r10)
	movntq	%mm6, 112(%r10)
	movntq	%mm7, 120(%r10)
	prefetcht0	768(%r9)
	movq	128(%r9), %mm0
	movq	136(%r9), %mm1
	movq	144(%r9), %mm2
	movq	152(%r9), %mm3
	prefetcht0	768(%r8)
	movq	160(%r9), %mm4
	movq	168(%r9), %mm5
	movq	176(%r9), %mm6
	movq	184(%r9), %mm7
	prefetcht0	832(%r9)
	paddusw	128(%r8), %mm0
	paddusw	136(%r8), %mm1
	paddusw	144(%r8), %mm2
	paddusw	152(%r8), %mm3
	prefetcht0	832(%r8)
	paddusw	160(%r8), %mm4
	paddusw	168(%r8), %mm5
	paddusw	176(%r8), %mm6
	paddusw	184(%r8), %mm7
	movntq	%mm0, 128(%r10)
	movntq	%mm1, 136(%r10)
	movntq	%mm2, 144(%r10)
	movntq	%mm3, 152(%r10)
	movntq	%mm4, 160(%r10)
	movntq	%mm5, 168(%r10)
	movntq	%mm6, 176(%r10)
	movntq	%mm7, 184(%r10)
	prefetcht0	896(%r9)
	movq	192(%r9), %mm0
	movq	200(%r9), %mm1
	movq	208(%r9), %mm2
	movq	216(%r9), %mm3
	prefetcht0	896(%r8)
	movq	224(%r9), %mm4
	movq	232(%r9), %mm5
	movq	240(%r9), %mm6
	movq	248(%r9), %mm7
	prefetcht0	960(%r9)
	paddusw	192(%r8), %mm0
	paddusw	200(%r8), %mm1
	paddusw	208(%r8), %mm2
	paddusw	216(%r8), %mm3
	prefetcht0	960(%r8)
	paddusw	224(%r8), %mm4
	paddusw	232(%r8), %mm5
	paddusw	240(%r8), %mm6
	paddusw	248(%r8), %mm7
	movntq	%mm0, 192(%r10)
	movntq	%mm1, 200(%r10)
	movntq	%mm2, 208(%r10)
	movntq	%mm3, 216(%r10)
	movntq	%mm4, 224(%r10)
	movntq	%mm5, 232(%r10)
	movntq	%mm6, 240(%r10)
	movntq	%mm7, 248(%r10)
	movq	256(%r9), %mm0
	movq	264(%r9), %mm1
	movq	272(%r9), %mm2
	movq	280(%r9), %mm3
	movq	288(%r9), %mm4
	movq	296(%r9), %mm5
	movq	304(%r9), %mm6
	movq	312(%r9), %mm7
	paddusw	256(%r8), %mm0
	paddusw	264(%r8), %mm1
	paddusw	272(%r8), %mm2
	paddusw	280(%r8), %mm3
	paddusw	288(%r8), %mm4
	paddusw	296(%r8), %mm5
	paddusw	304(%r8), %mm6
	paddusw	312(%r8), %mm7
	movntq	%mm0, 256(%r10)
	movntq	%mm1, 264(%r10)
	movntq	%mm2, 272(%r10)
	movntq	%mm3, 280(%r10)
	movntq	%mm4, 288(%r10)
	movntq	%mm5, 296(%r10)
	movntq	%mm6, 304(%r10)
	movntq	%mm7, 312(%r10)
	movq	320(%r9), %mm0
	movq	328(%r9), %mm1
	movq	336(%r9), %mm2
	movq	344(%r9), %mm3
	movq	352(%r9), %mm4
	movq	360(%r9), %mm5
	movq	368(%r9), %mm6
	movq	376(%r9), %mm7
	paddusw	320(%r8), %mm0
	paddusw	328(%r8), %mm1
	paddusw	336(%r8), %mm2
	paddusw	344(%r8), %mm3
	paddusw	352(%r8), %mm4
	paddusw	360(%r8), %mm5
	paddusw	368(%r8), %mm6
	paddusw	376(%r8), %mm7
	movntq	%mm0, 320(%r10)
	movntq	%mm1, 328(%r10)
	movntq	%mm2, 336(%r10)
	movntq	%mm3, 344(%r10)
	movntq	%mm4, 352(%r10)
	movntq	%mm5, 360(%r10)
	movntq	%mm6, 368(%r10)
	movntq	%mm7, 376(%r10)
	movq	384(%r9), %mm0
	movq	392(%r9), %mm1
	movq	400(%r9), %mm2
	movq	408(%r9), %mm3
	movq	416(%r9), %mm4
	movq	424(%r9), %mm5
	movq	432(%r9), %mm6
	movq	440(%r9), %mm7
	paddusw	384(%r8), %mm0
	paddusw	392(%r8), %mm1
	paddusw	400(%r8), %mm2
	paddusw	408(%r8), %mm3
	paddusw	416(%r8), %mm4
	paddusw	424(%r8), %mm5
	paddusw	432(%r8), %mm6
	paddusw	440(%r8), %mm7
	movntq	%mm0, 384(%r10)
	movntq	%mm1, 392(%r10)
	movntq	%mm2, 400(%r10)
	movntq	%mm3, 408(%r10)
	movntq	%mm4, 416(%r10)
	movntq	%mm5, 424(%r10)
	movntq	%mm6, 432(%r10)
	movntq	%mm7, 440(%r10)
	movq	448(%r9), %mm0
	movq	456(%r9), %mm1
	movq	464(%r9), %mm2
	movq	472(%r9), %mm3
	movq	480(%r9), %mm4
	movq	488(%r9), %mm5
	movq	496(%r9), %mm6
	movq	504(%r9), %mm7
	paddusw	448(%r8), %mm0
	paddusw	456(%r8), %mm1
	paddusw	464(%r8), %mm2
	paddusw	472(%r8), %mm3
	paddusw	480(%r8), %mm4
	paddusw	488(%r8), %mm5
	paddusw	496(%r8), %mm6
	paddusw	504(%r8), %mm7
	movntq	%mm0, 448(%r10)
	movntq	%mm1, 456(%r10)
	movntq	%mm2, 464(%r10)
	movntq	%mm3, 472(%r10)
	movntq	%mm4, 480(%r10)
	movntq	%mm5, 488(%r10)
	movntq	%mm6, 496(%r10)
	movntq	%mm7, 504(%r10)
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
	emms
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxtr_nt_t0
mmxtr_nt_t0:
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
	movq	$0x0021002100210021, %rax
	movq	$0x0037003700370037, %rdx
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
.pretr_nt_t0:
	movq	%rax, 0(%r8)
	movq	%rax, 8(%r8)
	movq	%rax, 16(%r8)
	movq	%rax, 24(%r8)
	movq	%rax, 32(%r8)
	movq	%rax, 40(%r8)
	movq	%rax, 48(%r8)
	movq	%rax, 56(%r8)
	movq	%rdx, 0(%r9)
	movq	%rdx, 8(%r9)
	movq	%rdx, 16(%r9)
	movq	%rdx, 24(%r9)
	movq	%rdx, 32(%r9)
	movq	%rdx, 40(%r9)
	movq	%rdx, 48(%r9)
	movq	%rdx, 56(%r9)
	addq	$64, %r8
	addq	$64, %r9
	loopq	.pretr_nt_t0
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* create the multiplier */
	movw	$77, 16(%rsp)
	movw	$77, 18(%rsp)
	movw	$77, 20(%rsp)
	movw	$77, 22(%rsp)
	movq	16(%rsp), %mm4
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	movq	%r14, %r10
	movq	$512, %rax
.maintr_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	512(%r9)
	movq	0(%r9), %mm0
	movq	8(%r9), %mm1
	movq	16(%r9), %mm2
	movq	24(%r9), %mm3
	prefetcht0	512(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	0(%r8), %mm0
	paddusw	8(%r8), %mm1
	paddusw	16(%r8), %mm2
	paddusw	24(%r8), %mm3
	movntq	%mm0, 0(%r10)
	movntq	%mm1, 8(%r10)
	movntq	%mm2, 16(%r10)
	movntq	%mm3, 24(%r10)
	prefetcht0	576(%r9)
	movq	32(%r9), %mm0
	movq	40(%r9), %mm1
	movq	48(%r9), %mm2
	movq	56(%r9), %mm3
	prefetcht0	576(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	32(%r8), %mm0
	paddusw	40(%r8), %mm1
	paddusw	48(%r8), %mm2
	paddusw	56(%r8), %mm3
	movntq	%mm0, 32(%r10)
	movntq	%mm1, 40(%r10)
	movntq	%mm2, 48(%r10)
	movntq	%mm3, 56(%r10)
	prefetcht0	640(%r9)
	movq	64(%r9), %mm0
	movq	72(%r9), %mm1
	movq	80(%r9), %mm2
	movq	88(%r9), %mm3
	prefetcht0	640(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	64(%r8), %mm0
	paddusw	72(%r8), %mm1
	paddusw	80(%r8), %mm2
	paddusw	88(%r8), %mm3
	movntq	%mm0, 64(%r10)
	movntq	%mm1, 72(%r10)
	movntq	%mm2, 80(%r10)
	movntq	%mm3, 88(%r10)
	prefetcht0	704(%r9)
	movq	96(%r9), %mm0
	movq	104(%r9), %mm1
	movq	112(%r9), %mm2
	movq	120(%r9), %mm3
	prefetcht0	704(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	96(%r8), %mm0
	paddusw	104(%r8), %mm1
	paddusw	112(%r8), %mm2
	paddusw	120(%r8), %mm3
	movntq	%mm0, 96(%r10)
	movntq	%mm1, 104(%r10)
	movntq	%mm2, 112(%r10)
	movntq	%mm3, 120(%r10)
	prefetcht0	768(%r9)
	movq	128(%r9), %mm0
	movq	136(%r9), %mm1
	movq	144(%r9), %mm2
	movq	152(%r9), %mm3
	prefetcht0	768(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	128(%r8), %mm0
	paddusw	136(%r8), %mm1
	paddusw	144(%r8), %mm2
	paddusw	152(%r8), %mm3
	movntq	%mm0, 128(%r10)
	movntq	%mm1, 136(%r10)
	movntq	%mm2, 144(%r10)
	movntq	%mm3, 152(%r10)
	prefetcht0	832(%r9)
	movq	160(%r9), %mm0
	movq	168(%r9), %mm1
	movq	176(%r9), %mm2
	movq	184(%r9), %mm3
	prefetcht0	832(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	160(%r8), %mm0
	paddusw	168(%r8), %mm1
	paddusw	176(%r8), %mm2
	paddusw	184(%r8), %mm3
	movntq	%mm0, 160(%r10)
	movntq	%mm1, 168(%r10)
	movntq	%mm2, 176(%r10)
	movntq	%mm3, 184(%r10)
	prefetcht0	896(%r9)
	movq	192(%r9), %mm0
	movq	200(%r9), %mm1
	movq	208(%r9), %mm2
	movq	216(%r9), %mm3
	prefetcht0	896(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	192(%r8), %mm0
	paddusw	200(%r8), %mm1
	paddusw	208(%r8), %mm2
	paddusw	216(%r8), %mm3
	movntq	%mm0, 192(%r10)
	movntq	%mm1, 200(%r10)
	movntq	%mm2, 208(%r10)
	movntq	%mm3, 216(%r10)
	prefetcht0	960(%r9)
	movq	224(%r9), %mm0
	movq	232(%r9), %mm1
	movq	240(%r9), %mm2
	movq	248(%r9), %mm3
	prefetcht0	960(%r8)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	224(%r8), %mm0
	paddusw	232(%r8), %mm1
	paddusw	240(%r8), %mm2
	paddusw	248(%r8), %mm3
	movntq	%mm0, 224(%r10)
	movntq	%mm1, 232(%r10)
	movntq	%mm2, 240(%r10)
	movntq	%mm3, 248(%r10)
	movq	256(%r9), %mm0
	movq	264(%r9), %mm1
	movq	272(%r9), %mm2
	movq	280(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	256(%r8), %mm0
	paddusw	264(%r8), %mm1
	paddusw	272(%r8), %mm2
	paddusw	280(%r8), %mm3
	movntq	%mm0, 256(%r10)
	movntq	%mm1, 264(%r10)
	movntq	%mm2, 272(%r10)
	movntq	%mm3, 280(%r10)
	movq	288(%r9), %mm0
	movq	296(%r9), %mm1
	movq	304(%r9), %mm2
	movq	312(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	288(%r8), %mm0
	paddusw	296(%r8), %mm1
	paddusw	304(%r8), %mm2
	paddusw	312(%r8), %mm3
	movntq	%mm0, 288(%r10)
	movntq	%mm1, 296(%r10)
	movntq	%mm2, 304(%r10)
	movntq	%mm3, 312(%r10)
	movq	320(%r9), %mm0
	movq	328(%r9), %mm1
	movq	336(%r9), %mm2
	movq	344(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	320(%r8), %mm0
	paddusw	328(%r8), %mm1
	paddusw	336(%r8), %mm2
	paddusw	344(%r8), %mm3
	movntq	%mm0, 320(%r10)
	movntq	%mm1, 328(%r10)
	movntq	%mm2, 336(%r10)
	movntq	%mm3, 344(%r10)
	movq	352(%r9), %mm0
	movq	360(%r9), %mm1
	movq	368(%r9), %mm2
	movq	376(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	352(%r8), %mm0
	paddusw	360(%r8), %mm1
	paddusw	368(%r8), %mm2
	paddusw	376(%r8), %mm3
	movntq	%mm0, 352(%r10)
	movntq	%mm1, 360(%r10)
	movntq	%mm2, 368(%r10)
	movntq	%mm3, 376(%r10)
	movq	384(%r9), %mm0
	movq	392(%r9), %mm1
	movq	400(%r9), %mm2
	movq	408(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	384(%r8), %mm0
	paddusw	392(%r8), %mm1
	paddusw	400(%r8), %mm2
	paddusw	408(%r8), %mm3
	movntq	%mm0, 384(%r10)
	movntq	%mm1, 392(%r10)
	movntq	%mm2, 400(%r10)
	movntq	%mm3, 408(%r10)
	movq	416(%r9), %mm0
	movq	424(%r9), %mm1
	movq	432(%r9), %mm2
	movq	440(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	416(%r8), %mm0
	paddusw	424(%r8), %mm1
	paddusw	432(%r8), %mm2
	paddusw	440(%r8), %mm3
	movntq	%mm0, 416(%r10)
	movntq	%mm1, 424(%r10)
	movntq	%mm2, 432(%r10)
	movntq	%mm3, 440(%r10)
	movq	448(%r9), %mm0
	movq	456(%r9), %mm1
	movq	464(%r9), %mm2
	movq	472(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	448(%r8), %mm0
	paddusw	456(%r8), %mm1
	paddusw	464(%r8), %mm2
	paddusw	472(%r8), %mm3
	movntq	%mm0, 448(%r10)
	movntq	%mm1, 456(%r10)
	movntq	%mm2, 464(%r10)
	movntq	%mm3, 472(%r10)
	movq	480(%r9), %mm0
	movq	488(%r9), %mm1
	movq	496(%r9), %mm2
	movq	504(%r9), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	480(%r8), %mm0
	paddusw	488(%r8), %mm1
	paddusw	496(%r8), %mm2
	paddusw	504(%r8), %mm3
	movntq	%mm0, 480(%r10)
	movntq	%mm1, 488(%r10)
	movntq	%mm2, 496(%r10)
	movntq	%mm3, 504(%r10)
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
	emms
	addq	$80, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret
