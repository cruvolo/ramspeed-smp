/*
**  INTmem benchmarks for RAMspeed (alpha [GNU])
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

.set	noat
.set	noreorder

.globl	intcp
.ent	intcp
intcp:
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
	ldiq	$2, 33
$precp:
	stq	$2, 0($0)
	stq	$2, 8($0)
	stq	$2, 16($0)
	stq	$2, 24($0)
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
	ldq	$1, 0($22)
	ldq	$2, 8($22)
	ldq	$3, 16($22)
	ldq	$4, 24($22)
	ldq	$5, 32($22)
	ldq	$6, 40($22)
	ldq	$7, 48($22)
	ldq	$8, 56($22)
	ldq	$16, 64($22)
	ldq	$17, 72($22)
	ldq	$18, 80($22)
	ldq	$19, 88($22)
	ldq	$20, 96($22)
	ldq	$21, 104($22)
	ldq	$27, 112($22)
	ldq	$28, 120($22)
	stq	$1, 0($23)
	stq	$2, 8($23)
	stq	$3, 16($23)
	stq	$4, 24($23)
	stq	$5, 32($23)
	stq	$6, 40($23)
	stq	$7, 48($23)
	stq	$8, 56($23)
	stq	$16, 64($23)
	stq	$17, 72($23)
	stq	$18, 80($23)
	stq	$19, 88($23)
	stq	$20, 96($23)
	stq	$21, 104($23)
	stq	$27, 112($23)
	stq	$28, 120($23)
	ldq	$1, 128($22)
	ldq	$2, 136($22)
	ldq	$3, 144($22)
	ldq	$4, 152($22)
	ldq	$5, 160($22)
	ldq	$6, 168($22)
	ldq	$7, 176($22)
	ldq	$8, 184($22)
	ldq	$16, 192($22)
	ldq	$17, 200($22)
	ldq	$18, 208($22)
	ldq	$19, 216($22)
	ldq	$20, 224($22)
	ldq	$21, 232($22)
	ldq	$27, 240($22)
	ldq	$28, 248($22)
	stq	$1, 128($23)
	stq	$2, 136($23)
	stq	$3, 144($23)
	stq	$4, 152($23)
	stq	$5, 160($23)
	stq	$6, 168($23)
	stq	$7, 176($23)
	stq	$8, 184($23)
	stq	$16, 192($23)
	stq	$17, 200($23)
	stq	$18, 208($23)
	stq	$19, 216($23)
	stq	$20, 224($23)
	stq	$21, 232($23)
	stq	$27, 240($23)
	stq	$28, 248($23)
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
.end    intcp

.globl  intsc
.ent    intsc
intsc:
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
	ldiq	$2, 33
$presc:
	stq	$2, 0($0)
	stq	$2, 8($0)
	stq	$2, 16($0)
	stq	$2, 24($0)
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
	ldiq	$26, 77
$mainsc:
	ldq	$1, 0($22)
	ldq	$2, 8($22)
	ldq	$3, 16($22)
	ldq	$4, 24($22)
	ldq	$5, 32($22)
	ldq	$6, 40($22)
	ldq	$7, 48($22)
	ldq	$8, 56($22)
	ldq	$16, 64($22)
	ldq	$17, 72($22)
	ldq	$18, 80($22)
	ldq	$19, 88($22)
	ldq	$20, 96($22)
	ldq	$21, 104($22)
	ldq	$27, 112($22)
	ldq	$28, 120($22)
	mulq	$1, $26
	mulq	$2, $26
	mulq	$3, $26
	mulq	$4, $26
	mulq	$5, $26
	mulq	$6, $26
	mulq	$7, $26
	mulq	$8, $26
	mulq	$16, $26
	mulq	$17, $26
	mulq	$18, $26
	mulq	$19, $26
	mulq	$20, $26
	mulq	$21, $26
	mulq	$27, $26
	mulq	$28, $26
	stq	$1, 0($23)
	stq	$2, 8($23)
	stq	$3, 16($23)
	stq	$4, 24($23)
	stq	$5, 32($23)
	stq	$6, 40($23)
	stq	$7, 48($23)
	stq	$8, 56($23)
	stq	$16, 64($23)
	stq	$17, 72($23)
	stq	$18, 80($23)
	stq	$19, 88($23)
	stq	$20, 96($23)
	stq	$21, 104($23)
	stq	$27, 112($23)
	stq	$28, 120($23)
	ldq	$1, 128($22)
	ldq	$2, 136($22)
	ldq	$3, 144($22)
	ldq	$4, 152($22)
	ldq	$5, 160($22)
	ldq	$6, 168($22)
	ldq	$7, 176($22)
	ldq	$8, 184($22)
	ldq	$16, 192($22)
	ldq	$17, 200($22)
	ldq	$18, 208($22)
	ldq	$19, 216($22)
	ldq	$20, 224($22)
	ldq	$21, 232($22)
	ldq	$27, 240($22)
	ldq	$28, 248($22)
	mulq	$1, $26
	mulq	$2, $26
	mulq	$3, $26
	mulq	$4, $26
	mulq	$5, $26
	mulq	$6, $26
	mulq	$7, $26
	mulq	$8, $26
	mulq	$16, $26
	mulq	$17, $26
	mulq	$18, $26
	mulq	$19, $26
	mulq	$20, $26
	mulq	$21, $26
	mulq	$27, $26
	mulq	$28, $26
	stq	$1, 128($23)
	stq	$2, 136($23)
	stq	$3, 144($23)
	stq	$4, 152($23)
	stq	$5, 160($23)
	stq	$6, 168($23)
	stq	$7, 176($23)
	stq	$8, 184($23)
	stq	$16, 192($23)
	stq	$17, 200($23)
	stq	$18, 208($23)
	stq	$19, 216($23)
	stq	$20, 224($23)
	stq	$21, 232($23)
	stq	$27, 240($23)
	stq	$28, 248($23)
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
.end    intsc

.globl	intad
.ent	intad
intad:
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
	ldiq	$3, 33
	ldiq	$4, 55
$pread:
	stq	$3, 0($0)
	stq	$3, 8($0)
	stq	$3, 16($0)
	stq	$3, 24($0)
	stq	$4, 0($1)
	stq	$4, 8($1)
	stq	$4, 16($1)
	stq	$4, 24($1)
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
	ldq	$1, 0($22)
	ldq	$2, 8($22)
	ldq	$3, 16($22)
	ldq	$4, 24($22)
	ldq	$5, 32($22)
	ldq	$6, 40($22)
	ldq	$7, 48($22)
	ldq	$8, 56($22)
	ldq	$16, 0($23)
	ldq	$17, 8($23)
	ldq	$18, 16($23)
	ldq	$19, 24($23)
	ldq	$20, 32($23)
	ldq	$21, 40($23)
	ldq	$27, 48($23)
	ldq	$28, 56($23)
	addq	$1, $16
	addq	$2, $17
	addq	$3, $18
	addq	$4, $19
	addq	$5, $20
	addq	$6, $21
	addq	$7, $27
	addq	$8, $28
	stq	$1, 0($24)
	stq	$2, 8($24)
	stq	$3, 16($24)
	stq	$4, 24($24)
	stq	$5, 32($24)
	stq	$6, 40($24)
	stq	$7, 48($24)
	stq	$8, 56($24)
	ldq	$1, 64($22)
	ldq	$2, 72($22)
	ldq	$3, 80($22)
	ldq	$4, 88($22)
	ldq	$5, 96($22)
	ldq	$6, 104($22)
	ldq	$7, 112($22)
	ldq	$8, 120($22)
	ldq	$16, 64($23)
	ldq	$17, 72($23)
	ldq	$18, 80($23)
	ldq	$19, 88($23)
	ldq	$20, 96($23)
	ldq	$21, 104($23)
	ldq	$27, 112($23)
	ldq	$28, 120($23)
	addq	$1, $16
	addq	$2, $17
	addq	$3, $18
	addq	$4, $19
	addq	$5, $20
	addq	$6, $21
	addq	$7, $27
	addq	$8, $28
	stq	$1, 64($24)
	stq	$2, 72($24)
	stq	$3, 80($24)
	stq	$4, 88($24)
	stq	$5, 96($24)
	stq	$6, 104($24)
	stq	$7, 112($24)
	stq	$8, 120($24)
	ldq	$1, 128($22)
	ldq	$2, 136($22)
	ldq	$3, 144($22)
	ldq	$4, 152($22)
	ldq	$5, 160($22)
	ldq	$6, 168($22)
	ldq	$7, 176($22)
	ldq	$8, 184($22)
	ldq	$16, 128($23)
	ldq	$17, 136($23)
	ldq	$18, 144($23)
	ldq	$19, 152($23)
	ldq	$20, 160($23)
	ldq	$21, 168($23)
	ldq	$27, 176($23)
	ldq	$28, 184($23)
	addq	$1, $16
	addq	$2, $17
	addq	$3, $18
	addq	$4, $19
	addq	$5, $20
	addq	$6, $21
	addq	$7, $27
	addq	$8, $28
	stq	$1, 128($24)
	stq	$2, 136($24)
	stq	$3, 144($24)
	stq	$4, 152($24)
	stq	$5, 160($24)
	stq	$6, 168($24)
	stq	$7, 176($24)
	stq	$8, 184($24)
	ldq	$1, 192($22)
	ldq	$2, 200($22)
	ldq	$3, 208($22)
	ldq	$4, 216($22)
	ldq	$5, 224($22)
	ldq	$6, 232($22)
	ldq	$7, 240($22)
	ldq	$8, 248($22)
	ldq	$16, 192($23)
	ldq	$17, 200($23)
	ldq	$18, 208($23)
	ldq	$19, 216($23)
	ldq	$20, 224($23)
	ldq	$21, 232($23)
	ldq	$27, 240($23)
	ldq	$28, 248($23)
	addq	$1, $16
	addq	$2, $17
	addq	$3, $18
	addq	$4, $19
	addq	$5, $20
	addq	$6, $21
	addq	$7, $27
	addq	$8, $28
	stq	$1, 192($24)
	stq	$2, 200($24)
	stq	$3, 208($24)
	stq	$4, 216($24)
	stq	$5, 224($24)
	stq	$6, 232($24)
	stq	$7, 240($24)
	stq	$8, 248($24)
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
.end	intad

.globl	inttr
.ent	inttr
inttr:
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
	ldiq	$3, 33
	ldiq	$4, 55
$pretr:
	stq	$3, 0($0)
	stq	$3, 8($0)
	stq	$3, 16($0)
	stq	$3, 24($0)
	stq	$4, 0($1)
	stq	$4, 8($1)
	stq	$4, 16($1)
	stq	$4, 24($1)
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
	ldiq	$26, 77
$maintr:
	ldq	$1, 0($22)
	ldq	$2, 8($22)
	ldq	$3, 16($22)
	ldq	$4, 24($22)
	ldq	$5, 32($22)
	ldq	$6, 40($22)
	ldq	$7, 48($22)
	ldq	$8, 56($22)
	ldq	$16, 0($23)
	ldq	$17, 8($23)
	ldq	$18, 16($23)
	ldq	$19, 24($23)
	ldq	$20, 32($23)
	ldq	$21, 40($23)
	ldq	$27, 48($23)
	ldq	$28, 56($23)
	mulq	$1, $26
	mulq	$2, $26
	mulq	$3, $26
	mulq	$4, $26
	mulq	$5, $26
	mulq	$6, $26
	mulq	$7, $26
	mulq	$8, $26
	addq	$1, $16
	addq	$2, $17
	addq	$3, $18
	addq	$4, $19
	addq	$5, $20
	addq	$6, $21
	addq	$7, $27
	addq	$8, $28
	stq	$1, 0($24)
	stq	$2, 8($24)
	stq	$3, 16($24)
	stq	$4, 24($24)
	stq	$5, 32($24)
	stq	$6, 40($24)
	stq	$7, 48($24)
	stq	$8, 56($24)
	ldq	$1, 64($22)
	ldq	$2, 72($22)
	ldq	$3, 80($22)
	ldq	$4, 88($22)
	ldq	$5, 96($22)
	ldq	$6, 104($22)
	ldq	$7, 112($22)
	ldq	$8, 120($22)
	ldq	$16, 64($23)
	ldq	$17, 72($23)
	ldq	$18, 80($23)
	ldq	$19, 88($23)
	ldq	$20, 96($23)
	ldq	$21, 104($23)
	ldq	$27, 112($23)
	ldq	$28, 120($23)
	mulq	$1, $26
	mulq	$2, $26
	mulq	$3, $26
	mulq	$4, $26
	mulq	$5, $26
	mulq	$6, $26
	mulq	$7, $26
	mulq	$8, $26
	addq	$1, $16
	addq	$2, $17
	addq	$3, $18
	addq	$4, $19
	addq	$5, $20
	addq	$6, $21
	addq	$7, $27
	addq	$8, $28
	stq	$1, 64($24)
	stq	$2, 72($24)
	stq	$3, 80($24)
	stq	$4, 88($24)
	stq	$5, 96($24)
	stq	$6, 104($24)
	stq	$7, 112($24)
	stq	$8, 120($24)
	ldq	$1, 128($22)
	ldq	$2, 136($22)
	ldq	$3, 144($22)
	ldq	$4, 152($22)
	ldq	$5, 160($22)
	ldq	$6, 168($22)
	ldq	$7, 176($22)
	ldq	$8, 184($22)
	ldq	$16, 128($23)
	ldq	$17, 136($23)
	ldq	$18, 144($23)
	ldq	$19, 152($23)
	ldq	$20, 160($23)
	ldq	$21, 168($23)
	ldq	$27, 176($23)
	ldq	$28, 184($23)
	mulq	$1, $26
	mulq	$2, $26
	mulq	$3, $26
	mulq	$4, $26
	mulq	$5, $26
	mulq	$6, $26
	mulq	$7, $26
	mulq	$8, $26
	addq	$1, $16
	addq	$2, $17
	addq	$3, $18
	addq	$4, $19
	addq	$5, $20
	addq	$6, $21
	addq	$7, $27
	addq	$8, $28
	stq	$1, 128($24)
	stq	$2, 136($24)
	stq	$3, 144($24)
	stq	$4, 152($24)
	stq	$5, 160($24)
	stq	$6, 168($24)
	stq	$7, 176($24)
	stq	$8, 184($24)
	ldq	$1, 192($22)
	ldq	$2, 200($22)
	ldq	$3, 208($22)
	ldq	$4, 216($22)
	ldq	$5, 224($22)
	ldq	$6, 232($22)
	ldq	$7, 240($22)
	ldq	$8, 248($22)
	ldq	$16, 192($23)
	ldq	$17, 200($23)
	ldq	$18, 208($23)
	ldq	$19, 216($23)
	ldq	$20, 224($23)
	ldq	$21, 232($23)
	ldq	$27, 240($23)
	ldq	$28, 248($23)
	mulq	$1, $26
	mulq	$2, $26
	mulq	$3, $26
	mulq	$4, $26
	mulq	$5, $26
	mulq	$6, $26
	mulq	$7, $26
	mulq	$8, $26
	addq	$1, $16
	addq	$2, $17
	addq	$3, $18
	addq	$4, $19
	addq	$5, $20
	addq	$6, $21
	addq	$7, $27
	addq	$8, $28
	stq	$1, 192($24)
	stq	$2, 200($24)
	stq	$3, 208($24)
	stq	$4, 216($24)
	stq	$5, 224($24)
	stq	$6, 232($24)
	stq	$7, 240($24)
	stq	$8, 248($24)
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
.end	inttr
