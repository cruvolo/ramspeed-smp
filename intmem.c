/*
**  INTmem benchmarks for RAMspeed
**
**  (UNIX release)
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2002-05 Rhett M. Hollander <rhett@alasir.com>
**
**  All rights reserved.
**
*/

#include <stdlib.h>
#include <sys/time.h>
#include "defines.h"

UTL intcp(UTL blksize, UTL passnum) {
    UTL blk = (blksize << 10);
    UTL i, ret, start, ustart, finish, ufinish;
    UTL *a, *b;
    struct timeval time;

    a = (UTL *) malloc(blk);
    b = (UTL *) malloc(blk);

    for(i = 0; i < blk/sizeof(UTL); i++) a[i] = 33;

    gettimeofday(&time, NULL);
    start  = time.tv_sec;
    ustart = time.tv_usec;

    while(passnum--) {
	for(i = 0; i < blk/sizeof(UTL); i += 32) {
    	    b[i] = a[i];        b[i+1] = a[i+1];
	    b[i+2] = a[i+2];    b[i+3] = a[i+3];
	    b[i+4] = a[i+4];    b[i+5] = a[i+5];
	    b[i+6] = a[i+6];    b[i+7] = a[i+7];
	    b[i+8] = a[i+8];    b[i+9] = a[i+9];
	    b[i+10] = a[i+10];  b[i+11] = a[i+11];
	    b[i+12] = a[i+12];  b[i+13] = a[i+13];
	    b[i+14] = a[i+14];  b[i+15] = a[i+15];
	    b[i+16] = a[i+16];  b[i+17] = a[i+17];
	    b[i+18] = a[i+18];  b[i+19] = a[i+19];
	    b[i+20] = a[i+20];  b[i+21] = a[i+21];
	    b[i+22] = a[i+22];  b[i+23] = a[i+23];
	    b[i+24] = a[i+24];  b[i+25] = a[i+25];
	    b[i+26] = a[i+26];  b[i+27] = a[i+27];
	    b[i+28] = a[i+28];  b[i+29] = a[i+29];
	    b[i+30] = a[i+30];  b[i+31] = a[i+31];
        }
    }

    gettimeofday(&time, NULL);
    finish  = time.tv_sec;
    ufinish = time.tv_usec;

    ret = (finish - start)*1000000 + (ufinish - ustart);

    free((UTL *) b);
    free((UTL *) a);

    return(ret);
}

UTL intsc(UTL blksize, UTL passnum) {
    UTL blk = (blksize << 10);
    UTL m = 77;
    UTL i, ret, start, finish, ustart, ufinish;
    UTL *a, *b;
    struct timeval time;

    a = (UTL *) malloc(blk);
    b = (UTL *) malloc(blk);

    for(i = 0; i < blk/sizeof(UTL); i++) a[i] = 33;

    gettimeofday(&time, NULL);
    start  = time.tv_sec;
    ustart = time.tv_usec;

    while(passnum--) {
	for(i = 0; i < blk/sizeof(UTL); i += 32) {
    	    b[i] = m*a[i];        b[i+1] = m*a[i+1];
	    b[i+2] = m*a[i+2];    b[i+3] = m*a[i+3];
	    b[i+4] = m*a[i+4];    b[i+5] = m*a[i+5];
	    b[i+6] = m*a[i+6];    b[i+7] = m*a[i+7];
	    b[i+8] = m*a[i+8];    b[i+9] = m*a[i+9];
	    b[i+10] = m*a[i+10];  b[i+11] = m*a[i+11];
	    b[i+12] = m*a[i+12];  b[i+13] = m*a[i+13];
	    b[i+14] = m*a[i+14];  b[i+15] = m*a[i+15];
	    b[i+16] = m*a[i+16];  b[i+17] = m*a[i+17];
	    b[i+18] = m*a[i+18];  b[i+19] = m*a[i+19];
	    b[i+20] = m*a[i+20];  b[i+21] = m*a[i+21];
	    b[i+22] = m*a[i+22];  b[i+23] = m*a[i+23];
	    b[i+24] = m*a[i+24];  b[i+25] = m*a[i+25];
	    b[i+26] = m*a[i+26];  b[i+27] = m*a[i+27];
	    b[i+28] = m*a[i+28];  b[i+29] = m*a[i+29];
	    b[i+30] = m*a[i+30];  b[i+31] = m*a[i+31];
        }
    }

    gettimeofday(&time, NULL);
    finish  = time.tv_sec;
    ufinish = time.tv_usec;

    ret = (finish - start)*1000000 + (ufinish - ustart);

    free((UTL *) b);
    free((UTL *) a);

    return(ret);
}

UTL intad(UTL blksize, UTL passnum) {
    UTL blk = (blksize << 10);
    UTL i, ret, start, finish, ustart, ufinish;
    UTL *a, *b, *c;
    struct timeval time;

    a = (UTL *) malloc(blk);
    b = (UTL *) malloc(blk);
    c = (UTL *) malloc(blk);

    for(i = 0; i < blk/sizeof(UTL); i++) {
    	a[i] = 33;
	b[i] = 55;
    }

    gettimeofday(&time, NULL);
    start  = time.tv_sec;
    ustart = time.tv_usec;

    while(passnum--) {
	for(i = 0; i < blk/sizeof(UTL); i += 32) {
	    c[i] = a[i] + b[i];           c[i+1] = a[i+1] + b[i+1];
	    c[i+2] = a[i+2] + b[i+2];     c[i+3] = a[i+3] + b[i+3];
	    c[i+4] = a[i+4] + b[i+4];     c[i+5] = a[i+5] + b[i+5];
	    c[i+6] = a[i+6] + b[i+6];     c[i+7] = a[i+7] + b[i+7];
	    c[i+8] = a[i+8] + b[i+8];     c[i+9] = a[i+9] + b[i+9];
	    c[i+10] = a[i+10] + b[i+10];  c[i+11] = a[i+11] + b[i+11];
	    c[i+12] = a[i+12] + b[i+12];  c[i+13] = a[i+13] + b[i+13];
	    c[i+14] = a[i+14] + b[i+14];  c[i+15] = a[i+15] + b[i+15];
	    c[i+16] = a[i+16] + b[i+16];  c[i+17] = a[i+17] + b[i+17];
	    c[i+18] = a[i+18] + b[i+18];  c[i+19] = a[i+19] + b[i+19];
	    c[i+20] = a[i+20] + b[i+20];  c[i+21] = a[i+21] + b[i+21];
	    c[i+22] = a[i+22] + b[i+22];  c[i+23] = a[i+23] + b[i+23];
	    c[i+24] = a[i+24] + b[i+24];  c[i+25] = a[i+25] + b[i+25];
	    c[i+26] = a[i+26] + b[i+26];  c[i+27] = a[i+27] + b[i+27];
	    c[i+28] = a[i+28] + b[i+28];  c[i+29] = a[i+29] + b[i+29];
	    c[i+30] = a[i+30] + b[i+30];  c[i+31] = a[i+31] + b[i+31];
        }
    }

    gettimeofday(&time, NULL);
    finish  = time.tv_sec;
    ufinish = time.tv_usec;

    ret = (finish - start)*1000000 + (ufinish - ustart);

    free((UTL *) c);
    free((UTL *) b);
    free((UTL *) a);
    
    return(ret);
}

UTL inttr(UTL blksize, UTL passnum) {
    UTL blk = (blksize << 10);
    UTL m = 77;
    UTL i, ret, start, finish, ustart, ufinish;
    UTL *a, *b, *c;
    struct timeval time;

    a = (UTL *) malloc(blk);
    b = (UTL *) malloc(blk);
    c = (UTL *) malloc(blk);

    for(i = 0; i < blk/sizeof(UTL); i++) {
    	a[i] = 33;
	b[i] = 55;
    }

    gettimeofday(&time, NULL);
    start  = time.tv_sec;
    ustart = time.tv_usec;

    while(passnum--) {
	for(i = 0; i < blk/sizeof(UTL); i += 32) {
	    c[i] = a[i] + m*b[i];           c[i+1] = a[i+1] + m*b[i+1];
	    c[i+2] = a[i+2] + m*b[i+2];     c[i+3] = a[i+3] + m*b[i+3];
	    c[i+4] = a[i+4] + m*b[i+4];     c[i+5] = a[i+5] + m*b[i+5];
	    c[i+6] = a[i+6] + m*b[i+6];     c[i+7] = a[i+7] + m*b[i+7];
	    c[i+8] = a[i+8] + m*b[i+8];     c[i+9] = a[i+9] + m*b[i+9];
	    c[i+10] = a[i+10] + m*b[i+10];  c[i+11] = a[i+11] + m*b[i+11];
	    c[i+12] = a[i+12] + m*b[i+12];  c[i+13] = a[i+13] + m*b[i+13];
	    c[i+14] = a[i+14] + m*b[i+14];  c[i+15] = a[i+15] + m*b[i+15];
	    c[i+16] = a[i+16] + m*b[i+16];  c[i+17] = a[i+17] + m*b[i+17];
	    c[i+18] = a[i+18] + m*b[i+18];  c[i+19] = a[i+19] + m*b[i+19];
	    c[i+20] = a[i+20] + m*b[i+20];  c[i+21] = a[i+21] + m*b[i+21];
	    c[i+22] = a[i+22] + m*b[i+22];  c[i+23] = a[i+23] + m*b[i+23];
	    c[i+24] = a[i+24] + m*b[i+24];  c[i+25] = a[i+25] + m*b[i+25];
	    c[i+26] = a[i+26] + m*b[i+26];  c[i+27] = a[i+27] + m*b[i+27];
	    c[i+28] = a[i+28] + m*b[i+28];  c[i+29] = a[i+29] + m*b[i+29];
	    c[i+30] = a[i+30] + m*b[i+30];  c[i+31] = a[i+31] + m*b[i+31];
        }
    }

    gettimeofday(&time, NULL);
    finish  = time.tv_sec;
    ufinish = time.tv_usec;

    ret = (finish - start)*1000000 + (ufinish - ustart);

    free((UTL *) c);
    free((UTL *) b);
    free((UTL *) a);
    
    return(ret);
}
