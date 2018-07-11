/*
**  MMXmem benchmarks for RAMspeed (i386)
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
**  Copyright (c) 2006-09 Paul V. Bolotoff <walter@alasir.com>
**
**  All rights reserved.
**
*/

.globl  mmxcp
mmxcp:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
.precp:
	movq	%mm0, 0(%edx)
	movq	%mm0, 8(%edx)
	movq	%mm0, 16(%edx)
	movq	%mm0, 24(%edx)
	addl	$32, %edx
	loopl	.precp
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
	movq	0(%esi), %mm0
	movq	8(%esi), %mm1
	movq	16(%esi), %mm2
	movq	24(%esi), %mm3
	movq	%mm0, 0(%edi)
	movq	%mm1, 8(%edi)
	movq	%mm2, 16(%edi)
	movq	%mm3, 24(%edi)
	movq	32(%esi), %mm4
	movq	40(%esi), %mm5
	movq	48(%esi), %mm6
	movq	56(%esi), %mm7
	movq	%mm4, 32(%edi)
	movq	%mm5, 40(%edi)
	movq	%mm6, 48(%edi)
	movq	%mm7, 56(%edi)
	movq	64(%esi), %mm0
	movq	72(%esi), %mm1
	movq	80(%esi), %mm2
	movq	88(%esi), %mm3
	movq	%mm0, 64(%edi)
	movq	%mm1, 72(%edi)
	movq	%mm2, 80(%edi)
	movq	%mm3, 88(%edi)
	movq	96(%esi), %mm4
	movq	104(%esi), %mm5
	movq	112(%esi), %mm6
	movq	120(%esi), %mm7
	movq	%mm4, 96(%edi)
	movq	%mm5, 104(%edi)
	movq	%mm6, 112(%edi)
	movq	%mm7, 120(%edi)
	movq	128(%esi), %mm0
	movq	136(%esi), %mm1
	movq	144(%esi), %mm2
	movq	152(%esi), %mm3
	movq	%mm0, 128(%edi)
	movq	%mm1, 136(%edi)
	movq	%mm2, 144(%edi)
	movq	%mm3, 152(%edi)
	movq	160(%esi), %mm4
	movq	168(%esi), %mm5
	movq	176(%esi), %mm6
	movq	184(%esi), %mm7
	movq	%mm4, 160(%edi)
	movq	%mm5, 168(%edi)
	movq	%mm6, 176(%edi)
	movq	%mm7, 184(%edi)
	movq	192(%esi), %mm0
	movq	200(%esi), %mm1
	movq	208(%esi), %mm2
	movq	216(%esi), %mm3
	movq	%mm0, 192(%edi)
	movq	%mm1, 200(%edi)
	movq	%mm2, 208(%edi)
	movq	%mm3, 216(%edi)
	movq	224(%esi), %mm4
	movq	232(%esi), %mm5
	movq	240(%esi), %mm6
	movq	248(%esi), %mm7
	movq	%mm4, 224(%edi)
	movq	%mm5, 232(%edi)
	movq	%mm6, 240(%edi)
	movq	%mm7, 248(%edi)
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
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxsc
mmxsc:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
.presc:
	movq	%mm0, 0(%edx)
	movq	%mm0, 8(%edx)
	movq	%mm0, 16(%edx)
	movq	%mm0, 24(%edx)
	addl	$32, %edx
	loopl	.presc
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	movw	$77, 8(%esp)
	movw	$77, 10(%esp)
	movw	$77, 12(%esp)
	movw	$77, 14(%esp)
	movq	8(%esp), %mm4
