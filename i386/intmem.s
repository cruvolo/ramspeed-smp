/*
**  INTmem benchmarks for RAMspeed (i386)
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

.globl  intcp
intcp:
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
	shrl	$4, %ecx
	movl	%esi, %edx
.precp:
	movl	$33, 0(%edx)
	movl	$33, 4(%edx)
	movl	$33, 8(%edx)
	movl	$33, 12(%edx)
	addl	$16, %edx
	loopl	.precp
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$7, %ebx
	movl	%ebx, %ebp
	movl	%ebx, 20(%esp)
	movl	72(%esp), %eax
	movl	%eax, 24(%esp)
	movl	%esi, 8(%esp)
	movl	%edi, 12(%esp)
.maincp:
	movl	0(%esi), %eax
	movl	4(%esi), %ebx
	movl	8(%esi), %ecx
	movl	12(%esi), %edx
	movl	%eax, 0(%edi)
	movl	%ebx, 4(%edi)
	movl	%ecx, 8(%edi)
	movl	%edx, 12(%edi)
	movl	16(%esi), %eax
	movl	20(%esi), %ebx
	movl	24(%esi), %ecx
	movl	28(%esi), %edx
	movl	%eax, 16(%edi)
	movl	%ebx, 20(%edi)
	movl	%ecx, 24(%edi)
	movl	%edx, 28(%edi)
	movl	32(%esi), %eax
	movl	36(%esi), %ebx
	movl	40(%esi), %ecx
	movl	44(%esi), %edx
	movl	%eax, 32(%edi)
	movl	%ebx, 36(%edi)
	movl	%ecx, 40(%edi)
	movl	%edx, 44(%edi)
	movl	48(%esi), %eax
	movl	52(%esi), %ebx
	movl	56(%esi), %ecx
	movl	60(%esi), %edx
	movl	%eax, 48(%edi)
	movl	%ebx, 52(%edi)
	movl	%ecx, 56(%edi)
	movl	%edx, 60(%edi)
	movl	64(%esi), %eax
	movl	68(%esi), %ebx
	movl	72(%esi), %ecx
	movl	76(%esi), %edx
	movl	%eax, 64(%edi)
	movl	%ebx, 68(%edi)
	movl	%ecx, 72(%edi)
	movl	%edx, 76(%edi)
	movl	80(%esi), %eax
	movl	84(%esi), %ebx
	movl	88(%esi), %ecx
	movl	92(%esi), %edx
	movl	%eax, 80(%edi)
	movl	%ebx, 84(%edi)
	movl	%ecx, 88(%edi)
	movl	%edx, 92(%edi)
	movl	96(%esi), %eax
	movl	100(%esi), %ebx
	movl	104(%esi), %ecx
	movl	108(%esi), %edx
	movl	%eax, 96(%edi)
	movl	%ebx, 100(%edi)
	movl	%ecx, 104(%edi)
	movl	%edx, 108(%edi)
	movl	112(%esi), %eax
	movl	116(%esi), %ebx
	movl	120(%esi), %ecx
	movl	124(%esi), %edx
	movl	%eax, 112(%edi)
	movl	%ebx, 116(%edi)
	movl	%ecx, 120(%edi)
	movl	%edx, 124(%edi)
	addl	$128, %esi
	addl	$128, %edi
	decl	%ebp
	jnz	.maincp

	movl	20(%esp), %ebp
	movl	8(%esp), %esi
	movl	12(%esp), %edi
	decl	24(%esp)
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

.globl  intsc
intsc:
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
	shrl	$4, %ecx
	movl	%esi, %edx
.presc:
	movl	$33, 0(%edx)
	movl	$33, 4(%edx)
	movl	$33, 8(%edx)
	movl	$33, 12(%edx)
	addl	$16, %edx
	loopl	.presc
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$7, %ebx
	movl	%ebx, %ebp
	movl	%ebx, 20(%esp)
	movl	72(%esp), %eax
	movl	%eax, 24(%esp)
	movl	%esi, 8(%esp)
	movl	%edi, 12(%esp)
.mainsc:
	imull	$77, 0(%esi), %eax
	imull	$77, 4(%esi), %ebx
	imull	$77, 8(%esi), %ecx
	imull	$77, 12(%esi), %edx
	movl	%eax, 0(%edi)
	movl	%ebx, 4(%edi)
	movl	%ecx, 8(%edi)
	movl	%edx, 12(%edi)
	imull	$77, 16(%esi), %eax
	imull	$77, 20(%esi), %ebx
	imull	$77, 24(%esi), %ecx
	imull	$77, 28(%esi), %edx
	movl	%eax, 16(%edi)
	movl	%ebx, 20(%edi)
	movl	%ecx, 24(%edi)
	movl	%edx, 28(%edi)
	imull	$77, 32(%esi), %eax
	imull	$77, 36(%esi), %ebx
	imull	$77, 40(%esi), %ecx
	imull	$77, 44(%esi), %edx
	movl	%eax, 32(%edi)
	movl	%ebp, 36(%edi)
	movl	%ecx, 40(%edi)
	movl	%edx, 44(%edi)
	imull	$77, 48(%esi), %eax
	imull	$77, 52(%esi), %ebx
	imull	$77, 56(%esi), %ecx
	imull	$77, 60(%esi), %edx
	movl	%eax, 48(%edi)
	movl	%ebx, 52(%edi)
	movl	%ecx, 56(%edi)
	movl	%edx, 60(%edi)
	imull	$77, 64(%esi), %eax
	imull	$77, 68(%esi), %ebx
	imull	$77, 72(%esi), %ecx
	imull	$77, 76(%esi), %edx
	movl	%eax, 64(%edi)
	movl	%ebx, 68(%edi)
	movl	%ecx, 72(%edi)
	movl	%edx, 76(%edi)
	imull	$77, 80(%esi), %eax
	imull	$77, 84(%esi), %ebx
	imull	$77, 88(%esi), %ecx
	imull	$77, 92(%esi), %edx
	movl	%eax, 80(%edi)
	movl	%ebx, 84(%edi)
	movl	%ecx, 88(%edi)
	movl	%edx, 92(%edi)
	imull	$77, 96(%esi), %eax
	imull	$77, 100(%esi), %ebx
	imull	$77, 104(%esi), %ecx
	imull	$77, 108(%esi), %edx
	movl	%eax, 96(%edi)
	movl	%ebx, 100(%edi)
	movl	%ecx, 104(%edi)
	movl	%edx, 108(%edi)
	imull	$77, 112(%esi), %eax
	imull	$77, 116(%esi), %ebx
	imull	$77, 120(%esi), %ecx
	imull	$77, 124(%esi), %edx
	movl	%eax, 112(%edi)
	movl	%ebx, 116(%edi)
	movl	%ecx, 120(%edi)
	movl	%edx, 124(%edi)
	addl	$128, %esi
	addl	$128, %edi
	decl	%ebp
	jnz	.mainsc

	movl	20(%esp), %ebp
	movl	8(%esp), %esi
	movl	12(%esp), %edi
	decl	24(%esp)
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

.globl  intad
intad:
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
	shrl	$4, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
.pread:
	movl	$33, 0(%edx)
	movl	$33, 4(%edx)
	movl	$33, 8(%edx)
	movl	$33, 12(%edx)
	movl	$55, 0(%eax)
	movl	$55, 4(%eax)
	movl	$55, 8(%eax)
	movl	$55, 12(%eax)
	addl	$16, %edx
	addl	$16, %eax
	loopl	.pread
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$7, %ebx
	movl	%ebx, 20(%esp)
	movl	%ebx, 24(%esp)
	movl	72(%esp), %eax
	movl	%eax, 28(%esp)
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
.mainad:
	movl	0(%esi), %eax
	movl	4(%esi), %ebx
	movl	8(%esi), %ecx
	movl	12(%esi), %edx
	addl	0(%ebp), %eax
	addl	4(%ebp), %ebx
	addl	8(%ebp), %ecx
	addl	12(%ebp), %edx
	movl	%eax, 0(%edi)
	movl	%ebx, 4(%edi)
	movl	%ecx, 8(%edi)
	movl	%edx, 12(%edi)
	movl	16(%esi), %eax
	movl	20(%esi), %ebx
	movl	24(%esi), %ecx
	movl	28(%esi), %edx
	addl	16(%ebp), %eax
	addl	20(%ebp), %ebx
	addl	24(%ebp), %ecx
	addl	28(%ebp), %edx
	movl	%eax, 16(%edi)
	movl	%ebx, 20(%edi)
	movl	%ecx, 24(%edi)
	movl	%edx, 28(%edi)
	movl	32(%esi), %eax
	movl	36(%esi), %ebx
	movl	40(%esi), %ecx
	movl	44(%esi), %edx
	addl	32(%ebp), %eax
	addl	36(%ebp), %ebx
	addl	40(%ebp), %ecx
	addl	44(%ebp), %edx
	movl	%eax, 32(%edi)
	movl	%ebx, 36(%edi)
	movl	%ecx, 40(%edi)
	movl	%edx, 44(%edi)
	movl	48(%esi), %eax
	movl	52(%esi), %ebx
	movl	56(%esi), %ecx
	movl	60(%esi), %edx
	addl	48(%ebp), %eax
	addl	52(%ebp), %ebx
	addl	56(%ebp), %ecx
	addl	60(%ebp), %edx
	movl	%eax, 48(%edi)
	movl	%ebx, 52(%edi)
	movl	%ecx, 56(%edi)
	movl	%edx, 60(%edi)
	movl	64(%esi), %eax
	movl	68(%esi), %ebx
	movl	72(%esi), %ecx
	movl	76(%esi), %edx
	addl	64(%ebp), %eax
	addl	68(%ebp), %ebx
	addl	72(%ebp), %ecx
	addl	76(%ebp), %edx
	movl	%eax, 64(%edi)
	movl	%ebx, 68(%edi)
	movl	%ecx, 72(%edi)
	movl	%edx, 76(%edi)
	movl	80(%esi), %eax
	movl	84(%esi), %ebx
	movl	88(%esi), %ecx
	movl	92(%esi), %edx
	addl	80(%ebp), %eax
	addl	84(%ebp), %ebx
	addl	88(%ebp), %ecx
	addl	92(%ebp), %edx
	movl	%eax, 80(%edi)
	movl	%ebx, 84(%edi)
	movl	%ecx, 88(%edi)
	movl	%edx, 92(%edi)
	movl	96(%esi), %eax
	movl	100(%esi), %ebx
	movl	104(%esi), %ecx
	movl	108(%esi), %edx
	addl	96(%ebp), %eax
	addl	100(%ebp), %ebx
	addl	104(%ebp), %ecx
	addl	108(%ebp), %edx
	movl	%eax, 96(%edi)
	movl	%ebx, 100(%edi)
	movl	%ecx, 104(%edi)
	movl	%edx, 108(%edi)
	movl	112(%esi), %eax
	movl	116(%esi), %ebx
	movl	120(%esi), %ecx
	movl	124(%esi), %edx
	addl	112(%ebp), %eax
	addl	116(%ebp), %ebx
	addl	120(%ebp), %ecx
	addl	124(%ebp), %edx
	movl	%eax, 112(%edi)
	movl	%ebx, 116(%edi)
	movl	%ecx, 120(%edi)
	movl	%edx, 124(%edi)
	addl	$128, %esi
	addl	$128, %ebp
	addl	$128, %edi
	decl	20(%esp)
	jnz	.mainad

	movl	24(%esp), %eax
	movl	%eax, 20(%esp)
	movl	8(%esp), %esi
	movl	12(%esp), %ebp
	movl	16(%esp), %edi
	decl	28(%esp)
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

.globl  inttr
inttr:
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
	shrl	$4, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
.pretr:
	movl	$33, 0(%edx)
	movl	$33, 4(%edx)
	movl	$33, 8(%edx)
	movl	$33, 12(%edx)
	movl	$55, 0(%eax)
	movl	$55, 4(%eax)
	movl	$55, 8(%eax)
	movl	$55, 12(%eax)
	addl	$16, %edx
	addl	$16, %eax
	loopl	.pretr
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$7, %ebx
	movl	%ebx, 20(%esp)
	movl	%ebx, 24(%esp)
	movl	72(%esp), %eax
	movl	%eax, 28(%esp)
	movl	%esi,8(%esp)
	movl	%ebp,12(%esp)
	movl	%edi,16(%esp)
.maintr:
	imull	$77, (%ebp), %eax
	imull	$77, 4(%ebp), %ebx
	imull	$77, 8(%ebp), %ecx
	imull	$77, 12(%ebp), %edx
	addl	(%esi), %eax
	addl	4(%esi), %ebx
	addl	8(%esi), %ecx
	addl	12(%esi), %edx
	movl	%eax, (%edi)
	movl	%edx, 4(%edi)
	movl	%eax, 8(%edi)
	movl	%edx, 12(%edi)
	imull	$77, 16(%ebp), %eax
	imull	$77, 20(%ebp), %ebx
	imull	$77, 24(%ebp), %ecx
	imull	$77, 28(%ebp), %edx
	addl	16(%esi), %eax
	addl	20(%esi), %ebx
	addl	24(%esi), %ecx
	addl	28(%esi), %edx
	movl	%eax, 16(%edi)
	movl	%ebx, 20(%edi)
	movl	%ecx, 24(%edi)
	movl	%edx, 28(%edi)
	imull	$77, 32(%ebp), %eax
	imull	$77, 36(%ebp), %ebx
	imull	$77, 40(%ebp), %ecx
	imull	$77, 44(%ebp), %edx
	addl	32(%esi), %eax
	addl	36(%esi), %ebx
	addl	40(%esi), %ecx
	addl	44(%esi), %edx
	movl	%eax, 32(%edi)
	movl	%ebx, 36(%edi)
	movl	%ecx, 40(%edi)
	movl	%edx, 44(%edi)
	imull	$77, 48(%ebp), %eax
	imull	$77, 52(%ebp), %ebx
	imull	$77, 56(%ebp), %ecx
	imull	$77, 60(%ebp), %edx
	addl	48(%esi), %eax
	addl	52(%esi), %ebx
	addl	56(%esi), %ecx
	addl	60(%esi), %edx
	movl	%eax, 48(%edi)
	movl	%ebx, 52(%edi)
	movl	%ecx, 56(%edi)
	movl	%edx, 60(%edi)
	imull	$77, 64(%ebp), %eax
	imull	$77, 68(%ebp), %ebx
	imull	$77, 72(%ebp), %ecx
	imull	$77, 76(%ebp), %edx
	addl	64(%esi), %eax
	addl	68(%esi), %ebx
	addl	72(%esi), %ecx
	addl	76(%esi), %edx
	movl	%eax, 64(%edi)
	movl	%ebx, 68(%edi)
	movl	%ecx, 72(%edi)
	movl	%edx, 76(%edi)
	imull	$77, 80(%ebp), %eax
	imull	$77, 84(%ebp), %ebx
	imull	$77, 88(%ebp), %ecx
	imull	$77, 92(%ebp), %edx
	addl	80(%esi), %eax
	addl	84(%esi), %ebx
	addl	88(%esi), %ecx
	addl	92(%esi), %edx
	movl	%eax, 80(%edi)
	movl	%ebx, 84(%edi)
	movl	%ecx, 88(%edi)
	movl	%edx, 92(%edi)
	imull	$77, 96(%ebp), %eax
	imull	$77, 100(%ebp), %ebx
	imull	$77, 104(%ebp), %ecx
	imull	$77, 108(%ebp), %edx
	addl	96(%esi), %eax
	addl	100(%esi), %ebx
	addl	104(%esi), %ecx
	addl	108(%esi), %edx
	movl	%eax, 96(%edi)
	movl	%ebx, 100(%edi)
	movl	%ecx, 104(%edi)
	movl	%edx, 108(%edi)
	imull	$77, 112(%ebp), %eax
	imull	$77, 116(%ebp), %ebx
	imull	$77, 120(%ebp), %ecx
	imull	$77, 124(%ebp), %edx
	addl	112(%esi), %eax
	addl	116(%esi), %ebx
	addl	120(%esi), %ecx
	addl	124(%esi), %edx
	movl	%eax, 112(%edi)
	movl	%ebx, 116(%edi)
	movl	%ecx, 120(%edi)
	movl	%edx, 124(%edi)
	addl	$128, %esi
	addl	$128, %ebp
	addl	$128, %edi
	decl	20(%esp)
	jnz	.maintr

	movl	24(%esp), %eax
	movl	%eax, 20(%esp)
	movl	8(%esp), %esi
	movl	12(%esp), %ebp
	movl	16(%esp), %edi
	decl	28(%esp)
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
