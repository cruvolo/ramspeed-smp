/*
**  SSEmem benchmarks for RAMspeed (i386)
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

.globl  ssecp
ssecp:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	shrl	$4, %ecx
	finit
	fldpi
.precp:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	addl	$16, %edx
	loopl	.precp
	ffree	%st(0)
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
.maincp:
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm1
	movaps	32(%esi), %xmm2
	movaps	48(%esi), %xmm3
	movaps	%xmm0, 0(%edi)
	movaps	%xmm1, 16(%edi)
	movaps	%xmm2, 32(%edi)
	movaps	%xmm3, 48(%edi)
	movaps	64(%esi), %xmm4
	movaps	80(%esi), %xmm5
	movaps	96(%esi), %xmm6
	movaps	112(%esi), %xmm7
	movaps	%xmm4, 64(%edi)
	movaps	%xmm5, 80(%edi)
	movaps	%xmm6, 96(%edi)
	movaps	%xmm7, 112(%edi)
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm1
	movaps	160(%esi), %xmm2
	movaps	176(%esi), %xmm3
	movaps	%xmm0, 128(%edi)
	movaps	%xmm1, 144(%edi)
	movaps	%xmm2, 160(%edi)
	movaps	%xmm3, 176(%edi)
	movaps	192(%esi), %xmm4
	movaps	208(%esi), %xmm5
	movaps	224(%esi), %xmm6
	movaps	240(%esi), %xmm7
	movaps	%xmm4, 192(%edi)
	movaps	%xmm5, 208(%edi)
	movaps	%xmm6, 224(%edi)
	movaps	%xmm7, 240(%edi)
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm1
	movaps	288(%esi), %xmm2
	movaps	304(%esi), %xmm3
	movaps	%xmm0, 256(%edi)
	movaps	%xmm1, 272(%edi)
	movaps	%xmm2, 288(%edi)
	movaps	%xmm3, 304(%edi)
	movaps	320(%esi), %xmm4
	movaps	336(%esi), %xmm5
	movaps	352(%esi), %xmm6
	movaps	368(%esi), %xmm7
	movaps	%xmm4, 320(%edi)
	movaps	%xmm5, 336(%edi)
	movaps	%xmm6, 352(%edi)
	movaps	%xmm7, 368(%edi)
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm1
	movaps	416(%esi), %xmm2
	movaps	432(%esi), %xmm3
	movaps	%xmm0, 384(%edi)
	movaps	%xmm1, 400(%edi)
	movaps	%xmm2, 416(%edi)
	movaps	%xmm3, 432(%edi)
	movaps	448(%esi), %xmm4
	movaps	464(%esi), %xmm5
	movaps	480(%esi), %xmm6
	movaps	496(%esi), %xmm7
	movaps	%xmm4, 448(%edi)
	movaps	%xmm5, 464(%edi)
	movaps	%xmm6, 480(%edi)
	movaps	%xmm7, 496(%edi)
	addl	$512, %esi
	addl	$512, %edi
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssesc
ssesc:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	shrl	$4, %ecx
	finit
	fldpi
.presc:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	addl	$16, %edx
	loopl	.presc
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	8(%esp)
	fst	12(%esp)
	fst	16(%esp)
	fst	20(%esp)
	movups	8(%esp), %xmm4
	ffree	%st(0)
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.mainsc:
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm1
	movaps	32(%esi), %xmm2
	movaps	48(%esi), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movaps	%xmm0, 0(%edi)
	movaps	%xmm1, 16(%edi)
	movaps	%xmm2, 32(%edi)
	movaps	%xmm3, 48(%edi)
	movaps	64(%esi), %xmm0
	movaps	80(%esi), %xmm1
	movaps	96(%esi), %xmm2
	movaps	112(%esi), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movaps	%xmm0, 64(%edi)
	movaps	%xmm1, 80(%edi)
	movaps	%xmm2, 96(%edi)
	movaps	%xmm3, 112(%edi)
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm1
	movaps	160(%esi), %xmm2
	movaps	176(%esi), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movaps	%xmm0, 128(%edi)
	movaps	%xmm1, 144(%edi)
	movaps	%xmm2, 160(%edi)
	movaps	%xmm3, 176(%edi)
	movaps	192(%esi), %xmm0
	movaps	208(%esi), %xmm1
	movaps	224(%esi), %xmm2
	movaps	240(%esi), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movaps	%xmm0, 192(%edi)
	movaps	%xmm1, 208(%edi)
	movaps	%xmm2, 224(%edi)
	movaps	%xmm3, 240(%edi)
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm1
	movaps	288(%esi), %xmm2
	movaps	304(%esi), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movaps	%xmm0, 256(%edi)
	movaps	%xmm1, 272(%edi)
	movaps	%xmm2, 288(%edi)
	movaps	%xmm3, 304(%edi)
	movaps	320(%esi), %xmm0
	movaps	336(%esi), %xmm1
	movaps	352(%esi), %xmm2
	movaps	368(%esi), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movaps	%xmm0, 320(%edi)
	movaps	%xmm1, 336(%edi)
	movaps	%xmm2, 352(%edi)
	movaps	%xmm3, 368(%edi)
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm1
	movaps	416(%esi), %xmm2
	movaps	432(%esi), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movaps	%xmm0, 384(%edi)
	movaps	%xmm1, 400(%edi)
	movaps	%xmm2, 416(%edi)
	movaps	%xmm3, 432(%edi)
	movaps	448(%esi), %xmm0
	movaps	464(%esi), %xmm1
	movaps	480(%esi), %xmm2
	movaps	496(%esi), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movaps	%xmm0, 448(%edi)
	movaps	%xmm1, 464(%edi)
	movaps	%xmm2, 480(%edi)
	movaps	%xmm3, 496(%edi)
	addl	$512, %esi
	addl	$512, %edi
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssead
ssead:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
	shrl	$4, %ecx
	finit
	fldpi
.pread:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	fst	0(%eax)
	fst	4(%eax)
	fst	8(%eax)
	fst	12(%eax)
	addl	$16, %edx
	addl	$16, %eax
	loopl	.pread
	ffree	%st(0)
/* wall time (start) */
	movl $0, 4(%esp)
	leal 32(%esp), %eax
	movl %eax, 0(%esp)
	call gettimeofday
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$512, %edx
.mainad:
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm1
	movaps	32(%esi), %xmm2
	movaps	48(%esi), %xmm3
	addps	0(%ebp), %xmm0
	addps	16(%ebp), %xmm1
	addps	32(%ebp), %xmm2
	addps	48(%ebp), %xmm3
	movaps	%xmm0, 0(%edi)
	movaps	%xmm1, 16(%edi)
	movaps	%xmm2, 32(%edi)
	movaps	%xmm3, 48(%edi)
	movaps	64(%esi), %xmm4
	movaps	80(%esi), %xmm5
	movaps	96(%esi), %xmm6
	movaps	112(%esi), %xmm7
	addps	64(%ebp), %xmm4
	addps	80(%ebp), %xmm5
	addps	96(%ebp), %xmm6
	addps	112(%ebp), %xmm7
	movaps	%xmm4, 64(%edi)
	movaps	%xmm5, 80(%edi)
	movaps	%xmm6, 96(%edi)
	movaps	%xmm7, 112(%edi)
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm1
	movaps	160(%esi), %xmm2
	movaps	176(%esi), %xmm3
	addps	128(%ebp), %xmm0
	addps	144(%ebp), %xmm1
	addps	160(%ebp), %xmm2
	addps	176(%ebp), %xmm3
	movaps	%xmm0, 128(%edi)
	movaps	%xmm1, 144(%edi)
	movaps	%xmm2, 160(%edi)
	movaps	%xmm3, 176(%edi)
	movaps	192(%esi), %xmm4
	movaps	208(%esi), %xmm5
	movaps	224(%esi), %xmm6
	movaps	240(%esi), %xmm7
	addps	192(%ebp), %xmm4
	addps	208(%ebp), %xmm5
	addps	224(%ebp), %xmm6
	addps	240(%ebp), %xmm7
	movaps	%xmm4, 192(%edi)
	movaps	%xmm5, 208(%edi)
	movaps	%xmm6, 224(%edi)
	movaps	%xmm7, 240(%edi)
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm1
	movaps	288(%esi), %xmm2
	movaps	304(%esi), %xmm3
	addps	256(%ebp), %xmm0
	addps	272(%ebp), %xmm1
	addps	288(%ebp), %xmm2
	addps	304(%ebp), %xmm3
	movaps	%xmm0, 256(%edi)
	movaps	%xmm1, 272(%edi)
	movaps	%xmm2, 288(%edi)
	movaps	%xmm3, 304(%edi)
	movaps	320(%esi), %xmm4
	movaps	336(%esi), %xmm5
	movaps	352(%esi), %xmm6
	movaps	368(%esi), %xmm7
	addps	320(%ebp), %xmm4
	addps	336(%ebp), %xmm5
	addps	352(%ebp), %xmm6
	addps	368(%ebp), %xmm7
	movaps	%xmm4, 320(%edi)
	movaps	%xmm5, 336(%edi)
	movaps	%xmm6, 352(%edi)
	movaps	%xmm7, 368(%edi)
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm1
	movaps	416(%esi), %xmm2
	movaps	432(%esi), %xmm3
	addps	384(%ebp), %xmm0
	addps	400(%ebp), %xmm1
	addps	416(%ebp), %xmm2
	addps	432(%ebp), %xmm3
	movaps	%xmm0, 384(%edi)
	movaps	%xmm1, 400(%edi)
	movaps	%xmm2, 416(%edi)
	movaps	%xmm3, 432(%edi)
	movaps	448(%esi), %xmm4
	movaps	464(%esi), %xmm5
	movaps	480(%esi), %xmm6
	movaps	496(%esi), %xmm7
	addps	448(%ebp), %xmm4
	addps	464(%ebp), %xmm5
	addps	480(%ebp), %xmm6
	addps	496(%ebp), %xmm7
	movaps	%xmm4, 448(%edi)
	movaps	%xmm5, 464(%edi)
	movaps	%xmm6, 480(%edi)
	movaps	%xmm7, 496(%edi)
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssetr
ssetr:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
	shrl	$4, %ecx
	finit
	fldpi
.pretr:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	fst	0(%eax)
	fst	4(%eax)
	fst	8(%eax)
	fst	12(%eax)
	addl	$16, %edx
	addl	$16, %eax
	loopl	.pretr
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	8(%esp)
	fst	12(%esp)
	fst	16(%esp)
	fst	20(%esp)
	movups	8(%esi), %xmm4
	ffree	%st(0)
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$512, %edx
.maintr:
	movaps	0(%ebp), %xmm0
	movaps	16(%ebp), %xmm1
	movaps	32(%ebp), %xmm2
	movaps	48(%ebp), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	0(%esi), %xmm0
	addps	16(%esi), %xmm1
	addps	32(%esi), %xmm2
	addps	48(%esi), %xmm3
	movaps	%xmm0, 0(%edi)
	movaps	%xmm1, 16(%edi)
	movaps	%xmm2, 32(%edi)
	movaps	%xmm3, 48(%edi)
	movaps	64(%ebp), %xmm0
	movaps	80(%ebp), %xmm1
	movaps	96(%ebp), %xmm2
	movaps	112(%ebp), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	64(%esi), %xmm0
	addps	80(%esi), %xmm1
	addps	96(%esi), %xmm2
	addps	112(%esi), %xmm3
	movaps	%xmm0, 64(%edi)
	movaps	%xmm1, 80(%edi)
	movaps	%xmm2, 96(%edi)
	movaps	%xmm3, 112(%edi)
	movaps	128(%ebp), %xmm0
	movaps	144(%ebp), %xmm1
	movaps	160(%ebp), %xmm2
	movaps	176(%ebp), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	128(%esi), %xmm0
	addps	144(%esi), %xmm1
	addps	160(%esi), %xmm2
	addps	176(%esi), %xmm3
	movaps	%xmm0, 128(%edi)
	movaps	%xmm1, 144(%edi)
	movaps	%xmm2, 160(%edi)
	movaps	%xmm3, 176(%edi)
	movaps	192(%ebp), %xmm0
	movaps	208(%ebp), %xmm1
	movaps	224(%ebp), %xmm2
	movaps	240(%ebp), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	192(%esi), %xmm0
	addps	208(%esi), %xmm1
	addps	224(%esi), %xmm2
	addps	240(%esi), %xmm3
	movaps	%xmm0, 192(%edi)
	movaps	%xmm1, 208(%edi)
	movaps	%xmm2, 224(%edi)
	movaps	%xmm3, 240(%edi)
	movaps	256(%ebp), %xmm0
	movaps	272(%ebp), %xmm1
	movaps	288(%ebp), %xmm2
	movaps	304(%ebp), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	256(%esi), %xmm0
	addps	272(%esi), %xmm1
	addps	288(%esi), %xmm2
	addps	304(%esi), %xmm3
	movaps	%xmm0, 256(%edi)
	movaps	%xmm1, 272(%edi)
	movaps	%xmm2, 288(%edi)
	movaps	%xmm3, 304(%edi)
	movaps	320(%ebp), %xmm0
	movaps	336(%ebp), %xmm1
	movaps	352(%ebp), %xmm2
	movaps	368(%ebp), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	320(%esi), %xmm0
	addps	336(%esi), %xmm1
	addps	352(%esi), %xmm2
	addps	368(%esi), %xmm3
	movaps	%xmm0, 320(%edi)
	movaps	%xmm1, 336(%edi)
	movaps	%xmm2, 352(%edi)
	movaps	%xmm3, 368(%edi)
	movaps	384(%ebp), %xmm0
	movaps	400(%ebp), %xmm1
	movaps	416(%ebp), %xmm2
	movaps	432(%ebp), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	384(%esi), %xmm0
	addps	400(%esi), %xmm1
	addps	416(%esi), %xmm2
	addps	432(%esi), %xmm3
	movaps	%xmm0, 384(%edi)
	movaps	%xmm1, 400(%edi)
	movaps	%xmm2, 416(%edi)
	movaps	%xmm3, 432(%edi)
	movaps	448(%ebp), %xmm0
	movaps	464(%ebp), %xmm1
	movaps	480(%ebp), %xmm2
	movaps	496(%ebp), %xmm3
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	448(%esi), %xmm0
	addps	464(%esi), %xmm1
	addps	480(%esi), %xmm2
	addps	496(%esi), %xmm3
	movaps	%xmm0, 448(%edi)
	movaps	%xmm1, 464(%edi)
	movaps	%xmm2, 480(%edi)
	movaps	%xmm3, 496(%edi)
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssecp_nt
ssecp_nt:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	shrl	$4, %ecx
	finit
	fldpi
.precp_nt:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	addl	$16, %edx
	loopl	.precp_nt
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$10, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.maincp_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	1024(%esi)
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm1
	movaps	32(%esi), %xmm2
	movaps	48(%esi), %xmm3
	prefetchnta	1056(%esi)
	movntps	%xmm0, 0(%edi)
	movntps	%xmm1, 16(%edi)
	movntps	%xmm2, 32(%edi)
	movntps	%xmm3, 48(%edi)
	prefetchnta	1088(%esi)
	movaps	64(%esi), %xmm4
	movaps	80(%esi), %xmm5
	movaps	96(%esi), %xmm6
	movaps	112(%esi), %xmm7
	prefetchnta	1120(%esi)
	movntps	%xmm4, 64(%edi)
	movntps	%xmm5, 80(%edi)
	movntps	%xmm6, 96(%edi)
	movntps	%xmm7, 112(%edi)
	prefetchnta	1152(%esi)
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm1
	movaps	160(%esi), %xmm2
	movaps	176(%esi), %xmm3
	prefetchnta	1184(%esi)
	movntps	%xmm0, 128(%edi)
	movntps	%xmm1, 144(%edi)
	movntps	%xmm2, 160(%edi)
	movntps	%xmm3, 176(%edi)
	prefetchnta	1216(%esi)
	movaps	192(%esi), %xmm4
	movaps	208(%esi), %xmm5
	movaps	224(%esi), %xmm6
	movaps	240(%esi), %xmm7
	prefetchnta	1248(%esi)
	movntps	%xmm4, 192(%edi)
	movntps	%xmm5, 208(%edi)
	movntps	%xmm6, 224(%edi)
	movntps	%xmm7, 240(%edi)
	prefetchnta	1280(%esi)
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm1
	movaps	288(%esi), %xmm2
	movaps	304(%esi), %xmm3
	prefetchnta	1312(%esi)
	movntps	%xmm0, 256(%edi)
	movntps	%xmm1, 272(%edi)
	movntps	%xmm2, 288(%edi)
	movntps	%xmm3, 304(%edi)
	prefetchnta	1344(%esi)
	movaps	320(%esi), %xmm4
	movaps	336(%esi), %xmm5
	movaps	352(%esi), %xmm6
	movaps	368(%esi), %xmm7
	prefetchnta	1376(%esi)
	movntps	%xmm4, 320(%edi)
	movntps	%xmm5, 336(%edi)
	movntps	%xmm6, 352(%edi)
	movntps	%xmm7, 368(%edi)
	prefetchnta	1408(%esi)
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm1
	movaps	416(%esi), %xmm2
	movaps	432(%esi), %xmm3
	prefetchnta	1440(%esi)
	movntps	%xmm0, 384(%edi)
	movntps	%xmm1, 400(%edi)
	movntps	%xmm2, 416(%edi)
	movntps	%xmm3, 432(%edi)
	prefetchnta	1472(%esi)
	movaps	448(%esi), %xmm4
	movaps	464(%esi), %xmm5
	movaps	480(%esi), %xmm6
	movaps	496(%esi), %xmm7
	prefetchnta	1504(%esi)
	movntps	%xmm4, 448(%edi)
	movntps	%xmm5, 464(%edi)
	movntps	%xmm6, 480(%edi)
	movntps	%xmm7, 496(%edi)
	prefetchnta	1536(%esi)
	movaps	512(%esi), %xmm0
	movaps	528(%esi), %xmm1
	movaps	544(%esi), %xmm2
	movaps	560(%esi), %xmm3
	prefetchnta	1568(%esi)
	movntps	%xmm0, 512(%edi)
	movntps	%xmm1, 528(%edi)
	movntps	%xmm2, 544(%edi)
	movntps	%xmm3, 560(%edi)
	prefetchnta	1600(%esi)
	movaps	576(%esi), %xmm4
	movaps	592(%esi), %xmm5
	movaps	608(%esi), %xmm6
	movaps	624(%esi), %xmm7
	prefetchnta	1632(%esi)
	movntps	%xmm4, 576(%edi)
	movntps	%xmm5, 592(%edi)
	movntps	%xmm6, 608(%edi)
	movntps	%xmm7, 624(%edi)
	prefetchnta	1664(%esi)
	movaps	640(%esi), %xmm0
	movaps	656(%esi), %xmm1
	movaps	672(%esi), %xmm2
	movaps	688(%esi), %xmm3
	prefetchnta	1696(%esi)
	movntps	%xmm0, 640(%edi)
	movntps	%xmm1, 656(%edi)
	movntps	%xmm2, 672(%edi)
	movntps	%xmm3, 688(%edi)
	prefetchnta	1728(%esi)
	movaps	704(%esi), %xmm4
	movaps	720(%esi), %xmm5
	movaps	736(%esi), %xmm6
	movaps	752(%esi), %xmm7
	prefetchnta	1760(%esi)
	movntps	%xmm4, 704(%edi)
	movntps	%xmm5, 720(%edi)
	movntps	%xmm6, 736(%edi)
	movntps	%xmm7, 752(%edi)
	prefetchnta	1792(%esi)
	movaps	768(%esi), %xmm0
	movaps	784(%esi), %xmm1
	movaps	800(%esi), %xmm2
	movaps	816(%esi), %xmm3
	prefetchnta	1824(%esi)
	movntps	%xmm0, 768(%edi)
	movntps	%xmm1, 784(%edi)
	movntps	%xmm2, 800(%edi)
	movntps	%xmm3, 816(%edi)
	prefetchnta	1856(%esi)
	movaps	832(%esi), %xmm4
	movaps	848(%esi), %xmm5
	movaps	864(%esi), %xmm6
	movaps	880(%esi), %xmm7
	prefetchnta	1888(%esi)
	movntps	%xmm4, 832(%edi)
	movntps	%xmm5, 848(%edi)
	movntps	%xmm6, 864(%edi)
	movntps	%xmm7, 880(%edi)
	prefetchnta	1920(%esi)
	movaps	896(%esi), %xmm0
	movaps	912(%esi), %xmm1
	movaps	928(%esi), %xmm2
	movaps	944(%esi), %xmm3
	prefetchnta	1952(%esi)
	movntps	%xmm0, 896(%edi)
	movntps	%xmm1, 912(%edi)
	movntps	%xmm2, 928(%edi)
	movntps	%xmm3, 944(%edi)
	prefetchnta	1984(%esi)
	movaps	960(%esi), %xmm4
	movaps	976(%esi), %xmm5
	movaps	992(%esi), %xmm6
	movaps	1008(%esi), %xmm7
	prefetchnta	2016(%esi)
	movntps	%xmm4, 960(%edi)
	movntps	%xmm5, 976(%edi)
	movntps	%xmm6, 992(%edi)
	movntps	%xmm7, 1008(%edi)
	addl	$1024, %esi
	addl	$1024, %edi
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssesc_nt
ssesc_nt:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	shrl	$4, %ecx
	finit
	fldpi
.presc_nt:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	addl	$16, %edx
	loopl	.presc_nt
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	8(%esp)
	fst	12(%esp)
	fst	16(%esp)
	fst	20(%esp)
	movups	8(%esp), %xmm4
	ffree	%st(0)
/* execute */
	shrl	$10, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.mainsc_nt:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetchnta	1024(%esi)
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm1
	movaps	32(%esi), %xmm2
	movaps	48(%esi), %xmm3
	prefetchnta	1056(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 0(%edi)
	movntps	%xmm1, 16(%edi)
	movntps	%xmm2, 32(%edi)
	movntps	%xmm3, 48(%edi)
	prefetchnta	1088(%esi)
	movaps	64(%esi), %xmm0
	movaps	80(%esi), %xmm1
	movaps	96(%esi), %xmm2
	movaps	112(%esi), %xmm3
	prefetchnta	1120(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 64(%edi)
	movntps	%xmm1, 80(%edi)
	movntps	%xmm2, 96(%edi)
	movntps	%xmm3, 112(%edi)
	prefetchnta	1152(%esi)
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm1
	movaps	160(%esi), %xmm2
	movaps	176(%esi), %xmm3
	prefetchnta	1184(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 128(%edi)
	movntps	%xmm1, 144(%edi)
	movntps	%xmm2, 160(%edi)
	movntps	%xmm3, 176(%edi)
	prefetchnta	1216(%esi)
	movaps	192(%esi), %xmm0
	movaps	208(%esi), %xmm1
	movaps	224(%esi), %xmm2
	movaps	240(%esi), %xmm3
	prefetchnta	1248(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 192(%edi)
	movntps	%xmm1, 208(%edi)
	movntps	%xmm2, 224(%edi)
	movntps	%xmm3, 240(%edi)
	prefetchnta	1280(%esi)
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm1
	movaps	288(%esi), %xmm2
	movaps	304(%esi), %xmm3
	prefetchnta	1312(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 256(%edi)
	movntps	%xmm1, 272(%edi)
	movntps	%xmm2, 288(%edi)
	movntps	%xmm3, 304(%edi)
	prefetchnta	1344(%esi)
	movaps	320(%esi), %xmm0
	movaps	336(%esi), %xmm1
	movaps	352(%esi), %xmm2
	movaps	368(%esi), %xmm3
	prefetchnta	1376(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 320(%edi)
	movntps	%xmm1, 336(%edi)
	movntps	%xmm2, 352(%edi)
	movntps	%xmm3, 368(%edi)
	prefetchnta	1408(%esi)
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm1
	movaps	416(%esi), %xmm2
	movaps	432(%esi), %xmm3
	prefetchnta	1440(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 384(%edi)
	movntps	%xmm1, 400(%edi)
	movntps	%xmm2, 416(%edi)
	movntps	%xmm3, 432(%edi)
	prefetchnta	1472(%esi)
	movaps	448(%esi), %xmm0
	movaps	464(%esi), %xmm1
	movaps	480(%esi), %xmm2
	movaps	496(%esi), %xmm3
	prefetchnta	1504(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 448(%edi)
	movntps	%xmm1, 464(%edi)
	movntps	%xmm2, 480(%edi)
	movntps	%xmm3, 496(%edi)
	prefetchnta	1536(%esi)
	movaps	512(%esi), %xmm0
	movaps	528(%esi), %xmm1
	movaps	544(%esi), %xmm2
	movaps	560(%esi), %xmm3
	prefetchnta	1568(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 512(%edi)
	movntps	%xmm1, 528(%edi)
	movntps	%xmm2, 544(%edi)
	movntps	%xmm3, 560(%edi)
	prefetchnta	1600(%esi)
	movaps	576(%esi), %xmm0
	movaps	592(%esi), %xmm1
	movaps	608(%esi), %xmm2
	movaps	624(%esi), %xmm3
	prefetchnta	1632(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 576(%edi)
	movntps	%xmm1, 592(%edi)
	movntps	%xmm2, 608(%edi)
	movntps	%xmm3, 624(%edi)
	prefetchnta	1664(%esi)
	movaps	640(%esi), %xmm0
	movaps	656(%esi), %xmm1
	movaps	672(%esi), %xmm2
	movaps	688(%esi), %xmm3
	prefetchnta	1696(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 640(%edi)
	movntps	%xmm1, 656(%edi)
	movntps	%xmm2, 672(%edi)
	movntps	%xmm3, 688(%edi)
	prefetchnta	1728(%esi)
	movaps	704(%esi), %xmm0
	movaps	720(%esi), %xmm1
	movaps	736(%esi), %xmm2
	movaps	752(%esi), %xmm3
	prefetchnta	1760(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 704(%edi)
	movntps	%xmm1, 720(%edi)
	movntps	%xmm2, 736(%edi)
	movntps	%xmm3, 752(%edi)
	prefetchnta	1792(%esi)
	movaps	768(%esi), %xmm0
	movaps	784(%esi), %xmm1
	movaps	800(%esi), %xmm2
	movaps	816(%esi), %xmm3
	prefetchnta	1824(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 768(%edi)
	movntps	%xmm1, 784(%edi)
	movntps	%xmm2, 800(%edi)
	movntps	%xmm3, 816(%edi)
	prefetchnta	1856(%esi)
	movaps	832(%esi), %xmm0
	movaps	848(%esi), %xmm1
	movaps	864(%esi), %xmm2
	movaps	880(%esi), %xmm3
	prefetchnta	1888(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 832(%edi)
	movntps	%xmm1, 848(%edi)
	movntps	%xmm2, 864(%edi)
	movntps	%xmm3, 880(%edi)
	prefetchnta	1920(%esi)
	movaps	896(%esi), %xmm0
	movaps	912(%esi), %xmm1
	movaps	928(%esi), %xmm2
	movaps	944(%esi), %xmm3
	prefetchnta	1952(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 896(%edi)
	movntps	%xmm1, 912(%edi)
	movntps	%xmm2, 928(%edi)
	movntps	%xmm3, 944(%edi)
	prefetchnta	1984(%esi)
	movaps	960(%esi), %xmm0
	movaps	976(%esi), %xmm1
	movaps	992(%esi), %xmm2
	movaps	1008(%esi), %xmm3
	prefetchnta	2016(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 960(%edi)
	movntps	%xmm1, 976(%edi)
	movntps	%xmm2, 992(%edi)
	movntps	%xmm3, 1008(%edi)
	addl	$1024, %esi
	addl	$1024, %edi
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssead_nt
ssead_nt:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
	shrl	$4, %ecx
	finit
	fldpi
.pread_nt:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	fst	0(%eax)
	fst	4(%eax)
	fst	8(%eax)
	fst	12(%eax)
	addl	$16, %edx
	addl	$16, %eax
	loopl	.pread_nt
	ffree	%st(0)
/* wall time (start) */
	movl $0, 4(%esp)
	leal 32(%esp), %eax
	movl %eax, 0(%esp)
	call gettimeofday
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
	prefetchnta	1024(%ebp)
	movaps	0(%ebp), %xmm0
	movaps	16(%ebp), %xmm1
	prefetchnta	1024(%esi)
	movaps	32(%ebp), %xmm2
	movaps	48(%ebp), %xmm3
	prefetchnta	1056(%ebp)
	movaps	64(%ebp), %xmm4
	movaps	80(%ebp), %xmm5
	prefetchnta	1056(%esi)
	movaps	96(%ebp), %xmm6
	movaps	112(%ebp), %xmm7
	prefetchnta	1088(%ebp)
	addps	0(%esi), %xmm0
	addps	16(%esi), %xmm1
	prefetchnta	1088(%esi)
	addps	32(%esi), %xmm2
	addps	48(%esi), %xmm3
	movntps	%xmm0, 0(%edi)
	movntps	%xmm1, 16(%edi)
	movntps	%xmm2, 32(%edi)
	movntps	%xmm3, 48(%edi)
	prefetchnta	1120(%ebp)
	addps	64(%esi), %xmm4
	addps	80(%esi), %xmm5
	prefetchnta	1120(%esi)
	addps	96(%esi), %xmm6
	addps	112(%esi), %xmm7
	movntps	%xmm4, 64(%edi)
	movntps	%xmm5, 80(%edi)
	movntps	%xmm6, 96(%edi)
	movntps	%xmm7, 112(%edi)
	prefetchnta	1152(%ebp)
	movaps	128(%ebp), %xmm0
	movaps	144(%ebp), %xmm1
	prefetchnta	1152(%esi)
	movaps	160(%ebp), %xmm2
	movaps	176(%ebp), %xmm3
	prefetchnta	1184(%ebp)
	movaps	192(%ebp), %xmm4
	movaps	208(%ebp), %xmm5
	prefetchnta	1184(%esi)
	movaps	224(%ebp), %xmm6
	movaps	240(%ebp), %xmm7
	prefetchnta	1216(%ebp)
	addps	128(%esi), %xmm0
	addps	144(%esi), %xmm1
	prefetchnta	1216(%esi)
	addps	160(%esi), %xmm2
	addps	176(%esi), %xmm3
	movntps	%xmm0, 128(%edi)
	movntps	%xmm1, 144(%edi)
	movntps	%xmm2, 160(%edi)
	movntps	%xmm3, 176(%edi)
	prefetchnta	1248(%ebp)
	addps	192(%esi), %xmm4
	addps	208(%esi), %xmm5
	prefetchnta	1248(%esi)
	addps	224(%esi), %xmm6
	addps	240(%esi), %xmm7
	movntps	%xmm4, 192(%edi)
	movntps	%xmm5, 208(%edi)
	movntps	%xmm6, 224(%edi)
	movntps	%xmm7, 240(%edi)
	prefetchnta	1280(%ebp)
	movaps	256(%ebp), %xmm0
	movaps	272(%ebp), %xmm1
	prefetchnta	1280(%esi)
	movaps	288(%ebp), %xmm2
	movaps	304(%ebp), %xmm3
	prefetchnta	1312(%ebp)
	movaps	320(%ebp), %xmm4
	movaps	336(%ebp), %xmm5
	prefetchnta	1312(%esi)
	movaps	352(%ebp), %xmm6
	movaps	368(%ebp), %xmm7
	prefetchnta	1344(%ebp)
	addps	256(%esi), %xmm0
	addps	272(%esi), %xmm1
	prefetchnta	1344(%esi)
	addps	288(%esi), %xmm2
	addps	304(%esi), %xmm3
	movntps	%xmm0, 256(%edi)
	movntps	%xmm1, 272(%edi)
	movntps	%xmm2, 288(%edi)
	movntps	%xmm3, 304(%edi)
	prefetchnta	1376(%ebp)
	addps	320(%esi), %xmm4
	addps	336(%esi), %xmm5
	prefetchnta	1376(%esi)
	addps	352(%esi), %xmm6
	addps	368(%esi), %xmm7
	movntps	%xmm4, 320(%edi)
	movntps	%xmm5, 336(%edi)
	movntps	%xmm6, 352(%edi)
	movntps	%xmm7, 368(%edi)
	prefetchnta	1408(%ebp)
	movaps	384(%ebp), %xmm0
	movaps	400(%ebp), %xmm1
	prefetchnta	1408(%esi)
	movaps	416(%ebp), %xmm2
	movaps	432(%ebp), %xmm3
	prefetchnta	1440(%ebp)
	movaps	448(%ebp), %xmm4
	movaps	464(%ebp), %xmm5
	prefetchnta	1440(%esi)
	movaps	480(%ebp), %xmm6
	movaps	496(%ebp), %xmm7
	prefetchnta	1472(%ebp)
	addps	384(%esi), %xmm0
	addps	400(%esi), %xmm1
	prefetchnta	1472(%esi)
	addps	416(%esi), %xmm2
	addps	432(%esi), %xmm3
	movntps	%xmm0, 384(%edi)
	movntps	%xmm1, 400(%edi)
	movntps	%xmm2, 416(%edi)
	movntps	%xmm3, 432(%edi)
	prefetchnta	1504(%ebp)
	addps	448(%esi), %xmm4
	addps	464(%esi), %xmm5
	prefetchnta	1504(%esi)
	addps	480(%esi), %xmm6
	addps	496(%esi), %xmm7
	movntps	%xmm4, 448(%edi)
	movntps	%xmm5, 464(%edi)
	movntps	%xmm6, 480(%edi)
	movntps	%xmm7, 496(%edi)
	prefetchnta	1536(%ebp)
	movaps	512(%ebp), %xmm0
	movaps	528(%ebp), %xmm1
	prefetchnta	1536(%esi)
	movaps	544(%ebp), %xmm2
	movaps	560(%ebp), %xmm3
	prefetchnta	1568(%ebp)
	movaps	576(%ebp), %xmm4
	movaps	592(%ebp), %xmm5
	prefetchnta	1568(%esi)
	movaps	608(%ebp), %xmm6
	movaps	624(%ebp), %xmm7
	prefetchnta	1600(%ebp)
	addps	512(%esi), %xmm0
	addps	528(%esi), %xmm1
	prefetchnta	1600(%esi)
	addps	544(%esi), %xmm2
	addps	560(%esi), %xmm3
	movntps	%xmm0, 512(%edi)
	movntps	%xmm1, 528(%edi)
	movntps	%xmm2, 544(%edi)
	movntps	%xmm3, 560(%edi)
	prefetchnta	1632(%ebp)
	addps	576(%esi), %xmm4
	addps	592(%esi), %xmm5
	prefetchnta	1632(%esi)
	addps	608(%esi), %xmm6
	addps	624(%esi), %xmm7
	movntps	%xmm4, 576(%edi)
	movntps	%xmm5, 592(%edi)
	movntps	%xmm6, 608(%edi)
	movntps	%xmm7, 624(%edi)
	prefetchnta	1664(%ebp)
	movaps	640(%ebp), %xmm0
	movaps	656(%ebp), %xmm1
	prefetchnta	1664(%esi)
	movaps	672(%ebp), %xmm2
	movaps	688(%ebp), %xmm3
	prefetchnta	1696(%ebp)
	movaps	704(%ebp), %xmm4
	movaps	720(%ebp), %xmm5
	prefetchnta	1696(%esi)
	movaps	736(%ebp), %xmm6
	movaps	752(%ebp), %xmm7
	prefetchnta	1728(%ebp)
	addps	640(%esi), %xmm0
	addps	656(%esi), %xmm1
	prefetchnta	1728(%esi)
	addps	672(%esi), %xmm2
	addps	688(%esi), %xmm3
	movntps	%xmm0, 640(%edi)
	movntps	%xmm1, 656(%edi)
	movntps	%xmm2, 672(%edi)
	movntps	%xmm3, 688(%edi)
	prefetchnta	1760(%ebp)
	addps	704(%esi), %xmm4
	addps	720(%esi), %xmm5
	prefetchnta	1760(%esi)
	addps	736(%esi), %xmm6
	addps	752(%esi), %xmm7
	movntps	%xmm4, 704(%edi)
	movntps	%xmm5, 720(%edi)
	movntps	%xmm6, 736(%edi)
	movntps	%xmm7, 752(%edi)
	prefetchnta	1792(%ebp)
	movaps	768(%ebp), %xmm0
	movaps	784(%ebp), %xmm1
	prefetchnta	1792(%esi)
	movaps	800(%ebp), %xmm2
	movaps	816(%ebp), %xmm3
	prefetchnta	1824(%ebp)
	movaps	832(%ebp), %xmm4
	movaps	848(%ebp), %xmm5
	prefetchnta	1824(%esi)
	movaps	864(%ebp), %xmm6
	movaps	880(%ebp), %xmm7
	prefetchnta	1856(%ebp)
	addps	768(%esi), %xmm0
	addps	784(%esi), %xmm1
	prefetchnta	1856(%esi)
	addps	800(%esi), %xmm2
	addps	816(%esi), %xmm3
	movntps	%xmm0, 768(%edi)
	movntps	%xmm1, 784(%edi)
	movntps	%xmm2, 800(%edi)
	movntps	%xmm3, 816(%edi)
	prefetchnta	1888(%ebp)
	addps	832(%esi), %xmm4
	addps	848(%esi), %xmm5
	prefetchnta	1888(%esi)
	addps	864(%esi), %xmm6
	addps	880(%esi), %xmm7
	movntps	%xmm4, 832(%edi)
	movntps	%xmm5, 848(%edi)
	movntps	%xmm6, 864(%edi)
	movntps	%xmm7, 880(%edi)
	prefetchnta	1920(%ebp)
	movaps	896(%ebp), %xmm0
	movaps	912(%ebp), %xmm1
	prefetchnta	1920(%esi)
	movaps	928(%ebp), %xmm2
	movaps	944(%ebp), %xmm3
	prefetchnta	1952(%ebp)
	movaps	960(%ebp), %xmm4
	movaps	976(%ebp), %xmm5
	prefetchnta	1952(%esi)
	movaps	992(%ebp), %xmm6
	movaps	1008(%ebp), %xmm7
	prefetchnta	1984(%ebp)
	addps	896(%esi), %xmm0
	addps	912(%esi), %xmm1
	prefetchnta	1984(%esi)
	addps	928(%esi), %xmm2
	addps	944(%esi), %xmm3
	movntps	%xmm0, 896(%edi)
	movntps	%xmm1, 912(%edi)
	movntps	%xmm2, 928(%edi)
	movntps	%xmm3, 944(%edi)
	prefetchnta	2016(%ebp)
	addps	960(%esi), %xmm4
	addps	976(%esi), %xmm5
	prefetchnta	2016(%esi)
	addps	992(%esi), %xmm6
	addps	1008(%esi), %xmm7
	movntps	%xmm4, 960(%edi)
	movntps	%xmm5, 976(%edi)
	movntps	%xmm6, 992(%edi)
	movntps	%xmm7, 1008(%edi)
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssetr_nt
ssetr_nt:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
	shrl	$4, %ecx
	finit
	fldpi
.pretr_nt:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	fst	0(%eax)
	fst	4(%eax)
	fst	8(%eax)
	fst	12(%eax)
	addl	$16, %edx
	addl	$16, %eax
	loopl	.pretr_nt
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	8(%esp)
	fst	12(%esp)
	fst	16(%esp)
	fst	20(%esp)
	movups	8(%esi), %xmm4
	ffree	%st(0)
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
	prefetchnta	1024(%ebp)
	movaps	0(%ebp), %xmm0
	movaps	16(%ebp), %xmm1
	prefetchnta	1024(%esi)
	movaps	32(%ebp), %xmm2
	movaps	48(%ebp), %xmm3
	prefetchnta	1056(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1056(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	0(%esi), %xmm0
	addps	16(%esi), %xmm1
	addps	32(%esi), %xmm2
	addps	48(%esi), %xmm3
	movntps	%xmm0, 0(%edi)
	movntps	%xmm1, 16(%edi)
	movntps	%xmm2, 32(%edi)
	movntps	%xmm3, 48(%edi)
	prefetchnta	1088(%esi)
	movaps	64(%ebp), %xmm0
	movaps	80(%ebp), %xmm1
	prefetchnta	1088(%ebp)
	movaps	96(%ebp), %xmm2
	movaps	112(%ebp), %xmm3
	prefetchnta	1120(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1120(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	64(%esi), %xmm0
	addps	80(%esi), %xmm1
	addps	96(%esi), %xmm2
	addps	112(%esi), %xmm3
	movntps	%xmm0, 64(%edi)
	movntps	%xmm1, 80(%edi)
	movntps	%xmm2, 96(%edi)
	movntps	%xmm3, 112(%edi)
	prefetchnta	1152(%ebp)
	movaps	128(%ebp), %xmm0
	movaps	144(%ebp), %xmm1
	prefetchnta	1152(%esi)
	movaps	160(%ebp), %xmm2
	movaps	176(%ebp), %xmm3
	prefetchnta	1184(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1184(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	128(%esi), %xmm0
	addps	144(%esi), %xmm1
	addps	160(%esi), %xmm2
	addps	176(%esi), %xmm3
	movntps	%xmm0, 128(%edi)
	movntps	%xmm1, 144(%edi)
	movntps	%xmm2, 160(%edi)
	movntps	%xmm3, 176(%edi)
	prefetchnta	1216(%ebp)
	movaps	192(%ebp), %xmm0
	movaps	208(%ebp), %xmm1
	prefetchnta	1216(%esi)
	movaps	224(%ebp), %xmm2
	movaps	240(%ebp), %xmm3
	prefetchnta	1248(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1248(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	192(%esi), %xmm0
	addps	208(%esi), %xmm1
	addps	224(%esi), %xmm2
	addps	240(%esi), %xmm3
	movntps	%xmm0, 192(%edi)
	movntps	%xmm1, 208(%edi)
	movntps	%xmm2, 224(%edi)
	movntps	%xmm3, 240(%edi)
	prefetchnta	1280(%ebp)
	movaps	256(%ebp), %xmm0
	movaps	272(%ebp), %xmm1
	prefetchnta	1280(%esi)
	movaps	288(%ebp), %xmm2
	movaps	304(%ebp), %xmm3
	prefetchnta	1312(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1312(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	256(%esi), %xmm0
	addps	272(%esi), %xmm1
	addps	288(%esi), %xmm2
	addps	304(%esi), %xmm3
	movntps	%xmm0, 256(%edi)
	movntps	%xmm1, 272(%edi)
	movntps	%xmm2, 288(%edi)
	movntps	%xmm3, 304(%edi)
	prefetchnta	1344(%ebp)
	movaps	320(%ebp), %xmm0
	movaps	336(%ebp), %xmm1
	prefetchnta	1344(%esi)
	movaps	352(%ebp), %xmm2
	movaps	368(%ebp), %xmm3
	prefetchnta	1376(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1376(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	320(%esi), %xmm0
	addps	336(%esi), %xmm1
	addps	352(%esi), %xmm2
	addps	368(%esi), %xmm3
	movntps	%xmm0, 320(%edi)
	movntps	%xmm1, 336(%edi)
	movntps	%xmm2, 352(%edi)
	movntps	%xmm3, 368(%edi)
	prefetchnta	1408(%ebp)
	movaps	384(%ebp), %xmm0
	movaps	400(%ebp), %xmm1
	prefetchnta	1408(%esi)
	movaps	416(%ebp), %xmm2
	movaps	432(%ebp), %xmm3
	prefetchnta	1440(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1440(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	384(%esi), %xmm0
	addps	400(%esi), %xmm1
	addps	416(%esi), %xmm2
	addps	432(%esi), %xmm3
	movntps	%xmm0, 384(%edi)
	movntps	%xmm1, 400(%edi)
	movntps	%xmm2, 416(%edi)
	movntps	%xmm3, 432(%edi)
	prefetchnta	1472(%ebp)
	movaps	448(%ebp), %xmm0
	movaps	464(%ebp), %xmm1
	prefetchnta	1472(%esi)
	movaps	480(%ebp), %xmm2
	movaps	496(%ebp), %xmm3
	prefetchnta	1504(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1504(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	448(%esi), %xmm0
	addps	464(%esi), %xmm1
	addps	480(%esi), %xmm2
	addps	496(%esi), %xmm3
	movntps	%xmm0, 448(%edi)
	movntps	%xmm1, 464(%edi)
	movntps	%xmm2, 480(%edi)
	movntps	%xmm3, 496(%edi)
	prefetchnta	1536(%ebp)
	movaps	512(%ebp), %xmm0
	movaps	528(%ebp), %xmm1
	prefetchnta	1536(%esi)
	movaps	544(%ebp), %xmm2
	movaps	560(%ebp), %xmm3
	prefetchnta	1568(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1568(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	512(%esi), %xmm0
	addps	528(%esi), %xmm1
	addps	544(%esi), %xmm2
	addps	560(%esi), %xmm3
	movntps	%xmm0, 512(%edi)
	movntps	%xmm1, 528(%edi)
	movntps	%xmm2, 544(%edi)
	movntps	%xmm3, 560(%edi)
	prefetchnta	1600(%ebp)
	movaps	576(%ebp), %xmm0
	movaps	592(%ebp), %xmm1
	prefetchnta	1600(%esi)
	movaps	608(%ebp), %xmm2
	movaps	624(%ebp), %xmm3
	prefetchnta	1632(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1632(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	576(%esi), %xmm0
	addps	592(%esi), %xmm1
	addps	608(%esi), %xmm2
	addps	624(%esi), %xmm3
	movntps	%xmm0, 576(%edi)
	movntps	%xmm1, 592(%edi)
	movntps	%xmm2, 608(%edi)
	movntps	%xmm3, 624(%edi)
	prefetchnta	1664(%ebp)
	movaps	640(%ebp), %xmm0
	movaps	656(%ebp), %xmm1
	prefetchnta	1664(%esi)
	movaps	672(%ebp), %xmm2
	movaps	688(%ebp), %xmm3
	prefetchnta	1696(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1696(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	640(%esi), %xmm0
	addps	656(%esi), %xmm1
	addps	672(%esi), %xmm2
	addps	688(%esi), %xmm3
	movntps	%xmm0, 640(%edi)
	movntps	%xmm1, 656(%edi)
	movntps	%xmm2, 672(%edi)
	movntps	%xmm3, 688(%edi)
	prefetchnta	1728(%ebp)
	movaps	704(%ebp), %xmm0
	movaps	720(%ebp), %xmm1
	prefetchnta	1728(%esi)
	movaps	736(%ebp), %xmm2
	movaps	752(%ebp), %xmm3
	prefetchnta	1760(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1760(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	704(%esi), %xmm0
	addps	720(%esi), %xmm1
	addps	736(%esi), %xmm2
	addps	752(%esi), %xmm3
	movntps	%xmm0, 704(%edi)
	movntps	%xmm1, 720(%edi)
	movntps	%xmm2, 736(%edi)
	movntps	%xmm3, 752(%edi)
	prefetchnta	1792(%ebp)
	movaps	768(%ebp), %xmm0
	movaps	784(%ebp), %xmm1
	prefetchnta	1792(%esi)
	movaps	800(%ebp), %xmm2
	movaps	816(%ebp), %xmm3
	prefetchnta	1824(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1824(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	768(%esi), %xmm0
	addps	784(%esi), %xmm1
	addps	800(%esi), %xmm2
	addps	816(%esi), %xmm3
	movntps	%xmm0, 768(%edi)
	movntps	%xmm1, 784(%edi)
	movntps	%xmm2, 800(%edi)
	movntps	%xmm3, 816(%edi)
	prefetchnta	1856(%ebp)
	movaps	832(%ebp), %xmm0
	movaps	848(%ebp), %xmm1
	prefetchnta	1856(%esi)
	movaps	864(%ebp), %xmm2
	movaps	880(%ebp), %xmm3
	prefetchnta	1888(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1888(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	832(%esi), %xmm0
	addps	848(%esi), %xmm1
	addps	864(%esi), %xmm2
	addps	880(%esi), %xmm3
	movntps	%xmm0, 832(%edi)
	movntps	%xmm1, 848(%edi)
	movntps	%xmm2, 864(%edi)
	movntps	%xmm3, 880(%edi)
	prefetchnta	1920(%ebp)
	movaps	896(%ebp), %xmm0
	movaps	912(%ebp), %xmm1
	prefetchnta	1920(%esi)
	movaps	928(%ebp), %xmm2
	movaps	944(%ebp), %xmm3
	prefetchnta	1952(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	1952(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	896(%esi), %xmm0
	addps	912(%esi), %xmm1
	addps	928(%esi), %xmm2
	addps	944(%esi), %xmm3
	movntps	%xmm0, 896(%edi)
	movntps	%xmm1, 912(%edi)
	movntps	%xmm2, 928(%edi)
	movntps	%xmm3, 944(%edi)
	prefetchnta	1984(%ebp)
	movaps	960(%ebp), %xmm0
	movaps	976(%ebp), %xmm1
	prefetchnta	1984(%esi)
	movaps	992(%ebp), %xmm2
	movaps	1008(%ebp), %xmm3
	prefetchnta	2016(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetchnta	2016(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	960(%esi), %xmm0
	addps	976(%esi), %xmm1
	addps	992(%esi), %xmm2
	addps	1008(%esi), %xmm3
	movntps	%xmm0, 960(%edi)
	movntps	%xmm1, 976(%edi)
	movntps	%xmm2, 992(%edi)
	movntps	%xmm3, 1008(%edi)

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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssecp_nt_t0
ssecp_nt_t0:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	shrl	$4, %ecx
	finit
	fldpi
.precp_nt_t0:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	addl	$16, %edx
	loopl	.precp_nt_t0
	ffree	%st(0)
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
	prefetcht0	1024(%esi)
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm1
	movaps	32(%esi), %xmm2
	movaps	48(%esi), %xmm3
	prefetcht0	1056(%esi)
	movntps	%xmm0, 0(%edi)
	movntps	%xmm1, 16(%edi)
	movntps	%xmm2, 32(%edi)
	movntps	%xmm3, 48(%edi)
	prefetcht0	1088(%esi)
	movaps	64(%esi), %xmm4
	movaps	80(%esi), %xmm5
	movaps	96(%esi), %xmm6
	movaps	112(%esi), %xmm7
	prefetcht0	1120(%esi)
	movntps	%xmm4, 64(%edi)
	movntps	%xmm5, 80(%edi)
	movntps	%xmm6, 96(%edi)
	movntps	%xmm7, 112(%edi)
	prefetcht0	1152(%esi)
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm1
	movaps	160(%esi), %xmm2
	movaps	176(%esi), %xmm3
	prefetcht0	1184(%esi)
	movntps	%xmm0, 128(%edi)
	movntps	%xmm1, 144(%edi)
	movntps	%xmm2, 160(%edi)
	movntps	%xmm3, 176(%edi)
	prefetcht0	1216(%esi)
	movaps	192(%esi), %xmm4
	movaps	208(%esi), %xmm5
	movaps	224(%esi), %xmm6
	movaps	240(%esi), %xmm7
	prefetcht0	1248(%esi)
	movntps	%xmm4, 192(%edi)
	movntps	%xmm5, 208(%edi)
	movntps	%xmm6, 224(%edi)
	movntps	%xmm7, 240(%edi)
	prefetcht0	1280(%esi)
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm1
	movaps	288(%esi), %xmm2
	movaps	304(%esi), %xmm3
	prefetcht0	1312(%esi)
	movntps	%xmm0, 256(%edi)
	movntps	%xmm1, 272(%edi)
	movntps	%xmm2, 288(%edi)
	movntps	%xmm3, 304(%edi)
	prefetcht0	1344(%esi)
	movaps	320(%esi), %xmm4
	movaps	336(%esi), %xmm5
	movaps	352(%esi), %xmm6
	movaps	368(%esi), %xmm7
	prefetcht0	1376(%esi)
	movntps	%xmm4, 320(%edi)
	movntps	%xmm5, 336(%edi)
	movntps	%xmm6, 352(%edi)
	movntps	%xmm7, 368(%edi)
	prefetcht0	1408(%esi)
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm1
	movaps	416(%esi), %xmm2
	movaps	432(%esi), %xmm3
	prefetcht0	1440(%esi)
	movntps	%xmm0, 384(%edi)
	movntps	%xmm1, 400(%edi)
	movntps	%xmm2, 416(%edi)
	movntps	%xmm3, 432(%edi)
	prefetcht0	1472(%esi)
	movaps	448(%esi), %xmm4
	movaps	464(%esi), %xmm5
	movaps	480(%esi), %xmm6
	movaps	496(%esi), %xmm7
	prefetcht0	1504(%esi)
	movntps	%xmm4, 448(%edi)
	movntps	%xmm5, 464(%edi)
	movntps	%xmm6, 480(%edi)
	movntps	%xmm7, 496(%edi)
	prefetcht0	1536(%esi)
	movaps	512(%esi), %xmm0
	movaps	528(%esi), %xmm1
	movaps	544(%esi), %xmm2
	movaps	560(%esi), %xmm3
	prefetcht0	1568(%esi)
	movntps	%xmm0, 512(%edi)
	movntps	%xmm1, 528(%edi)
	movntps	%xmm2, 544(%edi)
	movntps	%xmm3, 560(%edi)
	prefetcht0	1600(%esi)
	movaps	576(%esi), %xmm4
	movaps	592(%esi), %xmm5
	movaps	608(%esi), %xmm6
	movaps	624(%esi), %xmm7
	prefetcht0	1632(%esi)
	movntps	%xmm4, 576(%edi)
	movntps	%xmm5, 592(%edi)
	movntps	%xmm6, 608(%edi)
	movntps	%xmm7, 624(%edi)
	prefetcht0	1664(%esi)
	movaps	640(%esi), %xmm0
	movaps	656(%esi), %xmm1
	movaps	672(%esi), %xmm2
	movaps	688(%esi), %xmm3
	prefetcht0	1696(%esi)
	movntps	%xmm0, 640(%edi)
	movntps	%xmm1, 656(%edi)
	movntps	%xmm2, 672(%edi)
	movntps	%xmm3, 688(%edi)
	prefetcht0	1728(%esi)
	movaps	704(%esi), %xmm4
	movaps	720(%esi), %xmm5
	movaps	736(%esi), %xmm6
	movaps	752(%esi), %xmm7
	prefetcht0	1760(%esi)
	movntps	%xmm4, 704(%edi)
	movntps	%xmm5, 720(%edi)
	movntps	%xmm6, 736(%edi)
	movntps	%xmm7, 752(%edi)
	prefetcht0	1792(%esi)
	movaps	768(%esi), %xmm0
	movaps	784(%esi), %xmm1
	movaps	800(%esi), %xmm2
	movaps	816(%esi), %xmm3
	prefetcht0	1824(%esi)
	movntps	%xmm0, 768(%edi)
	movntps	%xmm1, 784(%edi)
	movntps	%xmm2, 800(%edi)
	movntps	%xmm3, 816(%edi)
	prefetcht0	1856(%esi)
	movaps	832(%esi), %xmm4
	movaps	848(%esi), %xmm5
	movaps	864(%esi), %xmm6
	movaps	880(%esi), %xmm7
	prefetcht0	1888(%esi)
	movntps	%xmm4, 832(%edi)
	movntps	%xmm5, 848(%edi)
	movntps	%xmm6, 864(%edi)
	movntps	%xmm7, 880(%edi)
	prefetcht0	1920(%esi)
	movaps	896(%esi), %xmm0
	movaps	912(%esi), %xmm1
	movaps	928(%esi), %xmm2
	movaps	944(%esi), %xmm3
	prefetcht0	1952(%esi)
	movntps	%xmm0, 896(%edi)
	movntps	%xmm1, 912(%edi)
	movntps	%xmm2, 928(%edi)
	movntps	%xmm3, 944(%edi)
	prefetcht0	1984(%esi)
	movaps	960(%esi), %xmm4
	movaps	976(%esi), %xmm5
	movaps	992(%esi), %xmm6
	movaps	1008(%esi), %xmm7
	prefetcht0	2016(%esi)
	movntps	%xmm4, 960(%edi)
	movntps	%xmm5, 976(%edi)
	movntps	%xmm6, 992(%edi)
	movntps	%xmm7, 1008(%edi)
	addl	$1024, %esi
	addl	$1024, %edi
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssesc_nt_t0
ssesc_nt_t0:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	shrl	$4, %ecx
	finit
	fldpi
.presc_nt_t0:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	addl	$16, %edx
	loopl	.presc_nt_t0
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	8(%esp)
	fst	12(%esp)
	fst	16(%esp)
	fst	20(%esp)
	movups	8(%esp), %xmm4
	ffree	%st(0)
/* execute */
	shrl	$9, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, %edx
	movl	%edi, %ebp
.mainsc_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	1024(%esi)
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm1
	movaps	32(%esi), %xmm2
	movaps	48(%esi), %xmm3
	prefetcht0	1056(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 0(%edi)
	movntps	%xmm1, 16(%edi)
	movntps	%xmm2, 32(%edi)
	movntps	%xmm3, 48(%edi)
	prefetcht0	1088(%esi)
	movaps	64(%esi), %xmm0
	movaps	80(%esi), %xmm1
	movaps	96(%esi), %xmm2
	movaps	112(%esi), %xmm3
	prefetcht0	1120(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 64(%edi)
	movntps	%xmm1, 80(%edi)
	movntps	%xmm2, 96(%edi)
	movntps	%xmm3, 112(%edi)
	prefetcht0	1152(%esi)
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm1
	movaps	160(%esi), %xmm2
	movaps	176(%esi), %xmm3
	prefetcht0	1184(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 128(%edi)
	movntps	%xmm1, 144(%edi)
	movntps	%xmm2, 160(%edi)
	movntps	%xmm3, 176(%edi)
	prefetcht0	1216(%esi)
	movaps	192(%esi), %xmm0
	movaps	208(%esi), %xmm1
	movaps	224(%esi), %xmm2
	movaps	240(%esi), %xmm3
	prefetcht0	1248(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 192(%edi)
	movntps	%xmm1, 208(%edi)
	movntps	%xmm2, 224(%edi)
	movntps	%xmm3, 240(%edi)
	prefetcht0	1280(%esi)
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm1
	movaps	288(%esi), %xmm2
	movaps	304(%esi), %xmm3
	prefetcht0	1312(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 256(%edi)
	movntps	%xmm1, 272(%edi)
	movntps	%xmm2, 288(%edi)
	movntps	%xmm3, 304(%edi)
	prefetcht0	1344(%esi)
	movaps	320(%esi), %xmm0
	movaps	336(%esi), %xmm1
	movaps	352(%esi), %xmm2
	movaps	368(%esi), %xmm3
	prefetcht0	1376(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 320(%edi)
	movntps	%xmm1, 336(%edi)
	movntps	%xmm2, 352(%edi)
	movntps	%xmm3, 368(%edi)
	prefetcht0	1408(%esi)
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm1
	movaps	416(%esi), %xmm2
	movaps	432(%esi), %xmm3
	prefetcht0	1440(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 384(%edi)
	movntps	%xmm1, 400(%edi)
	movntps	%xmm2, 416(%edi)
	movntps	%xmm3, 432(%edi)
	prefetcht0	1472(%esi)
	movaps	448(%esi), %xmm0
	movaps	464(%esi), %xmm1
	movaps	480(%esi), %xmm2
	movaps	496(%esi), %xmm3
	prefetcht0	1504(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 448(%edi)
	movntps	%xmm1, 464(%edi)
	movntps	%xmm2, 480(%edi)
	movntps	%xmm3, 496(%edi)
	prefetcht0	1536(%esi)
	movaps	512(%esi), %xmm0
	movaps	528(%esi), %xmm1
	movaps	544(%esi), %xmm2
	movaps	560(%esi), %xmm3
	prefetcht0	1568(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 512(%edi)
	movntps	%xmm1, 528(%edi)
	movntps	%xmm2, 544(%edi)
	movntps	%xmm3, 560(%edi)
	prefetcht0	1600(%esi)
	movaps	576(%esi), %xmm0
	movaps	592(%esi), %xmm1
	movaps	608(%esi), %xmm2
	movaps	624(%esi), %xmm3
	prefetcht0	1632(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 576(%edi)
	movntps	%xmm1, 592(%edi)
	movntps	%xmm2, 608(%edi)
	movntps	%xmm3, 624(%edi)
	prefetcht0	1664(%esi)
	movaps	640(%esi), %xmm0
	movaps	656(%esi), %xmm1
	movaps	672(%esi), %xmm2
	movaps	688(%esi), %xmm3
	prefetcht0	1696(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 640(%edi)
	movntps	%xmm1, 656(%edi)
	movntps	%xmm2, 672(%edi)
	movntps	%xmm3, 688(%edi)
	prefetcht0	1728(%esi)
	movaps	704(%esi), %xmm0
	movaps	720(%esi), %xmm1
	movaps	736(%esi), %xmm2
	movaps	752(%esi), %xmm3
	prefetcht0	1760(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 704(%edi)
	movntps	%xmm1, 720(%edi)
	movntps	%xmm2, 736(%edi)
	movntps	%xmm3, 752(%edi)
	prefetcht0	1792(%esi)
	movaps	768(%esi), %xmm0
	movaps	784(%esi), %xmm1
	movaps	800(%esi), %xmm2
	movaps	816(%esi), %xmm3
	prefetcht0	1824(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 768(%edi)
	movntps	%xmm1, 784(%edi)
	movntps	%xmm2, 800(%edi)
	movntps	%xmm3, 816(%edi)
	prefetcht0	1856(%esi)
	movaps	832(%esi), %xmm0
	movaps	848(%esi), %xmm1
	movaps	864(%esi), %xmm2
	movaps	880(%esi), %xmm3
	prefetcht0	1888(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 832(%edi)
	movntps	%xmm1, 848(%edi)
	movntps	%xmm2, 864(%edi)
	movntps	%xmm3, 880(%edi)
	prefetcht0	1920(%esi)
	movaps	896(%esi), %xmm0
	movaps	912(%esi), %xmm1
	movaps	928(%esi), %xmm2
	movaps	944(%esi), %xmm3
	prefetcht0	1952(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 896(%edi)
	movntps	%xmm1, 912(%edi)
	movntps	%xmm2, 928(%edi)
	movntps	%xmm3, 944(%edi)
	prefetcht0	1984(%esi)
	movaps	960(%esi), %xmm0
	movaps	976(%esi), %xmm1
	movaps	992(%esi), %xmm2
	movaps	1008(%esi), %xmm3
	prefetcht0	2016(%esi)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	movntps	%xmm0, 960(%edi)
	movntps	%xmm1, 976(%edi)
	movntps	%xmm2, 992(%edi)
	movntps	%xmm3, 1008(%edi)
	addl	$1024, %esi
	addl	$1024, %edi
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssead_nt_t0
ssead_nt_t0:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
	shrl	$4, %ecx
	finit
	fldpi
.pread_nt_t0:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	fst	0(%eax)
	fst	4(%eax)
	fst	8(%eax)
	fst	12(%eax)
	addl	$16, %edx
	addl	$16, %eax
	loopl	.pread_nt_t0
	ffree	%st(0)
/* wall time (start) */
	movl $0, 4(%esp)
	leal 32(%esp), %eax
	movl %eax, 0(%esp)
	call gettimeofday
/* execute */
	shrl	$10, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$1024, %edx
.mainad_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	1024(%ebp)
	movaps	0(%ebp), %xmm0
	movaps	16(%ebp), %xmm1
	prefetcht0	1024(%esi)
	movaps	32(%ebp), %xmm2
	movaps	48(%ebp), %xmm3
	prefetcht0	1056(%ebp)
	movaps	64(%ebp), %xmm4
	movaps	80(%ebp), %xmm5
	prefetcht0	1056(%esi)
	movaps	96(%ebp), %xmm6
	movaps	112(%ebp), %xmm7
	prefetcht0	1088(%ebp)
	addps	0(%esi), %xmm0
	addps	16(%esi), %xmm1
	prefetcht0	1088(%esi)
	addps	32(%esi), %xmm2
	addps	48(%esi), %xmm3
	movntps	%xmm0, 0(%edi)
	movntps	%xmm1, 16(%edi)
	movntps	%xmm2, 32(%edi)
	movntps	%xmm3, 48(%edi)
	prefetcht0	1120(%ebp)
	addps	64(%esi), %xmm4
	addps	80(%esi), %xmm5
	prefetcht0	1120(%esi)
	addps	96(%esi), %xmm6
	addps	112(%esi), %xmm7
	movntps	%xmm4, 64(%edi)
	movntps	%xmm5, 80(%edi)
	movntps	%xmm6, 96(%edi)
	movntps	%xmm7, 112(%edi)
	prefetcht0	1152(%ebp)
	movaps	128(%ebp), %xmm0
	movaps	144(%ebp), %xmm1
	prefetcht0	1152(%esi)
	movaps	160(%ebp), %xmm2
	movaps	176(%ebp), %xmm3
	prefetcht0	1184(%ebp)
	movaps	192(%ebp), %xmm4
	movaps	208(%ebp), %xmm5
	prefetcht0	1184(%esi)
	movaps	224(%ebp), %xmm6
	movaps	240(%ebp), %xmm7
	prefetcht0	1216(%ebp)
	addps	128(%esi), %xmm0
	addps	144(%esi), %xmm1
	prefetcht0	1216(%esi)
	addps	160(%esi), %xmm2
	addps	176(%esi), %xmm3
	movntps	%xmm0, 128(%edi)
	movntps	%xmm1, 144(%edi)
	movntps	%xmm2, 160(%edi)
	movntps	%xmm3, 176(%edi)
	prefetcht0	1248(%ebp)
	addps	192(%esi), %xmm4
	addps	208(%esi), %xmm5
	prefetcht0	1248(%esi)
	addps	224(%esi), %xmm6
	addps	240(%esi), %xmm7
	movntps	%xmm4, 192(%edi)
	movntps	%xmm5, 208(%edi)
	movntps	%xmm6, 224(%edi)
	movntps	%xmm7, 240(%edi)
	prefetcht0	1280(%ebp)
	movaps	256(%ebp), %xmm0
	movaps	272(%ebp), %xmm1
	prefetcht0	1280(%esi)
	movaps	288(%ebp), %xmm2
	movaps	304(%ebp), %xmm3
	prefetcht0	1312(%ebp)
	movaps	320(%ebp), %xmm4
	movaps	336(%ebp), %xmm5
	prefetcht0	1312(%esi)
	movaps	352(%ebp), %xmm6
	movaps	368(%ebp), %xmm7
	prefetcht0	1344(%ebp)
	addps	256(%esi), %xmm0
	addps	272(%esi), %xmm1
	prefetcht0	1344(%esi)
	addps	288(%esi), %xmm2
	addps	304(%esi), %xmm3
	movntps	%xmm0, 256(%edi)
	movntps	%xmm1, 272(%edi)
	movntps	%xmm2, 288(%edi)
	movntps	%xmm3, 304(%edi)
	prefetcht0	1376(%ebp)
	addps	320(%esi), %xmm4
	addps	336(%esi), %xmm5
	prefetcht0	1376(%esi)
	addps	352(%esi), %xmm6
	addps	368(%esi), %xmm7
	movntps	%xmm4, 320(%edi)
	movntps	%xmm5, 336(%edi)
	movntps	%xmm6, 352(%edi)
	movntps	%xmm7, 368(%edi)
	prefetcht0	1408(%ebp)
	movaps	384(%ebp), %xmm0
	movaps	400(%ebp), %xmm1
	prefetcht0	1408(%esi)
	movaps	416(%ebp), %xmm2
	movaps	432(%ebp), %xmm3
	prefetcht0	1440(%ebp)
	movaps	448(%ebp), %xmm4
	movaps	464(%ebp), %xmm5
	prefetcht0	1440(%esi)
	movaps	480(%ebp), %xmm6
	movaps	496(%ebp), %xmm7
	prefetcht0	1472(%ebp)
	addps	384(%esi), %xmm0
	addps	400(%esi), %xmm1
	prefetcht0	1472(%esi)
	addps	416(%esi), %xmm2
	addps	432(%esi), %xmm3
	movntps	%xmm0, 384(%edi)
	movntps	%xmm1, 400(%edi)
	movntps	%xmm2, 416(%edi)
	movntps	%xmm3, 432(%edi)
	prefetcht0	1504(%ebp)
	addps	448(%esi), %xmm4
	addps	464(%esi), %xmm5
	prefetcht0	1504(%esi)
	addps	480(%esi), %xmm6
	addps	496(%esi), %xmm7
	movntps	%xmm4, 448(%edi)
	movntps	%xmm5, 464(%edi)
	movntps	%xmm6, 480(%edi)
	movntps	%xmm7, 496(%edi)
	prefetcht0	1536(%ebp)
	movaps	512(%ebp), %xmm0
	movaps	528(%ebp), %xmm1
	prefetcht0	1536(%esi)
	movaps	544(%ebp), %xmm2
	movaps	560(%ebp), %xmm3
	prefetcht0	1568(%ebp)
	movaps	576(%ebp), %xmm4
	movaps	592(%ebp), %xmm5
	prefetcht0	1568(%esi)
	movaps	608(%ebp), %xmm6
	movaps	624(%ebp), %xmm7
	prefetcht0	1600(%ebp)
	addps	512(%esi), %xmm0
	addps	528(%esi), %xmm1
	prefetcht0	1600(%esi)
	addps	544(%esi), %xmm2
	addps	560(%esi), %xmm3
	movntps	%xmm0, 512(%edi)
	movntps	%xmm1, 528(%edi)
	movntps	%xmm2, 544(%edi)
	movntps	%xmm3, 560(%edi)
	prefetcht0	1632(%ebp)
	addps	576(%esi), %xmm4
	addps	592(%esi), %xmm5
	prefetcht0	1632(%esi)
	addps	608(%esi), %xmm6
	addps	624(%esi), %xmm7
	movntps	%xmm4, 576(%edi)
	movntps	%xmm5, 592(%edi)
	movntps	%xmm6, 608(%edi)
	movntps	%xmm7, 624(%edi)
	prefetcht0	1664(%ebp)
	movaps	640(%ebp), %xmm0
	movaps	656(%ebp), %xmm1
	prefetcht0	1664(%esi)
	movaps	672(%ebp), %xmm2
	movaps	688(%ebp), %xmm3
	prefetcht0	1696(%ebp)
	movaps	704(%ebp), %xmm4
	movaps	720(%ebp), %xmm5
	prefetcht0	1696(%esi)
	movaps	736(%ebp), %xmm6
	movaps	752(%ebp), %xmm7
	prefetcht0	1728(%ebp)
	addps	640(%esi), %xmm0
	addps	656(%esi), %xmm1
	prefetcht0	1728(%esi)
	addps	672(%esi), %xmm2
	addps	688(%esi), %xmm3
	movntps	%xmm0, 640(%edi)
	movntps	%xmm1, 656(%edi)
	movntps	%xmm2, 672(%edi)
	movntps	%xmm3, 688(%edi)
	prefetcht0	1760(%ebp)
	addps	704(%esi), %xmm4
	addps	720(%esi), %xmm5
	prefetcht0	1760(%esi)
	addps	736(%esi), %xmm6
	addps	752(%esi), %xmm7
	movntps	%xmm4, 704(%edi)
	movntps	%xmm5, 720(%edi)
	movntps	%xmm6, 736(%edi)
	movntps	%xmm7, 752(%edi)
	prefetcht0	1792(%ebp)
	movaps	768(%ebp), %xmm0
	movaps	784(%ebp), %xmm1
	prefetcht0	1792(%esi)
	movaps	800(%ebp), %xmm2
	movaps	816(%ebp), %xmm3
	prefetcht0	1824(%ebp)
	movaps	832(%ebp), %xmm4
	movaps	848(%ebp), %xmm5
	prefetcht0	1824(%esi)
	movaps	864(%ebp), %xmm6
	movaps	880(%ebp), %xmm7
	prefetcht0	1856(%ebp)
	addps	768(%esi), %xmm0
	addps	784(%esi), %xmm1
	prefetcht0	1856(%esi)
	addps	800(%esi), %xmm2
	addps	816(%esi), %xmm3
	movntps	%xmm0, 768(%edi)
	movntps	%xmm1, 784(%edi)
	movntps	%xmm2, 800(%edi)
	movntps	%xmm3, 816(%edi)
	prefetcht0	1888(%ebp)
	addps	832(%esi), %xmm4
	addps	848(%esi), %xmm5
	prefetcht0	1888(%esi)
	addps	864(%esi), %xmm6
	addps	880(%esi), %xmm7
	movntps	%xmm4, 832(%edi)
	movntps	%xmm5, 848(%edi)
	movntps	%xmm6, 864(%edi)
	movntps	%xmm7, 880(%edi)
	prefetcht0	1920(%ebp)
	movaps	896(%ebp), %xmm0
	movaps	912(%ebp), %xmm1
	prefetcht0	1920(%esi)
	movaps	928(%ebp), %xmm2
	movaps	944(%ebp), %xmm3
	prefetcht0	1952(%ebp)
	movaps	960(%ebp), %xmm4
	movaps	976(%ebp), %xmm5
	prefetcht0	1952(%esi)
	movaps	992(%ebp), %xmm6
	movaps	1008(%ebp), %xmm7
	prefetcht0	1984(%ebp)
	addps	896(%esi), %xmm0
	addps	912(%esi), %xmm1
	prefetcht0	1984(%esi)
	addps	928(%esi), %xmm2
	addps	944(%esi), %xmm3
	movntps	%xmm0, 896(%edi)
	movntps	%xmm1, 912(%edi)
	movntps	%xmm2, 928(%edi)
	movntps	%xmm3, 944(%edi)
	prefetcht0	2016(%ebp)
	addps	960(%esi), %xmm4
	addps	976(%esi), %xmm5
	prefetcht0	2016(%esi)
	addps	992(%esi), %xmm6
	addps	1008(%esi), %xmm7
	movntps	%xmm4, 960(%edi)
	movntps	%xmm5, 976(%edi)
	movntps	%xmm6, 992(%edi)
	movntps	%xmm7, 1008(%edi)
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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  ssetr_nt_t0
ssetr_nt_t0:
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
	movl	%ebx, %ecx
	movl	%esi, %edx
	movl	%ebp, %eax
	shrl	$4, %ecx
	finit
	fldpi
.pretr_nt_t0:
	fst	0(%edx)
	fst	4(%edx)
	fst	8(%edx)
	fst	12(%edx)
	fst	0(%eax)
	fst	4(%eax)
	fst	8(%eax)
	fst	12(%eax)
	addl	$16, %edx
	addl	$16, %eax
	loopl	.pretr_nt_t0
	ffree	%st(0)
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* create the multiplier */
	fldln2
	fst	8(%esp)
	fst	12(%esp)
	fst	16(%esp)
	fst	20(%esp)
	movups	8(%esi), %xmm4
	ffree	%st(0)
/* execute */
	shrl	$10, %ebx
	movl	%ebx, %ecx
	movl	72(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%ebp, 12(%esp)
	movl	%edi, 16(%esp)
	movl	$1024, %edx
.maintr_nt_t0:
/* every loop prefetches the next one;
 * don't care about hidden page faults of the last loop */
	prefetcht0	1024(%ebp)
	movaps	0(%ebp), %xmm0
	movaps	16(%ebp), %xmm1
	prefetcht0	1024(%esi)
	movaps	32(%ebp), %xmm2
	movaps	48(%ebp), %xmm3
	prefetcht0	1056(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1056(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	0(%esi), %xmm0
	addps	16(%esi), %xmm1
	addps	32(%esi), %xmm2
	addps	48(%esi), %xmm3
	movntps	%xmm0, 0(%edi)
	movntps	%xmm1, 16(%edi)
	movntps	%xmm2, 32(%edi)
	movntps	%xmm3, 48(%edi)
	prefetcht0	1088(%esi)
	movaps	64(%ebp), %xmm0
	movaps	80(%ebp), %xmm1
	prefetcht0	1088(%ebp)
	movaps	96(%ebp), %xmm2
	movaps	112(%ebp), %xmm3
	prefetcht0	1120(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1120(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	64(%esi), %xmm0
	addps	80(%esi), %xmm1
	addps	96(%esi), %xmm2
	addps	112(%esi), %xmm3
	movntps	%xmm0, 64(%edi)
	movntps	%xmm1, 80(%edi)
	movntps	%xmm2, 96(%edi)
	movntps	%xmm3, 112(%edi)
	prefetcht0	1152(%ebp)
	movaps	128(%ebp), %xmm0
	movaps	144(%ebp), %xmm1
	prefetcht0	1152(%esi)
	movaps	160(%ebp), %xmm2
	movaps	176(%ebp), %xmm3
	prefetcht0	1184(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1184(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	128(%esi), %xmm0
	addps	144(%esi), %xmm1
	addps	160(%esi), %xmm2
	addps	176(%esi), %xmm3
	movntps	%xmm0, 128(%edi)
	movntps	%xmm1, 144(%edi)
	movntps	%xmm2, 160(%edi)
	movntps	%xmm3, 176(%edi)
	prefetcht0	1216(%ebp)
	movaps	192(%ebp), %xmm0
	movaps	208(%ebp), %xmm1
	prefetcht0	1216(%esi)
	movaps	224(%ebp), %xmm2
	movaps	240(%ebp), %xmm3
	prefetcht0	1248(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1248(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	192(%esi), %xmm0
	addps	208(%esi), %xmm1
	addps	224(%esi), %xmm2
	addps	240(%esi), %xmm3
	movntps	%xmm0, 192(%edi)
	movntps	%xmm1, 208(%edi)
	movntps	%xmm2, 224(%edi)
	movntps	%xmm3, 240(%edi)
	prefetcht0	1280(%ebp)
	movaps	256(%ebp), %xmm0
	movaps	272(%ebp), %xmm1
	prefetcht0	1280(%esi)
	movaps	288(%ebp), %xmm2
	movaps	304(%ebp), %xmm3
	prefetcht0	1312(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1312(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	256(%esi), %xmm0
	addps	272(%esi), %xmm1
	addps	288(%esi), %xmm2
	addps	304(%esi), %xmm3
	movntps	%xmm0, 256(%edi)
	movntps	%xmm1, 272(%edi)
	movntps	%xmm2, 288(%edi)
	movntps	%xmm3, 304(%edi)
	prefetcht0	1344(%ebp)
	movaps	320(%ebp), %xmm0
	movaps	336(%ebp), %xmm1
	prefetcht0	1344(%esi)
	movaps	352(%ebp), %xmm2
	movaps	368(%ebp), %xmm3
	prefetcht0	1376(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1376(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	320(%esi), %xmm0
	addps	336(%esi), %xmm1
	addps	352(%esi), %xmm2
	addps	368(%esi), %xmm3
	movntps	%xmm0, 320(%edi)
	movntps	%xmm1, 336(%edi)
	movntps	%xmm2, 352(%edi)
	movntps	%xmm3, 368(%edi)
	prefetcht0	1408(%ebp)
	movaps	384(%ebp), %xmm0
	movaps	400(%ebp), %xmm1
	prefetcht0	1408(%esi)
	movaps	416(%ebp), %xmm2
	movaps	432(%ebp), %xmm3
	prefetcht0	1440(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1440(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	384(%esi), %xmm0
	addps	400(%esi), %xmm1
	addps	416(%esi), %xmm2
	addps	432(%esi), %xmm3
	movntps	%xmm0, 384(%edi)
	movntps	%xmm1, 400(%edi)
	movntps	%xmm2, 416(%edi)
	movntps	%xmm3, 432(%edi)
	prefetcht0	1472(%ebp)
	movaps	448(%ebp), %xmm0
	movaps	464(%ebp), %xmm1
	prefetcht0	1472(%esi)
	movaps	480(%ebp), %xmm2
	movaps	496(%ebp), %xmm3
	prefetcht0	1504(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1504(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	448(%esi), %xmm0
	addps	464(%esi), %xmm1
	addps	480(%esi), %xmm2
	addps	496(%esi), %xmm3
	movntps	%xmm0, 448(%edi)
	movntps	%xmm1, 464(%edi)
	movntps	%xmm2, 480(%edi)
	movntps	%xmm3, 496(%edi)
	prefetcht0	1536(%ebp)
	movaps	512(%ebp), %xmm0
	movaps	528(%ebp), %xmm1
	prefetcht0	1536(%esi)
	movaps	544(%ebp), %xmm2
	movaps	560(%ebp), %xmm3
	prefetcht0	1568(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1568(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	512(%esi), %xmm0
	addps	528(%esi), %xmm1
	addps	544(%esi), %xmm2
	addps	560(%esi), %xmm3
	movntps	%xmm0, 512(%edi)
	movntps	%xmm1, 528(%edi)
	movntps	%xmm2, 544(%edi)
	movntps	%xmm3, 560(%edi)
	prefetcht0	1600(%ebp)
	movaps	576(%ebp), %xmm0
	movaps	592(%ebp), %xmm1
	prefetcht0	1600(%esi)
	movaps	608(%ebp), %xmm2
	movaps	624(%ebp), %xmm3
	prefetcht0	1632(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1632(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	576(%esi), %xmm0
	addps	592(%esi), %xmm1
	addps	608(%esi), %xmm2
	addps	624(%esi), %xmm3
	movntps	%xmm0, 576(%edi)
	movntps	%xmm1, 592(%edi)
	movntps	%xmm2, 608(%edi)
	movntps	%xmm3, 624(%edi)
	prefetcht0	1664(%ebp)
	movaps	640(%ebp), %xmm0
	movaps	656(%ebp), %xmm1
	prefetcht0	1664(%esi)
	movaps	672(%ebp), %xmm2
	movaps	688(%ebp), %xmm3
	prefetcht0	1696(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1696(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	640(%esi), %xmm0
	addps	656(%esi), %xmm1
	addps	672(%esi), %xmm2
	addps	688(%esi), %xmm3
	movntps	%xmm0, 640(%edi)
	movntps	%xmm1, 656(%edi)
	movntps	%xmm2, 672(%edi)
	movntps	%xmm3, 688(%edi)
	prefetcht0	1728(%ebp)
	movaps	704(%ebp), %xmm0
	movaps	720(%ebp), %xmm1
	prefetcht0	1728(%esi)
	movaps	736(%ebp), %xmm2
	movaps	752(%ebp), %xmm3
	prefetcht0	1760(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1760(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	704(%esi), %xmm0
	addps	720(%esi), %xmm1
	addps	736(%esi), %xmm2
	addps	752(%esi), %xmm3
	movntps	%xmm0, 704(%edi)
	movntps	%xmm1, 720(%edi)
	movntps	%xmm2, 736(%edi)
	movntps	%xmm3, 752(%edi)
	prefetcht0	1792(%ebp)
	movaps	768(%ebp), %xmm0
	movaps	784(%ebp), %xmm1
	prefetcht0	1792(%esi)
	movaps	800(%ebp), %xmm2
	movaps	816(%ebp), %xmm3
	prefetcht0	1824(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1824(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	768(%esi), %xmm0
	addps	784(%esi), %xmm1
	addps	800(%esi), %xmm2
	addps	816(%esi), %xmm3
	movntps	%xmm0, 768(%edi)
	movntps	%xmm1, 784(%edi)
	movntps	%xmm2, 800(%edi)
	movntps	%xmm3, 816(%edi)
	prefetcht0	1856(%ebp)
	movaps	832(%ebp), %xmm0
	movaps	848(%ebp), %xmm1
	prefetcht0	1856(%esi)
	movaps	864(%ebp), %xmm2
	movaps	880(%ebp), %xmm3
	prefetcht0	1888(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1888(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	832(%esi), %xmm0
	addps	848(%esi), %xmm1
	addps	864(%esi), %xmm2
	addps	880(%esi), %xmm3
	movntps	%xmm0, 832(%edi)
	movntps	%xmm1, 848(%edi)
	movntps	%xmm2, 864(%edi)
	movntps	%xmm3, 880(%edi)
	prefetcht0	1920(%ebp)
	movaps	896(%ebp), %xmm0
	movaps	912(%ebp), %xmm1
	prefetcht0	1920(%esi)
	movaps	928(%ebp), %xmm2
	movaps	944(%ebp), %xmm3
	prefetcht0	1952(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	1952(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	896(%esi), %xmm0
	addps	912(%esi), %xmm1
	addps	928(%esi), %xmm2
	addps	944(%esi), %xmm3
	movntps	%xmm0, 896(%edi)
	movntps	%xmm1, 912(%edi)
	movntps	%xmm2, 928(%edi)
	movntps	%xmm3, 944(%edi)
	prefetcht0	1984(%ebp)
	movaps	960(%ebp), %xmm0
	movaps	976(%ebp), %xmm1
	prefetcht0	1984(%esi)
	movaps	992(%ebp), %xmm2
	movaps	1008(%ebp), %xmm3
	prefetcht0	2016(%ebp)
	mulps	%xmm4, %xmm0
	mulps	%xmm4, %xmm1
	prefetcht0	2016(%esi)
	mulps	%xmm4, %xmm2
	mulps	%xmm4, %xmm3
	addps	960(%esi), %xmm0
	addps	976(%esi), %xmm1
	addps	992(%esi), %xmm2
	addps	1008(%esi), %xmm3
	movntps	%xmm0, 960(%edi)
	movntps	%xmm1, 976(%edi)
	movntps	%xmm2, 992(%edi)
	movntps	%xmm3, 1008(%edi)

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
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret
