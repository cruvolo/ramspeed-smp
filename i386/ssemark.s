/*
**  SSEmark benchmarks for RAMspeed (i386)
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

.globl  ssewr
ssewr:
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
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
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
	xorps	%xmm0, %xmm0
.mainwr:
	movaps	%xmm0, 0(%edi)
	movaps	%xmm0, 16(%edi)
	movaps	%xmm0, 32(%edi)
	movaps	%xmm0, 48(%edi)
	movaps	%xmm0, 64(%edi)
	movaps	%xmm0, 80(%edi)
	movaps	%xmm0, 96(%edi)
	movaps	%xmm0, 112(%edi)
	movaps	%xmm0, 128(%edi)
	movaps	%xmm0, 144(%edi)
	movaps	%xmm0, 160(%edi)
	movaps	%xmm0, 176(%edi)
	movaps	%xmm0, 192(%edi)
	movaps	%xmm0, 208(%edi)
	movaps	%xmm0, 224(%edi)
	movaps	%xmm0, 240(%edi)
	movaps	%xmm0, 256(%edi)
	movaps	%xmm0, 272(%edi)
	movaps	%xmm0, 288(%edi)
	movaps	%xmm0, 304(%edi)
	movaps	%xmm0, 320(%edi)
	movaps	%xmm0, 336(%edi)
	movaps	%xmm0, 352(%edi)
	movaps	%xmm0, 368(%edi)
	movaps	%xmm0, 384(%edi)
	movaps	%xmm0, 400(%edi)
	movaps	%xmm0, 416(%edi)
	movaps	%xmm0, 432(%edi)
	movaps	%xmm0, 448(%edi)
	movaps	%xmm0, 464(%edi)
	movaps	%xmm0, 480(%edi)
	movaps	%xmm0, 496(%edi)
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

.globl  sserd
sserd:
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
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
/* prefill */
	movl	%ebx, %ecx
	shrl	$6, %ecx
	xorps	%xmm0, %xmm0
.prerd:
	movaps	%xmm0, 0(%eax)
	movaps	%xmm0, 16(%eax)
	movaps	%xmm0, 32(%eax)
	movaps	%xmm0, 48(%eax)
	addl	$64, %eax
	loopl	.prerd
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
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm0
	movaps	32(%esi), %xmm0
	movaps	48(%esi), %xmm0
	movaps	64(%esi), %xmm0
	movaps	80(%esi), %xmm0
	movaps	96(%esi), %xmm0
	movaps	112(%esi), %xmm0
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm0
	movaps	160(%esi), %xmm0
	movaps	176(%esi), %xmm0
	movaps	192(%esi), %xmm0
	movaps	208(%esi), %xmm0
	movaps	224(%esi), %xmm0
	movaps	240(%esi), %xmm0
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm0
	movaps	288(%esi), %xmm0
	movaps	304(%esi), %xmm0
	movaps	320(%esi), %xmm0
	movaps	336(%esi), %xmm0
	movaps	352(%esi), %xmm0
	movaps	368(%esi), %xmm0
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm0
	movaps	416(%esi), %xmm0
	movaps	432(%esi), %xmm0
	movaps	448(%esi), %xmm0
	movaps	464(%esi), %xmm0
	movaps	480(%esi), %xmm0
	movaps	496(%esi), %xmm0
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

.globl  ssewr_nt
ssewr_nt:
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
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
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
	xorps	%xmm0, %xmm0
.mainwr_nt:
	movntps	%xmm0, 0(%edi)
	movntps	%xmm0, 16(%edi)
	movntps	%xmm0, 32(%edi)
	movntps	%xmm0, 48(%edi)
	movntps	%xmm0, 64(%edi)
	movntps	%xmm0, 80(%edi)
	movntps	%xmm0, 96(%edi)
	movntps	%xmm0, 112(%edi)
	movntps	%xmm0, 128(%edi)
	movntps	%xmm0, 144(%edi)
	movntps	%xmm0, 160(%edi)
	movntps	%xmm0, 176(%edi)
	movntps	%xmm0, 192(%edi)
	movntps	%xmm0, 208(%edi)
	movntps	%xmm0, 224(%edi)
	movntps	%xmm0, 240(%edi)
	movntps	%xmm0, 256(%edi)
	movntps	%xmm0, 272(%edi)
	movntps	%xmm0, 288(%edi)
	movntps	%xmm0, 304(%edi)
	movntps	%xmm0, 320(%edi)
	movntps	%xmm0, 336(%edi)
	movntps	%xmm0, 352(%edi)
	movntps	%xmm0, 368(%edi)
	movntps	%xmm0, 384(%edi)
	movntps	%xmm0, 400(%edi)
	movntps	%xmm0, 416(%edi)
	movntps	%xmm0, 432(%edi)
	movntps	%xmm0, 448(%edi)
	movntps	%xmm0, 464(%edi)
	movntps	%xmm0, 480(%edi)
	movntps	%xmm0, 496(%edi)
	addl	%eax, %edi
	decl	%ebx
	jnz	.mainwr_nt

	movl	%ebp, %ebx
	movl	%esi, %edi
	decl	%ecx
	jnz	.mainwr_nt

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

.globl  sserd_nt
sserd_nt:
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
	addl	%ebp, %ecx
	movl	%ecx, 0(%esp)
	call	malloc
	movl	%eax, 28(%esp)
	addl	%ebp, %eax
	andw	$0xF000, %ax
	movl	%eax, %esi
/* prefill */
	movl	%ebx, %ecx
	shrl	$6, %ecx
	xorps	%xmm0, %xmm0
.prerd_nt:
	movntps	%xmm0, 0(%eax)
	movntps	%xmm0, 16(%eax)
	movntps	%xmm0, 32(%eax)
	movntps	%xmm0, 48(%eax)
	addl	$64, %eax
	loopl	.prerd_nt
/* wall time (start) */
	movl	$0, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, 0(%esp)
	call	gettimeofday
/* execute */
	shrl	$9, %ebx
	decl	%ebx
	movl	%ebx, %ebp
	movl	%esi, %edi
	movl	72(%esp), %ecx
	movl	$512, %eax
.mainrd_nt:
/* every loop prefetches the next one */
	prefetchnta	512(%esi)
	prefetchnta	544(%esi)
	prefetchnta	576(%esi)
	prefetchnta	608(%esi)
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm0
	movaps	32(%esi), %xmm0
	movaps	48(%esi), %xmm0
	prefetchnta	640(%esi)
	prefetchnta	672(%esi)
	prefetchnta	704(%esi)
	prefetchnta	736(%esi)
	movaps	64(%esi), %xmm0
	movaps	80(%esi), %xmm0
	movaps	96(%esi), %xmm0
	movaps	112(%esi), %xmm0
	prefetchnta	768(%esi)
	prefetchnta	800(%esi)
	prefetchnta	832(%esi)
	prefetchnta	864(%esi)
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm0
	movaps	160(%esi), %xmm0
	movaps	176(%esi), %xmm0
	prefetchnta	896(%esi)
	prefetchnta	928(%esi)
	prefetchnta	960(%esi)
	prefetchnta	992(%esi)
	movaps	192(%esi), %xmm0
	movaps	208(%esi), %xmm0
	movaps	224(%esi), %xmm0
	movaps	240(%esi), %xmm0
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm0
	movaps	288(%esi), %xmm0
	movaps	304(%esi), %xmm0
	movaps	320(%esi), %xmm0
	movaps	336(%esi), %xmm0
	movaps	352(%esi), %xmm0
	movaps	368(%esi), %xmm0
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm0
	movaps	416(%esi), %xmm0
	movaps	432(%esi), %xmm0
	movaps	448(%esi), %xmm0
	movaps	464(%esi), %xmm0
	movaps	480(%esi), %xmm0
	movaps	496(%esi), %xmm0
	addl	%eax, %esi
	decl	%ebx
	jnz	.mainrd_nt

/* the last loop of the memory block;
 * no more prefetches to avoid hidden page faults */
	movaps	0(%esi), %xmm0
	movaps	16(%esi), %xmm0
	movaps	32(%esi), %xmm0
	movaps	48(%esi), %xmm0
	movaps	64(%esi), %xmm0
	movaps	80(%esi), %xmm0
	movaps	96(%esi), %xmm0
	movaps	112(%esi), %xmm0
	movaps	128(%esi), %xmm0
	movaps	144(%esi), %xmm0
	movaps	160(%esi), %xmm0
	movaps	176(%esi), %xmm0
	movaps	192(%esi), %xmm0
	movaps	208(%esi), %xmm0
	movaps	224(%esi), %xmm0
	movaps	240(%esi), %xmm0
	movaps	256(%esi), %xmm0
	movaps	272(%esi), %xmm0
	movaps	288(%esi), %xmm0
	movaps	304(%esi), %xmm0
	movaps	320(%esi), %xmm0
	movaps	336(%esi), %xmm0
	movaps	352(%esi), %xmm0
	movaps	368(%esi), %xmm0
	movaps	384(%esi), %xmm0
	movaps	400(%esi), %xmm0
	movaps	416(%esi), %xmm0
	movaps	432(%esi), %xmm0
	movaps	448(%esi), %xmm0
	movaps	464(%esi), %xmm0
	movaps	480(%esi), %xmm0
	movaps	496(%esi), %xmm0

	movl	%ebp, %ebx
	movl	%edi, %esi
	decl	%ecx
	jnz	.mainrd_nt

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