/* execute */
	shrl	$8, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.mainsc:
	movq	0(%esi), %mm0
	movq	8(%esi), %mm1
	movq	16(%esi), %mm2
	movq	24(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 0(%edi)
	movq	%mm1, 8(%edi)
	movq	%mm2, 16(%edi)
	movq	%mm3, 24(%edi)
	movq	32(%esi), %mm0
	movq	40(%esi), %mm1
	movq	48(%esi), %mm2
	movq	56(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 32(%edi)
	movq	%mm1, 40(%edi)
	movq	%mm2, 48(%edi)
	movq	%mm3, 56(%edi)
	movq	64(%esi), %mm0
	movq	72(%esi), %mm1
	movq	80(%esi), %mm2
	movq	88(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 64(%edi)
	movq	%mm1, 72(%edi)
	movq	%mm2, 80(%edi)
	movq	%mm3, 88(%edi)
	movq	96(%esi), %mm0
	movq	104(%esi), %mm1
	movq	112(%esi), %mm2
	movq	120(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 96(%edi)
	movq	%mm1, 104(%edi)
	movq	%mm2, 112(%edi)
	movq	%mm3, 120(%edi)
	movq	128(%esi), %mm0
	movq	136(%esi), %mm1
	movq	144(%esi), %mm2
	movq	152(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 128(%edi)
	movq	%mm1, 136(%edi)
	movq	%mm2, 144(%edi)
	movq	%mm3, 152(%edi)
	movq	160(%esi), %mm0
	movq	168(%esi), %mm1
	movq	176(%esi), %mm2
	movq	184(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 160(%edi)
	movq	%mm1, 168(%edi)
	movq	%mm2, 176(%edi)
	movq	%mm3, 184(%edi)
	movq	192(%esi), %mm0
	movq	200(%esi), %mm1
	movq	208(%esi), %mm2
	movq	216(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 192(%edi)
	movq	%mm1, 200(%edi)
	movq	%mm2, 208(%edi)
	movq	%mm3, 216(%edi)
	movq	224(%esi), %mm0
	movq	232(%esi), %mm1
	movq	240(%esi), %mm2
	movq	248(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movq	%mm0, 224(%edi)
	movq	%mm1, 232(%edi)
	movq	%mm2, 240(%edi)
	movq	%mm3, 248(%edi)
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
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxad
mmxad:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %ebp
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	$0x00370037, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm1
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
.pread:
	movq	%mm0, 0(%edx)
	movq	%mm0, 8(%edx)
	movq	%mm0, 16(%edx)
	movq	%mm0, 24(%edx)
	movq	%mm1, 0(%eax)
	movq	%mm1, 8(%eax)
	movq	%mm1, 16(%eax)
	movq	%mm1, 24(%eax)
	addl	$32, %edx
	addl	$32, %eax
	loopl	.pread
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
	movq	0(%ebp), %mm0
	movq	8(%ebp), %mm1
	movq	16(%ebp), %mm2
	movq	24(%ebp), %mm3
	paddusw	0(%esi), %mm0
	paddusw	8(%esi), %mm1
	paddusw	16(%esi), %mm2
	paddusw	24(%esi), %mm3
	movq	%mm0, 0(%edi)
	movq	%mm1, 8(%edi)
	movq	%mm2, 16(%edi)
	movq	%mm3, 24(%edi)
	movq	32(%ebp), %mm4
	movq	40(%ebp), %mm5
	movq	48(%ebp), %mm6
	movq	56(%ebp), %mm7
	paddusw	32(%esi), %mm4
	paddusw	40(%esi), %mm5
	paddusw	48(%esi), %mm6
	paddusw	56(%esi), %mm7
	movq	%mm4, 32(%edi)
	movq	%mm5, 40(%edi)
	movq	%mm6, 48(%edi)
	movq	%mm7, 56(%edi)
	movq	64(%ebp), %mm0
	movq	72(%ebp), %mm1
	movq	80(%ebp), %mm2
	movq	88(%ebp), %mm3
	paddusw	64(%esi), %mm0
	paddusw	72(%esi), %mm1
	paddusw	80(%esi), %mm2
	paddusw	88(%esi), %mm3
	movq	%mm0, 64(%edi)
	movq	%mm1, 72(%edi)
	movq	%mm2, 80(%edi)
	movq	%mm3, 88(%edi)
	movq	96(%ebp), %mm4
	movq	104(%ebp), %mm5
	movq	112(%ebp), %mm6
	movq	120(%ebp), %mm7
	paddusw	96(%esi), %mm4
	paddusw	104(%esi), %mm5
	paddusw	112(%esi), %mm6
	paddusw	120(%esi), %mm7
	movq	%mm4, 96(%edi)
	movq	%mm5, 104(%edi)
	movq	%mm6, 112(%edi)
	movq	%mm7, 120(%edi)
	movq	128(%ebp), %mm0
	movq	136(%ebp), %mm1
	movq	144(%ebp), %mm2
	movq	152(%ebp), %mm3
	paddusw	128(%esi), %mm0
	paddusw	136(%esi), %mm1
	paddusw	144(%esi), %mm2
	paddusw	152(%esi), %mm3
	movq	%mm0, 128(%edi)
	movq	%mm1, 136(%edi)
	movq	%mm2, 144(%edi)
	movq	%mm3, 152(%edi)
	movq	160(%ebp), %mm4
	movq	168(%ebp), %mm5
	movq	176(%ebp), %mm6
	movq	184(%ebp), %mm7
	paddusw	160(%esi), %mm4
	paddusw	168(%esi), %mm5
	paddusw	176(%esi), %mm6
	paddusw	184(%esi), %mm7
	movq	%mm4, 160(%edi)
	movq	%mm5, 168(%edi)
	movq	%mm6, 176(%edi)
	movq	%mm7, 184(%edi)
	movq	192(%ebp), %mm0
	movq	200(%ebp), %mm1
	movq	208(%ebp), %mm2
	movq	216(%ebp), %mm3
	paddusw	192(%esi), %mm0
	paddusw	200(%esi), %mm1
	paddusw	208(%esi), %mm2
	paddusw	216(%esi), %mm3
	movq	%mm0, 192(%edi)
	movq	%mm1, 200(%edi)
	movq	%mm2, 208(%edi)
	movq	%mm3, 216(%edi)
	movq	224(%ebp), %mm4
	movq	232(%ebp), %mm5
	movq	240(%ebp), %mm6
	movq	248(%ebp), %mm7
	paddusw	224(%esi), %mm4
	paddusw	232(%esi), %mm5
	paddusw	240(%esi), %mm6
	paddusw	248(%esi), %mm7
	movq	%mm4, 224(%edi)
	movq	%mm5, 232(%edi)
	movq	%mm6, 240(%edi)
	movq	%mm7, 248(%edi)
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
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxtr
mmxtr:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %ebp
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	$0x00370037, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm1
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
.pretr:
	movq	%mm0, 0(%edx)
	movq	%mm0, 8(%edx)
	movq	%mm0, 16(%edx)
	movq	%mm0, 24(%edx)
	movq	%mm1, 0(%eax)
	movq	%mm1, 8(%eax)
	movq	%mm1, 16(%eax)
	movq	%mm1, 24(%eax)
	addl	$32, %edx
	addl	$32, %eax
	loopl	.pretr
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	movw	$77, 8(%esp)
	movw	$77, 10(%esp)
	movw	$77, 12(%esp)
	movw	$77, 14(%esp)
	movq	8(%esp), %mm4
/* execute */
	shrl	$8, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$256, %edx
.maintr:
	movq	0(%ebp), %mm0
	movq	8(%ebp), %mm1
	movq	16(%ebp), %mm2
	movq	24(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	0(%esi), %mm0
	paddusw	8(%esi), %mm1
	paddusw	16(%esi), %mm2
	paddusw	24(%esi), %mm3
	movq	%mm0, 0(%edi)
	movq	%mm1, 8(%edi)
	movq	%mm2, 16(%edi)
	movq	%mm3, 24(%edi)
	movq	32(%ebp), %mm0
	movq	40(%ebp), %mm1
	movq	48(%ebp), %mm2
	movq	56(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	32(%esi), %mm0
	paddusw	40(%esi), %mm1
	paddusw	48(%esi), %mm2
	paddusw	56(%esi), %mm3
	movq	%mm0, 32(%edi)
	movq	%mm1, 40(%edi)
	movq	%mm2, 48(%edi)
	movq	%mm3, 56(%edi)
	movq	64(%ebp), %mm0
	movq	72(%ebp), %mm1
	movq	80(%ebp), %mm2
	movq	88(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	64(%esi), %mm0
	paddusw	72(%esi), %mm1
	paddusw	80(%esi), %mm2
	paddusw	88(%esi), %mm3
	movq	%mm0, 64(%edi)
	movq	%mm1, 72(%edi)
	movq	%mm2, 80(%edi)
	movq	%mm3, 88(%edi)
	movq	96(%ebp), %mm0
	movq	104(%ebp), %mm1
	movq	112(%ebp), %mm2
	movq	120(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	96(%esi), %mm0
	paddusw	104(%esi), %mm1
	paddusw	112(%esi), %mm2
	paddusw	120(%esi), %mm3
	movq	%mm0, 96(%edi)
	movq	%mm1, 104(%edi)
	movq	%mm2, 112(%edi)
	movq	%mm3, 120(%edi)
	movq	128(%ebp), %mm0
	movq	136(%ebp), %mm1
	movq	144(%ebp), %mm2
	movq	152(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	128(%esi), %mm0
	paddusw	136(%esi), %mm1
	paddusw	144(%esi), %mm2
	paddusw	152(%esi), %mm3
	movq	%mm0, 128(%edi)
	movq	%mm1, 136(%edi)
	movq	%mm2, 144(%edi)
	movq	%mm3, 152(%edi)
	movq	160(%ebp), %mm0
	movq	168(%ebp), %mm1
	movq	176(%ebp), %mm2
	movq	184(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	160(%esi), %mm0
	paddusw	168(%esi), %mm1
	paddusw	176(%esi), %mm2
	paddusw	184(%esi), %mm3
	movq	%mm0, 160(%edi)
	movq	%mm1, 168(%edi)
	movq	%mm2, 176(%edi)
	movq	%mm3, 184(%edi)
	movq	192(%ebp), %mm0
	movq	200(%ebp), %mm1
	movq	208(%ebp), %mm2
	movq	216(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	192(%esi), %mm0
	paddusw	200(%esi), %mm1
	paddusw	208(%esi), %mm2
	paddusw	216(%esi), %mm3
	movq	%mm0, 192(%edi)
	movq	%mm1, 200(%edi)
	movq	%mm2, 208(%edi)
	movq	%mm3, 216(%edi)
	movq	224(%ebp), %mm0
	movq	232(%ebp), %mm1
	movq	240(%ebp), %mm2
	movq	248(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	224(%esi), %mm0
	paddusw	232(%esi), %mm1
	paddusw	240(%esi), %mm2
	paddusw	248(%esi), %mm3
	movq	%mm0, 224(%edi)
	movq	%mm1, 232(%edi)
	movq	%mm2, 240(%edi)
	movq	%mm3, 248(%edi)
	addl	%edx, %esi
	addl	%edx, %ebp
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
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxcp_nt
mmxcp_nt:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
.precp_nt:
	movntq	%mm0, 0(%edx)
	movntq	%mm0, 8(%edx)
	movntq	%mm0, 16(%edx)
	movntq	%mm0, 24(%edx)
	addl	$32, %edx
	loopl	.precp_nt
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.maincp_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	512(%esi)
	movq	0(%esi), %mm0
	movq	8(%esi), %mm1
	prefetchnta	544(%esi)
	movq	16(%esi), %mm2
	movq	24(%esi), %mm3
	prefetchnta	576(%esi)
	movq	32(%esi), %mm4
	movq	40(%esi), %mm5
	prefetchnta	608(%esi)
	movq	48(%esi), %mm6
	movq	56(%esi), %mm7
	movntq	%mm0, 0(%edi)
	movntq	%mm1, 8(%edi)
	movntq	%mm2, 16(%edi)
	movntq	%mm3, 24(%edi)
	movntq	%mm4, 32(%edi)
	movntq	%mm5, 40(%edi)
	movntq	%mm6, 48(%edi)
	movntq	%mm7, 56(%edi)
	prefetchnta	640(%esi)
	movq	64(%esi), %mm0
	movq	72(%esi), %mm1
	prefetchnta	672(%esi)
	movq	80(%esi), %mm2
	movq	88(%esi), %mm3
	prefetchnta	704(%esi)
	movq	96(%esi), %mm4
	movq	104(%esi), %mm5
	prefetchnta	736(%esi)
	movq	112(%esi), %mm6
	movq	120(%esi), %mm7
	movntq	%mm0, 64(%edi)
	movntq	%mm1, 72(%edi)
	movntq	%mm2, 80(%edi)
	movntq	%mm3, 88(%edi)
	movntq	%mm4, 96(%edi)
	movntq	%mm5, 104(%edi)
	movntq	%mm6, 112(%edi)
	movntq	%mm7, 120(%edi)
	prefetchnta	768(%esi)
	movq	128(%esi), %mm0
	movq	136(%esi), %mm1
	prefetchnta	800(%esi)
	movq	144(%esi), %mm2
	movq	152(%esi), %mm3
	prefetchnta	832(%esi)
	movq	160(%esi), %mm4
	movq	168(%esi), %mm5
	prefetchnta	864(%esi)
	movq	176(%esi), %mm6
	movq	184(%esi), %mm7
	movntq	%mm0, 128(%edi)
	movntq	%mm1, 136(%edi)
	movntq	%mm2, 144(%edi)
	movntq	%mm3, 152(%edi)
	movntq	%mm4, 160(%edi)
	movntq	%mm5, 168(%edi)
	movntq	%mm6, 176(%edi)
	movntq	%mm7, 184(%edi)
	prefetchnta	896(%esi)
	movq	192(%esi), %mm0
	movq	200(%esi), %mm1
	prefetchnta	928(%esi)
	movq	208(%esi), %mm2
	movq	216(%esi), %mm3
	prefetchnta	960(%esi)
	movq	224(%esi), %mm4
	movq	232(%esi), %mm5
	prefetchnta	992(%esi)
	movq	240(%esi), %mm6
	movq	248(%esi), %mm7
	movntq	%mm0, 192(%edi)
	movntq	%mm1, 200(%edi)
	movntq	%mm2, 208(%edi)
	movntq	%mm3, 216(%edi)
	movntq	%mm4, 224(%edi)
	movntq	%mm5, 232(%edi)
	movntq	%mm6, 240(%edi)
	movntq	%mm7, 248(%edi)
	movq	256(%esi), %mm0
	movq	264(%esi), %mm1
	movq	272(%esi), %mm2
	movq	280(%esi), %mm3
	movq	288(%esi), %mm4
	movq	296(%esi), %mm5
	movq	304(%esi), %mm6
	movq	312(%esi), %mm7
	movntq	%mm0, 256(%edi)
	movntq	%mm1, 264(%edi)
	movntq	%mm2, 272(%edi)
	movntq	%mm3, 280(%edi)
	movntq	%mm4, 288(%edi)
	movntq	%mm5, 296(%edi)
	movntq	%mm6, 304(%edi)
	movntq	%mm7, 312(%edi)
	movq	320(%esi), %mm0
	movq	328(%esi), %mm1
	movq	336(%esi), %mm2
	movq	344(%esi), %mm3
	movq	352(%esi), %mm4
	movq	360(%esi), %mm5
	movq	368(%esi), %mm6
	movq	376(%esi), %mm7
	movntq	%mm0, 320(%edi)
	movntq	%mm1, 328(%edi)
	movntq	%mm2, 336(%edi)
	movntq	%mm3, 344(%edi)
	movntq	%mm4, 352(%edi)
	movntq	%mm5, 360(%edi)
	movntq	%mm6, 368(%edi)
	movntq	%mm7, 376(%edi)
	movq	384(%esi), %mm0
	movq	392(%esi), %mm1
	movq	400(%esi), %mm2
	movq	408(%esi), %mm3
	movq	416(%esi), %mm4
	movq	424(%esi), %mm5
	movq	432(%esi), %mm6
	movq	440(%esi), %mm7
	movntq	%mm0, 384(%edi)
	movntq	%mm1, 392(%edi)
	movntq	%mm2, 400(%edi)
	movntq	%mm3, 408(%edi)
	movntq	%mm4, 416(%edi)
	movntq	%mm5, 424(%edi)
	movntq	%mm6, 432(%edi)
	movntq	%mm7, 440(%edi)
	movq	448(%esi), %mm0
	movq	456(%esi), %mm1
	movq	464(%esi), %mm2
	movq	472(%esi), %mm3
	movq	480(%esi), %mm4
	movq	488(%esi), %mm5
	movq	496(%esi), %mm6
	movq	504(%esi), %mm7
	movntq	%mm0, 448(%edi)
	movntq	%mm1, 456(%edi)
	movntq	%mm2, 464(%edi)
	movntq	%mm3, 472(%edi)
	movntq	%mm4, 480(%edi)
	movntq	%mm5, 488(%edi)
	movntq	%mm6, 496(%edi)
	movntq	%mm7, 504(%edi)
	addl	$512, %esi
	addl	$512, %edi
	decl	%ebx
	jnz	.maincp_nt

	movl	%ecx, %ebx
	movl	%edx, %esi
	movl	%ebp, %edi
	decl	%eax
	jnz	.maincp_nt

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxsc_nt
mmxsc_nt:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
.presc_nt:
	movntq	%mm0, 0(%edx)
	movntq	%mm0, 8(%edx)
	movntq	%mm0, 16(%edx)
	movntq	%mm0, 24(%edx)
	addl	$32, %edx
	loopl	.presc_nt
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	movw	$77, 8(%esp)
	movw	$77, 10(%esp)
	movw	$77, 12(%esp)
	movw	$77, 14(%esp)
	movq	8(%esp), %mm4
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.mainsc_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	512(%esi)
	movq	0(%esi), %mm0
	movq	8(%esi), %mm1
	movq	16(%esi), %mm2
	movq	24(%esi), %mm3
	prefetchnta	544(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 0(%edi)
	movntq	%mm1, 8(%edi)
	movntq	%mm2, 16(%edi)
	movntq	%mm3, 24(%edi)
	prefetchnta	576(%esi)
	movq	32(%esi), %mm0
	movq	40(%esi), %mm1
	movq	48(%esi), %mm2
	movq	56(%esi), %mm3
	prefetchnta	608(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 32(%edi)
	movntq	%mm1, 40(%edi)
	movntq	%mm2, 48(%edi)
	movntq	%mm3, 56(%edi)
	prefetchnta	640(%esi)
	movq	64(%esi), %mm0
	movq	72(%esi), %mm1
	movq	80(%esi), %mm2
	movq	88(%esi), %mm3
	prefetchnta	672(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 64(%edi)
	movntq	%mm1, 72(%edi)
	movntq	%mm2, 80(%edi)
	movntq	%mm3, 88(%edi)
	prefetchnta	704(%esi)
	movq	96(%esi), %mm0
	movq	104(%esi), %mm1
	movq	112(%esi), %mm2
	movq	120(%esi), %mm3
	prefetchnta	736(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 96(%edi)
	movntq	%mm1, 104(%edi)
	movntq	%mm2, 112(%edi)
	movntq	%mm3, 120(%edi)
	prefetchnta	768(%esi)
	movq	128(%esi), %mm0
	movq	136(%esi), %mm1
	movq	144(%esi), %mm2
	movq	152(%esi), %mm3
	prefetchnta	800(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 128(%edi)
	movntq	%mm1, 136(%edi)
	movntq	%mm2, 144(%edi)
	movntq	%mm3, 152(%edi)
	prefetchnta	832(%esi)
	movq	160(%esi), %mm0
	movq	168(%esi), %mm1
	movq	176(%esi), %mm2
	movq	184(%esi), %mm3
	prefetchnta	864(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 160(%edi)
	movntq	%mm1, 168(%edi)
	movntq	%mm2, 176(%edi)
	movntq	%mm3, 184(%edi)
	prefetchnta	896(%esi)
	movq	192(%esi), %mm0
	movq	200(%esi), %mm1
	movq	208(%esi), %mm2
	movq	216(%esi), %mm3
	prefetchnta	928(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 192(%edi)
	movntq	%mm1, 200(%edi)
	movntq	%mm2, 208(%edi)
	movntq	%mm3, 216(%edi)
	prefetchnta	960(%esi)
	movq	224(%esi), %mm0
	movq	232(%esi), %mm1
	movq	240(%esi), %mm2
	movq	248(%esi), %mm3
	prefetchnta	992(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 224(%edi)
	movntq	%mm1, 232(%edi)
	movntq	%mm2, 240(%edi)
	movntq	%mm3, 248(%edi)
	movq	256(%esi), %mm0
	movq	264(%esi), %mm1
	movq	272(%esi), %mm2
	movq	280(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 256(%edi)
	movntq	%mm1, 264(%edi)
	movntq	%mm2, 272(%edi)
	movntq	%mm3, 280(%edi)	
	movq	288(%esi), %mm0
	movq	296(%esi), %mm1
	movq	304(%esi), %mm2
	movq	312(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 288(%edi)
	movntq	%mm1, 296(%edi)
	movntq	%mm2, 304(%edi)
	movntq	%mm3, 312(%edi)
	movq	320(%esi), %mm0
	movq	328(%esi), %mm1
	movq	336(%esi), %mm2
	movq	344(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 320(%edi)
	movntq	%mm1, 328(%edi)
	movntq	%mm2, 336(%edi)
	movntq	%mm3, 344(%edi)
	movq	352(%esi), %mm0
	movq	360(%esi), %mm1
	movq	368(%esi), %mm2
	movq	376(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 352(%edi)
	movntq	%mm1, 360(%edi)
	movntq	%mm2, 368(%edi)
	movntq	%mm3, 376(%edi)
	movq	384(%esi), %mm0
	movq	392(%esi), %mm1
	movq	400(%esi), %mm2
	movq	408(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 384(%edi)
	movntq	%mm1, 392(%edi)
	movntq	%mm2, 400(%edi)
	movntq	%mm3, 408(%edi)
	movq	416(%esi), %mm0
	movq	424(%esi), %mm1
	movq	432(%esi), %mm2
	movq	440(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 416(%edi)
	movntq	%mm1, 424(%edi)
	movntq	%mm2, 432(%edi)
	movntq	%mm3, 440(%edi)
	movq	448(%esi), %mm0
	movq	456(%esi), %mm1
	movq	464(%esi), %mm2
	movq	472(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 448(%edi)
	movntq	%mm1, 456(%edi)
	movntq	%mm2, 464(%edi)
	movntq	%mm3, 472(%edi)
	movq	480(%esi), %mm0
	movq	488(%esi), %mm1
	movq	496(%esi), %mm2
	movq	504(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 480(%edi)
	movntq	%mm1, 488(%edi)
	movntq	%mm2, 496(%edi)
	movntq	%mm3, 504(%edi)
	addl	$512, %esi
	addl	$512, %edi
	decl	%ebx
	jnz	.mainsc_nt

	movl	%ecx, %ebx
	movl	%edx, %esi
	movl	%ebp, %edi
	decl	%eax
	jnz	.mainsc_nt

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxad_nt
mmxad_nt:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %ebp
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	$0x00370037, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm1
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
.pread_nt:
	movntq	%mm0, 0(%edx)
	movntq	%mm0, 8(%edx)
	movntq	%mm0, 16(%edx)
	movntq	%mm0, 24(%edx)
	movntq	%mm1, 0(%eax)
	movntq	%mm1, 8(%eax)
	movntq	%mm1, 16(%eax)
	movntq	%mm1, 24(%eax)
	addl	$32, %edx
	addl	$32, %eax
	loopl	.pread_nt
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$512, %edx
.mainad_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	512(%ebp)
	movq	0(%ebp), %mm0
	movq	8(%ebp), %mm1
	prefetchnta	512(%esi)
	movq	16(%ebp), %mm2
	movq	24(%ebp), %mm3
	prefetchnta	544(%ebp)
	movq	32(%ebp), %mm4
	movq	40(%ebp), %mm5
	prefetchnta	544(%esi)
	movq	48(%ebp), %mm6
	movq	56(%ebp), %mm7
	prefetchnta	576(%ebp)
	paddusw	0(%esi), %mm0
	paddusw	8(%esi), %mm1
	prefetchnta	576(%esi)
	paddusw	16(%esi), %mm2
	paddusw	24(%esi), %mm3
	prefetchnta	608(%ebp)
	paddusw	32(%esi), %mm4
	paddusw	40(%esi), %mm5
	prefetchnta	608(%esi)
	paddusw	48(%esi), %mm6
	paddusw	56(%esi), %mm7
	movntq	%mm0, 0(%edi)
	movntq	%mm1, 8(%edi)
	movntq	%mm2, 16(%edi)
	movntq	%mm3, 24(%edi)
	movntq	%mm4, 32(%edi)
	movntq	%mm5, 40(%edi)
	movntq	%mm6, 48(%edi)
	movntq	%mm7, 56(%edi)
	prefetchnta	640(%ebp)
	movq	64(%ebp), %mm0
	movq	72(%ebp), %mm1
	prefetchnta	640(%esi)
	movq	80(%ebp), %mm2
	movq	88(%ebp), %mm3
	prefetchnta	672(%ebp)
	movq	96(%ebp), %mm4
	movq	104(%ebp), %mm5
	prefetchnta	672(%esi)
	movq	112(%ebp), %mm6
	movq	120(%ebp), %mm7
	prefetchnta	704(%ebp)
	paddusw	64(%esi), %mm0
	paddusw	72(%esi), %mm1
	prefetchnta	704(%esi)
	paddusw	80(%esi), %mm2
	paddusw	88(%esi), %mm3
	prefetchnta	736(%ebp)
	paddusw	96(%esi), %mm4
	paddusw	104(%esi), %mm5
	prefetchnta	736(%esi)
	paddusw	112(%esi), %mm6
	paddusw	120(%esi), %mm7
	movntq	%mm0, 64(%edi)
	movntq	%mm1, 72(%edi)
	movntq	%mm2, 80(%edi)
	movntq	%mm3, 88(%edi)
	movntq	%mm4, 96(%edi)
	movntq	%mm5, 104(%edi)
	movntq	%mm6, 112(%edi)
	movntq	%mm7, 120(%edi)
	prefetchnta	768(%ebp)
	movq	128(%ebp), %mm0
	movq	136(%ebp), %mm1
	prefetchnta	768(%esi)
	movq	144(%ebp), %mm2
	movq	152(%ebp), %mm3
	prefetchnta	800(%ebp)
	movq	160(%ebp), %mm4
	movq	168(%ebp), %mm5
	prefetchnta	800(%esi)
	movq	176(%ebp), %mm6
	movq	184(%ebp), %mm7
	prefetchnta	832(%ebp)
	paddusw	128(%esi), %mm0
	paddusw	136(%esi), %mm1
	prefetchnta	832(%esi)
	paddusw	144(%esi), %mm2
	paddusw	152(%esi), %mm3
	prefetchnta	864(%ebp)
	paddusw	160(%esi), %mm4
	paddusw	168(%esi), %mm5
	prefetchnta	864(%esi)
	paddusw	176(%esi), %mm6
	paddusw	184(%esi), %mm7
	movntq	%mm0, 128(%edi)
	movntq	%mm1, 136(%edi)
	movntq	%mm2, 144(%edi)
	movntq	%mm3, 152(%edi)
	movntq	%mm4, 160(%edi)
	movntq	%mm5, 168(%edi)
	movntq	%mm6, 176(%edi)
	movntq	%mm7, 184(%edi)
	prefetchnta	896(%ebp)
	movq	192(%ebp), %mm0
	movq	200(%ebp), %mm1
	prefetchnta	896(%esi)
	movq	208(%ebp), %mm2
	movq	216(%ebp), %mm3
	prefetchnta	928(%ebp)
	movq	224(%ebp), %mm4
	movq	232(%ebp), %mm5
	prefetchnta	928(%esi)
	movq	240(%ebp), %mm6
	movq	248(%ebp), %mm7
	prefetchnta	960(%ebp)
	paddusw	192(%esi), %mm0
	paddusw	200(%esi), %mm1
	prefetchnta	960(%esi)
	paddusw	208(%esi), %mm2
	paddusw	216(%esi), %mm3
	prefetchnta	992(%ebp)
	paddusw	224(%esi), %mm4
	paddusw	232(%esi), %mm5
	prefetchnta	992(%esi)
	paddusw	240(%esi), %mm6
	paddusw	248(%esi), %mm7
	movntq	%mm0, 192(%edi)
	movntq	%mm1, 200(%edi)
	movntq	%mm2, 208(%edi)
	movntq	%mm3, 216(%edi)
	movntq	%mm4, 224(%edi)
	movntq	%mm5, 232(%edi)
	movntq	%mm6, 240(%edi)
	movntq	%mm7, 248(%edi)
	movq	256(%ebp), %mm0
	movq	264(%ebp), %mm1
	movq	272(%ebp), %mm2
	movq	280(%ebp), %mm3
	movq	288(%ebp), %mm4
	movq	296(%ebp), %mm5
	movq	304(%ebp), %mm6
	movq	312(%ebp), %mm7
	paddusw	256(%esi), %mm0
	paddusw	264(%esi), %mm1
	paddusw	272(%esi), %mm2
	paddusw	280(%esi), %mm3
	paddusw	288(%esi), %mm4
	paddusw	296(%esi), %mm5
	paddusw	304(%esi), %mm6
	paddusw	312(%esi), %mm7
	movntq	%mm0, 256(%edi)
	movntq	%mm1, 264(%edi)
	movntq	%mm2, 272(%edi)
	movntq	%mm3, 280(%edi)
	movntq	%mm4, 288(%edi)
	movntq	%mm5, 296(%edi)
	movntq	%mm6, 304(%edi)
	movntq	%mm7, 312(%edi)
	movq	320(%ebp), %mm0
	movq	328(%ebp), %mm1
	movq	336(%ebp), %mm2
	movq	344(%ebp), %mm3
	movq	352(%ebp), %mm4
	movq	360(%ebp), %mm5
	movq	368(%ebp), %mm6
	movq	376(%ebp), %mm7
	paddusw	320(%esi), %mm0
	paddusw	328(%esi), %mm1
	paddusw	336(%esi), %mm2
	paddusw	344(%esi), %mm3
	paddusw	352(%esi), %mm4
	paddusw	360(%esi), %mm5
	paddusw	368(%esi), %mm6
	paddusw	376(%esi), %mm7
	movntq	%mm0, 320(%edi)
	movntq	%mm1, 328(%edi)
	movntq	%mm2, 336(%edi)
	movntq	%mm3, 344(%edi)
	movntq	%mm4, 352(%edi)
	movntq	%mm5, 360(%edi)
	movntq	%mm6, 368(%edi)
	movntq	%mm7, 376(%edi)
	movq	384(%ebp), %mm0
	movq	392(%ebp), %mm1
	movq	400(%ebp), %mm2
	movq	408(%ebp), %mm3
	movq	416(%ebp), %mm4
	movq	424(%ebp), %mm5
	movq	432(%ebp), %mm6
	movq	440(%ebp), %mm7
	paddusw	384(%esi), %mm0
	paddusw	392(%esi), %mm1
	paddusw	400(%esi), %mm2
	paddusw	408(%esi), %mm3
	paddusw	416(%esi), %mm4
	paddusw	424(%esi), %mm5
	paddusw	432(%esi), %mm6
	paddusw	440(%esi), %mm7
	movntq	%mm0, 384(%edi)
	movntq	%mm1, 392(%edi)
	movntq	%mm2, 400(%edi)
	movntq	%mm3, 408(%edi)
	movntq	%mm4, 416(%edi)
	movntq	%mm5, 424(%edi)
	movntq	%mm6, 432(%edi)
	movntq	%mm7, 440(%edi)
	movq	448(%ebp), %mm0
	movq	456(%ebp), %mm1
	movq	464(%ebp), %mm2
	movq	472(%ebp), %mm3
	movq	480(%ebp), %mm4
	movq	488(%ebp), %mm5
	movq	496(%ebp), %mm6
	movq	504(%ebp), %mm7
	paddusw	448(%esi), %mm0
	paddusw	456(%esi), %mm1
	paddusw	464(%esi), %mm2
	paddusw	472(%esi), %mm3
	paddusw	480(%esi), %mm4
	paddusw	488(%esi), %mm5
	paddusw	496(%esi), %mm6
	paddusw	504(%esi), %mm7
	movntq	%mm0, 448(%edi)
	movntq	%mm1, 456(%edi)
	movntq	%mm2, 464(%edi)
	movntq	%mm3, 472(%edi)
	movntq	%mm4, 480(%edi)
	movntq	%mm5, 488(%edi)
	movntq	%mm6, 496(%edi)
	movntq	%mm7, 504(%edi)
	addl	%edx, %esi
	addl	%edx, %ebp
	addl	%edx, %edi
	decl	%ebx
	jnz	.mainad_nt

	movl	%ecx, %ebx
	movl	8(%esp), %esi
	movl	12(%esp), %ebp
	movl	16(%esp), %edi
	decl	%eax
	jnz	.mainad_nt

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxtr_nt
mmxtr_nt:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %ebp
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	$0x00370037, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm1
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
.pretr_nt:
	movntq	%mm0, 0(%edx)
	movntq	%mm0, 8(%edx)
	movntq	%mm0, 16(%edx)
	movntq	%mm0, 24(%edx)
	movntq	%mm1, 0(%eax)
	movntq	%mm1, 8(%eax)
	movntq	%mm1, 16(%eax)
	movntq	%mm1, 24(%eax)
	addl	$32, %edx
	addl	$32, %eax
	loopl	.pretr_nt
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	movw	$77, 8(%esp)
	movw	$77, 10(%esp)
	movw	$77, 12(%esp)
	movw	$77, 14(%esp)
	movq	8(%esp), %mm4
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$512, %edx
.maintr_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	512(%ebp)
	movq	0(%ebp), %mm0
	movq	8(%ebp), %mm1
	prefetchnta	512(%esi)
	movq	16(%ebp), %mm2
	movq	24(%ebp), %mm3
	prefetchnta	544(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetchnta	544(%esi)
	paddusw	0(%esi), %mm0
	paddusw	8(%esi), %mm1
	paddusw	16(%esi), %mm2
	paddusw	24(%esi), %mm3
	movntq	%mm0, 0(%edi)
	movntq	%mm1, 8(%edi)
	movntq	%mm2, 16(%edi)
	movntq	%mm3, 24(%edi)
	prefetchnta	576(%ebp)
	movq	32(%ebp), %mm0
	movq	40(%ebp), %mm1
	prefetchnta	576(%esi)
	movq	48(%ebp), %mm2
	movq	56(%ebp), %mm3
	prefetchnta	608(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetchnta	608(%esi)
	paddusw	32(%esi), %mm0
	paddusw	40(%esi), %mm1
	paddusw	48(%esi), %mm2
	paddusw	56(%esi), %mm3
	movntq	%mm0, 32(%edi)
	movntq	%mm1, 40(%edi)
	movntq	%mm2, 48(%edi)
	movntq	%mm3, 56(%edi)
	prefetchnta	640(%ebp)
	movq	64(%ebp), %mm0
	movq	72(%ebp), %mm1
	prefetchnta	640(%esi)
	movq	80(%ebp), %mm2
	movq	88(%ebp), %mm3
	prefetchnta	672(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetchnta	672(%esi)
	paddusw	64(%esi), %mm0
	paddusw	72(%esi), %mm1
	paddusw	80(%esi), %mm2
	paddusw	88(%esi), %mm3
	movntq	%mm0, 64(%edi)
	movntq	%mm1, 72(%edi)
	movntq	%mm2, 80(%edi)
	movntq	%mm3, 88(%edi)
	prefetchnta	704(%ebp)
	movq	96(%ebp), %mm0
	movq	104(%ebp), %mm1
	prefetchnta	704(%esi)
	movq	112(%ebp), %mm2
	movq	120(%ebp), %mm3
	prefetchnta	736(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetchnta	736(%esi)
	paddusw	96(%esi), %mm0
	paddusw	104(%esi), %mm1
	paddusw	112(%esi), %mm2
	paddusw	120(%esi), %mm3
	movntq	%mm0, 96(%edi)
	movntq	%mm1, 104(%edi)
	movntq	%mm2, 112(%edi)
	movntq	%mm3, 120(%edi)
	prefetchnta	768(%ebp)
	movq	128(%ebp), %mm0
	movq	136(%ebp), %mm1
	prefetchnta	768(%esi)
	movq	144(%ebp), %mm2
	movq	152(%ebp), %mm3
	prefetchnta	800(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetchnta	800(%esi)
	paddusw	128(%esi), %mm0
	paddusw	136(%esi), %mm1
	paddusw	144(%esi), %mm2
	paddusw	152(%esi), %mm3
	movntq	%mm0, 128(%edi)
	movntq	%mm1, 136(%edi)
	movntq	%mm2, 144(%edi)
	movntq	%mm3, 152(%edi)
	prefetchnta	832(%ebp)
	movq	160(%ebp), %mm0
	movq	168(%ebp), %mm1
	prefetchnta	832(%esi)
	movq	176(%ebp), %mm2
	movq	184(%ebp), %mm3
	prefetchnta	864(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetchnta	864(%esi)
	paddusw	160(%esi), %mm0
	paddusw	168(%esi), %mm1
	paddusw	176(%esi), %mm2
	paddusw	184(%esi), %mm3
	movntq	%mm0, 160(%edi)
	movntq	%mm1, 168(%edi)
	movntq	%mm2, 176(%edi)
	movntq	%mm3, 184(%edi)
	prefetchnta	896(%ebp)
	movq	192(%ebp), %mm0
	movq	200(%ebp), %mm1
	prefetchnta	896(%esi)
	movq	208(%ebp), %mm2
	movq	216(%ebp), %mm3
	prefetchnta	928(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetchnta	928(%esi)
	paddusw	192(%esi), %mm0
	paddusw	200(%esi), %mm1
	paddusw	208(%esi), %mm2
	paddusw	216(%esi), %mm3
	movntq	%mm0, 192(%edi)
	movntq	%mm1, 200(%edi)
	movntq	%mm2, 208(%edi)
	movntq	%mm3, 216(%edi)
	prefetchnta	960(%ebp)
	movq	224(%ebp), %mm0
	movq	232(%ebp), %mm1
	prefetchnta	960(%esi)
	movq	240(%ebp), %mm2
	movq	248(%ebp), %mm3
	prefetchnta	992(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetchnta	992(%esi)
	paddusw	224(%esi), %mm0
	paddusw	232(%esi), %mm1
	paddusw	240(%esi), %mm2
	paddusw	248(%esi), %mm3
	movntq	%mm0, 224(%edi)
	movntq	%mm1, 232(%edi)
	movntq	%mm2, 240(%edi)
	movntq	%mm3, 248(%edi)
	movq	256(%ebp), %mm0
	movq	264(%ebp), %mm1
	movq	272(%ebp), %mm2
	movq	280(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	256(%esi), %mm0
	paddusw	264(%esi), %mm1
	paddusw	272(%esi), %mm2
	paddusw	280(%esi), %mm3
	movntq	%mm0, 256(%edi)
	movntq	%mm1, 264(%edi)
	movntq	%mm2, 272(%edi)
	movntq	%mm3, 280(%edi)
	movq	288(%ebp), %mm0
	movq	296(%ebp), %mm1
	movq	304(%ebp), %mm2
	movq	312(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	288(%esi), %mm0
	paddusw	296(%esi), %mm1
	paddusw	304(%esi), %mm2
	paddusw	312(%esi), %mm3
	movntq	%mm0, 288(%edi)
	movntq	%mm1, 296(%edi)
	movntq	%mm2, 304(%edi)
	movntq	%mm3, 312(%edi)
	movq	320(%ebp), %mm0
	movq	328(%ebp), %mm1
	movq	336(%ebp), %mm2
	movq	344(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	320(%esi), %mm0
	paddusw	328(%esi), %mm1
	paddusw	336(%esi), %mm2
	paddusw	344(%esi), %mm3
	movntq	%mm0, 320(%edi)
	movntq	%mm1, 328(%edi)
	movntq	%mm2, 336(%edi)
	movntq	%mm3, 344(%edi)
	movq	352(%ebp), %mm0
	movq	360(%ebp), %mm1
	movq	368(%ebp), %mm2
	movq	376(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	352(%esi), %mm0
	paddusw	360(%esi), %mm1
	paddusw	368(%esi), %mm2
	paddusw	376(%esi), %mm3
	movntq	%mm0, 352(%edi)
	movntq	%mm1, 360(%edi)
	movntq	%mm2, 368(%edi)
	movntq	%mm3, 376(%edi)
	movq	384(%ebp), %mm0
	movq	392(%ebp), %mm1
	movq	400(%ebp), %mm2
	movq	408(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	384(%esi), %mm0
	paddusw	392(%esi), %mm1
	paddusw	400(%esi), %mm2
	paddusw	408(%esi), %mm3
	movntq	%mm0, 384(%edi)
	movntq	%mm1, 392(%edi)
	movntq	%mm2, 400(%edi)
	movntq	%mm3, 408(%edi)
	movq	416(%ebp), %mm0
	movq	424(%ebp), %mm1
	movq	432(%ebp), %mm2
	movq	440(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	416(%esi), %mm0
	paddusw	424(%esi), %mm1
	paddusw	432(%esi), %mm2
	paddusw	440(%esi), %mm3
	movntq	%mm0, 416(%edi)
	movntq	%mm1, 424(%edi)
	movntq	%mm2, 432(%edi)
	movntq	%mm3, 440(%edi)
	movq	448(%ebp), %mm0
	movq	456(%ebp), %mm1
	movq	464(%ebp), %mm2
	movq	472(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	448(%esi), %mm0
	paddusw	456(%esi), %mm1
	paddusw	464(%esi), %mm2
	paddusw	472(%esi), %mm3
	movntq	%mm0, 448(%edi)
	movntq	%mm1, 456(%edi)
	movntq	%mm2, 464(%edi)
	movntq	%mm3, 472(%edi)
	movq	480(%ebp), %mm0
	movq	488(%ebp), %mm1
	movq	496(%ebp), %mm2
	movq	504(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	480(%esi), %mm0
	paddusw	488(%esi), %mm1
	paddusw	496(%esi), %mm2
	paddusw	504(%esi), %mm3
	movntq	%mm0, 480(%edi)
	movntq	%mm1, 488(%edi)
	movntq	%mm2, 496(%edi)
	movntq	%mm3, 504(%edi)
	addl	%edx, %esi
	addl	%edx, %ebp
	addl	%edx, %edi
	decl	%ebx
	jnz	.maintr_nt

	movl	%ecx, %ebx
	movl	8(%esp), %esi
	movl	12(%esp), %ebp
	movl	16(%esp), %edi
	decl	%eax
	jnz	.maintr_nt

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxcp_nt_t0
mmxcp_nt_t0:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
.precp_nt_t0:
	movntq	%mm0, 0(%edx)
	movntq	%mm0, 8(%edx)
	movntq	%mm0, 16(%edx)
	movntq	%mm0, 24(%edx)
	addl	$32, %edx
	loopl	.precp_nt_t0
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.maincp_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	512(%esi)
	movq	0(%esi), %mm0
	movq	8(%esi), %mm1
	prefetcht0	544(%esi)
	movq	16(%esi), %mm2
	movq	24(%esi), %mm3
	prefetcht0	576(%esi)
	movq	32(%esi), %mm4
	movq	40(%esi), %mm5
	prefetcht0	608(%esi)
	movq	48(%esi), %mm6
	movq	56(%esi), %mm7
	movntq	%mm0, 0(%edi)
	movntq	%mm1, 8(%edi)
	movntq	%mm2, 16(%edi)
	movntq	%mm3, 24(%edi)
	movntq	%mm4, 32(%edi)
	movntq	%mm5, 40(%edi)
	movntq	%mm6, 48(%edi)
	movntq	%mm7, 56(%edi)
	prefetcht0	640(%esi)
	movq	64(%esi), %mm0
	movq	72(%esi), %mm1
	prefetcht0	672(%esi)
	movq	80(%esi), %mm2
	movq	88(%esi), %mm3
	prefetcht0	704(%esi)
	movq	96(%esi), %mm4
	movq	104(%esi), %mm5
	prefetcht0	736(%esi)
	movq	112(%esi), %mm6
	movq	120(%esi), %mm7
	movntq	%mm0, 64(%edi)
	movntq	%mm1, 72(%edi)
	movntq	%mm2, 80(%edi)
	movntq	%mm3, 88(%edi)
	movntq	%mm4, 96(%edi)
	movntq	%mm5, 104(%edi)
	movntq	%mm6, 112(%edi)
	movntq	%mm7, 120(%edi)
	prefetcht0	768(%esi)
	movq	128(%esi), %mm0
	movq	136(%esi), %mm1
	prefetcht0	800(%esi)
	movq	144(%esi), %mm2
	movq	152(%esi), %mm3
	prefetcht0	832(%esi)
	movq	160(%esi), %mm4
	movq	168(%esi), %mm5
	prefetcht0	864(%esi)
	movq	176(%esi), %mm6
	movq	184(%esi), %mm7
	movntq	%mm0, 128(%edi)
	movntq	%mm1, 136(%edi)
	movntq	%mm2, 144(%edi)
	movntq	%mm3, 152(%edi)
	movntq	%mm4, 160(%edi)
	movntq	%mm5, 168(%edi)
	movntq	%mm6, 176(%edi)
	movntq	%mm7, 184(%edi)
	prefetcht0	896(%esi)
	movq	192(%esi), %mm0
	movq	200(%esi), %mm1
	prefetcht0	928(%esi)
	movq	208(%esi), %mm2
	movq	216(%esi), %mm3
	prefetcht0	960(%esi)
	movq	224(%esi), %mm4
	movq	232(%esi), %mm5
	prefetcht0	992(%esi)
	movq	240(%esi), %mm6
	movq	248(%esi), %mm7
	movntq	%mm0, 192(%edi)
	movntq	%mm1, 200(%edi)
	movntq	%mm2, 208(%edi)
	movntq	%mm3, 216(%edi)
	movntq	%mm4, 224(%edi)
	movntq	%mm5, 232(%edi)
	movntq	%mm6, 240(%edi)
	movntq	%mm7, 248(%edi)
	movq	256(%esi), %mm0
	movq	264(%esi), %mm1
	movq	272(%esi), %mm2
	movq	280(%esi), %mm3
	movq	288(%esi), %mm4
	movq	296(%esi), %mm5
	movq	304(%esi), %mm6
	movq	312(%esi), %mm7
	movntq	%mm0, 256(%edi)
	movntq	%mm1, 264(%edi)
	movntq	%mm2, 272(%edi)
	movntq	%mm3, 280(%edi)
	movntq	%mm4, 288(%edi)
	movntq	%mm5, 296(%edi)
	movntq	%mm6, 304(%edi)
	movntq	%mm7, 312(%edi)
	movq	320(%esi), %mm0
	movq	328(%esi), %mm1
	movq	336(%esi), %mm2
	movq	344(%esi), %mm3
	movq	352(%esi), %mm4
	movq	360(%esi), %mm5
	movq	368(%esi), %mm6
	movq	376(%esi), %mm7
	movntq	%mm0, 320(%edi)
	movntq	%mm1, 328(%edi)
	movntq	%mm2, 336(%edi)
	movntq	%mm3, 344(%edi)
	movntq	%mm4, 352(%edi)
	movntq	%mm5, 360(%edi)
	movntq	%mm6, 368(%edi)
	movntq	%mm7, 376(%edi)
	movq	384(%esi), %mm0
	movq	392(%esi), %mm1
	movq	400(%esi), %mm2
	movq	408(%esi), %mm3
	movq	416(%esi), %mm4
	movq	424(%esi), %mm5
	movq	432(%esi), %mm6
	movq	440(%esi), %mm7
	movntq	%mm0, 384(%edi)
	movntq	%mm1, 392(%edi)
	movntq	%mm2, 400(%edi)
	movntq	%mm3, 408(%edi)
	movntq	%mm4, 416(%edi)
	movntq	%mm5, 424(%edi)
	movntq	%mm6, 432(%edi)
	movntq	%mm7, 440(%edi)
	movq	448(%esi), %mm0
	movq	456(%esi), %mm1
	movq	464(%esi), %mm2
	movq	472(%esi), %mm3
	movq	480(%esi), %mm4
	movq	488(%esi), %mm5
	movq	496(%esi), %mm6
	movq	504(%esi), %mm7
	movntq	%mm0, 448(%edi)
	movntq	%mm1, 456(%edi)
	movntq	%mm2, 464(%edi)
	movntq	%mm3, 472(%edi)
	movntq	%mm4, 480(%edi)
	movntq	%mm5, 488(%edi)
	movntq	%mm6, 496(%edi)
	movntq	%mm7, 504(%edi)
	addl	$512, %esi
	addl	$512, %edi
	decl	%ebx
	jnz	.maincp_nt_t0

	movl	%ecx, %ebx
	movl	%edx, %esi
	movl	%ebp, %edi
	decl	%eax
	jnz	.maincp_nt_t0

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxsc_nt_t0
mmxsc_nt_t0:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
.presc_nt_t0:
	movntq	%mm0, 0(%edx)
	movntq	%mm0, 8(%edx)
	movntq	%mm0, 16(%edx)
	movntq	%mm0, 24(%edx)
	addl	$32, %edx
	loopl	.presc_nt_t0
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	movw	$77, 8(%esp)
	movw	$77, 10(%esp)
	movw	$77, 12(%esp)
	movw	$77, 14(%esp)
	movq	8(%esp), %mm4
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.mainsc_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	512(%esi)
	movq	0(%esi), %mm0
	movq	8(%esi), %mm1
	movq	16(%esi), %mm2
	movq	24(%esi), %mm3
	prefetcht0	544(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 0(%edi)
	movntq	%mm1, 8(%edi)
	movntq	%mm2, 16(%edi)
	movntq	%mm3, 24(%edi)
	prefetcht0	576(%esi)
	movq	32(%esi), %mm0
	movq	40(%esi), %mm1
	movq	48(%esi), %mm2
	movq	56(%esi), %mm3
	prefetcht0	608(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 32(%edi)
	movntq	%mm1, 40(%edi)
	movntq	%mm2, 48(%edi)
	movntq	%mm3, 56(%edi)
	prefetcht0	640(%esi)
	movq	64(%esi), %mm0
	movq	72(%esi), %mm1
	movq	80(%esi), %mm2
	movq	88(%esi), %mm3
	prefetcht0	672(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 64(%edi)
	movntq	%mm1, 72(%edi)
	movntq	%mm2, 80(%edi)
	movntq	%mm3, 88(%edi)
	prefetcht0	704(%esi)
	movq	96(%esi), %mm0
	movq	104(%esi), %mm1
	movq	112(%esi), %mm2
	movq	120(%esi), %mm3
	prefetcht0	736(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 96(%edi)
	movntq	%mm1, 104(%edi)
	movntq	%mm2, 112(%edi)
	movntq	%mm3, 120(%edi)
	prefetcht0	768(%esi)
	movq	128(%esi), %mm0
	movq	136(%esi), %mm1
	movq	144(%esi), %mm2
	movq	152(%esi), %mm3
	prefetcht0	800(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 128(%edi)
	movntq	%mm1, 136(%edi)
	movntq	%mm2, 144(%edi)
	movntq	%mm3, 152(%edi)
	prefetcht0	832(%esi)
	movq	160(%esi), %mm0
	movq	168(%esi), %mm1
	movq	176(%esi), %mm2
	movq	184(%esi), %mm3
	prefetcht0	864(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 160(%edi)
	movntq	%mm1, 168(%edi)
	movntq	%mm2, 176(%edi)
	movntq	%mm3, 184(%edi)
	prefetcht0	896(%esi)
	movq	192(%esi), %mm0
	movq	200(%esi), %mm1
	movq	208(%esi), %mm2
	movq	216(%esi), %mm3
	prefetcht0	928(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 192(%edi)
	movntq	%mm1, 200(%edi)
	movntq	%mm2, 208(%edi)
	movntq	%mm3, 216(%edi)
	prefetcht0	960(%esi)
	movq	224(%esi), %mm0
	movq	232(%esi), %mm1
	movq	240(%esi), %mm2
	movq	248(%esi), %mm3
	prefetcht0	992(%esi)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 224(%edi)
	movntq	%mm1, 232(%edi)
	movntq	%mm2, 240(%edi)
	movntq	%mm3, 248(%edi)
	movq	256(%esi), %mm0
	movq	264(%esi), %mm1
	movq	272(%esi), %mm2
	movq	280(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 256(%edi)
	movntq	%mm1, 264(%edi)
	movntq	%mm2, 272(%edi)
	movntq	%mm3, 280(%edi)	
	movq	288(%esi), %mm0
	movq	296(%esi), %mm1
	movq	304(%esi), %mm2
	movq	312(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 288(%edi)
	movntq	%mm1, 296(%edi)
	movntq	%mm2, 304(%edi)
	movntq	%mm3, 312(%edi)
	movq	320(%esi), %mm0
	movq	328(%esi), %mm1
	movq	336(%esi), %mm2
	movq	344(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 320(%edi)
	movntq	%mm1, 328(%edi)
	movntq	%mm2, 336(%edi)
	movntq	%mm3, 344(%edi)
	movq	352(%esi), %mm0
	movq	360(%esi), %mm1
	movq	368(%esi), %mm2
	movq	376(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 352(%edi)
	movntq	%mm1, 360(%edi)
	movntq	%mm2, 368(%edi)
	movntq	%mm3, 376(%edi)
	movq	384(%esi), %mm0
	movq	392(%esi), %mm1
	movq	400(%esi), %mm2
	movq	408(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 384(%edi)
	movntq	%mm1, 392(%edi)
	movntq	%mm2, 400(%edi)
	movntq	%mm3, 408(%edi)
	movq	416(%esi), %mm0
	movq	424(%esi), %mm1
	movq	432(%esi), %mm2
	movq	440(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 416(%edi)
	movntq	%mm1, 424(%edi)
	movntq	%mm2, 432(%edi)
	movntq	%mm3, 440(%edi)
	movq	448(%esi), %mm0
	movq	456(%esi), %mm1
	movq	464(%esi), %mm2
	movq	472(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 448(%edi)
	movntq	%mm1, 456(%edi)
	movntq	%mm2, 464(%edi)
	movntq	%mm3, 472(%edi)
	movq	480(%esi), %mm0
	movq	488(%esi), %mm1
	movq	496(%esi), %mm2
	movq	504(%esi), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	movntq	%mm0, 480(%edi)
	movntq	%mm1, 488(%edi)
	movntq	%mm2, 496(%edi)
	movntq	%mm3, 504(%edi)
	addl	$512, %esi
	addl	$512, %edi
	decl	%ebx
	jnz	.mainsc_nt_t0

	movl	%ecx, %ebx
	movl	%edx, %esi
	movl	%ebp, %edi
	decl	%eax
	jnz	.mainsc_nt_t0

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxad_nt_t0
mmxad_nt_t0:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %ebp
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	$0x00370037, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm1
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
.pread_nt_t0:
	movntq	%mm0, 0(%edx)
	movntq	%mm0, 8(%edx)
	movntq	%mm0, 16(%edx)
	movntq	%mm0, 24(%edx)
	movntq	%mm1, 0(%eax)
	movntq	%mm1, 8(%eax)
	movntq	%mm1, 16(%eax)
	movntq	%mm1, 24(%eax)
	addl	$32, %edx
	addl	$32, %eax
	loopl	.pread_nt_t0
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$512, %edx
.mainad_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	512(%ebp)
	movq	0(%ebp), %mm0
	movq	8(%ebp), %mm1
	prefetcht0	512(%esi)
	movq	16(%ebp), %mm2
	movq	24(%ebp), %mm3
	prefetcht0	544(%ebp)
	movq	32(%ebp), %mm4
	movq	40(%ebp), %mm5
	prefetcht0	544(%esi)
	movq	48(%ebp), %mm6
	movq	56(%ebp), %mm7
	prefetcht0	576(%ebp)
	paddusw	0(%esi), %mm0
	paddusw	8(%esi), %mm1
	prefetcht0	576(%esi)
	paddusw	16(%esi), %mm2
	paddusw	24(%esi), %mm3
	prefetcht0	608(%ebp)
	paddusw	32(%esi), %mm4
	paddusw	40(%esi), %mm5
	prefetcht0	608(%esi)
	paddusw	48(%esi), %mm6
	paddusw	56(%esi), %mm7
	movntq	%mm0, 0(%edi)
	movntq	%mm1, 8(%edi)
	movntq	%mm2, 16(%edi)
	movntq	%mm3, 24(%edi)
	movntq	%mm4, 32(%edi)
	movntq	%mm5, 40(%edi)
	movntq	%mm6, 48(%edi)
	movntq	%mm7, 56(%edi)
	prefetcht0	640(%ebp)
	movq	64(%ebp), %mm0
	movq	72(%ebp), %mm1
	prefetcht0	640(%esi)
	movq	80(%ebp), %mm2
	movq	88(%ebp), %mm3
	prefetcht0	672(%ebp)
	movq	96(%ebp), %mm4
	movq	104(%ebp), %mm5
	prefetcht0	672(%esi)
	movq	112(%ebp), %mm6
	movq	120(%ebp), %mm7
	prefetcht0	704(%ebp)
	paddusw	64(%esi), %mm0
	paddusw	72(%esi), %mm1
	prefetcht0	704(%esi)
	paddusw	80(%esi), %mm2
	paddusw	88(%esi), %mm3
	prefetcht0	736(%ebp)
	paddusw	96(%esi), %mm4
	paddusw	104(%esi), %mm5
	prefetcht0	736(%esi)
	paddusw	112(%esi), %mm6
	paddusw	120(%esi), %mm7
	movntq	%mm0, 64(%edi)
	movntq	%mm1, 72(%edi)
	movntq	%mm2, 80(%edi)
	movntq	%mm3, 88(%edi)
	movntq	%mm4, 96(%edi)
	movntq	%mm5, 104(%edi)
	movntq	%mm6, 112(%edi)
	movntq	%mm7, 120(%edi)
	prefetcht0	768(%ebp)
	movq	128(%ebp), %mm0
	movq	136(%ebp), %mm1
	prefetcht0	768(%esi)
	movq	144(%ebp), %mm2
	movq	152(%ebp), %mm3
	prefetcht0	800(%ebp)
	movq	160(%ebp), %mm4
	movq	168(%ebp), %mm5
	prefetcht0	800(%esi)
	movq	176(%ebp), %mm6
	movq	184(%ebp), %mm7
	prefetcht0	832(%ebp)
	paddusw	128(%esi), %mm0
	paddusw	136(%esi), %mm1
	prefetcht0	832(%esi)
	paddusw	144(%esi), %mm2
	paddusw	152(%esi), %mm3
	prefetcht0	864(%ebp)
	paddusw	160(%esi), %mm4
	paddusw	168(%esi), %mm5
	prefetcht0	864(%esi)
	paddusw	176(%esi), %mm6
	paddusw	184(%esi), %mm7
	movntq	%mm0, 128(%edi)
	movntq	%mm1, 136(%edi)
	movntq	%mm2, 144(%edi)
	movntq	%mm3, 152(%edi)
	movntq	%mm4, 160(%edi)
	movntq	%mm5, 168(%edi)
	movntq	%mm6, 176(%edi)
	movntq	%mm7, 184(%edi)
	prefetcht0	896(%ebp)
	movq	192(%ebp), %mm0
	movq	200(%ebp), %mm1
	prefetcht0	896(%esi)
	movq	208(%ebp), %mm2
	movq	216(%ebp), %mm3
	prefetcht0	928(%ebp)
	movq	224(%ebp), %mm4
	movq	232(%ebp), %mm5
	prefetcht0	928(%esi)
	movq	240(%ebp), %mm6
	movq	248(%ebp), %mm7
	prefetcht0	960(%ebp)
	paddusw	192(%esi), %mm0
	paddusw	200(%esi), %mm1
	prefetcht0	960(%esi)
	paddusw	208(%esi), %mm2
	paddusw	216(%esi), %mm3
	prefetcht0	992(%ebp)
	paddusw	224(%esi), %mm4
	paddusw	232(%esi), %mm5
	prefetcht0	992(%esi)
	paddusw	240(%esi), %mm6
	paddusw	248(%esi), %mm7
	movntq	%mm0, 192(%edi)
	movntq	%mm1, 200(%edi)
	movntq	%mm2, 208(%edi)
	movntq	%mm3, 216(%edi)
	movntq	%mm4, 224(%edi)
	movntq	%mm5, 232(%edi)
	movntq	%mm6, 240(%edi)
	movntq	%mm7, 248(%edi)
	movq	256(%ebp), %mm0
	movq	264(%ebp), %mm1
	movq	272(%ebp), %mm2
	movq	280(%ebp), %mm3
	movq	288(%ebp), %mm4
	movq	296(%ebp), %mm5
	movq	304(%ebp), %mm6
	movq	312(%ebp), %mm7
	paddusw	256(%esi), %mm0
	paddusw	264(%esi), %mm1
	paddusw	272(%esi), %mm2
	paddusw	280(%esi), %mm3
	paddusw	288(%esi), %mm4
	paddusw	296(%esi), %mm5
	paddusw	304(%esi), %mm6
	paddusw	312(%esi), %mm7
	movntq	%mm0, 256(%edi)
	movntq	%mm1, 264(%edi)
	movntq	%mm2, 272(%edi)
	movntq	%mm3, 280(%edi)
	movntq	%mm4, 288(%edi)
	movntq	%mm5, 296(%edi)
	movntq	%mm6, 304(%edi)
	movntq	%mm7, 312(%edi)
	movq	320(%ebp), %mm0
	movq	328(%ebp), %mm1
	movq	336(%ebp), %mm2
	movq	344(%ebp), %mm3
	movq	352(%ebp), %mm4
	movq	360(%ebp), %mm5
	movq	368(%ebp), %mm6
	movq	376(%ebp), %mm7
	paddusw	320(%esi), %mm0
	paddusw	328(%esi), %mm1
	paddusw	336(%esi), %mm2
	paddusw	344(%esi), %mm3
	paddusw	352(%esi), %mm4
	paddusw	360(%esi), %mm5
	paddusw	368(%esi), %mm6
	paddusw	376(%esi), %mm7
	movntq	%mm0, 320(%edi)
	movntq	%mm1, 328(%edi)
	movntq	%mm2, 336(%edi)
	movntq	%mm3, 344(%edi)
	movntq	%mm4, 352(%edi)
	movntq	%mm5, 360(%edi)
	movntq	%mm6, 368(%edi)
	movntq	%mm7, 376(%edi)
	movq	384(%ebp), %mm0
	movq	392(%ebp), %mm1
	movq	400(%ebp), %mm2
	movq	408(%ebp), %mm3
	movq	416(%ebp), %mm4
	movq	424(%ebp), %mm5
	movq	432(%ebp), %mm6
	movq	440(%ebp), %mm7
	paddusw	384(%esi), %mm0
	paddusw	392(%esi), %mm1
	paddusw	400(%esi), %mm2
	paddusw	408(%esi), %mm3
	paddusw	416(%esi), %mm4
	paddusw	424(%esi), %mm5
	paddusw	432(%esi), %mm6
	paddusw	440(%esi), %mm7
	movntq	%mm0, 384(%edi)
	movntq	%mm1, 392(%edi)
	movntq	%mm2, 400(%edi)
	movntq	%mm3, 408(%edi)
	movntq	%mm4, 416(%edi)
	movntq	%mm5, 424(%edi)
	movntq	%mm6, 432(%edi)
	movntq	%mm7, 440(%edi)
	movq	448(%ebp), %mm0
	movq	456(%ebp), %mm1
	movq	464(%ebp), %mm2
	movq	472(%ebp), %mm3
	movq	480(%ebp), %mm4
	movq	488(%ebp), %mm5
	movq	496(%ebp), %mm6
	movq	504(%ebp), %mm7
	paddusw	448(%esi), %mm0
	paddusw	456(%esi), %mm1
	paddusw	464(%esi), %mm2
	paddusw	472(%esi), %mm3
	paddusw	480(%esi), %mm4
	paddusw	488(%esi), %mm5
	paddusw	496(%esi), %mm6
	paddusw	504(%esi), %mm7
	movntq	%mm0, 448(%edi)
	movntq	%mm1, 456(%edi)
	movntq	%mm2, 464(%edi)
	movntq	%mm3, 472(%edi)
	movntq	%mm4, 480(%edi)
	movntq	%mm5, 488(%edi)
	movntq	%mm6, 496(%edi)
	movntq	%mm7, 504(%edi)
	addl	%edx, %esi
	addl	%edx, %ebp
	addl	%edx, %edi
	decl	%ebx
	jnz	.mainad_nt_t0

	movl	%ecx, %ebx
	movl	8(%esp), %esi
	movl	12(%esp), %ebp
	movl	16(%esp), %edi
	decl	%eax
	jnz	.mainad_nt_t0

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxtr_nt_t0
mmxtr_nt_t0:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48, %esp
/* allocate memory; 4Kb page alignment enabled */
	movl	$0x00001000, %ebp
	movl	68(%esp), %ebx
	shll	$10, %ebx
	movl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebx, %ecx
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
	addl	%ebx, %eax
	movl	%eax, %ebp
	addl	%ebx, %eax
	movl	%eax, %edi
/* prefill */
	movl	$0x00210021, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm0
	movl	$0x00370037, %eax
	movl	%eax, 0(%esp)
	movl	%eax, 4(%esp)
	movq	0(%esp), %mm1	
	movl	%ebx, %ecx
	shrl	$5, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
.pretr_nt_t0:
	movntq	%mm0, 0(%edx)
	movntq	%mm0, 8(%edx)
	movntq	%mm0, 16(%edx)
	movntq	%mm0, 24(%edx)
	movntq	%mm1, 0(%eax)
	movntq	%mm1, 8(%eax)
	movntq	%mm1, 16(%eax)
	movntq	%mm1, 24(%eax)
	addl	$32, %edx
	addl	$32, %eax
	loopl	.pretr_nt_t0
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	movw	$77, 8(%esp)
	movw	$77, 10(%esp)
	movw	$77, 12(%esp)
	movw	$77, 14(%esp)
	movq	8(%esp), %mm4
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$512, %edx
.maintr_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	512(%ebp)
	movq	0(%ebp), %mm0
	movq	8(%ebp), %mm1
	prefetcht0	512(%esi)
	movq	16(%ebp), %mm2
	movq	24(%ebp), %mm3
	prefetcht0	544(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetcht0	544(%esi)
	paddusw	0(%esi), %mm0
	paddusw	8(%esi), %mm1
	paddusw	16(%esi), %mm2
	paddusw	24(%esi), %mm3
	movntq	%mm0, 0(%edi)
	movntq	%mm1, 8(%edi)
	movntq	%mm2, 16(%edi)
	movntq	%mm3, 24(%edi)
	prefetcht0	576(%ebp)
	movq	32(%ebp), %mm0
	movq	40(%ebp), %mm1
	prefetcht0	576(%esi)
	movq	48(%ebp), %mm2
	movq	56(%ebp), %mm3
	prefetcht0	608(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetcht0	608(%esi)
	paddusw	32(%esi), %mm0
	paddusw	40(%esi), %mm1
	paddusw	48(%esi), %mm2
	paddusw	56(%esi), %mm3
	movntq	%mm0, 32(%edi)
	movntq	%mm1, 40(%edi)
	movntq	%mm2, 48(%edi)
	movntq	%mm3, 56(%edi)
	prefetcht0	640(%ebp)
	movq	64(%ebp), %mm0
	movq	72(%ebp), %mm1
	prefetcht0	640(%esi)
	movq	80(%ebp), %mm2
	movq	88(%ebp), %mm3
	prefetcht0	672(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetcht0	672(%esi)
	paddusw	64(%esi), %mm0
	paddusw	72(%esi), %mm1
	paddusw	80(%esi), %mm2
	paddusw	88(%esi), %mm3
	movntq	%mm0, 64(%edi)
	movntq	%mm1, 72(%edi)
	movntq	%mm2, 80(%edi)
	movntq	%mm3, 88(%edi)
	prefetcht0	704(%ebp)
	movq	96(%ebp), %mm0
	movq	104(%ebp), %mm1
	prefetcht0	704(%esi)
	movq	112(%ebp), %mm2
	movq	120(%ebp), %mm3
	prefetcht0	736(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetcht0	736(%esi)
	paddusw	96(%esi), %mm0
	paddusw	104(%esi), %mm1
	paddusw	112(%esi), %mm2
	paddusw	120(%esi), %mm3
	movntq	%mm0, 96(%edi)
	movntq	%mm1, 104(%edi)
	movntq	%mm2, 112(%edi)
	movntq	%mm3, 120(%edi)
	prefetcht0	768(%ebp)
	movq	128(%ebp), %mm0
	movq	136(%ebp), %mm1
	prefetcht0	768(%esi)
	movq	144(%ebp), %mm2
	movq	152(%ebp), %mm3
	prefetcht0	800(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetcht0	800(%esi)
	paddusw	128(%esi), %mm0
	paddusw	136(%esi), %mm1
	paddusw	144(%esi), %mm2
	paddusw	152(%esi), %mm3
	movntq	%mm0, 128(%edi)
	movntq	%mm1, 136(%edi)
	movntq	%mm2, 144(%edi)
	movntq	%mm3, 152(%edi)
	prefetcht0	832(%ebp)
	movq	160(%ebp), %mm0
	movq	168(%ebp), %mm1
	prefetcht0	832(%esi)
	movq	176(%ebp), %mm2
	movq	184(%ebp), %mm3
	prefetcht0	864(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetcht0	864(%esi)
	paddusw	160(%esi), %mm0
	paddusw	168(%esi), %mm1
	paddusw	176(%esi), %mm2
	paddusw	184(%esi), %mm3
	movntq	%mm0, 160(%edi)
	movntq	%mm1, 168(%edi)
	movntq	%mm2, 176(%edi)
	movntq	%mm3, 184(%edi)
	prefetcht0	896(%ebp)
	movq	192(%ebp), %mm0
	movq	200(%ebp), %mm1
	prefetcht0	896(%esi)
	movq	208(%ebp), %mm2
	movq	216(%ebp), %mm3
	prefetcht0	928(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetcht0	928(%esi)
	paddusw	192(%esi), %mm0
	paddusw	200(%esi), %mm1
	paddusw	208(%esi), %mm2
	paddusw	216(%esi), %mm3
	movntq	%mm0, 192(%edi)
	movntq	%mm1, 200(%edi)
	movntq	%mm2, 208(%edi)
	movntq	%mm3, 216(%edi)
	prefetcht0	960(%ebp)
	movq	224(%ebp), %mm0
	movq	232(%ebp), %mm1
	prefetcht0	960(%esi)
	movq	240(%ebp), %mm2
	movq	248(%ebp), %mm3
	prefetcht0	992(%ebp)
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	prefetcht0	992(%esi)
	paddusw	224(%esi), %mm0
	paddusw	232(%esi), %mm1
	paddusw	240(%esi), %mm2
	paddusw	248(%esi), %mm3
	movntq	%mm0, 224(%edi)
	movntq	%mm1, 232(%edi)
	movntq	%mm2, 240(%edi)
	movntq	%mm3, 248(%edi)
	movq	256(%ebp), %mm0
	movq	264(%ebp), %mm1
	movq	272(%ebp), %mm2
	movq	280(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	256(%esi), %mm0
	paddusw	264(%esi), %mm1
	paddusw	272(%esi), %mm2
	paddusw	280(%esi), %mm3
	movntq	%mm0, 256(%edi)
	movntq	%mm1, 264(%edi)
	movntq	%mm2, 272(%edi)
	movntq	%mm3, 280(%edi)
	movq	288(%ebp), %mm0
	movq	296(%ebp), %mm1
	movq	304(%ebp), %mm2
	movq	312(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	288(%esi), %mm0
	paddusw	296(%esi), %mm1
	paddusw	304(%esi), %mm2
	paddusw	312(%esi), %mm3
	movntq	%mm0, 288(%edi)
	movntq	%mm1, 296(%edi)
	movntq	%mm2, 304(%edi)
	movntq	%mm3, 312(%edi)
	movq	320(%ebp), %mm0
	movq	328(%ebp), %mm1
	movq	336(%ebp), %mm2
	movq	344(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	320(%esi), %mm0
	paddusw	328(%esi), %mm1
	paddusw	336(%esi), %mm2
	paddusw	344(%esi), %mm3
	movntq	%mm0, 320(%edi)
	movntq	%mm1, 328(%edi)
	movntq	%mm2, 336(%edi)
	movntq	%mm3, 344(%edi)
	movq	352(%ebp), %mm0
	movq	360(%ebp), %mm1
	movq	368(%ebp), %mm2
	movq	376(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	352(%esi), %mm0
	paddusw	360(%esi), %mm1
	paddusw	368(%esi), %mm2
	paddusw	376(%esi), %mm3
	movntq	%mm0, 352(%edi)
	movntq	%mm1, 360(%edi)
	movntq	%mm2, 368(%edi)
	movntq	%mm3, 376(%edi)
	movq	384(%ebp), %mm0
	movq	392(%ebp), %mm1
	movq	400(%ebp), %mm2
	movq	408(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	384(%esi), %mm0
	paddusw	392(%esi), %mm1
	paddusw	400(%esi), %mm2
	paddusw	408(%esi), %mm3
	movntq	%mm0, 384(%edi)
	movntq	%mm1, 392(%edi)
	movntq	%mm2, 400(%edi)
	movntq	%mm3, 408(%edi)
	movq	416(%ebp), %mm0
	movq	424(%ebp), %mm1
	movq	432(%ebp), %mm2
	movq	440(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	416(%esi), %mm0
	paddusw	424(%esi), %mm1
	paddusw	432(%esi), %mm2
	paddusw	440(%esi), %mm3
	movntq	%mm0, 416(%edi)
	movntq	%mm1, 424(%edi)
	movntq	%mm2, 432(%edi)
	movntq	%mm3, 440(%edi)
	movq	448(%ebp), %mm0
	movq	456(%ebp), %mm1
	movq	464(%ebp), %mm2
	movq	472(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	448(%esi), %mm0
	paddusw	456(%esi), %mm1
	paddusw	464(%esi), %mm2
	paddusw	472(%esi), %mm3
	movntq	%mm0, 448(%edi)
	movntq	%mm1, 456(%edi)
	movntq	%mm2, 464(%edi)
	movntq	%mm3, 472(%edi)
	movq	480(%ebp), %mm0
	movq	488(%ebp), %mm1
	movq	496(%ebp), %mm2
	movq	504(%ebp), %mm3
	pmullw	%mm4, %mm0
	pmullw	%mm4, %mm1
	pmullw	%mm4, %mm2
	pmullw	%mm4, %mm3
	paddusw	480(%esi), %mm0
	paddusw	488(%esi), %mm1
	paddusw	496(%esi), %mm2
	paddusw	504(%esi), %mm3
	movntq	%mm0, 480(%edi)
	movntq	%mm1, 488(%edi)
	movntq	%mm2, 496(%edi)
	movntq	%mm3, 504(%edi)
	addl	%edx, %esi
	addl	%edx, %ebp
	addl	%edx, %edi
	decl	%ebx
	jnz	.maintr_nt_t0

	movl	%ecx, %ebx
	movl	8(%esp), %esi
	movl	12(%esp), %ebp
	movl	16(%esp), %edi
	decl	%eax
	jnz	.maintr_nt_t0

/* wall time (finish) */
	leal	40(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* free memory */
	movl	28(%esp), %eax
	movl	%eax, 0(%esp)
	call	free
/* time calculation (in microseconds) */
	movl	40(%esp), %eax
	subl	32(%esp), %eax
	movl	$1000000, %edx
	mull	%edx
	addl	44(%esp), %eax
	subl	36(%esp), %eax
/* restore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret
