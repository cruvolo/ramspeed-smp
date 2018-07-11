#!/bin/sh
# this script builds RAMspeed/SMP for a particular environment detected;
# all fixes and additions should be emailed to walter@alasir.com

OS=`uname -s`
RELEASE=`uname -r`
ARCH=`uname -p`

if [ "$1" = "clean" ]; then
    echo "rm -f ramsmp temp/*.o"
    `rm -f ramsmp temp/*.o`
    exit
fi

if [ "$1" ]; then OS=$1; fi
if [ "$2" ]; then ARCH=$2; fi

case $OS in

    FreeBSD)
	CC="gcc"
	LD="gcc"
	AS="as"
	if [ $ARCH = "alpha" ]
	then GCCVER=`gcc --version | head -c 1`
	    if [ $GCCVER = "2" ]
	    then CFLAGS="-Wall -O"
		 LFLAGS="-Wl,-O -Wl,-s"
		 TARGET="ALPHA_GNU_ASM"
	    else CFLAGS="-Wall -O2"
		 LFLAGS="-Wl,-O2 -Wl,-s"
		 TARGET="ALPHA_GNU_ASM"
	    fi
	elif [ $ARCH = "i386" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="I386_ASM"
	elif [ $ARCH = "amd64" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="AMD64_ASM"
	elif [ $ARCH = "x86_64" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="AMD64_ASM"
	else CFLAGS="-Wall -O"
	     LFLAGS="-Wl,-O -Wl,-s"
	     TARGET="GENERIC"
	fi
	;;

    NetBSD)
	CC="gcc"
	LD="gcc"
	AS="as"
	if [ $ARCH = "alpha" ]
	then GCCVER=`gcc --version | head -c 1`
	    if [ $GCCVER = "2" ]
	    then CFLAGS="-Wall -O"
		 LFLAGS="-Wl,-O -Wl,-s"
		 TARGET="ALPHA_GNU_ASM"
	    else CFLAGS="-Wall -O2"
		 LFLAGS="-Wl,-O2 -Wl,-s"
		 TARGET="ALPHA_GNU_ASM"
	    fi
	elif [ $ARCH = "i386" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s -li386"
	     TARGET="I386_ASM"
	elif [ $ARCH = "amd64" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="AMD64_ASM"
	elif [ $ARCH = "x86_64" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="AMD64_ASM"
	else CFLAGS="-Wall -O"
	     LFLAGS="-Wl,-O -Wl,-s"
	     TARGET="GENERIC"
	fi
	;;

    Linux)
	CC="gcc"
	LD="gcc"
	AS="as"
	if [ $ARCH = "alpha" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="ALPHA_GNU_ASM"
	elif [ $ARCH = "i386" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="I386_ASM"
	elif [ $ARCH = "amd64" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="AMD64_ASM"
	elif [ $ARCH = "x86_64" ]
	then CFLAGS="-Wall -O2"
	     LFLAGS="-Wl,-O2 -Wl,-s"
	     TARGET="AMD64_ASM"
	else CFLAGS="-Wall -O"
	     LFLAGS="-Wl,-O -Wl,-s"
	     TARGET="GENERIC"
	fi
	;;

    OSF1)
	CC="cc"
	LD="cc"
	AS="as"
	CFLAGS="-O3"
	LFLAGS=
	TARGET="ALPHA_DEC_ASM"
	;;

    *)
	CC="cc"
	LD="cc"
	AS="as"
	CFLAGS="-O"
	TARGET="GENERIC"
	;;

esac

echo "building for $OS $RELEASE $ARCH"
echo "compiler is $CC, linker is $LD, assembler is $AS"
echo "compiler's flags are $CFLAGS"
echo "linker's flags are $LFLAGS"
echo " "

if [ $TARGET = "GENERIC" ]
then echo "WARNING! BUILDING FOR AN UNSUPPORTED OPERATING SYSTEM AND\OR ARCHITECTURE!"
     echo "Please don't be shy to tell us some information about your CPU architecture,"
     echo "OS version, compiler, linker, assembler and their optimisation flags."
     echo " "
fi

echo "press Enter to continue or Control-C to abort"
read ANS

case $TARGET in

    GENERIC)
	if [ ! -f temp/ramsmp.o ]; then
	echo "$CC $CFLAGS -c -o temp/ramsmp.o ramsmp.c"
	`$CC $CFLAGS -c -o temp/ramsmp.o ramsmp.c`; fi
	if [ ! -f temp/intmark.o ]; then
	echo "$CC $CFLAGS -c -o temp/intmark.o intmark.c"
	`$CC $CFLAGS -c -o temp/intmark.o intmark.c`; fi	
	if [ ! -f temp/intmem.o ]; then
	echo "$CC $CFLAGS -c -o temp/intmem.o intmem.c"
	`$CC $CFLAGS -c -o temp/intmem.o intmem.c`; fi
	if [ ! -f temp/fltmark.o ]; then
	echo "$CC $CFLAGS -c -o temp/fltmark.o fltmark.c"
	`$CC $CFLAGS -c -o temp/fltmark.o fltmark.c`; fi
	if [ ! -f temp/fltmem.o ]; then
	echo "$CC $CFLAGS -c -o temp/fltmem.o fltmem.c"
	`$CC $CFLAGS -c -o temp/fltmem.o fltmem.c`; fi	
	echo "$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o"
	`$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o`
	;;

    I386_ASM)
	if [ ! -f temp/ramsmp.o ]; then
	echo "$CC $CFLAGS -D$OS -D$TARGET -c -o temp/ramsmp.o ramsmp.c"
	`$CC $CFLAGS -D$OS -D$TARGET -c -o temp/ramsmp.o ramsmp.c`; fi
	if [ ! -f temp/intmark.o ]; then
	echo "$AS -o temp/intmark.o i386/intmark.s"
	`$AS -o temp/intmark.o i386/intmark.s`; fi
	if [ ! -f temp/intmem.o ]; then
	echo "$AS -o temp/intmem.o i386/intmem.s"
	`$AS -o temp/intmem.o i386/intmem.s`; fi
	if [ ! -f temp/fltmark.o ]; then
	echo "$AS -o temp/fltmark.o i386/fltmark.s"
	`$AS -o temp/fltmark.o i386/fltmark.s`; fi
	if [ ! -f temp/fltmem.o ]; then
	echo "$AS -o temp/fltmem.o i386/fltmem.s"
	`$AS -o temp/fltmem.o i386/fltmem.s`; fi
	if [ ! -f temp/mmxmark.o ]; then
	echo "$AS -o temp/mmxmark.o i386/mmxmark.s"
	`$AS -o temp/mmxmark.o i386/mmxmark.s`; fi
	if [ ! -f temp/mmxmem.o ]; then
	echo "$AS -o temp/mmxmem.o i386/mmxmem.s"
	`$AS -o temp/mmxmem.o i386/mmxmem.s`; fi
	if [ ! -f temp/ssemark.o ]; then
	echo "$AS -o temp/ssemark.o i386/ssemark.s"
	`$AS -o temp/ssemark.o i386/ssemark.s`; fi
	if [ ! -f temp/ssemem.o ]; then
	echo "$AS -o temp/ssemem.o i386/ssemem.s"
	`$AS -o temp/ssemem.o i386/ssemem.s`; fi
	if [ ! -f temp/cpuinfo_main.o ]; then
	echo "$AS -o temp/cpuinfo_main.o i386/cpuinfo/cpuinfo_main.s"
	`$AS -o temp/cpuinfo_main.o i386/cpuinfo/cpuinfo_main.s`; fi
	if [ ! -f temp/cpuinfo_ext.o ]; then
	echo "$AS -o temp/cpuinfo_ext.o i386/cpuinfo/cpuinfo_ext.s"
	`$AS -o temp/cpuinfo_ext.o i386/cpuinfo/cpuinfo_ext.s`; fi
	echo "$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o temp/mmxmark.o temp/mmxmem.o temp/ssemark.o temp/ssemem.o temp/cpuinfo_main.o temp/cpuinfo_ext.o"
	`$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o temp/mmxmark.o temp/mmxmem.o temp/ssemark.o temp/ssemem.o temp/cpuinfo_main.o temp/cpuinfo_ext.o`
	;;

    AMD64_ASM)
	if [ ! -f temp/ramsmp.o ]; then
	echo "$CC $CFLAGS -D$OS -D$TARGET -c -o temp/ramsmp.o ramsmp.c"
	`$CC $CFLAGS -D$OS -D$TARGET -c -o temp/ramsmp.o ramsmp.c`; fi
	if [ ! -f temp/intmark.o ]; then
	echo "$AS -o temp/intmark.o amd64/intmark.s"
	`$AS -o temp/intmark.o amd64/intmark.s`; fi
	if [ ! -f temp/intmem.o ]; then
	echo "$AS -o temp/intmem.o amd64/intmem.s"
	`$AS -o temp/intmem.o amd64/intmem.s`; fi
	if [ ! -f temp/fltmark.o ]; then
	echo "$AS -o temp/fltmark.o amd64/fltmark.s"
	`$AS -o temp/fltmark.o amd64/fltmark.s`; fi
	if [ ! -f temp/fltmem.o ]; then
	echo "$AS -o temp/fltmem.o amd64/fltmem.s"
	`$AS -o temp/fltmem.o amd64/fltmem.s`; fi
	if [ ! -f temp/mmxmark.o ]; then
	echo "$AS -o temp/mmxmark.o amd64/mmxmark.s"
	`$AS -o temp/mmxmark.o amd64/mmxmark.s`; fi
	if [ ! -f temp/mmxmem.o ]; then
	echo "$AS -o temp/mmxmem.o amd64/mmxmem.s"
	`$AS -o temp/mmxmem.o amd64/mmxmem.s`; fi
	if [ ! -f temp/ssemark.o ]; then
	echo "$AS -o temp/ssemark.o amd64/ssemark.s"
	`$AS -o temp/ssemark.o amd64/ssemark.s`; fi
	if [ ! -f temp/ssemem.o ]; then
	echo "$AS -o temp/ssemem.o amd64/ssemem.s"
	`$AS -o temp/ssemem.o amd64/ssemem.s`; fi
	echo "$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o temp/mmxmark.o temp/mmxmem.o temp/ssemark.o temp/ssemem.o"
	`$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o temp/mmxmark.o temp/mmxmem.o temp/ssemark.o temp/ssemem.o`
	;;

    ALPHA_GNU_ASM)
	if [ ! -f temp/ramsmp.o ]; then
	echo "$CC $CFLAGS -D$OS -c -o temp/ramsmp.o ramsmp.c"
	`$CC $CFLAGS -D$OS -c -o temp/ramsmp.o ramsmp.c`; fi
	if [ ! -f temp/intmark.o ]; then
	echo "$AS -o temp/intmark.o alpha/gnu/intmark.s"
	`$AS -o temp/intmark.o alpha/gnu/intmark.s`; fi
	if [ ! -f temp/intmem.o ]; then
	echo "$AS -o temp/intmem.o alpha/gnu/intmem.s"
	`$AS -o temp/intmem.o alpha/gnu/intmem.s`; fi
	if [ ! -f temp/fltmark.o ]; then
	echo "$AS -o temp/fltmark.o alpha/gnu/fltmark.s"
	`$AS -o temp/fltmark.o alpha/gnu/fltmark.s`; fi
	if [ ! -f temp/fltmem.o ]; then
	echo "$AS -o temp/fltmem.o alpha/gnu/fltmem.s"
	`$AS -o temp/fltmem.o alpha/gnu/fltmem.s`; fi
	echo "$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o"
	`$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o`
	;;

    ALPHA_DEC_ASM)
	if [ ! -f temp/ramsmp.o ]; then
	echo "$CC $CFLAGS -D$OS -c -o temp/ramsmp.o ramsmp.c"
	`$CC $CFLAGS -D$OS -c -o temp/ramsmp.o ramsmp.c`; fi
	if [ ! -f temp/intmark.o ]; then
	echo "$AS -o temp/intmark.o alpha/dec/intmark.s"
	`$AS -o temp/intmark.o alpha/dec/intmark.s`; fi
	if [ ! -f temp/intmem.o ]; then
	echo "$AS -o temp/intmem.o alpha/dec/intmem.s"
	`$AS -o temp/intmem.o alpha/dec/intmem.s`; fi
	if [ ! -f temp/fltmark.o ]; then
	echo "$AS -o temp/fltmark.o alpha/dec/fltmark.s"
	`$AS -o temp/fltmark.o alpha/dec/fltmark.s`; fi
	if [ ! -f temp/fltmem.o ]; then
	echo "$AS -o temp/fltmem.o alpha/dec/fltmem.s"
	`$AS -o temp/fltmem.o alpha/dec/fltmem.s`; fi
	echo "$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o"
	`$LD $LFLAGS -o ramsmp temp/ramsmp.o temp/intmark.o temp/intmem.o temp/fltmark.o temp/fltmem.o`
	;;

esac
