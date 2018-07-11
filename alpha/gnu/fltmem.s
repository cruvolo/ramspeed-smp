/*
**  FLOATmem benchmarks for RAMspeed (alpha [GNU])
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

$$pi:
	.double	3.1415926535897932

$$ln2:
	.double	0.6931471805599453

.globl	floatcp
.ent	floatcp
floatcp:
/* set up the stack frame */
	ldgp	$gp, 0($27)
	subq	$sp, 80
	stq	$26, 0($sp)
	stq	$9, 8($sp)
	stq	$10, 16($sp)
	stq	$11, 24($sp)
	stq	$12, 32($sp)
	.frame	$sp, 80, $26
	.mask	0x04001E00, -80
	.prologue 1
/* back up */
	mov	$16, $9
	mov	$17, $10
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $11
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $12
/* prefill */
	mov	$11, $0
	sll	$9, 5, $1
	lda	$2, $$pi
	ldt	$f0, 0($2)
$precp:
	stt	$f0, 0($0)
	stt	$f0, 8($0)
	stt	$f0, 16($0)
	stt	$f0, 24($0)
	addq	$0, 32
	subq	$1, 1
	bne	$1, $precp
/* wall time (start) */
	lda	$16, 48($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* execute */
	mov	$11, $22
	mov	$12, $23
	sll	$9, 2
	mov	$9, $0
	ldiq	$25, 256
$maincp:
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
	stt	$f10, 0($23)
	stt	$f11, 8($23)
	stt	$f12, 16($23)
	stt	$f13, 24($23)
	stt	$f14, 32($23)
	stt	$f15, 40($23)
	stt	$f16, 48($23)
	stt	$f17, 56($23)
	stt	$f18, 64($23)
	stt	$f19, 72($23)
	stt	$f20, 80($23)
	stt	$f21, 88($23)
	stt	$f22, 96($23)
	stt	$f23, 104($23)
	stt	$f24, 112($23)
	stt	$f25, 120($23)
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
	stt	$f10, 128($23)
	stt	$f11, 136($23)
	stt	$f12, 144($23)
	stt	$f13, 152($23)
	stt	$f14, 160($23)
	stt	$f15, 168($23)
	stt	$f16, 176($23)
	stt	$f17, 184($23)
	stt	$f18, 192($23)
	stt	$f19, 200($23)
	stt	$f20, 208($23)
	stt	$f21, 216($23)
	stt	$f22, 224($23)
	stt	$f23, 232($23)
	stt	$f24, 240($23)
	stt	$f25, 248($23)
	addq	$22, $25
	addq	$23, $25
	subq	$0, 1
	bne	$0, $maincp

	mov	$11, $22
	mov	$12, $23
	mov	$9, $0
	subq	$10, 1
	bne	$10, $maincp

/* wall time (finish) */
	lda	$16, 64($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* free */
	mov	$12, $16
	jsr	free
	ldgp	$gp, 0($26)
/* free */
	mov	$11, $16
	jsr	free
	ldgp	$gp, 0($26)
/* calculate */
	ldq	$22, 48($sp)
	ldq	$23, 56($sp)
	ldq	$24, 64($sp)
	ldq	$25, 72($sp)
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
	ldq	$12, 32($sp)
	addq	$sp, 80
	ret
.end    floatcp

.globl  floatsc
.ent    floatsc
floatsc:
/* set up the stack frame */
	ldgp	$gp, 0($27)
	subq	$sp, 80
	stq	$26, 0($sp)
	stq	$9, 8($sp)
	stq	$10, 16($sp)
	stq	$11, 24($sp)
	stq	$12, 32($sp)
	.frame	$sp, 80, $26
	.mask	0x04001E00, -80
	.prologue 1
/* back up */
	mov	$16, $9
	mov	$17, $10
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $11
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $12
/* prefill */
	mov	$11, $0
	sll	$9, 5, $1
	lda	$2, $$pi
	ldt	$f0, 0($2)
$presc:
	stt	$f0, 0($0)
	stt	$f0, 8($0)
	stt	$f0, 16($0)
	stt	$f0, 24($0)
	addq	$0, 32
	subq	$1, 1
	bne	$1, $presc
/* wall time (start) */
	lda	$16, 48($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* execute */
	mov	$11, $22
	mov	$12, $23
	sll	$9, 2
	mov	$9, $0
	ldiq	$25, 256
	lda	$2, $$ln2
	ldt	$f0, 0($2)
$mainsc:
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
	mult	$f10, $f0
	mult	$f11, $f0
	mult	$f12, $f0
	mult	$f13, $f0
	mult	$f14, $f0
	mult	$f15, $f0
	mult	$f16, $f0
	mult	$f17, $f0
	mult	$f18, $f0
	mult	$f19, $f0
	mult	$f20, $f0
	mult	$f21, $f0
	mult	$f22, $f0
	mult	$f23, $f0
	mult	$f24, $f0
	mult	$f25, $f0
	stt	$f10, 0($23)
	stt	$f11, 8($23)
	stt	$f12, 16($23)
	stt	$f13, 24($23)
	stt	$f14, 32($23)
	stt	$f15, 40($23)
	stt	$f16, 48($23)
	stt	$f17, 56($23)
	stt	$f18, 64($23)
	stt	$f19, 72($23)
	stt	$f20, 80($23)
	stt	$f21, 88($23)
	stt	$f22, 96($23)
	stt	$f23, 104($23)
	stt	$f24, 112($23)
	stt	$f25, 120($23)
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
	mult	$f10, $f0
	mult	$f11, $f0
	mult	$f12, $f0
	mult	$f13, $f0
	mult	$f14, $f0
	mult	$f15, $f0
	mult	$f16, $f0
	mult	$f17, $f0
	mult	$f18, $f0
	mult	$f19, $f0
	mult	$f20, $f0
	mult	$f21, $f0
	mult	$f22, $f0
	mult	$f23, $f0
	mult	$f24, $f0
	mult	$f25, $f0
	stt	$f10, 128($23)
	stt	$f11, 136($23)
	stt	$f12, 144($23)
	stt	$f13, 152($23)
	stt	$f14, 160($23)
	stt	$f15, 168($23)
	stt	$f16, 176($23)
	stt	$f17, 184($23)
	stt	$f18, 192($23)
	stt	$f19, 200($23)
	stt	$f20, 208($23)
	stt	$f21, 216($23)
	stt	$f22, 224($23)
	stt	$f23, 232($23)
	stt	$f24, 240($23)
	stt	$f25, 248($23)
	addq	$22, $25
	addq	$23, $25
	subq	$0, 1
	bne	$0, $mainsc

	mov	$11, $22
	mov	$12, $23
	mov	$9, $0
	subq	$10, 1
	bne	$10, $mainsc

/* wall time (finish) */
	lda	$16, 64($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* free */
	mov	$12, $16
	jsr	free
	ldgp	$gp, 0($26)
/* free */
	mov	$11, $16
	jsr	free
	ldgp	$gp, 0($26)
/* calculate */
	ldq	$22, 48($sp)
	ldq	$23, 56($sp)
	ldq	$24, 64($sp)
	ldq	$25, 72($sp)
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
	ldq	$12, 32($sp)
	addq	$sp, 80
	ret
.end    floatsc

.globl	floatad
.ent	floatad
floatad:
/* set up the stack frame */
	ldgp	$gp, 0($27)
	subq	$sp, 80
	stq	$26, 0($sp)
	stq	$9, 8($sp)
	stq	$10, 16($sp)
	stq	$11, 24($sp)
	stq	$12, 32($sp)
	stq	$13, 40($sp)
	.frame	$sp, 80, $26
	.mask	0x04003E00, -80
	.prologue 1
/* back up */
	mov	$16, $9
	mov	$17, $10
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $11
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $12
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $13
/* prefill */
	mov	$11, $0
	mov	$12, $1
	sll	$9, 5, $2
	lda	$3, $$pi
	ldt	$f0, 0($3)
$pread:
	stt	$f0, 0($0)
	stt	$f0, 8($0)
	stt	$f0, 16($0)
	stt	$f0, 24($0)
	stt	$f0, 0($1)
	stt	$f0, 8($1)
	stt	$f0, 16($1)
	stt	$f0, 24($1)
	addq	$0, 32
	addq	$1, 32
	subq	$2, 1
	bne	$2, $pread
/* wall time (start) */
	lda	$16, 48($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* execute */
	mov	$11, $22
	mov	$12, $23
	mov	$13, $24
	sll	$9, 2
	mov	$9, $0
	ldiq	$25, 256
$mainad:
	ldt	$f10, 0($22)
	ldt	$f11, 8($22)
	ldt	$f12, 16($22)
	ldt	$f13, 24($22)
	ldt	$f14, 32($22)
	ldt	$f15, 40($22)
	ldt	$f16, 48($22)
	ldt	$f17, 56($22)
	ldt	$f18, 0($23)
	ldt	$f19, 8($23)
	ldt	$f20, 16($23)
	ldt	$f21, 24($23)
	ldt	$f22, 32($23)
	ldt	$f23, 40($23)
	ldt	$f24, 48($23)
	ldt	$f25, 56($23)
	addt	$f10, $f18
	addt	$f11, $f19
	addt	$f12, $f20
	addt	$f13, $f21
	addt	$f14, $f22
	addt	$f15, $f23
	addt	$f16, $f24
	addt	$f17, $f25
	stt	$f10, 0($24)
	stt	$f11, 8($24)
	stt	$f12, 16($24)
	stt	$f13, 24($24)
	stt	$f14, 32($24)
	stt	$f15, 40($24)
	stt	$f16, 48($24)
	stt	$f17, 56($24)
	ldt	$f10, 64($22)
	ldt	$f11, 72($22)
	ldt	$f12, 80($22)
	ldt	$f13, 88($22)
	ldt	$f14, 96($22)
	ldt	$f15, 104($22)
	ldt	$f16, 112($22)
	ldt	$f17, 120($22)
	ldt	$f18, 64($23)
	ldt	$f19, 72($23)
	ldt	$f20, 80($23)
	ldt	$f21, 88($23)
	ldt	$f22, 96($23)
	ldt	$f23, 104($23)
	ldt	$f24, 112($23)
	ldt	$f25, 120($23)
	addt	$f10, $f18
	addt	$f11, $f19
	addt	$f12, $f20
	addt	$f13, $f21
	addt	$f14, $f22
	addt	$f15, $f23
	addt	$f16, $f24
	addt	$f17, $f25
	stt	$f10, 64($24)
	stt	$f11, 72($24)
	stt	$f12, 80($24)
	stt	$f13, 88($24)
	stt	$f14, 96($24)
	stt	$f15, 104($24)
	stt	$f16, 112($24)
	stt	$f17, 120($24)
	ldt	$f10, 128($22)
	ldt	$f11, 136($22)
	ldt	$f12, 144($22)
	ldt	$f13, 152($22)
	ldt	$f14, 160($22)
	ldt	$f15, 168($22)
	ldt	$f16, 176($22)
	ldt	$f17, 184($22)
	ldt	$f18, 128($23)
	ldt	$f19, 136($23)
	ldt	$f20, 144($23)
	ldt	$f21, 152($23)
	ldt	$f22, 160($23)
	ldt	$f23, 168($23)
	ldt	$f24, 176($23)
	ldt	$f25, 184($23)
	addt	$f10, $f18
	addt	$f11, $f19
	addt	$f12, $f20
	addt	$f13, $f21
	addt	$f14, $f22
	addt	$f15, $f23
	addt	$f16, $f24
	addt	$f17, $f25
	stt	$f10, 128($24)
	stt	$f11, 136($24)
	stt	$f12, 144($24)
	stt	$f13, 152($24)
	stt	$f14, 160($24)
	stt	$f15, 168($24)
	stt	$f16, 176($24)
	stt	$f17, 184($24)
	ldt	$f10, 192($22)
	ldt	$f11, 200($22)
	ldt	$f12, 208($22)
	ldt	$f13, 216($22)
	ldt	$f14, 224($22)
	ldt	$f15, 232($22)
	ldt	$f16, 240($22)
	ldt	$f17, 248($22)
	ldt	$f18, 192($23)
	ldt	$f19, 200($23)
	ldt	$f20, 208($23)
	ldt	$f21, 216($23)
	ldt	$f22, 224($23)
	ldt	$f23, 232($23)
	ldt	$f24, 240($23)
	ldt	$f25, 248($23)
	addt	$f10, $f18
	addt	$f11, $f19
	addt	$f12, $f20
	addt	$f13, $f21
	addt	$f14, $f22
	addt	$f15, $f23
	addt	$f16, $f24
	addt	$f17, $f25
	stt	$f10, 192($24)
	stt	$f11, 200($24)
	stt	$f12, 208($24)
	stt	$f13, 216($24)
	stt	$f14, 224($24)
	stt	$f15, 232($24)
	stt	$f16, 240($24)
	stt	$f17, 248($24)
	addq	$22, $25
	addq	$23, $25
	addq	$24, $25
	subq	$0, 1
	bne	$0, $mainad

	mov	$11, $22
	mov	$12, $23
	mov	$13, $24
	mov	$9, $0
	subq	$10, 1
	bne	$10, $mainad

/* wall time (finish) */
	lda	$16, 64($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* free */
	mov	$13, $16
	jsr	free
	ldgp	$gp, 0($26)
/* free */
	mov	$12, $16
	jsr	free
	ldgp	$gp, 0($26)
/* free */
	mov	$11, $16
	jsr	free
	ldgp	$gp, 0($26)
/* calculate */
	ldq	$22, 48($sp)
	ldq	$23, 56($sp)
	ldq	$24, 64($sp)
	ldq	$25, 72($sp)
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
	ldq	$12, 32($sp)
	ldq	$13, 40($sp)
	addq	$sp, 80
	ret
.end	floatad

.globl	floattr
.ent	floattr
floattr:
/* set up the stack frame */
	ldgp	$gp, 0($27)
	subq	$sp, 80
	stq	$26, 0($sp)
	stq	$9, 8($sp)
	stq	$10, 16($sp)
	stq	$11, 24($sp)
	stq	$12, 32($sp)
	stq	$13, 40($sp)
	.frame	$sp, 80, $26
	.mask	0x04003E00, -80
	.prologue 1
/* back up */
	mov	$16, $9
	mov	$17, $10
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $11
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $12
/* allocate */
	sll	$9, 10, $16
	jsr	malloc
	ldgp	$gp, 0($26)
	mov	$0, $13
/* prefill */
	mov	$11, $0
	mov	$12, $1
	sll	$9, 5, $2
	lda	$3, $$pi
	ldt	$f0, 0($3)
$pretr:
	stt	$f0, 0($0)
	stt	$f0, 8($0)
	stt	$f0, 16($0)
	stt	$f0, 24($0)
	stt	$f0, 0($1)
	stt	$f0, 8($1)
	stt	$f0, 16($1)
	stt	$f0, 24($1)
	addq	$0, 32
	addq	$1, 32
	subq	$2, 1
	bne	$2, $pretr
/* wall time (start) */
	lda	$16, 48($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* execute */
	mov	$11, $22
	mov	$12, $23
	mov	$13, $24
	sll	$9, 2
	mov	$9, $0
	ldiq	$25, 256
	lda	$2, $$ln2
	ldt	$f0, 0($2)
$maintr:
	ldt	$f10, 0($22)
	ldt	$f11, 8($22)
	ldt	$f12, 16($22)
	ldt	$f13, 24($22)
	ldt	$f14, 32($22)
	ldt	$f15, 40($22)
	ldt	$f16, 48($22)
	ldt	$f17, 56($22)
	ldt	$f18, 0($23)
	ldt	$f19, 8($23)
	ldt	$f20, 16($23)
	ldt	$f21, 24($23)
	ldt	$f22, 32($23)
	ldt	$f23, 40($23)
	ldt	$f24, 48($23)
	ldt	$f25, 56($23)
	mult	$f10, $f0
	mult	$f11, $f0
	mult	$f12, $f0
	mult	$f13, $f0
	mult	$f14, $f0
	mult	$f15, $f0
	mult	$f16, $f0
	mult	$f17, $f0
	addt	$f10, $f18
	addt	$f11, $f19
	addt	$f12, $f20
	addt	$f13, $f21
	addt	$f14, $f22
	addt	$f15, $f23
	addt	$f16, $f24
	addt	$f17, $f25
	stt	$f10, 0($24)
	stt	$f11, 8($24)
	stt	$f12, 16($24)
	stt	$f13, 24($24)
	stt	$f14, 32($24)
	stt	$f15, 40($24)
	stt	$f16, 48($24)
	stt	$f17, 56($24)
	ldt	$f10, 64($22)
	ldt	$f11, 72($22)
	ldt	$f12, 80($22)
	ldt	$f13, 88($22)
	ldt	$f14, 96($22)
	ldt	$f15, 104($22)
	ldt	$f16, 112($22)
	ldt	$f17, 120($22)
	ldt	$f18, 64($23)
	ldt	$f19, 72($23)
	ldt	$f20, 80($23)
	ldt	$f21, 88($23)
	ldt	$f22, 96($23)
	ldt	$f23, 104($23)
	ldt	$f24, 112($23)
	ldt	$f25, 120($23)
	mult	$f10, $f0
	mult	$f11, $f0
	mult	$f12, $f0
	mult	$f13, $f0
	mult	$f14, $f0
	mult	$f15, $f0
	mult	$f16, $f0
	mult	$f17, $f0
	addt	$f10, $f18
	addt	$f11, $f19
	addt	$f12, $f20
	addt	$f13, $f21
	addt	$f14, $f22
	addt	$f15, $f23
	addt	$f16, $f24
	addt	$f17, $f25
	stt	$f10, 64($24)
	stt	$f11, 72($24)
	stt	$f12, 80($24)
	stt	$f13, 88($24)
	stt	$f14, 96($24)
	stt	$f15, 104($24)
	stt	$f16, 112($24)
	stt	$f17, 120($24)
	ldt	$f10, 128($22)
	ldt	$f11, 136($22)
	ldt	$f12, 144($22)
	ldt	$f13, 152($22)
	ldt	$f14, 160($22)
	ldt	$f15, 168($22)
	ldt	$f16, 176($22)
	ldt	$f17, 184($22)
	ldt	$f18, 128($23)
	ldt	$f19, 136($23)
	ldt	$f20, 144($23)
	ldt	$f21, 152($23)
	ldt	$f22, 160($23)
	ldt	$f23, 168($23)
	ldt	$f24, 176($23)
	ldt	$f25, 184($23)
	mult	$f10, $f0
	mult	$f11, $f0
	mult	$f12, $f0
	mult	$f13, $f0
	mult	$f14, $f0
	mult	$f15, $f0
	mult	$f16, $f0
	mult	$f17, $f0
	addt	$f10, $f18
	addt	$f11, $f19
	addt	$f12, $f20
	addt	$f13, $f21
	addt	$f14, $f22
	addt	$f15, $f23
	addt	$f16, $f24
	addt	$f17, $f25
	stt	$f10, 128($24)
	stt	$f11, 136($24)
	stt	$f12, 144($24)
	stt	$f13, 152($24)
	stt	$f14, 160($24)
	stt	$f15, 168($24)
	stt	$f16, 176($24)
	stt	$f17, 184($24)
	ldt	$f10, 192($22)
	ldt	$f11, 200($22)
	ldt	$f12, 208($22)
	ldt	$f13, 216($22)
	ldt	$f14, 224($22)
	ldt	$f15, 232($22)
	ldt	$f16, 240($22)
	ldt	$f17, 248($22)
	ldt	$f18, 192($23)
	ldt	$f19, 200($23)
	ldt	$f20, 208($23)
	ldt	$f21, 216($23)
	ldt	$f22, 224($23)
	ldt	$f23, 232($23)
	ldt	$f24, 240($23)
	ldt	$f25, 248($23)
	mult	$f10, $f0
	mult	$f11, $f0
	mult	$f12, $f0
	mult	$f13, $f0
	mult	$f14, $f0
	mult	$f15, $f0
	mult	$f16, $f0
	mult	$f17, $f0
	addt	$f10, $f18
	addt	$f11, $f19
	addt	$f12, $f20
	addt	$f13, $f21
	addt	$f14, $f22
	addt	$f15, $f23
	addt	$f16, $f24
	addt	$f17, $f25
	stt	$f10, 192($24)
	stt	$f11, 200($24)
	stt	$f12, 208($24)
	stt	$f13, 216($24)
	stt	$f14, 224($24)
	stt	$f15, 232($24)
	stt	$f16, 240($24)
	stt	$f17, 248($24)
	addq	$22, $25
	addq	$23, $25
	addq	$24, $25
	subq	$0, 1
	bne	$0, $maintr

	mov	$11, $22
	mov	$12, $23
	mov	$13, $24
	mov	$9, $0
	subq	$10, 1
	bne	$10, $maintr

/* wall time (finish) */
	lda	$16, 64($sp)
	clr	$17
	jsr	gettimeofday
	ldgp	$gp, 0($26)
/* free */
	mov	$13, $16
	jsr	free
	ldgp	$gp, 0($26)
/* free */
	mov	$12, $16
	jsr	free
	ldgp	$gp, 0($26)
/* free */
	mov	$11, $16
	jsr	free
	ldgp	$gp, 0($26)
/* calculate */
	ldq	$22, 48($sp)
	ldq	$23, 56($sp)
	ldq	$24, 64($sp)
	ldq	$25, 72($sp)
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
	ldq	$12, 32($sp)
	ldq	$13, 40($sp)
	addq	$sp, 80
	ret
.end	floattr
