/*
**  MMXmark benchmarks for RAMspeed (i386)
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

.globl  mmxwr
mmxwr:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48,%esp
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
	pxor	%mm0, %mm0
.mainwr:
	movq	%mm0, 0(%edi)
	movq	%mm0, 8(%edi)
	movq	%mm0, 16(%edi)
	movq	%mm0, 24(%edi)
	movq	%mm0, 32(%edi)
	movq	%mm0, 40(%edi)
	movq	%mm0, 48(%edi)
	movq	%mm0, 56(%edi)
	movq	%mm0, 64(%edi)
	movq	%mm0, 72(%edi)
	movq	%mm0, 80(%edi)
	movq	%mm0, 88(%edi)
	movq	%mm0, 96(%edi)
	movq	%mm0, 104(%edi)
	movq	%mm0, 112(%edi)
	movq	%mm0, 120(%edi)
	movq	%mm0, 128(%edi)
	movq	%mm0, 136(%edi)
	movq	%mm0, 144(%edi)
	movq	%mm0, 152(%edi)
	movq	%mm0, 160(%edi)
	movq	%mm0, 168(%edi)
	movq	%mm0, 176(%edi)
	movq	%mm0, 184(%edi)
	movq	%mm0, 192(%edi)
	movq	%mm0, 200(%edi)
	movq	%mm0, 208(%edi)
	movq	%mm0, 216(%edi)
	movq	%mm0, 224(%edi)
	movq	%mm0, 232(%edi)
	movq	%mm0, 240(%edi)
	movq	%mm0, 248(%edi)
	movq	%mm0, 256(%edi)
	movq	%mm0, 264(%edi)
	movq	%mm0, 272(%edi)
	movq	%mm0, 280(%edi)
	movq	%mm0, 288(%edi)
	movq	%mm0, 296(%edi)
	movq	%mm0, 304(%edi)
	movq	%mm0, 312(%edi)
	movq	%mm0, 320(%edi)
	movq	%mm0, 328(%edi)
	movq	%mm0, 336(%edi)
	movq	%mm0, 344(%edi)
	movq	%mm0, 352(%edi)
	movq	%mm0, 360(%edi)
	movq	%mm0, 368(%edi)
	movq	%mm0, 376(%edi)
	movq	%mm0, 384(%edi)
	movq	%mm0, 392(%edi)
	movq	%mm0, 400(%edi)
	movq	%mm0, 408(%edi)
	movq	%mm0, 416(%edi)
	movq	%mm0, 424(%edi)
	movq	%mm0, 432(%edi)
	movq	%mm0, 440(%edi)
	movq	%mm0, 448(%edi)
	movq	%mm0, 456(%edi)
	movq	%mm0, 464(%edi)
	movq	%mm0, 472(%edi)
	movq	%mm0, 480(%edi)
	movq	%mm0, 488(%edi)
	movq	%mm0, 496(%edi)
	movq	%mm0, 504(%edi)
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
/* retore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxrd
mmxrd:
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
	shrl	$5, %ecx
	pxor	%mm0, %mm0
.prerd:
	movq	%mm0, 0(%eax)
	movq	%mm0, 8(%eax)
	movq	%mm0, 16(%eax)
	movq	%mm0, 24(%eax)
	addl	$32, %eax
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
	movq	0(%esi), %mm0
	movq	8(%esi), %mm0
	movq	16(%esi), %mm0
	movq	24(%esi), %mm0
	movq	32(%esi), %mm0
	movq	40(%esi), %mm0
	movq	48(%esi), %mm0
	movq	56(%esi), %mm0
	movq	64(%esi), %mm0
	movq	72(%esi), %mm0
	movq	80(%esi), %mm0
	movq	88(%esi), %mm0
	movq	96(%esi), %mm0
	movq	104(%esi), %mm0
	movq	112(%esi), %mm0
	movq	120(%esi), %mm0
	movq	128(%esi), %mm0
	movq	136(%esi), %mm0
	movq	144(%esi), %mm0
	movq	152(%esi), %mm0
	movq	160(%esi), %mm0
	movq	168(%esi), %mm0
	movq	176(%esi), %mm0
	movq	184(%esi), %mm0
	movq	192(%esi), %mm0
	movq	200(%esi), %mm0
	movq	208(%esi), %mm0
	movq	216(%esi), %mm0
	movq	224(%esi), %mm0
	movq	232(%esi), %mm0
	movq	240(%esi), %mm0
	movq	248(%esi), %mm0
	movq	256(%esi), %mm0
	movq	264(%esi), %mm0
	movq	272(%esi), %mm0
	movq	280(%esi), %mm0
	movq	288(%esi), %mm0
	movq	296(%esi), %mm0
	movq	304(%esi), %mm0
	movq	312(%esi), %mm0
	movq	320(%esi), %mm0
	movq	328(%esi), %mm0
	movq	336(%esi), %mm0
	movq	344(%esi), %mm0
	movq	352(%esi), %mm0
	movq	360(%esi), %mm0
	movq	368(%esi), %mm0
	movq	376(%esi), %mm0
	movq	384(%esi), %mm0
	movq	392(%esi), %mm0
	movq	400(%esi), %mm0
	movq	408(%esi), %mm0
	movq	416(%esi), %mm0
	movq	424(%esi), %mm0
	movq	432(%esi), %mm0
	movq	440(%esi), %mm0
	movq	448(%esi), %mm0
	movq	456(%esi), %mm0
	movq	464(%esi), %mm0
	movq	472(%esi), %mm0
	movq	480(%esi), %mm0
	movq	488(%esi), %mm0
	movq	496(%esi), %mm0
	movq	504(%esi), %mm0
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
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxwr_nt
mmxwr_nt:
/* set up the stack frame */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	subl	$48,%esp
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
	pxor	%mm0, %mm0
.mainwr_nt:
	movntq	%mm0, 0(%edi)
	movntq	%mm0, 8(%edi)
	movntq	%mm0, 16(%edi)
	movntq	%mm0, 24(%edi)
	movntq	%mm0, 32(%edi)
	movntq	%mm0, 40(%edi)
	movntq	%mm0, 48(%edi)
	movntq	%mm0, 56(%edi)
	movntq	%mm0, 64(%edi)
	movntq	%mm0, 72(%edi)
	movntq	%mm0, 80(%edi)
	movntq	%mm0, 88(%edi)
	movntq	%mm0, 96(%edi)
	movntq	%mm0, 104(%edi)
	movntq	%mm0, 112(%edi)
	movntq	%mm0, 120(%edi)
	movntq	%mm0, 128(%edi)
	movntq	%mm0, 136(%edi)
	movntq	%mm0, 144(%edi)
	movntq	%mm0, 152(%edi)
	movntq	%mm0, 160(%edi)
	movntq	%mm0, 168(%edi)
	movntq	%mm0, 176(%edi)
	movntq	%mm0, 184(%edi)
	movntq	%mm0, 192(%edi)
	movntq	%mm0, 200(%edi)
	movntq	%mm0, 208(%edi)
	movntq	%mm0, 216(%edi)
	movntq	%mm0, 224(%edi)
	movntq	%mm0, 232(%edi)
	movntq	%mm0, 240(%edi)
	movntq	%mm0, 248(%edi)
	movntq	%mm0, 256(%edi)
	movntq	%mm0, 264(%edi)
	movntq	%mm0, 272(%edi)
	movntq	%mm0, 280(%edi)
	movntq	%mm0, 288(%edi)
	movntq	%mm0, 296(%edi)
	movntq	%mm0, 304(%edi)
	movntq	%mm0, 312(%edi)
	movntq	%mm0, 320(%edi)
	movntq	%mm0, 328(%edi)
	movntq	%mm0, 336(%edi)
	movntq	%mm0, 344(%edi)
	movntq	%mm0, 352(%edi)
	movntq	%mm0, 360(%edi)
	movntq	%mm0, 368(%edi)
	movntq	%mm0, 376(%edi)
	movntq	%mm0, 384(%edi)
	movntq	%mm0, 392(%edi)
	movntq	%mm0, 400(%edi)
	movntq	%mm0, 408(%edi)
	movntq	%mm0, 416(%edi)
	movntq	%mm0, 424(%edi)
	movntq	%mm0, 432(%edi)
	movntq	%mm0, 440(%edi)
	movntq	%mm0, 448(%edi)
	movntq	%mm0, 456(%edi)
	movntq	%mm0, 464(%edi)
	movntq	%mm0, 472(%edi)
	movntq	%mm0, 480(%edi)
	movntq	%mm0, 488(%edi)
	movntq	%mm0, 496(%edi)
	movntq	%mm0, 504(%edi)
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
/* retore and return */
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

.globl  mmxrd_nt
mmxrd_nt:
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
	shrl	$5, %ecx
	pxor	%mm0, %mm0
.prerd_nt:
	movntq	%mm0, 0(%eax)
	movntq	%mm0, 8(%eax)
	movntq	%mm0, 16(%eax)
	movntq	%mm0, 24(%eax)
	addl	$32, %eax
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
	movq	0(%esi), %mm0
	movq	8(%esi), %mm0
	movq	16(%esi), %mm0
	movq	24(%esi), %mm0
	movq	32(%esi), %mm0
	movq	40(%esi), %mm0
	movq	48(%esi), %mm0
	movq	56(%esi), %mm0
	prefetchnta	640(%esi)
	prefetchnta	672(%esi)
	prefetchnta	704(%esi)
	prefetchnta	736(%esi)
	movq	64(%esi), %mm0
	movq	72(%esi), %mm0
	movq	80(%esi), %mm0
	movq	88(%esi), %mm0
	movq	96(%esi), %mm0
	movq	104(%esi), %mm0
	movq	112(%esi), %mm0
	movq	120(%esi), %mm0
	prefetchnta	768(%esi)
	prefetchnta	800(%esi)
	prefetchnta	832(%esi)
	prefetchnta	864(%esi)
	movq	128(%esi), %mm0
	movq	136(%esi), %mm0
	movq	144(%esi), %mm0
	movq	152(%esi), %mm0
	movq	160(%esi), %mm0
	movq	168(%esi), %mm0
	movq	176(%esi), %mm0
	movq	184(%esi), %mm0
	prefetchnta	896(%esi)
	prefetchnta	928(%esi)
	prefetchnta	960(%esi)
	prefetchnta	992(%esi)
	movq	192(%esi), %mm0
	movq	200(%esi), %mm0
	movq	208(%esi), %mm0
	movq	216(%esi), %mm0
	movq	224(%esi), %mm0
	movq	232(%esi), %mm0
	movq	240(%esi), %mm0
	movq	248(%esi), %mm0
	movq	256(%esi), %mm0
	movq	264(%esi), %mm0
	movq	272(%esi), %mm0
	movq	280(%esi), %mm0
	movq	288(%esi), %mm0
	movq	296(%esi), %mm0
	movq	304(%esi), %mm0
	movq	312(%esi), %mm0
	movq	320(%esi), %mm0
	movq	328(%esi), %mm0
	movq	336(%esi), %mm0
	movq	344(%esi), %mm0
	movq	352(%esi), %mm0
	movq	360(%esi), %mm0
	movq	368(%esi), %mm0
	movq	376(%esi), %mm0
	movq	384(%esi), %mm0
	movq	392(%esi), %mm0
	movq	400(%esi), %mm0
	movq	408(%esi), %mm0
	movq	416(%esi), %mm0
	movq	424(%esi), %mm0
	movq	432(%esi), %mm0
	movq	440(%esi), %mm0
	movq	448(%esi), %mm0
	movq	456(%esi), %mm0
	movq	464(%esi), %mm0
	movq	472(%esi), %mm0
	movq	480(%esi), %mm0
	movq	488(%esi), %mm0
	movq	496(%esi), %mm0
	movq	504(%esi), %mm0
	addl	%eax, %esi
	decl	%ebx
	jnz	.mainrd_nt

/* the last loop of the memory block;
 * no more prefetches to avoid hidden page faults */
	movq	0(%esi), %mm0
	movq	8(%esi), %mm0
	movq	16(%esi), %mm0
	movq	24(%esi), %mm0
	movq	32(%esi), %mm0
	movq	40(%esi), %mm0
	movq	48(%esi), %mm0
	movq	56(%esi), %mm0
	movq	64(%esi), %mm0
	movq	72(%esi), %mm0
	movq	80(%esi), %mm0
	movq	88(%esi), %mm0
	movq	96(%esi), %mm0
	movq	104(%esi), %mm0
	movq	112(%esi), %mm0
	movq	120(%esi), %mm0
	movq	128(%esi), %mm0
	movq	136(%esi), %mm0
	movq	144(%esi), %mm0
	movq	152(%esi), %mm0
	movq	160(%esi), %mm0
	movq	168(%esi), %mm0
	movq	176(%esi), %mm0
	movq	184(%esi), %mm0
	movq	192(%esi), %mm0
	movq	200(%esi), %mm0
	movq	208(%esi), %mm0
	movq	216(%esi), %mm0
	movq	224(%esi), %mm0
	movq	232(%esi), %mm0
	movq	240(%esi), %mm0
	movq	248(%esi), %mm0
	movq	256(%esi), %mm0
	movq	264(%esi), %mm0
	movq	272(%esi), %mm0
	movq	280(%esi), %mm0
	movq	288(%esi), %mm0
	movq	296(%esi), %mm0
	movq	304(%esi), %mm0
	movq	312(%esi), %mm0
	movq	320(%esi), %mm0
	movq	328(%esi), %mm0
	movq	336(%esi), %mm0
	movq	344(%esi), %mm0
	movq	352(%esi), %mm0
	movq	360(%esi), %mm0
	movq	368(%esi), %mm0
	movq	376(%esi), %mm0
	movq	384(%esi), %mm0
	movq	392(%esi), %mm0
	movq	400(%esi), %mm0
	movq	408(%esi), %mm0
	movq	416(%esi), %mm0
	movq	424(%esi), %mm0
	movq	432(%esi), %mm0
	movq	440(%esi), %mm0
	movq	448(%esi), %mm0
	movq	456(%esi), %mm0
	movq	464(%esi), %mm0
	movq	472(%esi), %mm0
	movq	480(%esi), %mm0
	movq	488(%esi), %mm0
	movq	496(%esi), %mm0
	movq	504(%esi), %mm0

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
	emms
	addl	$48, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret
