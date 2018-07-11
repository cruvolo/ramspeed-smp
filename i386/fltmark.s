/*
**  FLOATmark benchmarks for RAMspeed (i386)
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

.globl  floatwr
floatwr:
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
	shrl	$9, %ebx
	movl	%ebx, %ebp
	movl	%edi, %esi
	movl	72(%esp), %ecx
	movl	$512, %eax
	finit
	fldz
.mainwr:
	fstl	0(%edi)
	fstl	8(%edi)
	fstl	16(%edi)
	fstl	24(%edi)
	fstl	32(%edi)
	fstl	40(%edi)
	fstl	48(%edi)
	fstl	56(%edi)
	fstl	64(%edi)
	fstl	72(%edi)
	fstl	80(%edi)
	fstl	88(%edi)
	fstl	96(%edi)
	fstl	104(%edi)
	fstl	112(%edi)
	fstl	120(%edi)
	fstl	128(%edi)
	fstl	136(%edi)
	fstl	144(%edi)
	fstl	152(%edi)
	fstl	160(%edi)
	fstl	168(%edi)
	fstl	176(%edi)
	fstl	184(%edi)
	fstl	192(%edi)
	fstl	200(%edi)
	fstl	208(%edi)
	fstl	216(%edi)
	fstl	224(%edi)
	fstl	232(%edi)
	fstl	240(%edi)
	fstl	248(%edi)
	fstl	256(%edi)
	fstl	264(%edi)
	fstl	272(%edi)
	fstl	280(%edi)
	fstl	288(%edi)
	fstl	296(%edi)
	fstl	304(%edi)
	fstl	312(%edi)
	fstl	320(%edi)
	fstl	328(%edi)
	fstl	336(%edi)
	fstl	344(%edi)
	fstl	352(%edi)
	fstl	360(%edi)
	fstl	368(%edi)
	fstl	376(%edi)
	fstl	384(%edi)
	fstl	392(%edi)
	fstl	400(%edi)
	fstl	408(%edi)
	fstl	416(%edi)
	fstl	424(%edi)
	fstl	432(%edi)
	fstl	440(%edi)
	fstl	448(%edi)
	fstl	456(%edi)
	fstl	464(%edi)
	fstl	472(%edi)
	fstl	480(%edi)
	fstl	488(%edi)
	fstl	496(%edi)
	fstl	504(%edi)
	addl	%eax, %edi
	decl	%ebx
	jnz	.mainwr

	movl	%ebp, %ebx
	movl	%esi, %edi
	decl	%ecx
	jnz	.mainwr

	ffree	%st(0)

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

.globl  floatrd
floatrd:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48,%esp
/* allocate */
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, 0(%esp)
	call	malloc
	movl	%eax, %esi
/* prefill */
	movl	%ebx, %ecx
	shrl	$5, %ecx
	finit
	fldz
.prerd:
	fstl	0(%eax)
	fstl	8(%eax)
	fstl	16(%eax)
	fstl	24(%eax)
	addl	$32, %eax
	loopl	.prerd
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ebp
	movl	%esi, %edi
	movl	72(%esp), %ecx
	movl	$512, %eax
.mainrd:
	fldl	0(%esi)
	ffree	%st(0)
	fldl	8(%esi)
	ffree	%st(0)
	fldl	16(%esi)
	ffree	%st(0)
	fldl	24(%esi)
	ffree	%st(0)
	fldl	32(%esi)
	ffree	%st(0)
	fldl	40(%esi)
	ffree	%st(0)
	fldl	48(%esi)
	ffree	%st(0)
	fldl	56(%esi)
	ffree	%st(0)
	fldl	64(%esi)
	ffree	%st(0)
	fldl	72(%esi)
	ffree	%st(0)
	fldl	80(%esi)
	ffree	%st(0)
	fldl	88(%esi)
	ffree	%st(0)
	fldl	96(%esi)
	ffree	%st(0)
	fldl	104(%esi)
	ffree	%st(0)
	fldl	112(%esi)
	ffree	%st(0)
	fldl	120(%esi)
	ffree	%st(0)
	fldl	128(%esi)
	ffree	%st(0)
	fldl	136(%esi)
	ffree	%st(0)
	fldl	144(%esi)
	ffree	%st(0)
	fldl	152(%esi)
	ffree	%st(0)
	fldl	160(%esi)
	ffree	%st(0)
	fldl	168(%esi)
	ffree	%st(0)
	fldl	176(%esi)
	ffree	%st(0)
	fldl	184(%esi)
	ffree	%st(0)
	fldl	192(%esi)
	ffree	%st(0)
	fldl	200(%esi)
	ffree	%st(0)
	fldl	208(%esi)
	ffree	%st(0)
	fldl	216(%esi)
	ffree	%st(0)
	fldl	224(%esi)
	ffree	%st(0)
	fldl	232(%esi)
	ffree	%st(0)
	fldl	240(%esi)
	ffree	%st(0)
	fldl	248(%esi)
	ffree	%st(0)
	fldl	256(%esi)
	ffree	%st(0)
	fldl	264(%esi)
	ffree	%st(0)
	fldl	272(%esi)
	ffree	%st(0)
	fldl	280(%esi)
	ffree	%st(0)
	fldl	288(%esi)
	ffree	%st(0)
	fldl	296(%esi)
	ffree	%st(0)
	fldl	304(%esi)
	ffree	%st(0)
	fldl	312(%esi)
	ffree	%st(0)
	fldl	320(%esi)
	ffree	%st(0)
	fldl	328(%esi)
	ffree	%st(0)
	fldl	336(%esi)
	ffree	%st(0)
	fldl	344(%esi)
	ffree	%st(0)
	fldl	352(%esi)
	ffree	%st(0)
	fldl	360(%esi)
	ffree	%st(0)
	fldl	368(%esi)
	ffree	%st(0)
	fldl	376(%esi)
	ffree	%st(0)
	fldl	384(%esi)
	ffree	%st(0)
	fldl	392(%esi)
	ffree	%st(0)
	fldl	400(%esi)
	ffree	%st(0)
	fldl	408(%esi)
	ffree	%st(0)
	fldl	416(%esi)
	ffree	%st(0)
	fldl	424(%esi)
	ffree	%st(0)
	fldl	432(%esi)
	ffree	%st(0)
	fldl	440(%esi)
	ffree	%st(0)
	fldl	448(%esi)
	ffree	%st(0)
	fldl	456(%esi)
	ffree	%st(0)
	fldl	464(%esi)
	ffree	%st(0)
	fldl	472(%esi)
	ffree	%st(0)
	fldl	480(%esi)
	ffree	%st(0)
	fldl	488(%esi)
	ffree	%st(0)
	fldl	496(%esi)
	ffree	%st(0)
	fldl	504(%esi)
	ffree	%st(0)
	addl	%eax, %esi
	decl	%ebx
	jnz	.mainrd

	movl	%ebp, %ebx
	movl	%edi, %esi
	decl	%ecx
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
