/*
**  RAMspeed/SMP, a cache & memory benchmarking tool
**
**  (for multiprocessor machines running UNIX-like operating systems)
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2003-05 Rhett M. Hollander <rhett@alasir.com>
**  Copyright (c) 2006-09 Paul V. Bolotoff <walter@alasir.com>
**
**  All rights reserved.
**
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include "defines.h"

extern UTL intwr(UTL blksize, UTL passnum);
extern UTL intrd(UTL blksize, UTL passnum);
extern UTL floatwr(UTL blksize, UTL passnum);
extern UTL floatrd(UTL blksize, UTL passnum);
extern UTL intcp(UTL maxblk, UTL passnum);
extern UTL intsc(UTL maxblk, UTL passnum);
extern UTL intad(UTL maxblk, UTL passnum);
extern UTL inttr(UTL maxblk, UTL passnum);
extern UTL floatcp(UTL maxblk, UTL passnum);
extern UTL floatsc(UTL maxblk, UTL passnum);
extern UTL floatad(UTL maxblk, UTL passnum);
extern UTL floattr(UTL maxblk, UTL passnum);

#if (I386_ASM) || (AMD64_ASM)

#if (I386_ASM)

#if (FreeBSD)
#include <fcntl.h>
#elif (NetBSD) || (OpenBSD)
#include <sys/types.h>
#include <machine/sysarch.h>
#elif (Linux)
#include <sys/io.h>
#endif

extern U32 cpuinfo_main(U32 mode);
extern U32 cpuinfo_scalar_ext(U32 mode);
extern U32 cpuinfo_vector_ext(U32 mode);
extern U32 cpuinfo_general_ext(U32 mode);
extern U32 cpuinfo_address_ext(U32 mode);
extern U32 cpuinfo_monitor_ext(U32 mode);
extern U32 cpuinfo_other_ext(U32 mode);
extern U32 cpuinfo_htt_check(U32 mode);

#endif

extern U32 mmxwr(U32 blksize, U32 passnum);
extern U32 mmxrd(U32 blksize, U32 passnum);
extern U32 mmxcp(U32 maxblk, U32 passnum);
extern U32 mmxsc(U32 maxblk, U32 passnum);
extern U32 mmxad(U32 maxblk, U32 passnum);
extern U32 mmxtr(U32 maxblk, U32 passnum);

extern U32 ssewr(U32 blksize, U32 passnum);
extern U32 sserd(U32 blksize, U32 passnum);
extern U32 ssecp(U32 maxblk, U32 passnum);
extern U32 ssesc(U32 maxblk, U32 passnum);
extern U32 ssead(U32 maxblk, U32 passnum);
extern U32 ssetr(U32 maxblk, U32 passnum);

extern U32 mmxwr_nt(U32 blksize, U32 passnum);
extern U32 mmxrd_nt(U32 blksize, U32 passnum);
extern U32 mmxcp_nt(U32 maxblk, U32 passnum);
extern U32 mmxsc_nt(U32 maxblk, U32 passnum);
extern U32 mmxad_nt(U32 maxblk, U32 passnum);
extern U32 mmxtr_nt(U32 maxblk, U32 passnum);

extern U32 ssewr_nt(U32 blksize, U32 passnum);
extern U32 sserd_nt(U32 blksize, U32 passnum);
extern U32 ssecp_nt(U32 maxblk, U32 passnum);
extern U32 ssesc_nt(U32 maxblk, U32 passnum);
extern U32 ssead_nt(U32 maxblk, U32 passnum);
extern U32 ssetr_nt(U32 maxblk, U32 passnum);

extern U32 mmxcp_nt_t0(U32 maxblk, U32 passnum);
extern U32 mmxsc_nt_t0(U32 maxblk, U32 passnum);
extern U32 mmxad_nt_t0(U32 maxblk, U32 passnum);
extern U32 mmxtr_nt_t0(U32 maxblk, U32 passnum);

extern U32 ssecp_nt_t0(U32 maxblk, U32 passnum);
extern U32 ssesc_nt_t0(U32 maxblk, U32 passnum);
extern U32 ssead_nt_t0(U32 maxblk, U32 passnum);
extern U32 ssetr_nt_t0(U32 maxblk, U32 passnum);

#endif

void help(void) {

    printf("\n%s\n%s\n%s\n%s\n%s\n",
      "USAGE: ramsmp -b ID [-g size] [-m size] [-l runs] [-p processes]",
      "-b  runs a specified benchmark (by an ID number):",
      "     1 -- INTmark [writing]          4 -- FLOATmark [writing]",
      "     2 -- INTmark [reading]          5 -- FLOATmark [reading]",
      "     3 -- INTmem                     6 -- FLOATmem");

#if (I386_ASM) || (AMD64_ASM)
    printf("%s\n%s\n%s\n%s\n%s\n%s\n",
      "     7 -- MMXmark [writing]         10 -- SSEmark [writing]",
      "     8 -- MMXmark [reading]         11 -- SSEmark [reading]",
      "     9 -- MMXmem                    12 -- SSEmem",
      "    13 -- MMXmark (nt) [writing]    16 -- SSEmark (nt) [writing]",
      "    14 -- MMXmark (nt) [reading]    17 -- SSEmark (nt) [reading]",
      "    15 -- MMXmem (nt)               18 -- SSEmem (nt)");
#endif

    printf("%s\n%s\n%s\n%s\n%s\n%s\n",
      "-g  specifies a # of Gbytes per pass (default is 8)",
      "-m  specifies a # of Mbytes per array (default is 32)",
      "-l  enables the BatchRun mode (for *mem benchmarks only),",
      "    and specifies a # of runs (suggested is 5)",
      "-p  specifies a # of processes to spawn (default is 2)",
      "-r  displays speeds in real megabytes per second (default: decimal)");

#if (I386_ASM) || (AMD64_ASM)
    printf("-t  changes software prefetch mode (see the manual for details)\n");
#endif

#if (I386_ASM)
    printf("-i  shows processor related information (CPUinfo) and exits\n\n");
#else
    printf("\n");
#endif

}

int main(int argc, char *argv[]) {
    UTL maxblk  = (MEMSIZE << 10);
    UTL passize = MEMPASS;
    U32 nproc   = PROCNUM;
    U32 fproc = 0, bid = 0, bnum = 1, myptr = 0, counter = 0;
    F64 cp = 0, ad = 0, sc = 0, tr = 0,
	cplr = 0, adlr = 0, sclr = 0, trlr = 0,
	mb = 1048576.0;
    S8  bch = 'B';
    UTL blksize, passnum, time;
    STL opt, temp;
    U32 bmark, cnt;
    S32 ch, shmid;
    F64 avgtime;
    UTL *shm;
    pid_t masterpid, mypid;
    key_t shmkey;
#if (I386_ASM)
    U32 cpuinfomode = 0, cpucaps = 0, sw_prf = 0;
    U32 mask, ret;
#elif (AMD64_ASM)
    U32 sw_prf = 0;
#endif

    printf("%s%s%s%s%s%s\n",
      "RAMspeed/SMP (", TARGET_OS, ") v", RVERSION,
      " by Rhett M. Hollander and Paul V. Bolotoff, 2002-", RYEAR);

#if (I386_ASM)
    while((ch = getopt(argc, argv, "b:g:m:l:p:t:ri")) != -1)
#elif (AMD64_ASM)
    while((ch = getopt(argc, argv, "b:g:m:l:p:t:r")) != -1)
#else
    while((ch = getopt(argc, argv, "b:g:m:l:p:r")) != -1)
#endif

      switch(ch) {

        case 'b':
	    opt = atol(optarg);
	    if(opt < 0) opt = 0;
	    bid = (U32)opt;
	    break;

	case 'g':
	    opt = atol(optarg);
	    temp = 1;
	    passize = 0;
	    for(cnt = 0; cnt < (sizeof(STL) << 3); cnt++) {
		if(opt == temp) passize = opt;
		temp = (temp << 1);
	    }
	    if(!passize) {
		printf("\nERROR: invalid pass size\n");
		return(1);
	    }
	    break;

	case 'm':
	    opt = (atol(optarg) << 10);
	    temp = 1;
	    maxblk = 0;
	    for(cnt = 0; cnt < (sizeof(STL) << 3); cnt++) {
		if(opt == temp) maxblk = opt;
		temp = (temp << 1);
	    }
	    if(!maxblk) {
		printf("\nERROR: invalid array size\n");
		return(1);
	    }
	    break;

	case 'l':
	    opt = atol(optarg);
	    if(opt < 1) opt = 1;
	    bnum = (U32)opt;
	    break;

	case 'p':
	    opt = atol(optarg);
	    temp = 1;
	    nproc = 0;
	    for(cnt = 0; cnt < 8; cnt++) {
		if(opt == temp) nproc = opt;
		temp = (temp << 1);
	    }
	    if(!nproc) {
		printf("\nERROR: cannot spawn %li processes\n", opt);
		return(1);
	    }
	    break;

	case 'r':
	    mb = 1000000.0;
	    bch = 'b';
	    break;

#if (I386_ASM) || (AMD64_ASM)
	case 't':
	    opt = atol(optarg);
	    if((opt < 0) || (opt > 2)) {
		printf("\nERROR: invalid software prefetch mode\n");
		return(1);
	    }
	    sw_prf = (U32)opt;
	    break;
#endif

#if (I386_ASM)
	case 'i':
	    cpuinfomode = 1;
	    break;
#endif

	default:
	    help();
	    return(1);

    }

#if (I386_ASM)
    if(cpuinfomode) {

    printf("\n");

/* the following OS dependent calls will fail without super-user's privileges */

#if (FreeBSD)    
    ret = open("/dev/io", O_RDWR);
    if(ret > 0) {
    	/* in verbose privileged mode */
    	mask = cpuinfo_main(3);
	close(ret);
    } else {
	/* in verbose regular mode */
    	mask = cpuinfo_main(1);
    }
#elif (NetBSD) || (OpenBSD)
    ret = i386_iopl(3);
    if(ret == 0) mask = cpuinfo_main(3);
    else mask = cpuinfo_main(1);
#elif (Linux)
    ret = iopl(3);
    if (ret == 0) mask = cpuinfo_main(3);
    else mask = cpuinfo_main(1);
#else
    /* ret is here just to shut up the compiler */
    ret = mask = cpuinfo_main(1);
#endif

    /* processor extensions detectable through CPUID */
    if(mask & 0x20000000) {
	cpuinfo_scalar_ext(1);
	cpuinfo_vector_ext(1);
	cpuinfo_general_ext(1);
	cpuinfo_address_ext(1);
	cpuinfo_monitor_ext(1);
	cpuinfo_other_ext(1);
    }

    /* check for Hyper-Threading (Intel Pentium 4 processors) */
    if((mask & 0x000F000F) == 0x000000F1) cpuinfo_htt_check(1);

    /* check fo Hyper-Threading (Intel Core processors [0x61xx]) */
    if((mask & 0x000FF00F) == 0x00061001) cpuinfo_htt_check(1);

    return(0);

    } else {

    /* in silent regular mode */
    ret = mask = cpuinfo_main(0);

    if(mask & 0x20000000) cpucaps = cpuinfo_vector_ext(0);

    }

