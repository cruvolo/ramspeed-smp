/*
**  INTmark benchmarks for RAMspeed (alpha [DEC])
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

.globl	intwr
.ent	intwr
intwr:
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
	stq	$31, 0($22)
	stq	$31, 8($22)
	stq	$31, 16($22)
	stq	$31, 24($22)
	stq	$31, 32($22)
	stq	$31, 40($22)
	stq	$31, 48($22)
	stq	$31, 56($22)
	stq	$31, 64($22)
	stq	$31, 72($22)
	stq	$31, 80($22)
	stq	$31, 88($22)
	stq	$31, 96($22)
	stq	$31, 104($22)
	stq	$31, 112($22)
	stq	$31, 120($22)
	stq	$31, 128($22)
	stq	$31, 136($22)
	stq	$31, 144($22)
	stq	$31, 152($22)
	stq	$31, 160($22)
	stq	$31, 168($22)
	stq	$31, 176($22)
	stq	$31, 184($22)
	stq	$31, 192($22)
	stq	$31, 200($22)
	stq	$31, 208($22)
	stq	$31, 216($22)
	stq	$31, 224($22)
	stq	$31, 232($22)
	stq	$31, 240($22)
	stq	$31, 248($22)
	stq	$31, 256($22)
	stq	$31, 264($22)
	stq	$31, 272($22)
	stq	$31, 280($22)
	stq	$31, 288($22)
	stq	$31, 296($22)
	stq	$31, 304($22)
	stq	$31, 312($22)
	stq	$31, 320($22)
	stq	$31, 328($22)
	stq	$31, 336($22)
	stq	$31, 344($22)
	stq	$31, 352($22)
	stq	$31, 360($22)
	stq	$31, 368($22)
	stq	$31, 376($22)
	stq	$31, 384($22)
	stq	$31, 392($22)
	stq	$31, 400($22)
	stq	$31, 408($22)
	stq	$31, 416($22)
	stq	$31, 424($22)
	stq	$31, 432($22)
	stq	$31, 440($22)
	stq	$31, 448($22)
	stq	$31, 456($22)
	stq	$31, 464($22)
	stq	$31, 472($22)
	stq	$31, 480($22)
	stq	$31, 488($22)
	stq	$31, 496($22)
	stq	$31, 504($22)
	stq	$31, 512($22)
	stq	$31, 520($22)
	stq	$31, 528($22)
	stq	$31, 536($22)
	stq	$31, 544($22)
	stq	$31, 552($22)
	stq	$31, 560($22)
	stq	$31, 568($22)
	stq	$31, 576($22)
	stq	$31, 584($22)
	stq	$31, 592($22)
	stq	$31, 600($22)
	stq	$31, 608($22)
	stq	$31, 616($22)
	stq	$31, 624($22)
	stq	$31, 632($22)
	stq	$31, 640($22)
	stq	$31, 648($22)
	stq	$31, 656($22)
	stq	$31, 664($22)
	stq	$31, 672($22)
	stq	$31, 680($22)
	stq	$31, 688($22)
	stq	$31, 696($22)
	stq	$31, 704($22)
	stq	$31, 712($22)
	stq	$31, 720($22)
	stq	$31, 728($22)
	stq	$31, 736($22)
	stq	$31, 744($22)
	stq	$31, 752($22)
	stq	$31, 760($22)
	stq	$31, 768($22)
	stq	$31, 776($22)
	stq	$31, 784($22)
	stq	$31, 792($22)
	stq	$31, 800($22)
	stq	$31, 808($22)
	stq	$31, 816($22)
	stq	$31, 824($22)
	stq	$31, 832($22)
	stq	$31, 840($22)
	stq	$31, 848($22)
	stq	$31, 856($22)
	stq	$31, 864($22)
	stq	$31, 872($22)
	stq	$31, 880($22)
	stq	$31, 888($22)
	stq	$31, 896($22)
	stq	$31, 904($22)
	stq	$31, 912($22)
	stq	$31, 920($22)
	stq	$31, 928($22)
	stq	$31, 936($22)
	stq	$31, 944($22)
	stq	$31, 952($22)
	stq	$31, 960($22)
	stq	$31, 968($22)
	stq	$31, 976($22)
	stq	$31, 984($22)
	stq	$31, 992($22)
	stq	$31, 1000($22)
	stq	$31, 1008($22)
	stq	$31, 1016($22)
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
	ldl	$22, 32($sp)
	ldl	$23, 36($sp)
	ldl	$24, 48($sp)
	ldl	$25, 52($sp)
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
.end	intwr

.globl	intrd
.ent	intrd
intrd:
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
	stq	$31, 0($0)
	stq	$31, 8($0)
	stq	$31, 16($0)
	stq	$31, 24($0)
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
	ldq	$0, 0($22)
	ldq	$1, 8($22)
	ldq	$2, 16($22)
	ldq	$3, 24($22)
	ldq	$4, 32($22)
	ldq	$5, 40($22)
	ldq	$6, 48($22)
	ldq	$7, 56($22)
	ldq	$8, 64($22)
	ldq	$16, 72($22)
	ldq	$17, 80($22)
	ldq	$18, 88($22)
	ldq	$19, 96($22)
	ldq	$20, 104($22)
	ldq	$21, 112($22)
	ldq	$23, 120($22)
	ldq	$0, 128($22)
	ldq	$1, 136($22)
	ldq	$2, 144($22)
	ldq	$3, 152($22)
	ldq	$4, 160($22)
	ldq	$5, 168($22)
	ldq	$6, 176($22)
	ldq	$7, 184($22)
	ldq	$8, 192($22)
	ldq	$16, 200($22)
	ldq	$17, 208($22)
	ldq	$18, 216($22)
	ldq	$19, 224($22)
	ldq	$20, 232($22)
	ldq	$21, 240($22)
	ldq	$23, 248($22)
	ldq	$0, 256($22)
	ldq	$1, 264($22)
	ldq	$2, 272($22)
	ldq	$3, 280($22)
	ldq	$4, 288($22)
	ldq	$5, 296($22)
	ldq	$6, 304($22)
	ldq	$7, 312($22)
	ldq	$8, 320($22)
	ldq	$16, 328($22)
	ldq	$17, 336($22)
	ldq	$18, 344($22)
	ldq	$19, 352($22)
	ldq	$20, 360($22)
	ldq	$21, 368($22)
	ldq	$23, 376($22)
	ldq	$0, 384($22)
	ldq	$1, 392($22)
	ldq	$2, 400($22)
	ldq	$3, 408($22)
	ldq	$4, 416($22)
	ldq	$5, 424($22)
	ldq	$6, 432($22)
	ldq	$7, 440($22)
	ldq	$8, 448($22)
	ldq	$16, 456($22)
	ldq	$17, 464($22)
	ldq	$18, 472($22)
	ldq	$19, 480($22)
	ldq	$20, 488($22)
	ldq	$21, 496($22)
	ldq	$23, 504($22)
	ldq	$0, 512($22)
	ldq	$1, 520($22)
	ldq	$2, 528($22)
	ldq	$3, 536($22)
	ldq	$4, 544($22)
	ldq	$5, 552($22)
	ldq	$6, 560($22)
	ldq	$7, 568($22)
	ldq	$8, 576($22)
	ldq	$16, 584($22)
	ldq	$17, 592($22)
	ldq	$18, 600($22)
	ldq	$19, 608($22)
	ldq	$20, 616($22)
	ldq	$21, 624($22)
	ldq	$23, 632($22)
	ldq	$0, 640($22)
	ldq	$1, 648($22)
	ldq	$2, 656($22)
	ldq	$3, 664($22)
	ldq	$4, 672($22)
	ldq	$5, 680($22)
	ldq	$6, 688($22)
	ldq	$7, 696($22)
	ldq	$8, 704($22)
	ldq	$16, 712($22)
	ldq	$17, 720($22)
	ldq	$18, 728($22)
	ldq	$19, 736($22)
	ldq	$20, 744($22)
	ldq	$21, 752($22)
	ldq	$23, 760($22)
	ldq	$0, 768($22)
	ldq	$1, 776($22)
	ldq	$2, 784($22)
	ldq	$3, 792($22)
	ldq	$4, 800($22)
	ldq	$5, 808($22)
	ldq	$6, 816($22)
	ldq	$7, 824($22)
	ldq	$8, 832($22)
	ldq	$16, 840($22)
	ldq	$17, 848($22)
	ldq	$18, 856($22)
	ldq	$19, 864($22)
	ldq	$20, 872($22)
	ldq	$21, 880($22)
	ldq	$23, 888($22)
	ldq	$0, 896($22)
	ldq	$1, 904($22)
	ldq	$2, 912($22)
	ldq	$3, 920($22)
	ldq	$4, 928($22)
	ldq	$5, 936($22)
	ldq	$6, 944($22)
	ldq	$7, 952($22)
	ldq	$8, 960($22)
	ldq	$16, 968($22)
	ldq	$17, 976($22)
	ldq	$18, 984($22)
	ldq	$19, 992($22)
	ldq	$20, 1000($22)
	ldq	$21, 1008($22)
	ldq	$23, 1016($22)
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
	ldl	$22, 32($sp)
	ldl	$23, 36($sp)
	ldl	$24, 48($sp)
	ldl	$25, 52($sp)
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
.end	intrd
