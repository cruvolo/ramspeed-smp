/*
**  INTmark benchmarks for RAMspeed (i386)
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

.globl 	intwr
intwr:
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
	movl	%eax, %edi
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$8, %ebx
	movl	%ebx, %ebp
	movl	%edi, %esi
	movl	72(%esp), %ecx
	movl	$256, %eax
	xorl	%edx, %edx
.mainwr:
	movl	%edx, 0(%edi)
	movl	%edx, 4(%edi)
	movl	%edx, 8(%edi)
	movl	%edx, 12(%edi)
	movl	%edx, 16(%edi)
	movl	%edx, 20(%edi)
	movl	%edx, 24(%edi)
	movl	%edx, 28(%edi)
	movl	%edx, 32(%edi)
	movl	%edx, 36(%edi)
	movl	%edx, 40(%edi)
	movl	%edx, 44(%edi)
	movl	%edx, 48(%edi)
	movl	%edx, 52(%edi)
	movl	%edx, 56(%edi)
	movl	%edx, 60(%edi)
	movl	%edx, 64(%edi)
	movl	%edx, 68(%edi)
	movl	%edx, 72(%edi)
	movl	%edx, 76(%edi)
	movl	%edx, 80(%edi)
	movl	%edx, 84(%edi)
	movl	%edx, 88(%edi)
	movl	%edx, 92(%edi)
	movl	%edx, 96(%edi)
	movl	%edx, 100(%edi)
	movl	%edx, 104(%edi)
	movl	%edx, 108(%edi)
	movl	%edx, 112(%edi)
	movl	%edx, 116(%edi)
	movl	%edx, 120(%edi)
	movl	%edx, 124(%edi)
	movl	%edx, 128(%edi)
	movl	%edx, 132(%edi)
	movl	%edx, 136(%edi)
	movl	%edx, 140(%edi)
	movl	%edx, 144(%edi)
	movl	%edx, 148(%edi)
	movl	%edx, 152(%edi)
	movl	%edx, 156(%edi)
	movl	%edx, 160(%edi)
	movl	%edx, 164(%edi)
	movl	%edx, 168(%edi)
	movl	%edx, 172(%edi)
	movl	%edx, 176(%edi)
	movl	%edx, 180(%edi)
	movl	%edx, 184(%edi)
	movl	%edx, 188(%edi)
	movl	%edx, 192(%edi)
	movl	%edx, 196(%edi)
	movl	%edx, 200(%edi)
	movl	%edx, 204(%edi)
	movl	%edx, 208(%edi)
	movl	%edx, 212(%edi)
	movl	%edx, 216(%edi)
	movl	%edx, 220(%edi)
	movl	%edx, 224(%edi)
	movl	%edx, 228(%edi)
	movl	%edx, 232(%edi)
	movl	%edx, 236(%edi)
	movl	%edx, 240(%edi)
	movl	%edx, 244(%edi)
	movl	%edx, 248(%edi)
	movl	%edx, 252(%edi)
	addl	%eax, %edi
	decl	%ebx
	jnz	.mainwr

	movl	%ebp, %ebx
	movl	%esi, %edi
	decl	%ecx
	jnz	.mainwr

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free */
	movl	%edi, 0(%esp)
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

.globl  intrd
intrd:
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
/* prefill */
	movl	%ebx, %ecx
	shrl	$4, %ecx
	xorl	%edx, %edx
.prerd:
	movl	%edx, 0(%eax)
	movl	%edx, 4(%eax)
	movl	%edx, 8(%eax)
	movl	%edx, 12(%eax)
	addl	$16, %eax
	loopl	.prerd
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$8, %ebx
	movl	%ebx, %ebp
	movl	%esi, %edi
	movl	72(%esp), %ecx
.mainrd:
	movl	0(%esi), %eax
	movl	4(%esi), %edx
	movl	8(%esi), %eax
	movl	12(%esi), %edx
	movl	16(%esi), %eax
	movl	20(%esi), %edx
	movl	24(%esi), %eax
	movl	28(%esi), %edx
	movl	32(%esi), %eax
	movl	36(%esi), %edx
	movl	40(%esi), %eax
	movl	44(%esi), %edx
	movl	48(%esi), %eax
	movl	52(%esi), %edx
	movl	56(%esi), %eax
	movl	60(%esi), %edx
	movl	64(%esi), %eax
	movl	68(%esi), %edx
	movl	72(%esi), %eax
	movl	76(%esi), %edx
	movl	80(%esi), %eax
	movl	84(%esi), %edx
	movl	88(%esi), %eax
	movl	92(%esi), %edx
	movl	96(%esi), %eax
	movl	100(%esi), %edx
	movl	104(%esi), %eax
	movl	108(%esi), %edx
	movl	112(%esi), %eax
	movl	116(%esi), %edx
	movl	120(%esi), %eax
	movl	124(%esi), %edx
	movl	128(%esi), %eax
	movl	132(%esi), %edx
	movl	136(%esi), %eax
	movl	140(%esi), %edx
	movl	144(%esi), %eax
	movl	148(%esi), %edx
	movl	152(%esi), %eax
	movl	156(%esi), %edx
	movl	160(%esi), %eax
	movl	164(%esi), %edx
	movl	168(%esi), %eax
	movl	172(%esi), %edx
	movl	176(%esi), %eax
	movl	180(%esi), %edx
	movl	184(%esi), %eax
	movl	188(%esi), %edx
	movl	192(%esi), %eax
	movl	196(%esi), %edx
	movl	200(%esi), %eax
	movl	204(%esi), %edx
	movl	208(%esi), %eax
	movl	212(%esi), %edx
	movl	216(%esi), %eax
	movl	220(%esi), %edx
	movl	224(%esi), %eax
	movl	228(%esi), %edx
	movl	232(%esi), %eax
	movl	236(%esi), %edx
	movl	240(%esi), %eax
	movl	244(%esi), %edx
	movl	248(%esi), %eax
	movl	252(%esi), %edx
	addl	$256, %esi
	decl	%ebx
	jnz	.mainrd

	movl	%ebp, %ebx
	movl	%edi, %esi
	decl 	%ecx
	jnz	.mainrd

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
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
