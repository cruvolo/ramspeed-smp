/*
**  miscellaneous definitions related to RAMspeed/SMP
**
**  (UNIX release)
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2003-06 Rhett M. Hollander <rhett@alasir.com>
**  Copyright (c) 2006-09 Paul V. Bolotoff <walter@alasir.com>
**
**  All rights reserved.
**
*/


typedef	signed char         S8;
typedef signed short	    S16;
typedef signed int	    S32;
typedef signed long	    STL;

typedef unsigned char       U8;
typedef unsigned short	    U16;
typedef unsigned int	    U32;
typedef unsigned long	    UTL;

typedef float		    F32;
typedef double		    F64;

#define STARTBLK	(1)     /* in Kbytes */
#define MEMSIZE		(32)    /* in Mbytes */
#define MEMPASS		(8)     /* in Gbytes */
#define PROCNUM		(2)	/* processes to spawn */

#if (FreeBSD)
#define TARGET_OS	"FreeBSD"
#elif (NetBSD)
#define TARGET_OS	"NetBSD"
#elif (OpenBSD)
#define TARGET_OS	"OpenBSD"
#elif (Linux)
#define TARGET_OS	"Linux"
#elif (OSF1)
#define TARGET_OS	"Digital UNIX"
#else
#define TARGET_OS	"GENERIC"
#endif

#define RVERSION	"3.5.0"
#define RYEAR		"09"

#define PI              (3.1415926535897932)
#define LN2             (0.6931471805599453)
