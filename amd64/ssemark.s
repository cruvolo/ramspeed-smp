/*
**  SSEmark benchmarks for RAMspeed (amd64)
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

.globl ssewr
ssewr:
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
	xorps	%xmm0, %xmm0
.mainwr:
	movaps	%xmm0, 0(%r8)
	movaps	%xmm0, 16(%r8)
	movaps	%xmm0, 32(%r8)
	movaps	%xmm0, 48(%r8)
	movaps	%xmm0, 64(%r8)
	movaps	%xmm0, 80(%r8)
	movaps	%xmm0, 96(%r8)
	movaps	%xmm0, 112(%r8)
	movaps	%xmm0, 128(%r8)
	movaps	%xmm0, 144(%r8)
	movaps	%xmm0, 160(%r8)
	movaps	%xmm0, 176(%r8)
	movaps	%xmm0, 192(%r8)
	movaps	%xmm0, 208(%r8)
	movaps	%xmm0, 224(%r8)
	movaps	%xmm0, 240(%r8)
	movaps	%xmm0, 256(%r8)
	movaps	%xmm0, 272(%r8)
	movaps	%xmm0, 288(%r8)
	movaps	%xmm0, 304(%r8)
	movaps	%xmm0, 320(%r8)
	movaps	%xmm0, 336(%r8)
	movaps	%xmm0, 352(%r8)
	movaps	%xmm0, 368(%r8)
	movaps	%xmm0, 384(%r8)
	movaps	%xmm0, 400(%r8)
	movaps	%xmm0, 416(%r8)
	movaps	%xmm0, 432(%r8)
	movaps	%xmm0, 448(%r8)
	movaps	%xmm0, 464(%r8)
	movaps	%xmm0, 480(%r8)
	movaps	%xmm0, 496(%r8)
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
	addq	$32, %rsp
	popq	%r15
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl sserd
sserd:
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
	xorps	%xmm0, %xmm0
	movq	%rbx, %rcx
	shrq	$7, %rcx
	movq	%r12, %r8
.prerd:
	movaps	%xmm0, 0(%r8)
	movaps	%xmm0, 16(%r8)
	movaps	%xmm0, 32(%r8)
	movaps	%xmm0, 48(%r8)
	movaps	%xmm0, 64(%r8)
	movaps	%xmm0, 80(%r8)
	movaps	%xmm0, 96(%r8)
	movaps	%xmm0, 112(%r8)
	addq	$128, %rax
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
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	movaps	128(%r8), %xmm8
	movaps	144(%r8), %xmm9
	movaps	160(%r8), %xmm10
	movaps	176(%r8), %xmm11
	movaps	192(%r8), %xmm12
	movaps	208(%r8), %xmm13
	movaps	224(%r8), %xmm14
	movaps	240(%r8), %xmm15
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	movaps	384(%r8), %xmm8
	movaps	400(%r8), %xmm9
	movaps	416(%r8), %xmm10
	movaps	432(%r8), %xmm11
	movaps	448(%r8), %xmm12
	movaps	464(%r8), %xmm13
	movaps	480(%r8), %xmm14
	movaps	496(%r8), %xmm15
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
	addq	$32, %rsp
	popq	%r15
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl ssewr_nt
ssewr_nt:
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
	xorps	%xmm0, %xmm0
.mainwr_nt:
	movntps	%xmm0, 0(%r8)
	movntps	%xmm0, 16(%r8)
	movntps	%xmm0, 32(%r8)
	movntps	%xmm0, 48(%r8)
	movntps	%xmm0, 64(%r8)
	movntps	%xmm0, 80(%r8)
	movntps	%xmm0, 96(%r8)
	movntps	%xmm0, 112(%r8)
	movntps	%xmm0, 128(%r8)
	movntps	%xmm0, 144(%r8)
	movntps	%xmm0, 160(%r8)
	movntps	%xmm0, 176(%r8)
	movntps	%xmm0, 192(%r8)
	movntps	%xmm0, 208(%r8)
	movntps	%xmm0, 224(%r8)
	movntps	%xmm0, 240(%r8)
	movntps	%xmm0, 256(%r8)
	movntps	%xmm0, 272(%r8)
	movntps	%xmm0, 288(%r8)
	movntps	%xmm0, 304(%r8)
	movntps	%xmm0, 320(%r8)
	movntps	%xmm0, 336(%r8)
	movntps	%xmm0, 352(%r8)
	movntps	%xmm0, 368(%r8)
	movntps	%xmm0, 384(%r8)
	movntps	%xmm0, 400(%r8)
	movntps	%xmm0, 416(%r8)
	movntps	%xmm0, 432(%r8)
	movntps	%xmm0, 448(%r8)
	movntps	%xmm0, 464(%r8)
	movntps	%xmm0, 480(%r8)
	movntps	%xmm0, 496(%r8)
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
	addq	$32, %rsp
	popq	%r15
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl sserd_nt
sserd_nt:
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
	xorps	%xmm0, %xmm0
	movq	%rbx, %rcx
	shrq	$7, %rcx
	movq	%r12, %r8
.prerd_nt:
	movntps	%xmm0, 0(%r8)
	movntps	%xmm0, 16(%r8)
	movntps	%xmm0, 32(%r8)
	movntps	%xmm0, 48(%r8)
	movntps	%xmm0, 64(%r8)
	movntps	%xmm0, 80(%r8)
	movntps	%xmm0, 96(%r8)
	movntps	%xmm0, 112(%r8)
	addq	$128, %rax
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
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	prefetchnta	640(%r8)
	prefetchnta	704(%r8)
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	prefetchnta	768(%r8)
	prefetchnta	832(%r8)
	movaps	128(%r8), %xmm8
	movaps	144(%r8), %xmm9
	movaps	160(%r8), %xmm10
	movaps	176(%r8), %xmm11
	prefetchnta	896(%r8)
	prefetchnta	960(%r8)
	movaps	192(%r8), %xmm12
	movaps	208(%r8), %xmm13
	movaps	224(%r8), %xmm14
	movaps	240(%r8), %xmm15
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	movaps	384(%r8), %xmm8
	movaps	400(%r8), %xmm9
	movaps	416(%r8), %xmm10
	movaps	432(%r8), %xmm11
	movaps	448(%r8), %xmm12
	movaps	464(%r8), %xmm13
	movaps	480(%r8), %xmm14
	movaps	496(%r8), %xmm15
	addq	%rax, %r8
	decq	%rcx
	jnz	.mainrd_nt

/* the last loop of the memory block;
 * no more prefetches to avoid hidden page faults */
	movaps	0(%r8), %xmm0
	movaps	16(%r8), %xmm1
	movaps	32(%r8), %xmm2
	movaps	48(%r8), %xmm3
	movaps	64(%r8), %xmm4
	movaps	80(%r8), %xmm5
	movaps	96(%r8), %xmm6
	movaps	112(%r8), %xmm7
	movaps	128(%r8), %xmm8
	movaps	144(%r8), %xmm9
	movaps	160(%r8), %xmm10
	movaps	176(%r8), %xmm11
	movaps	192(%r8), %xmm12
	movaps	208(%r8), %xmm13
	movaps	224(%r8), %xmm14
	movaps	240(%r8), %xmm15
	movaps	256(%r8), %xmm0
	movaps	272(%r8), %xmm1
	movaps	288(%r8), %xmm2
	movaps	304(%r8), %xmm3
	movaps	320(%r8), %xmm4
	movaps	336(%r8), %xmm5
	movaps	352(%r8), %xmm6
	movaps	368(%r8), %xmm7
	movaps	384(%r8), %xmm8
	movaps	400(%r8), %xmm9
	movaps	416(%r8), %xmm10
	movaps	432(%r8), %xmm11
	movaps	448(%r8), %xmm12
	movaps	464(%r8), %xmm13
	movaps	480(%r8), %xmm14
	movaps	496(%r8), %xmm15

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
	addq	$32, %rsp
	popq	%r15
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret
