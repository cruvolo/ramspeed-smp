/*
**  FLOATmark benchmarks for RAMspeed (amd64)
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

.globl floatwr
floatwr:
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
	finit
	fldz
.mainwr:
	fstl	0(%rdi)
	fstl	8(%rdi)
	fstl	16(%rdi)
	fstl	24(%rdi)
	fstl	32(%rdi)
	fstl	40(%rdi)
	fstl	48(%rdi)
	fstl	56(%rdi)
	fstl	64(%rdi)
	fstl	72(%rdi)
	fstl	80(%rdi)
	fstl	88(%rdi)
	fstl	96(%rdi)
	fstl	104(%rdi)
	fstl	112(%rdi)
	fstl	120(%rdi)
	fstl	128(%rdi)
	fstl	136(%rdi)
	fstl	144(%rdi)
	fstl	152(%rdi)
	fstl	160(%rdi)
	fstl	168(%rdi)
	fstl	176(%rdi)
	fstl	184(%rdi)
	fstl	192(%rdi)
	fstl	200(%rdi)
	fstl	208(%rdi)
	fstl	216(%rdi)
	fstl	224(%rdi)
	fstl	232(%rdi)
	fstl	240(%rdi)
	fstl	248(%rdi)
	fstl	256(%rdi)
	fstl	264(%rdi)
	fstl	272(%rdi)
	fstl	280(%rdi)
	fstl	288(%rdi)
	fstl	296(%rdi)
	fstl	304(%rdi)
	fstl	312(%rdi)
	fstl	320(%rdi)
	fstl	328(%rdi)
	fstl	336(%rdi)
	fstl	344(%rdi)
	fstl	352(%rdi)
	fstl	360(%rdi)
	fstl	368(%rdi)
	fstl	376(%rdi)
	fstl	384(%rdi)
	fstl	392(%rdi)
	fstl	400(%rdi)
	fstl	408(%rdi)
	fstl	416(%rdi)
	fstl	424(%rdi)
	fstl	432(%rdi)
	fstl	440(%rdi)
	fstl	448(%rdi)
	fstl	456(%rdi)
	fstl	464(%rdi)
	fstl	472(%rdi)
	fstl	480(%rdi)
	fstl	488(%rdi)
	fstl	496(%rdi)
	fstl	504(%rdi)
	fstl	512(%rdi)
	fstl	520(%rdi)
	fstl	528(%rdi)
	fstl	536(%rdi)
	fstl	544(%rdi)
	fstl	552(%rdi)
	fstl	560(%rdi)
	fstl	568(%rdi)
	fstl	576(%rdi)
	fstl	584(%rdi)
	fstl	592(%rdi)
	fstl	600(%rdi)
	fstl	608(%rdi)
	fstl	616(%rdi)
	fstl	624(%rdi)
	fstl	632(%rdi)
	fstl	640(%rdi)
	fstl	648(%rdi)
	fstl	656(%rdi)
	fstl	664(%rdi)
	fstl	672(%rdi)
	fstl	680(%rdi)
	fstl	688(%rdi)
	fstl	696(%rdi)
	fstl	704(%rdi)
	fstl	712(%rdi)
	fstl	720(%rdi)
	fstl	728(%rdi)
	fstl	736(%rdi)
	fstl	744(%rdi)
	fstl	752(%rdi)
	fstl	760(%rdi)
	fstl	768(%rdi)
	fstl	776(%rdi)
	fstl	784(%rdi)
	fstl	792(%rdi)
	fstl	800(%rdi)
	fstl	808(%rdi)
	fstl	816(%rdi)
	fstl	824(%rdi)
	fstl	832(%rdi)
	fstl	840(%rdi)
	fstl	848(%rdi)
	fstl	856(%rdi)
	fstl	864(%rdi)
	fstl	872(%rdi)
	fstl	880(%rdi)
	fstl	888(%rdi)
	fstl	896(%rdi)
	fstl	904(%rdi)
	fstl	912(%rdi)
	fstl	920(%rdi)
	fstl	928(%rdi)
	fstl	936(%rdi)
	fstl	944(%rdi)
	fstl	952(%rdi)
	fstl	960(%rdi)
	fstl	968(%rdi)
	fstl	976(%rdi)
	fstl	984(%rdi)
	fstl	992(%rdi)
	fstl	1000(%rdi)
	fstl	1008(%rdi)
	fstl	1016(%rdi)
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

.globl floatrd
floatrd:
/* set up the stack frame */
	pushq	%rbx
	pushq	%rbp
	pushq	%r12
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
	finit
	fldz
.prerd:
	fstl	0(%rax)
	fstl	8(%rax)
	fstl	16(%rax)
	fstl	24(%rax)
	addq	$32, %rax
	loopq	.prerd
	ffree	%st(0)
/* wall time (start) */
	leaq	0(%rsp), %rdi
	xorq	%rsi, %rsi
	call	gettimeofday
/* execute */
	movq	%rbx, %rcx
	movq	%r12, %rdi
	movq	$1024, %rax
.mainrd:
	fldl	0(%rdi)
	ffree	%st(0)
	fldl	8(%rdi)
	ffree	%st(0)
	fldl	16(%rdi)
	ffree	%st(0)
	fldl	24(%rdi)
	ffree	%st(0)
	fldl	32(%rdi)
	ffree	%st(0)
	fldl	40(%rdi)
	ffree	%st(0)
	fldl	48(%rdi)
	ffree	%st(0)
	fldl	56(%rdi)
	ffree	%st(0)
	fldl	64(%rdi)
	ffree	%st(0)
	fldl	72(%rdi)
	ffree	%st(0)
	fldl	80(%rdi)
	ffree	%st(0)
	fldl	88(%rdi)
	ffree	%st(0)
	fldl	96(%rdi)
	ffree	%st(0)
	fldl	104(%rdi)
	ffree	%st(0)
	fldl	112(%rdi)
	ffree	%st(0)
	fldl	120(%rdi)
	ffree	%st(0)
	fldl	128(%rdi)
	ffree	%st(0)
	fldl	136(%rdi)
	ffree	%st(0)
	fldl	144(%rdi)
	ffree	%st(0)
	fldl	152(%rdi)
	ffree	%st(0)
	fldl	160(%rdi)
	ffree	%st(0)
	fldl	168(%rdi)
	ffree	%st(0)
	fldl	176(%rdi)
	ffree	%st(0)
	fldl	184(%rdi)
	ffree	%st(0)
	fldl	192(%rdi)
	ffree	%st(0)
	fldl	200(%rdi)
	ffree	%st(0)
	fldl	208(%rdi)
	ffree	%st(0)
	fldl	216(%rdi)
	ffree	%st(0)
	fldl	224(%rdi)
	ffree	%st(0)
	fldl	232(%rdi)
	ffree	%st(0)
	fldl	240(%rdi)
	ffree	%st(0)
	fldl	248(%rdi)
	ffree	%st(0)
	fldl	256(%rdi)
	ffree	%st(0)
	fldl	264(%rdi)
	ffree	%st(0)
	fldl	272(%rdi)
	ffree	%st(0)
	fldl	280(%rdi)
	ffree	%st(0)
	fldl	288(%rdi)
	ffree	%st(0)
	fldl	296(%rdi)
	ffree	%st(0)
	fldl	304(%rdi)
	ffree	%st(0)
	fldl	312(%rdi)
	ffree	%st(0)
	fldl	320(%rdi)
	ffree	%st(0)
	fldl	328(%rdi)
	ffree	%st(0)
	fldl	336(%rdi)
	ffree	%st(0)
	fldl	344(%rdi)
	ffree	%st(0)
	fldl	352(%rdi)
	ffree	%st(0)
	fldl	360(%rdi)
	ffree	%st(0)
	fldl	368(%rdi)
	ffree	%st(0)
	fldl	376(%rdi)
	ffree	%st(0)
	fldl	384(%rdi)
	ffree	%st(0)
	fldl	392(%rdi)
	ffree	%st(0)
	fldl	400(%rdi)
	ffree	%st(0)
	fldl	408(%rdi)
	ffree	%st(0)
	fldl	416(%rdi)
	ffree	%st(0)
	fldl	424(%rdi)
	ffree	%st(0)
	fldl	432(%rdi)
	ffree	%st(0)
	fldl	440(%rdi)
	ffree	%st(0)
	fldl	448(%rdi)
	ffree	%st(0)
	fldl	456(%rdi)
	ffree	%st(0)
	fldl	464(%rdi)
	ffree	%st(0)
	fldl	472(%rdi)
	ffree	%st(0)
	fldl	480(%rdi)
	ffree	%st(0)
	fldl	488(%rdi)
	ffree	%st(0)
	fldl	496(%rdi)
	ffree	%st(0)
	fldl	504(%rdi)
	ffree	%st(0)
	fldl	512(%rdi)
	ffree	%st(0)
	fldl	520(%rdi)
	ffree	%st(0)
	fldl	528(%rdi)
	ffree	%st(0)
	fldl	536(%rdi)
	ffree	%st(0)
	fldl	544(%rdi)
	ffree	%st(0)
	fldl	552(%rdi)
	ffree	%st(0)
	fldl	560(%rdi)
	ffree	%st(0)
	fldl	568(%rdi)
	ffree	%st(0)
	fldl	576(%rdi)
	ffree	%st(0)
	fldl	584(%rdi)
	ffree	%st(0)
	fldl	592(%rdi)
	ffree	%st(0)
	fldl	600(%rdi)
	ffree	%st(0)
	fldl	608(%rdi)
	ffree	%st(0)
	fldl	616(%rdi)
	ffree	%st(0)
	fldl	624(%rdi)
	ffree	%st(0)
	fldl	632(%rdi)
	ffree	%st(0)
	fldl	640(%rdi)
	ffree	%st(0)
	fldl	648(%rdi)
	ffree	%st(0)
	fldl	656(%rdi)
	ffree	%st(0)
	fldl	664(%rdi)
	ffree	%st(0)
	fldl	672(%rdi)
	ffree	%st(0)
	fldl	680(%rdi)
	ffree	%st(0)
	fldl	688(%rdi)
	ffree	%st(0)
	fldl	696(%rdi)
	ffree	%st(0)
	fldl	704(%rdi)
	ffree	%st(0)
	fldl	712(%rdi)
	ffree	%st(0)
	fldl	720(%rdi)
	ffree	%st(0)
	fldl	728(%rdi)
	ffree	%st(0)
	fldl	736(%rdi)
	ffree	%st(0)
	fldl	744(%rdi)
	ffree	%st(0)
	fldl	752(%rdi)
	ffree	%st(0)
	fldl	760(%rdi)
	ffree	%st(0)
	fldl	768(%rdi)
	ffree	%st(0)
	fldl	776(%rdi)
	ffree	%st(0)
	fldl	784(%rdi)
	ffree	%st(0)
	fldl	792(%rdi)
	ffree	%st(0)
	fldl	800(%rdi)
	ffree	%st(0)
	fldl	808(%rdi)
	ffree	%st(0)
	fldl	816(%rdi)
	ffree	%st(0)
	fldl	824(%rdi)
	ffree	%st(0)
	fldl	832(%rdi)
	ffree	%st(0)
	fldl	840(%rdi)
	ffree	%st(0)
	fldl	848(%rdi)
	ffree	%st(0)
	fldl	856(%rdi)
	ffree	%st(0)
	fldl	864(%rdi)
	ffree	%st(0)
	fldl	872(%rdi)
	ffree	%st(0)
	fldl	880(%rdi)
	ffree	%st(0)
	fldl	888(%rdi)
	ffree	%st(0)
	fldl	896(%rdi)
	ffree	%st(0)
	fldl	904(%rdi)
	ffree	%st(0)
	fldl	912(%rdi)
	ffree	%st(0)
	fldl	920(%rdi)
	ffree	%st(0)
	fldl	928(%rdi)
	ffree	%st(0)
	fldl	936(%rdi)
	ffree	%st(0)
	fldl	944(%rdi)
	ffree	%st(0)
	fldl	952(%rdi)
	ffree	%st(0)
	fldl	960(%rdi)
	ffree	%st(0)
	fldl	968(%rdi)
	ffree	%st(0)
	fldl	976(%rdi)
	ffree	%st(0)
	fldl	984(%rdi)
	ffree	%st(0)
	fldl	992(%rdi)
	ffree	%st(0)
	fldl	1000(%rdi)
	ffree	%st(0)
	fldl	1008(%rdi)
	ffree	%st(0)
	fldl	1016(%rdi)
	ffree	%st(0)
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
	popq	%r12
	popq	%rbp
	popq	%rbx
	ret