#endif

    /* display the built-in help and exit if no benchmark ID is specified */
    if(!bid) {
	help();
	return(1);
    }

    /* in fact, per pass values are only true for *mark benchmarks;
     * when it comes to *mem ones, cp & sc use 2 times more, ad & tr -- 3 */
    printf("\n%luGb per pass mode, %u processes\n\n", passize, nproc);

    passnum = (passize << 20)/maxblk;

    /* initialise the future master process and a segment of shared memory */
    shmkey = masterpid = getpid();
    shmid = shmget(shmkey, (sizeof(STL) << 11), IPC_CREAT | 0666);
    shm = (UTL *) shmat(shmid, 0, 0);
    for(cnt = 0; cnt < 2048; cnt++) shm[cnt] = 0;
    shmdt(shm);

    /* spawn the processes */
    switch(nproc) {
	case(1):   fproc = 0; break;
	case(2):   fproc = 1; break;
	case(4):   fproc = 2; break;
	case(8):   fproc = 3; break;
	case(16):  fproc = 4; break;
	case(32):  fproc = 5; break;
	case(64):  fproc = 6; break;
	case(128): fproc = 7; break;
	case(256): fproc = 8; break;
    }
    for(cnt = 0; cnt < fproc; cnt++) fork();

    /* every process initialises itself and attaches the SHM segment to its
     * virtual memory space */
    mypid = getpid();
    shmid = shmget(shmkey, (sizeof(STL) << 11), 0666);
    shm = (UTL *) shmat(shmid, 0, 0);

    /* now every process except the master stores its PID in the SHM, and in
     * fact obtains a local number used to identify the process further */
    if(mypid != masterpid) {
	for(cnt = 1; cnt < nproc; cnt++) {
	    if(shm[cnt] == 0) {
		shm[cnt] = mypid;
		myptr = cnt;
		break;
	    }
	}
    }

    if(mypid == masterpid) {
	/* the master knows how many clones should be hanging in memory, so it
         * waits until they initialise themselves and report */
        counter = 0;
	while(counter != (nproc - 1)) {
	    counter = 0;
	    for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
	    if(counter != (nproc - 1)) usleep(100);
	}
	/* all the clones are ready, so now the time has come to fight for
	 * gigabytes, make a start by clearing their flags */
	for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
    } else {
	/* every clone is obligated to set a flag indicating readiness to ride */
        shm[myptr+256] = 1;
	/* wait for a permission to ride */
	while(shm[myptr+256]) usleep(100);
    }

    /* as you may have realised already, the SHM segment consists of 2048 entries
     * each 32-bit or 64-bit depending upon a CPU architecture; the first 256
     * entries are reserved to hold PIDs, the next 256 -- "process ready" flags,
     * and all the rest -- time deltas used to calculate the averages */

    switch(bid) {

	case(1):
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = intwr(blksize, passnum);
		if(mypid == masterpid) {
		    /* the master waits for reports */
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    /* sets own time elapsed */
		    shm[512] = time;
		    /* collects information from the clones and calculates the
		     * average time spent */
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    /* the master only may print the result */
		    printf("INTEGER & WRITING  %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    /* clears the flags of the clones, thus releasing them */
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    /* every clone sets own time elapsed */
		    shm[myptr+512] = time;
		    /* reports to the master */
		    shm[myptr+256] = 1;
		    /* waits for a new ride */
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(2):
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = intrd(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("INTEGER & READING  %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(3):
	    if(mypid == masterpid) {
		if(bnum > 1) printf("%u-benchmark INTmem BatchRun mode\n\n", bnum);
	    }
	    for(bmark = 0; bmark < bnum; bmark++) {
		if(mypid == masterpid) {
		    if(bnum > 1) printf("Benchmark #%u:\n", bmark+1);
		}

		time = intcp(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    cp = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("INTEGER   Copy:      %.2f M%c/s\n", cp, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = intsc(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[768] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+768];
		    avgtime = avgtime/(F64)nproc;
		    sc = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("INTEGER   Scale:     %.2f M%c/s\n", sc, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+768] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = intad(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1024] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1024];
		    avgtime = avgtime/(F64)nproc;
		    ad = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("INTEGER   Add:       %.2f M%c/s\n", ad, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1024] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = inttr(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1280] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1280];
		    avgtime = avgtime/(F64)nproc;
		    tr = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("INTEGER   Triad:     %.2f M%c/s\n", tr, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1280] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(mypid == masterpid) {
		    printf("---\nINTEGER   AVERAGE:   %.2f M%c/s\n\n",
		      (cp + sc + ad + tr)/4.0, bch);
		    if(bnum > 1) {
			cplr += cp; sclr += sc; adlr += ad; trlr += tr;
		    }
		}

	    }

	    if(mypid == masterpid) {
		if(bnum > 1) {
		    printf("INTEGER BatchRun   Copy:      %.2f M%c/s\n",
		      cplr/(F64)bnum, bch);
		    printf("INTEGER BatchRun   Scale:     %.2f M%c/s\n",
		      sclr/(F64)bnum, bch);
		    printf("INTEGER BatchRun   Add:       %.2f M%c/s\n",
		      adlr/(F64)bnum, bch);
		    printf("INTEGER BatchRun   Triad:     %.2f M%c/s\n",
		      trlr/(F64)bnum, bch);
		    printf("---\nINTEGER BatchRun   AVERAGE:   %.2f M%c/s\n",
		      (cplr + sclr + adlr + trlr)/(F64)(bnum << 2), bch);
		}
	    }
	    break;

	case(4):
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = floatwr(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("FL-POINT & WRITING %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(5):
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = floatrd(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("FL-POINT & READING %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(6):
	    if(mypid == masterpid) {
		if(bnum > 1) printf("%u-benchmark FLOATmem BatchRun mode\n\n", bnum);
	    }
	    for(bmark = 0; bmark < bnum; bmark++) {
		if(mypid == masterpid) {
		    if(bnum > 1) printf("Benchmark #%u:\n", bmark+1);
		}

		time = floatcp(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    cp = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("FL-POINT  Copy:      %.2f M%c/s\n", cp, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = floatsc(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[768] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+768];
		    avgtime = avgtime/(F64)nproc;
		    sc = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("FL-POINT  Scale:     %.2f M%c/s\n", sc, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+768] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = floatad(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1024] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1024];
		    avgtime = avgtime/(F64)nproc;
		    ad = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("FL-POINT  Add:       %.2f M%c/s\n", ad, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1024] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = floattr(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1280] = time;
		    avgtime = 0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1280];
		    avgtime = avgtime/(F64)nproc;
		    tr = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("FL-POINT  Triad:     %.2f M%c/s\n", tr, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1280] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(mypid == masterpid) {
		    printf("---\nFL-POINT  AVERAGE:   %.2f M%c/s\n\n",
		      (F64)(cp + sc + ad + tr)/4.0, bch);
		    if(bnum > 1) {
			cplr += cp; sclr += sc; adlr += ad; trlr += tr;
		    }
		}

	    }

	    if(mypid == masterpid) {
		if(bnum > 1) {
		    printf("FL-POINT BatchRun  Copy:      %.2f M%c/s\n",
		      cplr/(F64)bnum, bch);
		    printf("FL-POINT BatchRun  Scale:     %.2f M%c/s\n",
		      sclr/(F64)bnum, bch);
		    printf("FL-POINT BatchRun  Add:       %.2f M%c/s\n",
		      adlr/(F64)bnum, bch);
		    printf("FL-POINT BatchRun  Triad:     %.2f M%c/s\n",
		      trlr/(F64)bnum, bch);
		    printf("---\nFL-POINT BatchRun  AVERAGE:   %.2f M%c/s\n",
		      (cplr + sclr + adlr + trlr)/(F64)(bnum << 2), bch);
		}
	    }
	    break;

#if (I386_ASM) || (AMD64_ASM)
	case(7):
#if (I386_ASM)
	    if(!(cpucaps & 0x1)) {
		if(mypid == masterpid) printf("ERROR: no MMX support available\n");
		return(1);
	    }
#endif
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = mmxwr(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("MMX & WRITING      %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(8):
#if (I386_ASM)
	    if(!(cpucaps & 0x1)) {
		if(mypid == masterpid) printf("ERROR: no MMX support available\n");
		return(1);
	    }
#endif
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = mmxrd(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("MMX & READING      %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(9):
#if (I386_ASM)
	    if(!(cpucaps & 0x1)) {
		if(mypid == masterpid) printf("ERROR: no MMX support available\n");
		return(1);
	    }
#endif
	    if(mypid == masterpid) {
		if(bnum > 1) printf("%u-benchmark MMXmem BatchRun mode\n\n", bnum);
	    }
	    for(bmark = 0; bmark < bnum; bmark++) {
		if(mypid == masterpid) {
		    if(bnum > 1) printf("Benchmark #%u:\n", bmark+1);
		}

		time = mmxcp(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    cp = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("MMX       Copy:      %.2f M%c/s\n", cp, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = mmxsc(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[768] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+768];
		    avgtime = avgtime/(F64)nproc;
		    sc = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("MMX       Scale:     %.2f M%c/s\n", sc, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+768] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = mmxad(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1024] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1024];
		    avgtime = avgtime/(F64)nproc;
		    ad = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("MMX       Add:       %.2f M%c/s\n", ad, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1024] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = mmxtr(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1280] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1280];
		    avgtime = avgtime/(F64)nproc;
		    tr = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("MMX       Triad:     %.2f M%c/s\n", tr, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1280] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(mypid == masterpid) {
		    printf("---\nMMX       AVERAGE:   %.2f M%c/s\n\n",
		      (F64)(cp + sc + ad + tr)/4.0, bch);
		    if(bnum > 1) {
			cplr += cp; sclr += sc; adlr += ad; trlr += tr;
		    }
		}

	    }

	    if(mypid == masterpid) {
		if(bnum > 1) {
		    printf("MMX BatchRun       Copy:      %.2f M%c/s\n",
		      cplr/(F64)bnum, bch);
		    printf("MMX BatchRun       Scale:     %.2f M%c/s\n",
		      sclr/(F64)bnum, bch);
		    printf("MMX BatchRun       Add:       %.2f M%c/s\n",
		      adlr/(F64)bnum, bch);
		    printf("MMX BatchRun       Triad:     %.2f M%c/s\n",
		      trlr/(F64)bnum, bch);
		    printf("---\nMMX BatchRun       AVERAGE:   %.2f M%c/s\n",
		      (cplr + sclr + adlr + trlr)/(F64)(bnum << 2), bch);
		}
	    }
	    break;

	case(10):
#if (I386_ASM)
	    if(!(cpucaps & 0x10)) {
		if(mypid == masterpid) printf("ERROR: no SSE support available\n");
		return(1);
	    }
#endif
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = ssewr(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("SSE & WRITING      %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(11):
#if (I386_ASM)
	    if(!(cpucaps & 0x10)) {
		if(mypid == masterpid) printf("ERROR: no SSE support available\n");
		return(1);
	    }
#endif
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = sserd(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("SSE & READING      %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(12):
#if (I386_ASM)
	    if(!(cpucaps & 0x10)) {
		if(mypid == masterpid) printf("ERROR: no SSE support available\n");
		return(1);
	    }
#endif
	    if(mypid == masterpid) {
		if(bnum > 1) printf("%u-benchmark SSEmem BatchRun mode\n\n", bnum);
	    }
	    for(bmark = 0; bmark < bnum; bmark++) {
		if(mypid == masterpid) {
		    if(bnum > 1) printf("Benchmark #%u:\n", bmark+1);
		}

		time = ssecp(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    cp = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("SSE       Copy:      %.2f M%c/s\n", cp, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = ssesc(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[768] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+768];
		    avgtime = avgtime/(F64)nproc;
		    sc = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("SSE       Scale:     %.2f M%c/s\n", sc, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+768] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = ssead(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1024] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1024];
		    avgtime = avgtime/(F64)nproc;
		    ad = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("SSE       Add:       %.2f M%c/s\n", ad, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1024] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		time = ssetr(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1280] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1280];
		    avgtime = avgtime/(F64)nproc;
		    tr = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("SSE       Triad:     %.2f M%c/s\n", tr, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1280] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(mypid == masterpid) {
		    printf("---\nSSE       AVERAGE:   %.2f M%c/s\n\n",
		      (F64)(cp + sc + ad + tr)/4.0, bch);
		    if(bnum > 1) {
			cplr += cp; sclr += sc; adlr += ad; trlr += tr;
		    }
		}

	    }

	    if(mypid == masterpid) {
		if(bnum > 1) {
		    printf("SSE BatchRun       Copy:      %.2f M%c/s\n",
		      cplr/(F64)bnum, bch);
		    printf("SSE BatchRun       Scale:     %.2f M%c/s\n",
		      sclr/(F64)bnum, bch);
		    printf("SSE BatchRun       Add:       %.2f M%c/s\n",
		      adlr/(F64)bnum, bch);
		    printf("SSE BatchRun       Triad:     %.2f M%c/s\n",
		      trlr/(F64)bnum, bch);
		    printf("---\nSSE BatchRun       AVERAGE:   %.2f M%c/s\n\n",
		      (cplr + sclr + adlr + trlr)/(F64)(bnum << 2), bch);
		}
	    }
	    break;

	case(13):
#if (I386_ASM)
	    if(!(cpucaps & 0x2)) {
		if(mypid == masterpid) printf("ERROR: no MMX+ support available\n");
		return(1);
	    }
#endif
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = mmxwr_nt(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("MMX (nt) & WRITING %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(14):
#if (I386_ASM)
	    if(!(cpucaps & 0x2)) {
		if(mypid == masterpid) printf("ERROR: no MMX+ support available\n");
		return(1);
	    }
#endif
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = mmxrd_nt(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("MMX (nt) & READING %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(15):
#if (I386_ASM)
	    if(!(cpucaps & 0x2)) {
		if(mypid == masterpid) printf("ERROR: no MMX+ support available\n");
		return(1);
	    }
#endif
	    if(mypid == masterpid) {
		if(bnum > 1) printf("%u-benchmark MMXmem (non-temporal) BatchRun mode\n\n", bnum);
	    }
	    for(bmark = 0; bmark < bnum; bmark++) {
		if(mypid == masterpid) {
		    if(bnum > 1) printf("Benchmark #%u:\n", bmark+1);
		}

		if(sw_prf == 2) time = mmxcp_nt_t0(maxblk, passnum);
		else time = mmxcp_nt(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    cp = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("MMX (nt)  Copy:      %.2f M%c/s  ", cp, bch);
		    if(sw_prf == 2) printf("[T0 prefetch]\n");
		    else printf("[NTA prefetch]\n");
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(sw_prf == 2) time = mmxsc_nt_t0(maxblk, passnum);
		else time = mmxsc_nt(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[768] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+768];
		    avgtime = avgtime/(F64)nproc;
		    sc = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("MMX (nt)  Scale:     %.2f M%c/s  ", sc, bch);
		    if(sw_prf == 2) printf("[T0 prefetch]\n");
		    else printf("[NTA prefetch]\n");
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+768] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(sw_prf == 1) time = mmxad_nt(maxblk, passnum);
		else time = mmxad_nt_t0(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1024] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1024];
		    avgtime = avgtime/(F64)nproc;
		    ad = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("MMX (nt)  Add:       %.2f M%c/s  ", ad, bch);
		    if(sw_prf == 1) printf("[NTA prefetch]\n");
		    else printf("[T0 prefetch]\n");
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1024] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(sw_prf == 1) time = mmxtr_nt(maxblk, passnum);
		else time = mmxtr_nt_t0(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1280] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1280];
		    avgtime = avgtime/(F64)nproc;
		    tr = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("MMX (nt)  Triad:     %.2f M%c/s  ", tr, bch);
		    if(sw_prf == 1) printf("[NTA prefetch]\n");
		    else printf("[T0 prefetch]\n");
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1280] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(mypid == masterpid) {
		    printf("---\nMMX (nt)  AVERAGE:   %.2f M%c/s\n\n",
		      (F64)(cp + sc + ad + tr)/4.0, bch);
		    if(bnum > 1) {
			cplr += cp; sclr += sc; adlr += ad; trlr += tr;
		    }
		}

	    }

	    if(mypid == masterpid) {
		if(bnum > 1) {
		    printf("MMX (nt) BatchRun  Copy:      %.2f M%c/s  ",
		      cplr/(F64)bnum, bch);
		    if(sw_prf == 2) printf("[T0 prefetch]\n");
		    else printf("[NTA prefetch]\n");
		    printf("MMX (nt) BatchRun  Scale:     %.2f M%c/s  ",
		      sclr/(F64)bnum, bch);
		    if(sw_prf == 2) printf("[T0 prefetch]\n");
		    else printf("[NTA prefetch]\n");
		    printf("MMX (nt) BatchRun  Add:       %.2f M%c/s  ",
		      adlr/(F64)bnum, bch);
		    if(sw_prf == 1) printf("[NTA prefetch]\n");
		    else printf("[T0 prefetch]\n");
		    printf("MMX (nt) BatchRun  Triad:     %.2f M%c/s  ",
		      trlr/(F64)bnum, bch);
		    if(sw_prf == 1) printf("[NTA prefetch]\n");
		    else printf("[T0 prefetch]\n");
		    printf("---\nMMX (nt) BatchRun  AVERAGE:   %.2f M%c/s\n\n",
		      (cplr + sclr + adlr + trlr)/(F64)(bnum << 2), bch);
		}
	    }
	    break;

	case(16):
#if (I386_ASM)
	    if(!(cpucaps & 0x10)) {
		if(mypid == masterpid) printf("ERROR: no SSE support available\n");
		return(1);
	    }
#endif
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = ssewr_nt(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("SSE & WRITING (nt) %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(17):
#if (I386_ASM)
	    if(!(cpucaps & 0x10)) {
		if(mypid == masterpid) printf("ERROR: no SSE support available\n");
		return(1);
	    }
#endif
	    for(blksize = STARTBLK; blksize <= maxblk; blksize = (blksize << 1)) {
		passnum = (passize << 20)/blksize;
		time = sserd_nt(blksize, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    printf("SSE & READING (nt) %8lu Kb block: %.2f M%c/s\n",
		      blksize, (F64)((passize << 10)*nproc)*mb/avgtime, bch);
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}
    	    }
	    break;

	case(18):
#if (I386_ASM)
	    if(!(cpucaps & 0x10)) {
		if(mypid == masterpid) printf("ERROR: no SSE support available\n");
		return(1);
	    }
#endif
	    if(mypid == masterpid) {
		if(bnum > 1) printf("%u-benchmark SSEmem (non-temporal) BatchRun mode\n\n", bnum);
	    }
	    for(bmark = 0; bmark < bnum; bmark++) {
		if(mypid == masterpid) {
		    if(bnum > 1) printf("Benchmark #%u:\n", bmark+1);
		}

		if(sw_prf == 2) time = ssecp_nt_t0(maxblk, passnum);
		else time = ssecp_nt(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[512] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+512];
		    avgtime = avgtime/(F64)nproc;
		    cp = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("SSE (nt)  Copy:      %.2f M%c/s  ", cp, bch);
		    if(sw_prf == 2) printf("[T0 prefetch]\n");
		    else printf("[NTA prefetch]\n");
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+512] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(sw_prf == 2) time = ssesc_nt_t0(maxblk, passnum);
		else time = ssesc_nt(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[768] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+768];
		    avgtime = avgtime/(F64)nproc;
		    sc = (F64)((passize << 11)*nproc)*mb/avgtime;
		    printf("SSE (nt)  Scale:     %.2f M%c/s  ", sc, bch);
		    if(sw_prf == 2) printf("[T0 prefetch]\n");
		    else printf("[NTA prefetch]\n");
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+768] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(sw_prf == 1) time = ssead_nt(maxblk, passnum);
		else time = ssead_nt_t0(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1024] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1024];
		    avgtime = avgtime/(F64)nproc;
		    ad = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("SSE (nt)  Add:       %.2f M%c/s  ", ad, bch);
		    if(sw_prf == 1) printf("[NTA prefetch]\n");
		    else printf("[T0 prefetch]\n");
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1024] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(sw_prf == 1) time = ssetr_nt(maxblk, passnum);
		else time = ssetr_nt_t0(maxblk, passnum);
		if(mypid == masterpid) {
		    counter = 0;
		    while(counter != (nproc-1)) {
			counter = 0;
			for(cnt = 1; cnt < nproc; cnt++) counter += shm[cnt+256];
			if(counter != (nproc-1)) usleep(100);
		    }
		    shm[1280] = time;
		    avgtime = 0.0;
		    for(cnt = 0; cnt < nproc; cnt++) avgtime += (F64)shm[cnt+1280];
		    avgtime = avgtime/(F64)nproc;
		    tr = (F64)(passize*3072*nproc)*mb/avgtime;
		    printf("SSE (nt)  Triad:     %.2f M%c/s  ", tr, bch);
		    if(sw_prf == 1) printf("[NTA prefetch]\n");
		    else printf("[T0 prefetch]\n");
		    for(cnt = 1; cnt < nproc; cnt++) shm[cnt+256] = 0;
		} else {
		    shm[myptr+1280] = time;
		    shm[myptr+256] = 1;
		    while(shm[myptr+256]) usleep(100);
		}

		if(mypid == masterpid) {
		    printf("---\nSSE (nt)  AVERAGE:   %.2f M%c/s\n\n",
		      (F64)(cp + sc + ad + tr)/4.0, bch);
		    if(bnum > 1) {
			cplr += cp; sclr += sc; adlr += ad; trlr += tr;
		    }
		}

	    }

	    if(mypid == masterpid) {
		if(bnum > 1) {
		    printf("SSE (nt) BatchRun  Copy:      %.2f M%c/s  ",
		      cplr/(F64)bnum, bch);
		    if(sw_prf == 2) printf("[T0 prefetch]\n");
		    else printf("[NTA prefetch]\n");
		    printf("SSE (nt) BatchRun  Scale:     %.2f M%c/s  ",
		      sclr/(F64)bnum, bch);
		    if(sw_prf == 2) printf("[T0 prefetch]\n");
		    else printf("[NTA prefetch]\n");
		    printf("SSE (nt) BatchRun  Add:       %.2f M%c/s  ",
		      adlr/(F64)bnum, bch);
		    if(sw_prf == 1) printf("[NTA prefetch]\n");
		    else printf("[T0 prefetch]\n");
		    printf("SSE (nt) BatchRun  Triad:     %.2f M%c/s  ",
		      trlr/(F64)bnum, bch);
		    if(sw_prf == 1) printf("[NTA prefetch]\n");
		    else printf("[T0 prefetch]\n");
		    printf("---\nSSE (nt) BatchRun  AVERAGE:   %.2f M%c/s\n\n",
		      (cplr + sclr + adlr + trlr)/(F64)(bnum << 2), bch);
		}
	    }
	    break;
#endif

	default:
	    if(mypid == masterpid) {
		help();
		printf("\nERROR: unknown benchmark ID\n");
	    }
	    return(1);
    }

    return(0);
}
