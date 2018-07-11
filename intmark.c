/*
**  INTmark benchmarks for RAMspeed
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

UTL intwr(UTL blksize, UTL passnum) {
    UTL blk = (blksize << 10);
    UTL b = 0;
    UTL a, ret, start, ustart, finish, ufinish;
    UTL *mem;
    struct timeval time;

    mem = (UTL *) malloc(blk);

    gettimeofday(&time, NULL);
    start  = time.tv_sec;
    ustart = time.tv_usec;

    while(passnum--) {
    	for(a = 0; a < blk/sizeof(UTL); a += 64) {
	    mem[a] = b;    mem[a+1] = b;  mem[a+2] = b;  mem[a+3] = b;
	    mem[a+4] = b;  mem[a+5] = b;  mem[a+6] = b;  mem[a+7] = b;
	    mem[a+8] = b;  mem[a+9] = b;  mem[a+10] = b; mem[a+11] = b;
	    mem[a+12] = b; mem[a+13] = b; mem[a+14] = b; mem[a+15] = b;
	    mem[a+16] = b; mem[a+17] = b; mem[a+18] = b; mem[a+19] = b;
	    mem[a+20] = b; mem[a+21] = b; mem[a+22] = b; mem[a+23] = b;
	    mem[a+24] = b; mem[a+25] = b; mem[a+26] = b; mem[a+27] = b;
	    mem[a+28] = b; mem[a+29] = b; mem[a+30] = b; mem[a+31] = b;
	    mem[a+32] = b; mem[a+33] = b; mem[a+34] = b; mem[a+35] = b;
	    mem[a+36] = b; mem[a+37] = b; mem[a+38] = b; mem[a+39] = b;
	    mem[a+40] = b; mem[a+41] = b; mem[a+42] = b; mem[a+43] = b;
	    mem[a+44] = b; mem[a+45] = b; mem[a+46] = b; mem[a+47] = b;
	    mem[a+48] = b; mem[a+49] = b; mem[a+50] = b; mem[a+51] = b;
	    mem[a+52] = b; mem[a+53] = b; mem[a+54] = b; mem[a+55] = b;
	    mem[a+56] = b; mem[a+57] = b; mem[a+58] = b; mem[a+59] = b;
	    mem[a+60] = b; mem[a+61] = b; mem[a+62] = b; mem[a+63] = b;
	}
    }

    gettimeofday(&time, NULL);
    finish  = time.tv_sec;
    ufinish = time.tv_usec;

    ret = (finish - start)*1000000 + (ufinish - ustart);

    free((UTL *) mem);

    return(ret);
}

UTL intrd(UTL blksize, UTL passnum) {
    UTL blk = (blksize << 10);
    UTL b = 0;
    UTL a, ret, start, ustart, finish, ufinish;
    volatile UTL *mem;
    struct timeval time;

    mem = (UTL *) malloc(blk);

    for(a = 0; a < blk/sizeof(UTL); a += 4) {
	mem[a] = b;
	mem[a+1] = b;
	mem[a+2] = b;
	mem[a+3] = b;
    }

    gettimeofday(&time, NULL);
    start  = time.tv_sec;
    ustart = time.tv_usec;

    while(passnum--) {
    	for(a = 0; a < blk/sizeof(UTL); a += 64) {
	    b = mem[a];    b = mem[a+1];  b = mem[a+2];  b = mem[a+3];
	    b = mem[a+4];  b = mem[a+5];  b = mem[a+6];  b = mem[a+7];
	    b = mem[a+8];  b = mem[a+9];  b = mem[a+10]; b = mem[a+11];
	    b = mem[a+12]; b = mem[a+13]; b = mem[a+14]; b = mem[a+15];
	    b = mem[a+16]; b = mem[a+17]; b = mem[a+18]; b = mem[a+19];
	    b = mem[a+20]; b = mem[a+21]; b = mem[a+22]; b = mem[a+23];
	    b = mem[a+24]; b = mem[a+25]; b = mem[a+26]; b = mem[a+27];
	    b = mem[a+28]; b = mem[a+29]; b = mem[a+30]; b = mem[a+31];
	    b = mem[a+32]; b = mem[a+33]; b = mem[a+34]; b = mem[a+35];
	    b = mem[a+36]; b = mem[a+37]; b = mem[a+38]; b = mem[a+39];
	    b = mem[a+40]; b = mem[a+41]; b = mem[a+42]; b = mem[a+43];
	    b = mem[a+44]; b = mem[a+45]; b = mem[a+46]; b = mem[a+47];
	    b = mem[a+48]; b = mem[a+49]; b = mem[a+50]; b = mem[a+51];
	    b = mem[a+52]; b = mem[a+53]; b = mem[a+54]; b = mem[a+55];
	    b = mem[a+56]; b = mem[a+57]; b = mem[a+58]; b = mem[a+59];
	    b = mem[a+60]; b = mem[a+61]; b = mem[a+62]; b = mem[a+63];
	}
    }

    gettimeofday(&time, NULL);
    finish  = time.tv_sec;
    ufinish = time.tv_usec;

    ret = (finish - start)*1000000 + (ufinish - ustart);

    free((UTL *) mem);

    return(ret);
}
