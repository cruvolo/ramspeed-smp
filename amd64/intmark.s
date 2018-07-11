/*
**  INTmark benchmarks for RAMspeed (amd64)
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

.globl intwr
intwr:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	subq	$32, %rsp
/* process the parameters */
	movq	%rdi, %rbx
	movq	%rsi, %rbp
/* allocate */
	shlq	$10, %rdi
	call	malloc
	movq	%rax, %r12
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	$1024, %rax
	xorq	%rdx, %rdx
.mainwr:
	movq	%rdx, 0(%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rdx, 16(%rdi)
	movq	%rdx, 24(%rdi)
	movq	%rdx, 32(%rdi)
	movq	%rdx, 40(%rdi)
	movq	%rdx, 48(%rdi)
	movq	%rdx, 56(%rdi)
	movq	%rdx, 64(%rdi)
	movq	%rdx, 72(%rdi)
	movq	%rdx, 80(%rdi)
	movq	%rdx, 88(%rdi)
	movq	%rdx, 96(%rdi)
	movq	%rdx, 104(%rdi)
	movq	%rdx, 112(%rdi)
	movq	%rdx, 120(%rdi)
	movq	%rdx, 128(%rdi)
	movq	%rdx, 136(%rdi)
	movq	%rdx, 144(%rdi)
	movq	%rdx, 152(%rdi)
	movq	%rdx, 160(%rdi)
	movq	%rdx, 168(%rdi)
	movq	%rdx, 176(%rdi)
	movq	%rdx, 184(%rdi)
	movq	%rdx, 192(%rdi)
	movq	%rdx, 200(%rdi)
	movq	%rdx, 208(%rdi)
	movq	%rdx, 216(%rdi)
	movq	%rdx, 224(%rdi)
	movq	%rdx, 232(%rdi)
	movq	%rdx, 240(%rdi)
	movq	%rdx, 248(%rdi)
	movq	%rdx, 256(%rdi)
	movq	%rdx, 264(%rdi)
	movq	%rdx, 272(%rdi)
	movq	%rdx, 280(%rdi)
	movq	%rdx, 288(%rdi)
	movq	%rdx, 296(%rdi)
	movq	%rdx, 304(%rdi)
	movq	%rdx, 312(%rdi)
	movq	%rdx, 320(%rdi)
	movq	%rdx, 328(%rdi)
	movq	%rdx, 336(%rdi)
	movq	%rdx, 344(%rdi)
	movq	%rdx, 352(%rdi)
	movq	%rdx, 360(%rdi)
	movq	%rdx, 368(%rdi)
	movq	%rdx, 376(%rdi)
	movq	%rdx, 384(%rdi)
	movq	%rdx, 392(%rdi)
	movq	%rdx, 400(%rdi)
	movq	%rdx, 408(%rdi)
	movq	%rdx, 416(%rdi)
	movq	%rdx, 424(%rdi)
	movq	%rdx, 432(%rdi)
	movq	%rdx, 440(%rdi)
	movq	%rdx, 448(%rdi)
	movq	%rdx, 456(%rdi)
	movq	%rdx, 464(%rdi)
	movq	%rdx, 472(%rdi)
	movq	%rdx, 480(%rdi)
	movq	%rdx, 488(%rdi)
	movq	%rdx, 496(%rdi)
	movq	%rdx, 504(%rdi)
	movq	%rdx, 512(%rdi)
	movq	%rdx, 520(%rdi)
	movq	%rdx, 528(%rdi)
	movq	%rdx, 536(%rdi)
	movq	%rdx, 544(%rdi)
	movq	%rdx, 552(%rdi)
	movq	%rdx, 560(%rdi)
	movq	%rdx, 568(%rdi)
	movq	%rdx, 576(%rdi)
	movq	%rdx, 584(%rdi)
	movq	%rdx, 592(%rdi)
	movq	%rdx, 600(%rdi)
	movq	%rdx, 608(%rdi)
	movq	%rdx, 616(%rdi)
	movq	%rdx, 624(%rdi)
	movq	%rdx, 632(%rdi)
	movq	%rdx, 640(%rdi)
	movq	%rdx, 648(%rdi)
	movq	%rdx, 656(%rdi)
	movq	%rdx, 664(%rdi)
	movq	%rdx, 672(%rdi)
	movq	%rdx, 680(%rdi)
	movq	%rdx, 688(%rdi)
	movq	%rdx, 696(%rdi)
	movq	%rdx, 704(%rdi)
	movq	%rdx, 712(%rdi)
	movq	%rdx, 720(%rdi)
	movq	%rdx, 728(%rdi)
	movq	%rdx, 736(%rdi)
	movq	%rdx, 744(%rdi)
	movq	%rdx, 752(%rdi)
	movq	%rdx, 760(%rdi)
	movq	%rdx, 768(%rdi)
	movq	%rdx, 776(%rdi)
	movq	%rdx, 784(%rdi)
	movq	%rdx, 792(%rdi)
	movq	%rdx, 800(%rdi)
	movq	%rdx, 808(%rdi)
	movq	%rdx, 816(%rdi)
	movq	%rdx, 824(%rdi)
	movq	%rdx, 832(%rdi)
	movq	%rdx, 840(%rdi)
	movq	%rdx, 848(%rdi)
	movq	%rdx, 856(%rdi)
	movq	%rdx, 864(%rdi)
	movq	%rdx, 872(%rdi)
	movq	%rdx, 880(%rdi)
	movq	%rdx, 888(%rdi)
	movq	%rdx, 896(%rdi)
	movq	%rdx, 904(%rdi)
	movq	%rdx, 912(%rdi)
	movq	%rdx, 920(%rdi)
	movq	%rdx, 928(%rdi)
	movq	%rdx, 936(%rdi)
	movq	%rdx, 944(%rdi)
	movq	%rdx, 952(%rdi)
	movq	%rdx, 960(%rdi)
	movq	%rdx, 968(%rdi)
	movq	%rdx, 976(%rdi)
	movq	%rdx, 984(%rdi)
	movq	%rdx, 992(%rdi)
	movq	%rdx, 1000(%rdi)
	movq	%rdx, 1008(%rdi)
	movq	%rdx, 1016(%rdi)
	addq	%rax, %rdi
	decq	%rcx
	jnz	.mainwr

	movq	%r12, %rdi
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainwr

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
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
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret

.globl intrd
intrd:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
	pushq	%r13
	pushq	%r14
	subq	$32, %rsp
/* save the parameters */
	movq	%rdi, %rbx
	movq	%rsi, %rbp
/* allocate */
	shlq	$10, %rdi
	call	malloc
	movq	%rax, %r12
/* prefill */
	movq	%rbx, %rcx
	shlq	$5, %rcx
	xorq	%rdx, %rdx
.prerd:
	movq	%rdx, 0(%rax)
	movq	%rdx, 8(%rax)
	movq	%rdx, 16(%rax)
	movq	%rdx, 24(%rax)
	addq	$32, %rax
	loopq	.prerd
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	$1024, %rax
.mainrd:
	movq	0(%rdi), %rdx
	movq	8(%rdi), %rsi
	movq	16(%rdi), %r8
	movq	24(%rdi), %r9
	movq	32(%rdi), %r10
	movq	40(%rdi), %r11
	movq	48(%rdi), %r13
	movq	56(%rdi), %r14
	movq	64(%rdi), %rdx
	movq	72(%rdi), %rsi
	movq	80(%rdi), %r8
	movq	88(%rdi), %r9
	movq	96(%rdi), %r10
	movq	104(%rdi), %r11
	movq	112(%rdi), %r13
	movq	120(%rdi), %r14
	movq	128(%rdi), %rdx
	movq	136(%rdi), %rsi
	movq	144(%rdi), %r8
	movq	152(%rdi), %r9
	movq	160(%rdi), %r10
	movq	168(%rdi), %r11
	movq	176(%rdi), %r13
	movq	184(%rdi), %r14
	movq	192(%rdi), %rdx
	movq	200(%rdi), %rsi
	movq	208(%rdi), %r8
	movq	216(%rdi), %r9
	movq	224(%rdi), %r10
	movq	232(%rdi), %r11
	movq	240(%rdi), %r13
	movq	248(%rdi), %r14
	movq	256(%rdi), %rdx
	movq	264(%rdi), %rsi
	movq	272(%rdi), %r8
	movq	280(%rdi), %r9
	movq	288(%rdi), %r10
	movq	296(%rdi), %r11
	movq	304(%rdi), %r13
	movq	312(%rdi), %r14
	movq	320(%rdi), %rdx
	movq	328(%rdi), %rsi
	movq	336(%rdi), %r8
	movq	344(%rdi), %r9
	movq	352(%rdi), %r10
	movq	360(%rdi), %r11
	movq	368(%rdi), %r13
	movq	376(%rdi), %r14
	movq	384(%rdi), %rdx
	movq	392(%rdi), %rsi
	movq	400(%rdi), %r8
	movq	408(%rdi), %r9
	movq	416(%rdi), %r10
	movq	424(%rdi), %r11
	movq	432(%rdi), %r13
	movq	440(%rdi), %r14
	movq	448(%rdi), %rdx
	movq	456(%rdi), %rsi
	movq	464(%rdi), %r8
	movq	472(%rdi), %r9
	movq	480(%rdi), %r10
	movq	488(%rdi), %r11
	movq	496(%rdi), %r13
	movq	504(%rdi), %r14
	movq	512(%rdi), %rdx
	movq	520(%rdi), %rsi
	movq	528(%rdi), %r8
	movq	536(%rdi), %r9
	movq	544(%rdi), %r10
	movq	552(%rdi), %r11
	movq	560(%rdi), %r13
	movq	568(%rdi), %r14
	movq	576(%rdi), %rdx
	movq	584(%rdi), %rsi
	movq	592(%rdi), %r8
	movq	600(%rdi), %r9
	movq	608(%rdi), %r10
	movq	616(%rdi), %r11
	movq	624(%rdi), %r13
	movq	632(%rdi), %r14
	movq	640(%rdi), %rdx
	movq	648(%rdi), %rsi
	movq	656(%rdi), %r8
	movq	664(%rdi), %r9
	movq	672(%rdi), %r10
	movq	680(%rdi), %r11
	movq	688(%rdi), %r13
	movq	696(%rdi), %r14
	movq	704(%rdi), %rdx
	movq	712(%rdi), %rsi
	movq	720(%rdi), %r8
	movq	728(%rdi), %r9
	movq	736(%rdi), %r10
	movq	744(%rdi), %r11
	movq	752(%rdi), %r13
	movq	760(%rdi), %r14
	movq	768(%rdi), %rdx
	movq	776(%rdi), %rsi
	movq	784(%rdi), %r8
	movq	792(%rdi), %r9
	movq	800(%rdi), %r10
	movq	808(%rdi), %r11
	movq	816(%rdi), %r13
	movq	824(%rdi), %r14
	movq	832(%rdi), %rdx
	movq	840(%rdi), %rsi
	movq	848(%rdi), %r8
	movq	856(%rdi), %r9
	movq	864(%rdi), %r10
	movq	872(%rdi), %r11
	movq	880(%rdi), %r13
	movq	888(%rdi), %r14
	movq	896(%rdi), %rdx
	movq	904(%rdi), %rsi
	movq	912(%rdi), %r8
	movq	920(%rdi), %r9
	movq	928(%rdi), %r10
	movq	936(%rdi), %r11
	movq	944(%rdi), %r13
	movq	952(%rdi), %r14
	movq	960(%rdi), %rdx
	movq	968(%rdi), %rsi
	movq	976(%rdi), %r8
	movq	984(%rdi), %r9
	movq	992(%rdi), %r10
	movq	1000(%rdi), %r11
	movq	1008(%rdi), %r13
	movq	1016(%rdi), %r14
	addq	%rax, %rdi
	decq	%rcx
	jnz	.mainrd

	movq	%r12, %rdi
	movq	%rbx, %rcx
	decq	%rbp
	jnz	.mainrd

/* wall time (finish) */
	leaq	16(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
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
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret
