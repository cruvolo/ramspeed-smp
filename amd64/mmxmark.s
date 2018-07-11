/*
**  MMXmark benchmarks for RAMspeed (amd64)
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

.globl mmxwr
mmxwr:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r15
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%rax, %r15
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	$512, %rax
	pxor	%mm0, %mm0
.mainwr:
	movq	%mm0, 0(%r8)
	movq	%mm0, 8(%r8)
	movq	%mm0, 16(%r8)
	movq	%mm0, 24(%r8)
	movq	%mm0, 32(%r8)
	movq	%mm0, 40(%r8)
	movq	%mm0, 48(%r8)
	movq	%mm0, 56(%r8)
	movq	%mm0, 64(%r8)
	movq	%mm0, 72(%r8)
	movq	%mm0, 80(%r8)
	movq	%mm0, 88(%r8)
	movq	%mm0, 96(%r8)
	movq	%mm0, 104(%r8)
	movq	%mm0, 112(%r8)
	movq	%mm0, 120(%r8)
	movq	%mm0, 128(%r8)
	movq	%mm0, 136(%r8)
	movq	%mm0, 144(%r8)
	movq	%mm0, 152(%r8)
	movq	%mm0, 160(%r8)
	movq	%mm0, 168(%r8)
	movq	%mm0, 176(%r8)
	movq	%mm0, 184(%r8)
	movq	%mm0, 192(%r8)
	movq	%mm0, 200(%r8)
	movq	%mm0, 208(%r8)
	movq	%mm0, 216(%r8)
	movq	%mm0, 224(%r8)
	movq	%mm0, 232(%r8)
	movq	%mm0, 240(%r8)
	movq	%mm0, 248(%r8)
	movq	%mm0, 256(%r8)
	movq	%mm0, 264(%r8)
	movq	%mm0, 272(%r8)
	movq	%mm0, 280(%r8)
	movq	%mm0, 288(%r8)
	movq	%mm0, 296(%r8)
	movq	%mm0, 304(%r8)
	movq	%mm0, 312(%r8)
	movq	%mm0, 320(%r8)
	movq	%mm0, 328(%r8)
	movq	%mm0, 336(%r8)
	movq	%mm0, 344(%r8)
	movq	%mm0, 352(%r8)
	movq	%mm0, 360(%r8)
	movq	%mm0, 368(%r8)
	movq	%mm0, 376(%r8)
	movq	%mm0, 384(%r8)
	movq	%mm0, 392(%r8)
	movq	%mm0, 400(%r8)
	movq	%mm0, 408(%r8)
	movq	%mm0, 416(%r8)
	movq	%mm0, 424(%r8)
	movq	%mm0, 432(%r8)
	movq	%mm0, 440(%r8)
	movq	%mm0, 448(%r8)
	movq	%mm0, 456(%r8)
	movq	%mm0, 464(%r8)
	movq	%mm0, 472(%r8)
	movq	%mm0, 480(%r8)
	movq	%mm0, 488(%r8)
	movq	%mm0, 496(%r8)
	movq	%mm0, 504(%r8)
	addq	%rax, %r8
	decq	%rcx
	jnz	.mainwr

	movq	%r12, %r8
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainwr

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
	addq	$32, %rsp
	popq	%r15
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxrd
mmxrd:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r15
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%rax, %r15
/* prefill */
	pxor	%mm0, %mm0
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
.prerd:
	movq	%mm0, 0(%r8)
	movq	%mm0, 8(%r8)
	movq	%mm0, 16(%r8)
	movq	%mm0, 24(%r8)
	movq	%mm0, 32(%r8)
	movq	%mm0, 40(%r8)
	movq	%mm0, 48(%r8)
	movq	%mm0, 56(%r8)
	addq	$64, %rax
	loopq	.prerd
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	$512, %rax
.mainrd:
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	movq	32(%r8), %mm4
	movq	40(%r8), %mm5
	movq	48(%r8), %mm6
	movq	56(%r8), %mm7
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	movq	96(%r8), %mm4
	movq	104(%r8), %mm5
	movq	112(%r8), %mm6
	movq	120(%r8), %mm7
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	movq	160(%r8), %mm4
	movq	168(%r8), %mm5
	movq	176(%r8), %mm6
	movq	184(%r8), %mm7
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	movq	224(%r8), %mm4
	movq	232(%r8), %mm5
	movq	240(%r8), %mm6
	movq	248(%r8), %mm7
	movq	256(%r8), %mm0
	movq	264(%r8), %mm1
	movq	272(%r8), %mm2
	movq	280(%r8), %mm3
	movq	288(%r8), %mm4
	movq	296(%r8), %mm5
	movq	304(%r8), %mm6
	movq	312(%r8), %mm7
	movq	320(%r8), %mm0
	movq	328(%r8), %mm1
	movq	336(%r8), %mm2
	movq	344(%r8), %mm3
	movq	352(%r8), %mm4
	movq	360(%r8), %mm5
	movq	368(%r8), %mm6
	movq	376(%r8), %mm7
	movq	384(%r8), %mm0
	movq	392(%r8), %mm1
	movq	400(%r8), %mm2
	movq	408(%r8), %mm3
	movq	416(%r8), %mm4
	movq	424(%r8), %mm5
	movq	432(%r8), %mm6
	movq	440(%r8), %mm7
	movq	448(%r8), %mm0
	movq	456(%r8), %mm1
	movq	464(%r8), %mm2
	movq	472(%r8), %mm3
	movq	480(%r8), %mm4
	movq	488(%r8), %mm5
	movq	496(%r8), %mm6
	movq	504(%r8), %mm7
	addq	%rax, %r8
	decq	%rcx
	jnz	.mainrd

	movq	%r12, %r8
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainrd

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
	addq	$32, %rsp
	popq	%r15
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxwr_nt
mmxwr_nt:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r15
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%rax, %r15
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	$512, %rax
	pxor	%mm0, %mm0
.mainwr_nt:
	movntq	%mm0, 0(%r8)
	movntq	%mm0, 8(%r8)
	movntq	%mm0, 16(%r8)
	movntq	%mm0, 24(%r8)
	movntq	%mm0, 32(%r8)
	movntq	%mm0, 40(%r8)
	movntq	%mm0, 48(%r8)
	movntq	%mm0, 56(%r8)
	movntq	%mm0, 64(%r8)
	movntq	%mm0, 72(%r8)
	movntq	%mm0, 80(%r8)
	movntq	%mm0, 88(%r8)
	movntq	%mm0, 96(%r8)
	movntq	%mm0, 104(%r8)
	movntq	%mm0, 112(%r8)
	movntq	%mm0, 120(%r8)
	movntq	%mm0, 128(%r8)
	movntq	%mm0, 136(%r8)
	movntq	%mm0, 144(%r8)
	movntq	%mm0, 152(%r8)
	movntq	%mm0, 160(%r8)
	movntq	%mm0, 168(%r8)
	movntq	%mm0, 176(%r8)
	movntq	%mm0, 184(%r8)
	movntq	%mm0, 192(%r8)
	movntq	%mm0, 200(%r8)
	movntq	%mm0, 208(%r8)
	movntq	%mm0, 216(%r8)
	movntq	%mm0, 224(%r8)
	movntq	%mm0, 232(%r8)
	movntq	%mm0, 240(%r8)
	movntq	%mm0, 248(%r8)
	movntq	%mm0, 256(%r8)
	movntq	%mm0, 264(%r8)
	movntq	%mm0, 272(%r8)
	movntq	%mm0, 280(%r8)
	movntq	%mm0, 288(%r8)
	movntq	%mm0, 296(%r8)
	movntq	%mm0, 304(%r8)
	movntq	%mm0, 312(%r8)
	movntq	%mm0, 320(%r8)
	movntq	%mm0, 328(%r8)
	movntq	%mm0, 336(%r8)
	movntq	%mm0, 344(%r8)
	movntq	%mm0, 352(%r8)
	movntq	%mm0, 360(%r8)
	movntq	%mm0, 368(%r8)
	movntq	%mm0, 376(%r8)
	movntq	%mm0, 384(%r8)
	movntq	%mm0, 392(%r8)
	movntq	%mm0, 400(%r8)
	movntq	%mm0, 408(%r8)
	movntq	%mm0, 416(%r8)
	movntq	%mm0, 424(%r8)
	movntq	%mm0, 432(%r8)
	movntq	%mm0, 440(%r8)
	movntq	%mm0, 448(%r8)
	movntq	%mm0, 456(%r8)
	movntq	%mm0, 464(%r8)
	movntq	%mm0, 472(%r8)
	movntq	%mm0, 480(%r8)
	movntq	%mm0, 488(%r8)
	movntq	%mm0, 496(%r8)
	movntq	%mm0, 504(%r8)
	addq	%rax, %r8
	decq	%rcx
	jnz	.mainwr_nt

	movq	%r12, %r8
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainwr_nt

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
	addq	$32, %rsp
	popq	%r15
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl mmxrd_nt
mmxrd_nt:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r15
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	shlq	$10, %rbx
	movq	%rsi, %rbp
/* allocate memory; 4Kb page alignment enabled */
	movq	$0x0000000000001000, %r15
	movq	%rbx, %rdi
	addq	%r15, %rdi
	call	malloc
	movq	%rax, %r12
	addq	%r15, %r12
	andq	$0xFFFFFFFFFFFFF000, %r12
	movq	%rax, %r15
/* prefill */
	pxor	%mm0, %mm0
	movq	%rbx, %rcx
	shrq	$6, %rcx
	movq	%r12, %r8
.prerd_nt:
	movq	%mm0, 0(%r8)
	movq	%mm0, 8(%r8)
	movq	%mm0, 16(%r8)
	movq	%mm0, 24(%r8)
	movq	%mm0, 32(%r8)
	movq	%mm0, 40(%r8)
	movq	%mm0, 48(%r8)
	movq	%mm0, 56(%r8)
	addq	$64, %rax
	loopq	.prerd_nt
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	shrq	$9, %rbx
	decq	%rbx
	movq	%rbx, %rcx
	movq	%r12, %r8
	movq	$512, %rax
.mainrd_nt:
/* every loop prefetches the next one */
	prefetchnta	512(%r8)
	prefetchnta	576(%r8)
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	movq	32(%r8), %mm4
	movq	40(%r8), %mm5
	movq	48(%r8), %mm6
	movq	56(%r8), %mm7
	prefetchnta	640(%r8)
	prefetchnta	704(%r8)
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	movq	96(%r8), %mm4
	movq	104(%r8), %mm5
	movq	112(%r8), %mm6
	movq	120(%r8), %mm7
	prefetchnta	768(%r8)
	prefetchnta	832(%r8)
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	movq	160(%r8), %mm4
	movq	168(%r8), %mm5
	movq	176(%r8), %mm6
	movq	184(%r8), %mm7
	prefetchnta	896(%r8)
	prefetchnta	960(%r8)
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	movq	224(%r8), %mm4
	movq	232(%r8), %mm5
	movq	240(%r8), %mm6
	movq	248(%r8), %mm7
	movq	256(%r8), %mm0
	movq	264(%r8), %mm1
	movq	272(%r8), %mm2
	movq	280(%r8), %mm3
	movq	288(%r8), %mm4
	movq	296(%r8), %mm5
	movq	304(%r8), %mm6
	movq	312(%r8), %mm7
	movq	320(%r8), %mm0
	movq	328(%r8), %mm1
	movq	336(%r8), %mm2
	movq	344(%r8), %mm3
	movq	352(%r8), %mm4
	movq	360(%r8), %mm5
	movq	368(%r8), %mm6
	movq	376(%r8), %mm7
	movq	384(%r8), %mm0
	movq	392(%r8), %mm1
	movq	400(%r8), %mm2
	movq	408(%r8), %mm3
	movq	416(%r8), %mm4
	movq	424(%r8), %mm5
	movq	432(%r8), %mm6
	movq	440(%r8), %mm7
	movq	448(%r8), %mm0
	movq	456(%r8), %mm1
	movq	464(%r8), %mm2
	movq	472(%r8), %mm3
	movq	480(%r8), %mm4
	movq	488(%r8), %mm5
	movq	496(%r8), %mm6
	movq	504(%r8), %mm7
	addq	%rax, %r8
	decq	%rcx
	jnz	.mainrd_nt

/* the last loop of the memory block;
 * no more prefetches to avoid hidden page faults */
	movq	0(%r8), %mm0
	movq	8(%r8), %mm1
	movq	16(%r8), %mm2
	movq	24(%r8), %mm3
	movq	32(%r8), %mm4
	movq	40(%r8), %mm5
	movq	48(%r8), %mm6
	movq	56(%r8), %mm7
	movq	64(%r8), %mm0
	movq	72(%r8), %mm1
	movq	80(%r8), %mm2
	movq	88(%r8), %mm3
	movq	96(%r8), %mm4
	movq	104(%r8), %mm5
	movq	112(%r8), %mm6
	movq	120(%r8), %mm7
	movq	128(%r8), %mm0
	movq	136(%r8), %mm1
	movq	144(%r8), %mm2
	movq	152(%r8), %mm3
	movq	160(%r8), %mm4
	movq	168(%r8), %mm5
	movq	176(%r8), %mm6
	movq	184(%r8), %mm7
	movq	192(%r8), %mm0
	movq	200(%r8), %mm1
	movq	208(%r8), %mm2
	movq	216(%r8), %mm3
	movq	224(%r8), %mm4
	movq	232(%r8), %mm5
	movq	240(%r8), %mm6
	movq	248(%r8), %mm7
	movq	256(%r8), %mm0
	movq	264(%r8), %mm1
	movq	272(%r8), %mm2
	movq	280(%r8), %mm3
	movq	288(%r8), %mm4
	movq	296(%r8), %mm5
	movq	304(%r8), %mm6
	movq	312(%r8), %mm7
	movq	320(%r8), %mm0
	movq	328(%r8), %mm1
	movq	336(%r8), %mm2
	movq	344(%r8), %mm3
	movq	352(%r8), %mm4
	movq	360(%r8), %mm5
	movq	368(%r8), %mm6
	movq	376(%r8), %mm7
	movq	384(%r8), %mm0
	movq	392(%r8), %mm1
	movq	400(%r8), %mm2
	movq	408(%r8), %mm3
	movq	416(%r8), %mm4
	movq	424(%r8), %mm5
	movq	432(%r8), %mm6
	movq	440(%r8), %mm7
	movq	448(%r8), %mm0
	movq	456(%r8), %mm1
	movq	464(%r8), %mm2
	movq	472(%r8), %mm3
	movq	480(%r8), %mm4
	movq	488(%r8), %mm5
	movq	496(%r8), %mm6
	movq	504(%r8), %mm7

	movq	%r12, %r8
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainrd_nt

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
	addq	$32, %rsp
	popq	%r15
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret
