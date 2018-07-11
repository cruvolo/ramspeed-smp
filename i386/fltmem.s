/*
**  FLOATmem benchmarks for RAMspeed (i386)
**
**  (UNIX release)
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2004-05 Rhett M. Hollander <rhett@alasir.com>
**
**  All rights reserved.
**
*/

.globl  floatcp
floatcp:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate */
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, 0(%esp)
	call	malloc
	movl	%eax, %esi
/* allocate */
	call	malloc
	movl	%eax, %edi
/* prefill */
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	finit
	fldpi
.precp:
	fstl	0(%edx)
	fstl	8(%edx)
	fstl	16(%edx)
	fstl	24(%edx)
	addl	$32, %edx
	loopl	.precp
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$8, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.maincp:
	fldl	0(%esi)
	fldl	8(%esi)
	fldl	16(%esi)
	fldl	24(%esi)
	fstpl	24(%edi)
	fstpl	16(%edi)
	fstpl	8(%edi)
	fstpl	0(%edi)
	fldl	32(%esi)
	fldl	40(%esi)
	fldl	48(%esi)
	fldl	56(%esi)
	fstpl	56(%edi)
	fstpl	48(%edi)
	fstpl	40(%edi)
	fstpl	32(%edi)
	fldl	64(%esi)
	fldl	72(%esi)
	fldl	80(%esi)
	fldl	88(%esi)
	fstpl	88(%edi)
	fstpl	80(%edi)
	fstpl	72(%edi)
	fstpl	64(%edi)	
	fldl	96(%esi)
	fldl	104(%esi)
	fldl	112(%esi)
	fldl	120(%esi)
	fstpl	120(%edi)
	fstpl	112(%edi)
	fstpl	104(%edi)
	fstpl	96(%edi)
	fldl	128(%esi)
	fldl	136(%esi)
	fldl	144(%esi)
	fldl	152(%esi)
	fstpl	152(%edi)
	fstpl	144(%edi)
	fstpl	136(%edi)
	fstpl	128(%edi)
	fldl	160(%esi)
	fldl	168(%esi)
	fldl	176(%esi)
	fldl	184(%esi)
	fstpl	184(%edi)
	fstpl	176(%edi)
	fstpl	168(%edi)
	fstpl	160(%edi)
	fldl	192(%esi)
	fldl	200(%esi)
	fldl	208(%esi)
	fldl	216(%esi)
	fstpl	216(%edi)
	fstpl	208(%edi)
	fstpl	200(%edi)
	fstpl	192(%edi)
	fldl	224(%esi)
	fldl	232(%esi)
	fldl	240(%esi)
	fldl	248(%esi)
	fstpl	248(%edi)
	fstpl	240(%edi)
	fstpl	232(%edi)
	fstpl	224(%edi)
	addl	$256, %esi
	addl	$256, %edi
	decl	%ebx
	jnz	.maincp

	movl	%ecx, %ebx
	movl	%edx, %esi
	movl	%ebp, %edi
	decl	%eax
	jnz	.maincp

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free */
	movl	%edi, 0(%esp)
	call	free
/* free */
	movl	%esi, 0(%esp)
	call	free
/* calculate */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  floatsc
floatsc:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate */
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, 0(%esp)
	call	malloc
	movl	%eax, %esi
/* allocate */
	call	malloc
	movl	%eax, %edi
/* prefill */
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	finit
	fldpi
.presc:
	fstl	0(%edx)
	fstl	8(%edx)
	fstl	16(%edx)
	fstl	24(%edx)
	addl	$32, %edx
	loopl	.presc
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$8, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
	fldln2
.mainsc:
	fldl	0(%esi)
	fmul	%st(1), %st(0)
	fldl	8(%esi)
	fmul	%st(2), %st(0)
	fldl	16(%esi)
	fmul	%st(3), %st(0)
	fldl	24(%esi)
	fmul	%st(4), %st(0)
	fstpl	24(%edi)
	fstpl	16(%edi)
	fstpl	8(%edi)
	fstpl	0(%edi)
	fldl	32(%esi)
	fmul	%st(1), %st(0)
	fldl	40(%esi)
	fmul	%st(2), %st(0)
	fldl	48(%esi)
	fmul	%st(3), %st(0)
	fldl	56(%esi)
	fmul	%st(4), %st(0)
	fstpl	56(%edi)
	fstpl	48(%edi)
	fstpl	40(%edi)
	fstpl	32(%edi)
	fldl	64(%esi)
	fmul	%st(1), %st(0)
	fldl	72(%esi)
	fmul	%st(2), %st(0)
	fldl	80(%esi)
	fmul	%st(3), %st(0)
	fldl	88(%esi)
	fmul	%st(4), %st(0)
	fstpl	88(%edi)
	fstpl	80(%edi)
	fstpl	72(%edi)
	fstpl	64(%edi)
	fldl	96(%esi)
	fmul	%st(1), %st(0)
	fldl	104(%esi)
	fmul	%st(2), %st(0)
	fldl	112(%esi)
	fmul	%st(3), %st(0)
	fldl	120(%esi)
	fmul	%st(4), %st(0)
	fstpl	120(%edi)
	fstpl	112(%edi)
	fstpl	104(%edi)
	fstpl	96(%edi)
	fldl	128(%esi)
	fmul	%st(1), %st(0)
	fldl	136(%esi)
	fmul	%st(2), %st(0)
	fldl	144(%esi)
	fmul	%st(3), %st(0)
	fldl	152(%esi)
	fmul	%st(4), %st(0)
	fstpl	152(%edi)
	fstpl	144(%edi)
	fstpl	136(%edi)
	fstpl	128(%edi)
	fldl	160(%esi)
	fmul	%st(1), %st(0)
	fldl	168(%esi)
	fmul	%st(2), %st(0)
	fldl	176(%esi)
	fmul	%st(3), %st(0)
	fldl	184(%esi)
	fmul	%st(4), %st(0)
	fstpl	184(%edi)
	fstpl	176(%edi)
	fstpl	168(%edi)
	fstpl	160(%edi)
	fldl	192(%esi)
	fmul	%st(1), %st(0)
	fldl	200(%esi)
	fmul	%st(2), %st(0)
	fldl	208(%esi)
	fmul	%st(3), %st(0)
	fldl	216(%esi)
	fmul	%st(4), %st(0)
	fstpl	216(%edi)
	fstpl	208(%edi)
	fstpl	200(%edi)
	fstpl	192(%edi)
	fldl	224(%esi)
	fmul	%st(1), %st(0)
	fldl	232(%esi)
	fmul	%st(2), %st(0)
	fldl	240(%esi)
	fmul	%st(3), %st(0)
	fldl	248(%esi)
	fmul	%st(4), %st(0)
	fstpl	248(%edi)
	fstpl	240(%edi)
	fstpl	232(%edi)
	fstpl	224(%edi)
	addl	$256, %esi
	addl	$256, %edi
	decl	%ebx
	jnz	.mainsc

	movl	%ecx, %ebx
	movl	%edx, %esi
	movl	%ebp, %edi
	decl	%eax
	jnz	.mainsc

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free */
	movl	%edi, 0(%esp)
	call	free
/* free */
	movl	%esi, 0(%esp)
	call	free
/* calculate */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  floatad
floatad:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate */
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, 0(%esp)
	call	malloc
	movl	%eax, %esi
/* allocate */
	call	malloc
	movl	%eax, %ebp
/* allocate */
	call	malloc
	movl	%eax, %edi
/* prefill */
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
	finit
	fldpi
.pread:
	fstl	0(%edx)
	fstl	8(%edx)
	fstl	16(%edx)
	fstl	24(%edx)
	fstl	0(%eax)
	fstl	8(%eax)
	fstl	16(%eax)
	fstl	24(%eax)
	addl	$32, %edx
	addl	$32, %eax
	loopl	.pread
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$8, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$256, %edx
.mainad:
	fldl	0(%esi)
	faddl	0(%ebp)
	fldl	8(%esi)
	faddl	8(%ebp)
	fldl	16(%esi)
	faddl	16(%ebp)
	fldl	24(%esi)
	faddl	24(%ebp)
	fstpl	24(%edi)
	fstpl	16(%edi)
	fstpl	8(%edi)
	fstpl	0(%edi)
	fldl	32(%esi)
	faddl	32(%ebp)
	fldl	40(%esi)
	faddl	40(%ebp)
	fldl	48(%esi)
	faddl	48(%ebp)
	fldl	56(%esi)
	faddl	56(%ebp)
	fstpl	56(%edi)
	fstpl	48(%edi)
	fstpl	40(%edi)
	fstpl	32(%edi)
	fldl	64(%esi)
	faddl	64(%ebp)
	fldl	72(%esi)
	faddl	72(%ebp)
	fldl	80(%esi)
	faddl	80(%ebp)
	fldl	88(%esi)
	faddl	88(%ebp)
	fstpl	88(%edi)
	fstpl	80(%edi)
	fstpl	72(%edi)
	fstpl	64(%edi)
	fldl	96(%esi)
	faddl	96(%ebp)
	fldl	104(%esi)
	faddl	104(%ebp)
	fldl	112(%esi)
	faddl	112(%ebp)
	fldl	120(%esi)
	faddl	120(%ebp)
	fstpl	120(%edi)
	fstpl	112(%edi)
	fstpl	104(%edi)
	fstpl	96(%edi)
	fldl	128(%esi)
	faddl	128(%ebp)
	fldl	136(%esi)
	faddl	136(%ebp)
	fldl	144(%esi)
	faddl	144(%ebp)
	fldl	152(%esi)
	faddl	152(%ebp)
	fstpl	152(%edi)
	fstpl	144(%edi)
	fstpl	136(%edi)
	fstpl	128(%edi)
	fldl	160(%esi)
	faddl	160(%ebp)
	fldl	168(%esi)
	faddl	168(%ebp)
	fldl	176(%esi)
	faddl	176(%ebp)
	fldl	184(%esi)
	faddl	184(%ebp)
	fstpl	184(%edi)
	fstpl	176(%edi)
	fstpl	168(%edi)
	fstpl	160(%edi)
	fldl	192(%esi)
	faddl	192(%ebp)
	fldl	200(%esi)
	faddl	200(%ebp)
	fldl	208(%esi)
	faddl	208(%ebp)
	fldl	216(%esi)
	faddl	216(%ebp)
	fstpl	216(%edi)
	fstpl	208(%edi)
	fstpl	200(%edi)
	fstpl	192(%edi)
	fldl	224(%esi)
	faddl	224(%ebp)
	fldl	232(%esi)
	faddl	232(%ebp)
	fldl	240(%esi)
	faddl	240(%ebp)
	fldl	248(%esi)
	faddl	248(%ebp)
	fstpl	248(%edi)
	fstpl	240(%edi)
	fstpl	232(%edi)
	fstpl	224(%edi)
	addl	%edx, %esi
	addl	%edx, %ebp
	addl	%edx, %edi
	decl	%ebx
	jnz	.mainad

	movl	%ecx, %ebx
	movl	8(%esp), %esi
	movl	12(%esp), %ebp
	movl	16(%esp), %edi
	decl	%eax
	jnz	.mainad

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free */
	movl	%edi, 0(%esp)
	call	free
/* free */
	movl	%ebp, 0(%esp)
	call	free
/* free */
	movl	%esi, 0(%esp)
	call	free
/* calculate */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  floattr
floattr:
/* set up the stack */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate */
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, 0(%esp)
	call	malloc
	movl	%eax, %esi
/* allocate */
	call	malloc
	movl	%eax, %ebp
/* allocate */
	call	malloc
	movl	%eax, %edi
/* prefill */
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
	finit
	fldpi
.pretr:
	fstl	0(%edx)
	fstl	8(%edx)
	fstl	16(%edx)
	fstl	24(%edx)
	fstl	0(%eax)
	fstl	8(%eax)
	fstl	16(%eax)
	fstl	24(%eax)
	addl	$32, %edx
	addl	$32, %eax
	loopl	.pretr
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$8, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$256, %edx
	fldln2
.maintr:
	fldl	0(%ebp)
	fmul	%st(1), %st(0)
	faddl	0(%esi)
	fldl	8(%ebp)
	fmul	%st(2), %st(0)
	faddl	8(%esi)
	fldl	16(%ebp)
	fmul	%st(3), %st(0)
	faddl	16(%esi)
	fldl	24(%ebp)
	fmul	%st(4), %st(0)
	faddl	24(%esi)
	fstpl	24(%edi)
	fstpl	16(%edi)
	fstpl	8(%edi)
	fstpl	0(%edi)
	fldl	32(%ebp)
	fmul	%st(1), %st(0)
	faddl	32(%esi)
	fldl	40(%ebp)
	fmul	%st(2), %st(0)
	faddl	40(%esi)
	fldl	48(%ebp)
	fmul	%st(3), %st(0)
	faddl	48(%esi)
	fldl	56(%ebp)
	fmul	%st(4), %st(0)
	faddl	56(%esi)
	fstpl	56(%edi)
	fstpl	48(%edi)
	fstpl	40(%edi)
	fstpl	32(%edi)
	fldl	64(%ebp)
	fmul	%st(1), %st(0)
	faddl	64(%esi)
	fldl	72(%ebp)
	fmul	%st(2), %st(0)
	faddl	72(%esi)
	fldl	80(%ebp)
	fmul	%st(3), %st(0)
	faddl	80(%esi)
	fldl	88(%ebp)
	fmul	%st(4), %st(0)
	faddl	88(%esi)
	fstpl	88(%edi)
	fstpl	80(%edi)
	fstpl	72(%edi)
	fstpl	64(%edi)
	fldl	96(%ebp)
	fmul	%st(1), %st(0)
	faddl	96(%esi)
	fldl	104(%ebp)
	fmul	%st(2), %st(0)
	faddl	104(%esi)
	fldl	112(%ebp)
	fmul	%st(3), %st(0)
	faddl	112(%esi)
	fldl	120(%ebp)
	fmul	%st(4), %st(0)
	faddl	120(%esi)
	fstpl	120(%edi)
	fstpl	112(%edi)
	fstpl	104(%edi)
	fstpl	96(%edi)
	fldl	128(%ebp)
	fmul	%st(1), %st(0)
	faddl	128(%esi)
	fldl	136(%ebp)
	fmul	%st(2), %st(0)
	faddl	136(%esi)
	fldl	144(%ebp)
	fmul	%st(3), %st(0)
	faddl	144(%esi)
	fldl	152(%ebp)
	fmul	%st(4), %st(0)
	faddl	152(%esi)
	fstpl	152(%edi)
	fstpl	144(%edi)
	fstpl	136(%edi)
	fstpl	128(%edi)
	fldl	160(%ebp)
	fmul	%st(1), %st(0)
	faddl	160(%esi)
	fldl	168(%ebp)
	fmul	%st(2), %st(0)
	faddl	168(%esi)
	fldl	176(%ebp)
	fmul	%st(3), %st(0)
	faddl	176(%esi)
	fldl	184(%ebp)
	fmul	%st(4), %st(0)
	faddl	184(%esi)
	fstpl	184(%edi)
	fstpl	176(%edi)
	fstpl	168(%edi)
	fstpl	160(%edi)
	fldl	192(%ebp)
	fmul	%st(1), %st(0)
	faddl	192(%esi)
	fldl	200(%ebp)
	fmul	%st(2), %st(0)
	faddl	200(%esi)
	fldl	208(%ebp)
	fmul	%st(3), %st(0)
	faddl	208(%esi)
	fldl	216(%ebp)
	fmul	%st(4), %st(0)
	faddl	216(%esi)
	fstpl	216(%edi)
	fstpl	208(%edi)
	fstpl	200(%edi)
	fstpl	192(%edi)
	fldl	224(%ebp)
	fmul	%st(1), %st(0)
	faddl	224(%esi)
	fldl	232(%ebp)
	fmul	%st(2), %st(0)
	faddl	232(%esi)
	fldl	240(%ebp)
	fmul	%st(3), %st(0)
	faddl	240(%esi)
	fldl	248(%ebp)
	fmul	%st(4), %st(0)
	faddl	248(%esi)
	fstpl	248(%edi)
	fstpl	240(%edi)
	fstpl	232(%edi)
	fstpl	224(%edi)
	addl	%edx, %ebp
	addl	%edx, %esi
	addl	%edx, %edi
	decl	%ebx
	jnz	.maintr

	movl	%ecx, %ebx
	movl	8(%esp), %esi
	movl	12(%esp), %ebp
	movl	16(%esp), %edi
	decl	%eax
	jnz	.maintr

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free */
	movl	%edi, 0(%esp)
	call	free
/* free */
	movl	%ebp, 0(%esp)
	call	free
/* free */
	movl	%esi, 0(%esp)
	call	free
/* calculate */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret
