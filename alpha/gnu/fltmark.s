/*
**  FLOATmark benchmarks for RAMspeed (alpha [GNU])
**
**  (UNIX release)
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2004 Rhett M. Hollander <rhett@alasir.com>
**
**  All rights reserved.
**
*/

.set	noreorder

.globl	floatwr
.ent	floatwr
floatwr:
/* set up the stack frame */
	ldgp	$gp, 0($27)
	subq	$sp, 64
	stq	$26, 0($sp)
	stq	$9, 8($sp)
	stq	$10, 16($sp)
	stq	$11, 24($sp)
	.frame	$sp, 64, $26
	.mask	0x04000E00, -64
	.prologue 1
/* back up */
	mov	$16, $9
	mov	$17, $10
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $11
/* wall time (start) */
	lda	$16, 32($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* execute */
	mov	$11, $22
	mulq	$10, $9
	subq	$9, 1
	ldiq	$25, 1024
$mainwr:
	stt	$f31, 0($22)
	stt	$f31, 8($22)
	stt	$f31, 16($22)
	stt	$f31, 24($22)
	stt	$f31, 32($22)
	stt	$f31, 40($22)
	stt	$f31, 48($22)
	stt	$f31, 56($22)
	stt	$f31, 64($22)
	stt	$f31, 72($22)
	stt	$f31, 80($22)
	stt	$f31, 88($22)
	stt	$f31, 96($22)
	stt	$f31, 104($22)
	stt	$f31, 112($22)
	stt	$f31, 120($22)
	stt	$f31, 128($22)
	stt	$f31, 136($22)
	stt	$f31, 144($22)
	stt	$f31, 152($22)
	stt	$f31, 160($22)
	stt	$f31, 168($22)
	stt	$f31, 176($22)
	stt	$f31, 184($22)
	stt	$f31, 192($22)
	stt	$f31, 200($22)
	stt	$f31, 208($22)
	stt	$f31, 216($22)
	stt	$f31, 224($22)
	stt	$f31, 232($22)
	stt	$f31, 240($22)
	stt	$f31, 248($22)
	stt	$f31, 256($22)
	stt	$f31, 264($22)
	stt	$f31, 272($22)
	stt	$f31, 280($22)
	stt	$f31, 288($22)
	stt	$f31, 296($22)
	stt	$f31, 304($22)
	stt	$f31, 312($22)
	stt	$f31, 320($22)
	stt	$f31, 328($22)
	stt	$f31, 336($22)
	stt	$f31, 344($22)
	stt	$f31, 352($22)
	stt	$f31, 360($22)
	stt	$f31, 368($22)
	stt	$f31, 376($22)
	stt	$f31, 384($22)
	stt	$f31, 392($22)
	stt	$f31, 400($22)
	stt	$f31, 408($22)
	stt	$f31, 416($22)
	stt	$f31, 424($22)
	stt	$f31, 432($22)
	stt	$f31, 440($22)
	stt	$f31, 448($22)
	stt	$f31, 456($22)
	stt	$f31, 464($22)
	stt	$f31, 472($22)
	stt	$f31, 480($22)
	stt	$f31, 488($22)
	stt	$f31, 496($22)
	stt	$f31, 504($22)
	stt	$f31, 512($22)
	stt	$f31, 520($22)
	stt	$f31, 528($22)
	stt	$f31, 536($22)
	stt	$f31, 544($22)
	stt	$f31, 552($22)
	stt	$f31, 560($22)
	stt	$f31, 568($22)
	stt	$f31, 576($22)
	stt	$f31, 584($22)
	stt	$f31, 592($22)
	stt	$f31, 600($22)
	stt	$f31, 608($22)
	stt	$f31, 616($22)
	stt	$f31, 624($22)
	stt	$f31, 632($22)
	stt	$f31, 640($22)
	stt	$f31, 648($22)
	stt	$f31, 656($22)
	stt	$f31, 664($22)
	stt	$f31, 672($22)
	stt	$f31, 680($22)
	stt	$f31, 688($22)
	stt	$f31, 696($22)
	stt	$f31, 704($22)
	stt	$f31, 712($22)
	stt	$f31, 720($22)
	stt	$f31, 728($22)
	stt	$f31, 736($22)
	stt	$f31, 744($22)
	stt	$f31, 752($22)
	stt	$f31, 760($22)
	stt	$f31, 768($22)
	stt	$f31, 776($22)
	stt	$f31, 784($22)
	stt	$f31, 792($22)
	stt	$f31, 800($22)
	stt	$f31, 808($22)
	stt	$f31, 816($22)
	stt	$f31, 824($22)
	stt	$f31, 832($22)
	stt	$f31, 840($22)
	stt	$f31, 848($22)
	stt	$f31, 856($22)
	stt	$f31, 864($22)
	stt	$f31, 872($22)
	stt	$f31, 880($22)
	stt	$f31, 888($22)
	stt	$f31, 896($22)
	stt	$f31, 904($22)
	stt	$f31, 912($22)
	stt	$f31, 920($22)
	stt	$f31, 928($22)
	stt	$f31, 936($22)
	stt	$f31, 944($22)
	stt	$f31, 952($22)
	stt	$f31, 960($22)
	stt	$f31, 968($22)
	stt	$f31, 976($22)
	stt	$f31, 984($22)
	stt	$f31, 992($22)
	stt	$f31, 1000($22)
	stt	$f31, 1008($22)
	stt	$f31, 1016($22)
	addq	$22, $25
	subq	$10, 1
	and	$10, $9, $0
	cmoveq	$0, $11, $22
	bne	$10, $mainwr

/* wall time (finish) */
	lda	$16, 48($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* free */
	mov	$11, $16
	jsr	free
	ldgp	$gp, 0($26)
/* calculate */
	ldq	$22, 32($sp)
	ldq	$23, 40($sp)
	ldq	$24, 48($sp)
	ldq	$25, 56($sp)
	subq	$24, $22
	ldiq	$26, 1000000
	mulq	$24, $26
	addq	$24, $25
	subq	$24, $23, $0
/* restore and return */
	ldq	$26, 0($sp)
	ldq	$9, 8($sp)
	ldq	$10, 16($sp)
	ldq	$11, 24($sp)
	addq	$sp, 64
	ret
.end	floatwr

.globl	floatrd
.ent	floatrd
floatrd:
/* set up the stack frame */
	ldgp	$gp, 0($27)
	subq	$sp, 64
	stq	$26, 0($sp)
	stq	$9, 8($sp)
	stq	$10, 16($sp)
	stq	$11, 24($sp)
	.frame	$sp, 64, $26
	.mask	0x04000E00, -64
	.prologue 1
/* back up */
	mov	$16, $9
	mov	$17, $10
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $11
/* prefill */
	sll	$9, 5, $1
$prerd:
	stt	$f31, 0($0)
	stt	$f31, 8($0)
	stt	$f31, 16($0)
	stt	$f31, 24($0)
	addq	$0, 32
	subq	$1, 1
	bne	$1, $prerd
/* wall time (start) */
	lda	$16, 32($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* execute */
	mov	$11, $22
	mulq	$10, $9
	subq	$9, 1
	ldiq	$25, 1024
$mainrd:
	ldt	$f10, 0($22)
	ldt	$f11, 8($22)
	ldt	$f12, 16($22)
	ldt	$f13, 24($22)
	ldt	$f14, 32($22)
	ldt	$f15, 40($22)
	ldt	$f16, 48($22)
	ldt	$f17, 56($22)
	ldt	$f18, 64($22)
	ldt	$f19, 72($22)
	ldt	$f20, 80($22)
	ldt	$f21, 88($22)
	ldt	$f22, 96($22)
	ldt	$f23, 104($22)
	ldt	$f24, 112($22)
	ldt	$f25, 120($22)
	ldt	$f10, 128($22)
	ldt	$f11, 136($22)
	ldt	$f12, 144($22)
	ldt	$f13, 152($22)
	ldt	$f14, 160($22)
	ldt	$f15, 168($22)
	ldt	$f16, 176($22)
	ldt	$f17, 184($22)
	ldt	$f18, 192($22)
	ldt	$f19, 200($22)
	ldt	$f20, 208($22)
	ldt	$f21, 216($22)
	ldt	$f22, 224($22)
	ldt	$f23, 232($22)
	ldt	$f24, 240($22)
	ldt	$f25, 248($22)
	ldt	$f10, 256($22)
	ldt	$f11, 264($22)
	ldt	$f12, 272($22)
	ldt	$f13, 280($22)
	ldt	$f14, 288($22)
	ldt	$f15, 296($22)
	ldt	$f16, 304($22)
	ldt	$f17, 312($22)
	ldt	$f18, 320($22)
	ldt	$f19, 328($22)
	ldt	$f20, 336($22)
	ldt	$f21, 344($22)
	ldt	$f22, 352($22)
	ldt	$f23, 360($22)
	ldt	$f24, 368($22)
	ldt	$f25, 376($22)
	ldt	$f10, 384($22)
	ldt	$f11, 392($22)
	ldt	$f12, 400($22)
	ldt	$f13, 408($22)
	ldt	$f14, 416($22)
	ldt	$f15, 424($22)
	ldt	$f16, 432($22)
	ldt	$f17, 440($22)
	ldt	$f18, 448($22)
	ldt	$f19, 456($22)
	ldt	$f20, 464($22)
	ldt	$f21, 472($22)
	ldt	$f22, 480($22)
	ldt	$f23, 488($22)
	ldt	$f24, 496($22)
	ldt	$f25, 504($22)
	ldt	$f10, 512($22)
	ldt	$f11, 520($22)
	ldt	$f12, 528($22)
	ldt	$f13, 536($22)
	ldt	$f14, 544($22)
	ldt	$f15, 552($22)
	ldt	$f16, 560($22)
	ldt	$f17, 568($22)
	ldt	$f18, 576($22)
	ldt	$f19, 584($22)
	ldt	$f20, 592($22)
	ldt	$f21, 600($22)
	ldt	$f22, 608($22)
	ldt	$f23, 616($22)
	ldt	$f24, 624($22)
	ldt	$f25, 632($22)
	ldt	$f10, 640($22)
	ldt	$f11, 648($22)
	ldt	$f12, 656($22)
	ldt	$f13, 664($22)
	ldt	$f14, 672($22)
	ldt	$f15, 680($22)
	ldt	$f16, 688($22)
	ldt	$f17, 696($22)
	ldt	$f18, 704($22)
	ldt	$f19, 712($22)
	ldt	$f20, 720($22)
	ldt	$f21, 728($22)
	ldt	$f22, 736($22)
	ldt	$f23, 744($22)
	ldt	$f24, 752($22)
	ldt	$f25, 760($22)
	ldt	$f10, 768($22)
	ldt	$f11, 776($22)
	ldt	$f12, 784($22)
	ldt	$f13, 792($22)
	ldt	$f14, 800($22)
	ldt	$f15, 808($22)
	ldt	$f16, 816($22)
	ldt	$f17, 824($22)
	ldt	$f18, 832($22)
	ldt	$f19, 840($22)
	ldt	$f20, 848($22)
	ldt	$f21, 856($22)
	ldt	$f22, 864($22)
	ldt	$f23, 872($22)
	ldt	$f24, 880($22)
	ldt	$f25, 888($22)
	ldt	$f10, 896($22)
	ldt	$f11, 904($22)
	ldt	$f12, 912($22)
	ldt	$f13, 920($22)
	ldt	$f14, 928($22)
	ldt	$f15, 936($22)
	ldt	$f16, 944($22)
	ldt	$f17, 952($22)
	ldt	$f18, 960($22)
	ldt	$f19, 968($22)
	ldt	$f20, 976($22)
	ldt	$f21, 984($22)
	ldt	$f22, 992($22)
	ldt	$f23, 1000($22)
	ldt	$f24, 1008($22)
	ldt	$f25, 1016($22)
	addq	$22, $25
	subq	$10, 1
	and	$10, $9, $0
	cmoveq	$0, $11, $22
	bne	$10, $mainrd

/* wall time (finish) */
	lda	$16, 48($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* free */
	mov	$11, $16
	jsr	free
	ldgp	$gp, 0($26)
/* calculate */
	ldq	$22, 32($sp)
	ldq	$23, 40($sp)
	ldq	$24, 48($sp)
	ldq	$25, 56($sp)
	subq	$24, $22
	ldiq	$26, 1000000
	mulq	$24, $26
	addq	$24, $25
	subq	$24, $23, $0
/* restore and return */
	ldq	$26, 0($sp)
	ldq	$9, 8($sp)
	ldq	$10, 16($sp)
	ldq	$11, 24($sp)
	addq	$sp, 64
	ret
.end	floatrd
