/*
**  CPUinfo, a processor information retrieving tool
**
**  (primary routine; UNIX release [i386])
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2004-05 Rhett M. Hollander <rhett@alasir.com>
**  Copyright (c) 2005-09 Paul V. Bolotoff <walter@alasir.com>
**
**  All rights reserved.
**
*/

/* detects and displays (optionally) a processor vendor, trade name, code name,
 * technological process, clock speed, also cache and TLB related information
 * INPUT:
 * bit 0 -- verbose (1) or silent (0) mode
 * bit 1 -- privileged (1) or regular (0) mode
 * OUTPUT:
 * bits 0 to 3 -- vendor code (may be populated even if no CPUID supported):
 *   0x0 -- unknown
 *   0x1 -- Intel
 *   0x2 -- AMD
 *   0x3 -- Cyrix
 *   0x4 -- Centaur
 *   0x5 -- Transmeta
 *   0x6 -- Rise
 *   0x7 -- NexGen
 *   0x8 -- UMC
 *   0x9 -- NSC
 *   0xA -- SiS
 * bits 4 to 7   -- CPU stepping
 * bits 8 to 15  -- CPU model
 * bits 16 to 23 -- CPU family (will be populated even if no CPUID supported)
 * bits 24 to 27 -- number of processor physical cores (N+1)
 * bit 28 is reserved for future use
 * bit 29 -- CPUID support flag
 * bit 30 -- verbose/silent mode flag
 * bit 31 -- privileged/regular mode flag
 * (bits 30 and 31 are for internal use only) */
.globl cpuinfo_main
cpuinfo_main:
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	movl	%esp, %ebp
	xorl	%esi, %esi
	xorl	%edi, %edi

/* set up the mode bits */
	movl	20(%esp), %eax
	shll	$30, %eax
	orl	%eax, %edi

/* push all printf() strings to stack if in verbose mode */
	testl	$0x40000000, %edi
	jz	.nostrings
/* "%s family %X model %X stepping %X\n" is at -36(%ebp) */
	pushl	$0x00000A58
	pushl	$0x2520676E
	pushl	$0x69707065
	pushl	$0x74732058
	pushl	$0x25206C65
	pushl	$0x646F6D20
	pushl	$0x58252079
	pushl	$0x6C696D61
	pushl	$0x66207325
/* "Cyrix model %X stepping %X revision %X\n" is at -76(%ebp) */
	pushl	$0x000A5825
	pushl	$0x206E6F69
	pushl	$0x73697665
	pushl	$0x72205825
	pushl	$0x20676E69
	pushl	$0x70706574
	pushl	$0x73205825
	pushl	$0x206C6564
	pushl	$0x6F6D2078
	pushl	$0x69727943
/* "%s processor" is at -92(%ebp) */
	pushl	$0x00000000
	pushl	$0x726F7373
	pushl	$0x65636F72
	pushl	$0x70207325
/* " %u.%uMHz\n" is at -104(%ebp) */
	pushl	$0x00000A7A
	pushl	$0x484D7525
	pushl	$0x2E752520
/* "\n" is at -108(%ebp) */
	pushl	$0x0000000A
/* "%s " is at -112(%ebp) */
	pushl	$0x00207325
/* "%ux I-cache: %uKuops, %u-way\n" is at -144(%ebp) or -140(%ebp) */
	pushl	$0x0000000A
	pushl	$0x7961772D
	pushl	$0x7525202C
	pushl	$0x73706F75
	pushl	$0x4B752520
	pushl	$0x3A656863
	pushl	$0x61632D49
	pushl	$0x20787525
/* "%ux %c-cache: %uKb, %u-way, %u bytes per line\n" is at -192(%ebp) or -188(%ebp) */
	pushl	$0x00000A65
	pushl	$0x6E696C20
	pushl	$0x72657020
	pushl	$0x73657479
	pushl	$0x62207525
	pushl	$0x202C7961
	pushl	$0x772D7525
	pushl	$0x202C624B
	pushl	$0x7525203A
	pushl	$0x65686361
	pushl	$0x632D6325
	pushl	$0x20787525
/* "%c-cache: [unknown]\n" is at -216(%ebp) */
	pushl	$0x00000000
	pushl	$0x0A5D6E77
	pushl	$0x6F6E6B6E
	pushl	$0x755B203A
	pushl	$0x65686361
	pushl	$0x632D6325
/* "%ux %c-cache: %uKb, %u-way, %u line(s) per tag, %u bytes per line\n" is at -284(%ebp) or -280(%ebp) */
	pushl	$0x00000A65
	pushl	$0x6E696C20
	pushl	$0x72657020
	pushl	$0x73657479
	pushl	$0x62207525
	pushl	$0x202C6761
	pushl	$0x74207265
	pushl	$0x70202973
	pushl	$0x28656E69
	pushl	$0x6C207525
	pushl	$0x202C7961
	pushl	$0x772D7525
	pushl	$0x202C624B
	pushl	$0x7525203A
	pushl	$0x65686361
	pushl	$0x632D6325
	pushl	$0x20787525
/* "%ux %c-TLB (4%cb pages): %u entries, %u-way\n" is at -332(%ebp) or -328(%ebp) */
	pushl	$0x00000000
	pushl	$0x0A796177
	pushl	$0x2D752520
	pushl	$0x2C736569
	pushl	$0x72746E65
	pushl	$0x20752520
	pushl	$0x3A297365
	pushl	$0x67617020
	pushl	$0x62632534
	pushl	$0x2820424C
	pushl	$0x542D6325
	pushl	$0x20787525
/* "%c-TLB (4%cb pages): [unknown]\n" is at -364(%ebp) */
	pushl	$0x000A5D6E
	pushl	$0x776F6E6B
	pushl	$0x6E755B20
	pushl	$0x3A297365
	pushl	$0x67617020
	pushl	$0x62632534
	pushl	$0x2820424C
	pushl	$0x542D6325
/* "BIOS name string: "%s"\n" is at -388(%ebp) */
	pushl	$0x000A2273
	pushl	$0x2522203A
	pushl	$0x676E6972
	pushl	$0x74732065
	pushl	$0x6D616E20
	pushl	$0x534F4942

.nostrings:
/* standard function 0 (eflags, bit 21) */
	pushfl
	popl	%eax
	movl	%eax, %ebx
	xorl	$0x00200000, %eax
	pushl	%eax
	popfl
	pushfl
	popl	%eax
	cmpl	%eax, %ebx
	je	.cpuinfo_nocpuid
	pushl	%ebx
	popfl

/* set up the CPUID support flag (should be checked before calling functions
 * evaluating miscellaneous processor extensions) */
	orl	$0x20000000, %edi
/* recognise a vendor by an ID string (scan the last double-word only) */
	xorl	%eax, %eax
	cpuid
/* "GenuineIntel" */
	cmpl	$0x6C65746E, %ecx
	jne	.vend2
	movw	$0x0001, %di
/* "AuthenticAMD" */
.vend2:
	cmpl	$0x444D4163, %ecx
	jne	.vend3
	movw	$0x0002, %di
/* "CyrixInstead" */
.vend3:
	cmpl	$0x64616574, %ecx
	jne	.vend4
	movw	$0x0003, %di
/* "CentaurHauls" */
.vend4:
	cmpl	$0x736C7561, %ecx
	jne	.vend5
	movw	$0x0004, %di
/* "GenuineTMx86" */
.vend5:
	cmpl	$0x3638784D, %ecx
	jne	.vend6
	movw	$0x0005, %di
/* "RiseRiseRise" */
.vend6:
	cmpl	$0x65736952, %ecx
	jne	.vend7
	movw	$0x0006, %di
/* "NexGenDriven" */
.vend7:
	cmpl	$0x6E657669, %ecx
	jne	.vend8
	movw	$0x0007, %di
/* "UMC UMC UMC " */
.vend8:
	cmpl	$0x20434D55, %ecx
	jne	.vend9
	movw	$0x0008, %di
/* "Geode by NSC" */
.vend9:
	cmpl	$0x43534E20, %ecx
	jne	.vend10
	movw	$0x0009, %di
/* "SiS SiS SiS " */
.vend10:
	cmpl	$0x20536953, %ecx
	jne	.cpuinfo_stdstr
	movw	$0x0000A, %di

/* obtain family, model, stepping (all processors supporting CPUID are
 * supposed to have standard function 1 implemented at least) */
.cpuinfo_stdstr:
	movl	$1, %eax
	cpuid
/* gather standard\extended family, standard\extended model, stepping */
	xorl	%ebx, %ebx
	movl	%eax, %edx
	shrl	$8, %edx
	andb	$0x0F, %dl
	movb	%dl, %bh
	shrl	$12, %edx
	addb	%dl, %bh
	movl	%eax, %edx
	shrl	$4, %edx
	andb	$0x0F, %dl
	movb	%dl, %bl
	shrl	$8, %edx
	andb	$0xF0, %dl
	orb	%dl, %bl
	shll	$8, %ebx
	movl	%eax, %edx
	shll	$4, %edx
	movb	%dl, %bl
	orl	%ebx, %edi
/* print family, model, stepping and vendor's ID string */
	testl	$0x40000000, %edi
	jz	.cpuinfo_main_exit
	xorl	%eax, %eax
	movb	%bl, %al
	shrb	$4, %al
	movl	%eax, -20(%esp)
	shrl	$8, %ebx
	movb	%bl, %al
	movl	%eax, -24(%esp)
	shrl	$8, %ebx
	movb	%bl, %al
	movl	%eax, -28(%esp)
	xorl	%eax, %eax
	pushl	%eax
	cpuid
	pushl	%ecx
	pushl	%edx
	pushl	%ebx
	movl	%esp, %eax
	subl	$12, %esp
	pushl	%eax
	leal	-36(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_table

.cpuinfo_nocpuid:
/* if there is no CPUID, detect either 386 or 486 first (eflags, bit 18) */
	pushfl
	popl	%eax
	movl	%eax, %ebx
	xorl	$0x00040000, %eax
	pushl	%eax
	popfl
	pushfl
	popl	%eax
	cmpl	%eax, %ebx
	jne	.un486

/* a 386-class CPU has been detected */
	orl	$0x00030000, %edi
/* try to detect a NexGen 586;
 * ZF shouldn't change after dividing 5 by 2
 * (from "Nx586 Processor Recognition Application Note") */
	xorl	%eax, %eax
	movb	$5, %al
	movb	$2, %bl
	divb	%bl
	jz	.nx586
/* a generic 386 by Intel, AMD, IBM, C&T or TI; nothing more to do here */
	testl	$0x40000000, %edi
	jz	.cpuinfo_main_exit
	pushl	$0x0000005D
	pushl	$0x36383320
	pushl	$0x63697265
	pushl	$0x6E65675B
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

.nx586:
	orw	$0x0007, %di
	testl	$0x40000000, %edi
	jz	.cpuinfo_main_exit
.nx586_print:
	pushl	$0x00753434
	pushl	$0x2E302050
	pushl	$0x46363835
	pushl	$0x20726F20
	pushl	$0x7530352E
	pushl	$0x30203638
	pushl	$0x35206E65
	pushl	$0x4778654E
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* TSC is unsupported, don't know how to calculate */
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

.un486:
/* a 486-class CPU has been detected */
	pushl	%ebx
	popfl
	orl	$0x00040000, %edi
/* try to detect a Cyrix processor;
 * undefined flags must remain unchanged after dividing 5 by 2
 * (from "Cyrix CPU Detection Guide") */
	xorl	%eax, %eax
	sahf
	movb	$5, %al
	movb	$2, %bl
	divb	%bl
	lahf
	cmpb	$2, %ah
	je	.cx486
/* generic 486; must be an early 486 by Intel or AMD */
	testl	$0x40000000, %edi
	jz	.cpuinfo_main_exit
	pushl	$0x0000005D
	pushl	$0x36383420
	pushl	$0x63697265
	pushl	$0x6E65675B
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

.cx486:
/* even the oldest Cyrix processors which were designed as upgrades to generic
 * 386-class hardware supported the 486 instruction set */
	orw	$0x0003, %di
	testl	$0x40000000, %edi
	jz	.cpuinfo_main_exit
	testl	$0x80000000, %edi
	jnz	.cyrix_dir
	pushl	$0x00000036
	pushl	$0x38342078
	pushl	$0x69727943
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

.cyrix_dir:
/* follow with DIR0 and DIR1 */
	xorl	%eax, %eax
	xorl	%esi, %esi
	movb	$0xFE, %al
	outb	%al, $0x22
	inb	$0x23, %al
	movb	%al, %bl
	movb	$0xFF, %al
	outb	%al, $0x22
	inb	$0x23, %al
	movb	%al, %bh
/* print model, stepping, revision */
	andb	$0x0F, %al
	pushl	%eax
	movb	%bh, %al
	shrb	$4, %al
	pushl	%eax
	movb	%bl, %al
	pushl	%eax
	leal	-76(%ebp), %eax
	pushl	%eax
	call	printf
/* Cyrix look-up table (very comprehensive) */
	andl	$0x0000FFFF, %ebx
	cmpb	$0x00, %bl
	je	.cx486slc
	cmpb	$0x01, %bl
	je	.cx486dlc
	cmpb	$0x02, %bl
	je	.cx486slc2
	cmpb	$0x03, %bl
	je	.cx486dlc2
	cmpb	$0x04, %bl
	je	.cx486srx
	cmpb	$0x05, %bl
	je	.cx486drx
	cmpb	$0x06, %bl
	je	.cx486srx2
	cmpb	$0x07, %bl
	je	.cx486drx2
	cmpb	$0x08, %bl
	je	.cx486sru
	cmpb	$0x09, %bl
	je	.cx486dru
	cmpb	$0x0A, %bl
	je	.cx486sru2
	cmpb	$0x0B, %bl
	je	.cx486dru2
	cmpb	$0x10, %bl
	je	.cx486s
	cmpb	$0x11, %bl
	je	.cx486s2
	cmpb	$0x12, %bl
	je	.cx486se
	cmpb	$0x13, %bl
	je	.cx486s2e
	cmpb	$0x1A, %bl
	je	.cx486dx
	cmpb	$0x1B, %bl
	je	.cx486dx2
	cmpb	$0x1F, %bl
	je	.cx486dx4
	movb	%bl, %al
	shrb	$4, %al
	cmpb	$0x02, %al
	je	.cxm1sc
	cmpb	$0x03, %al
	je	.cxm1_family
	cmpb	$0x04, %al
	je	.cxgx_family
	cmpb	$0x05, %al
	je	.cxm2
	xorl	%ebx, %ebx
	pushl	$0x0000005D
	pushl	$0x6E776F6E
	pushl	$0x6B6E755B
	jmp	.cyrix_dir_quit

.cx486slc:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x0000434C
	pushl	$0x53363834
	jmp	.cyrix_dir_quit

.cx486dlc:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x0000434C
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486slc2:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x0032434C
	pushl	$0x53363834
	jmp	.cyrix_dir_quit

.cx486dlc2:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x0032434C
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486srx:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00007852
	pushl	$0x53363834
	jmp	.cyrix_dir_quit

.cx486drx:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00007852
	pushl	$0x44363834
	jmp	.cyrix_dir_quit
	
.cx486srx2:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00327852
	pushl	$0x53363834
	jmp	.cyrix_dir_quit

.cx486drx2:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00327852
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486sru:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00007552
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486dru:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00007552
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486sru2:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00327552
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486dru2:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00327552
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486s:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00000000
	pushl	$0x53363834
	jmp	.cyrix_dir_quit

.cx486s2:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl 	$0x00000032
	pushl	$0x53363834
	jmp	.cyrix_dir_quit

.cx486se:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00000065
	pushl	$0x53363834
	jmp	.cyrix_dir_quit

.cx486s2e:
	movb	$0x01, %bl
	xorl	%esi, %esi
	pushl	$0x00006532
	pushl	$0x53363834
	jmp	.cyrix_dir_quit

.cx486dx:
	movb	$0x01, %bl
	movl	$0x00001408, %esi
	pushl	$0x00000058
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486dx2:
	movb	$0x01, %bl
	movl	$0x00001408, %esi
	pushl	$0x00003258
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cx486dx4:
	movb	$0x01, %bl
	movl	$0x00001408, %esi
	pushl	$0x00003458
	pushl	$0x44363834
	jmp	.cyrix_dir_quit

.cxm1sc:
	movb	$0x02, %bl
	movl	$0x00001410, %esi
	pushl	$0x00000075
	pushl	$0x35362E30
	pushl	$0x20296373
	pushl	$0x314D2820
	pushl	$0x36387835
	jmp	.cyrix_dir_quit

.cxm1_family:
	movl	$0x80080003, %ebx
	movl	$0x01802410, %esi
	cmpb	$0x20, %bh
	jae	.cxm1l
.cxm1:
/* 150MHz version at least was 0.44u */
	pushl	$0x00000075
	pushl	$0x34342E30
	pushl	$0x2D753536
	pushl	$0x2E302029
	pushl	$0x314D2820
	pushl	$0x36387836
	jmp	.cyrix_dir_quit
.cxm1l:
	pushl	$0x00000075
	pushl	$0x35332E30
	pushl	$0x20294C31
	pushl	$0x4D28204C
	pushl	$0x36387836
	jmp	.cyrix_dir_quit

.cxgx_family:
	movb	$0x02, %bl
	movl	$0x04201410, %esi
	cmpb	$0x30, %bh
	jae	.cxgxm
.cxmgx:
	pushl	$0x00000000
	pushl	$0x7535332E
	pushl	$0x30202936
	pushl	$0x38784728
	pushl	$0x20584761
	pushl	$0x6964654D
	jmp	.cyrix_dir_quit
.cxgxm:
/* GXm was 0.35u, GXlv -- 0.25u */
	pushl	$0x00753532
	pushl	$0x2E302076
	pushl	$0x6C584720
	pushl	$0x726F2075
	pushl	$0x35332E30
	pushl	$0x206D5847
	jmp	.cyrix_dir_quit

.cxm2:
/* was either 0.35u or 0.30u or 0.25u or 0.18u */
	movl	$0x61800003, %ebx
	movl	$0x01102440, %esi
	pushl	$0x00753831
	pushl	$0x2E302D75
	pushl	$0x35332E30
	pushl	$0x2029324D
	pushl	$0x2820584D
	pushl	$0x36387836

.cyrix_dir_quit:
	pushl	$0x20786972
	pushw	$0x7943
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	testl	$0x80000000, %edi
	jnz	.cyrix_clk
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

.cyrix_clk:
/* obtain and print processor clock speed
 * (thanks to Cyrix for the information) */
 	xorb	%bh, %bh
	pushw	%bx
	call	calcnt
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.cyrix_noclk
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_cxcache
.cyrix_noclk:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf

.cpuinfo_cxcache:
/* display cache- and TLB-related information;
 * has been sourced from official data sheets */
/* U-cache size, associativity and line size */
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	cmpl	%eax, %esi
	je	.cpuinfo_main_exit
	movw	%si, %ax
	andw	$0x00FF, %ax
	movw	%si, %cx
	shrw	$8, %cx
	andw	$0x000F, %cx
	movw	%si, %dx
	shrw	$8, %dx
	andw	$0x00F0, %dx
	pushl	%edx
	pushl	%ecx
	pushl	%eax
	pushl	$0x00000055
	leal	-188(%ebp), %eax
	pushl	%eax
	call	printf
/* U-TLB size and associativity */
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x00FF, %ax
	cmpb	%ah, %al
	je	.cpuinfo_main_exit
	movl	%esi, %ecx
	shrl	$24, %ecx
	pushl	%ecx
	pushl	%eax
	pushl	$0x0000004B
	pushl	$0x00000055
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf
/* S-TLB size and associativity */
	movl	%ebx, %eax
	shrl	$16, %eax
	andw	$0x0FFF, %ax
	xorw	%dx, %dx
	cmpw	%dx, %ax
	je	.cpuinfo_main_exit
	movl	%ebx, %ecx
	shrl	$28, %ecx
	pushl	%ecx
	pushl	%eax
	pushl	$0x0000004B
	pushl	$0x00000053
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf
	xorl	%esi, %esi
	jmp	.cpuinfo_main_exit

.cpuinfo_main_table:
/* primary processor look-up table;
 * prints a vendor's name, defines and prints a processor's trade name and code
 * name, an applicable technological process (in micrometres or nanometres) and
 * clock speed (if possible to calculate; in megahertz) */
	movl	%edi, %eax
	andb	$0x0F, %al
	movl	%edi, %ebx
	shrl	$8, %ebx
	cmpb	$0x01, %al
	je	.intel_table
	cmpb	$0x02, %al
	je	.amd_table
	cmpb	$0x03, %al
	je	.cyrix_table
	cmpb	$0x04, %al
	je	.centaur_table
	cmpb	$0x05, %al
	je	.trmeta_table
	cmpb	$0x06, %al
	je	.rise_table
	cmpb	$0x07, %al
	je	.nexgen_table
	cmpb	$0x08, %al
	je	.umc_table
	cmpb	$0x09, %al
	je	.nsc_table
	cmpb	$0x0A, %al
	je	.sis_table
	jmp	.cpuinfo_main_exit

.intel_table:
/* Intel processors */
	cmpb	$0x04, %bh
	je	.i486
	cmpb	$0x05, %bh
	je	.i586
	cmpb	$0x06, %bh
	je	.i686
	cmpb	$0x0F, %bh
	je	.iF86
/* "Intel [unknown]" */
	pushl	$0x005D6E77
	pushl	$0x6F6E6B6E
	pushl	$0x755B206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_table_quit

.i486:
	cmpb	$0x00, %bl
	je	.i486dx
	cmpb	$0x01, %bl
	je	.i486dxa
	cmpb	$0x02, %bl
	je	.i486sx
	cmpb	$0x03, %bl
	je	.i486dx2
	cmpb	$0x04, %bl
	je	.i486sl
	cmpb	$0x05, %bl
	je	.i486sx2
	cmpb	$0x07, %bl
	je	.i486dx2
	cmpb	$0x08, %bl
	je	.i486dx4
	cmpb	$0x09, %bl
	je	.i486dx4
/* "[486 class]" */
	pushl	$0x0000005D
	pushl	$0x7373616C
	pushl	$0x63203638
	pushw	$0x345B
	jmp	.i486_quit

.i486dx:
/* "486DX 1.0u" */
	pushl	$0x00000000
	pushl	$0x75302E31
	pushl	$0x20584436
	pushw	$0x3834
	jmp	.i486_quit

.i486dxa:
/* "486DX 0.8u" */
	pushl	$0x00000000
	pushl	$0x75382E30
	pushl	$0x20584436
	pushw	$0x3834
	jmp	.i486_quit

.i486sx:
/* "486SX 0.8u" */
	pushl	$0x00000000
	pushl	$0x75382E30
	pushl	$0x20585336
	pushw	$0x3834
	jmp	.i486_quit

.i486dx2:
/* "486DX2 0.8u" */
	pushl	$0x00000075
	pushl	$0x382E3020
	pushl	$0x32584436
	pushw	$0x3834
	jmp	.i486_quit

.i486sl:
/* "486SL" */
	pushl	$0x004C5336
	pushw	$0x3834
	jmp	.i486_quit

.i486sx2:
/* "486SX2 0.8u" */
	pushl	$0x00000075
	pushl	$0x382E3020
	pushl	$0x32585336
	pushw	$0x3834
	jmp	.i486_quit

.i486dx4:
/* "486DX4 0.6u" */
	pushl	$0x00000075
	pushl	$0x362E3020
	pushl	$0x34584436
	pushw	$0x3834
/*	jmp	.i486_quit */

.i486_quit:
/* "Intel " */
	pushw	$0x206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_table_quit

.i586:
	cmpb	$0x00, %bl
	je	.ip5
	cmpb	$0x01, %bl
	je	.ip5
	cmpb	$0x02, %bl
	je	.ip54c
	cmpb	$0x03, %bl
	je	.ip24t
	cmpb	$0x04, %bl
	je	.ip55c
	cmpb	$0x07, %bl
	je	.ip54cs
	cmpb	$0x08, %bl
	je	.itill
/* "[Pentium class]" */
	pushl	$0x0000005D
	pushl	$0x7373616C
	pushl	$0x63206D75
	pushl	$0x69746E65
	pushw	$0x505B
	jmp	.i586_quit

.ip5:
/* "Pentium (P5) 0.8u" */
	pushl	$0x0075382E
	pushl	$0x30202935
	pushl	$0x5028206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i586_quit

.ip54c:
/* "Pentium (P54C) 0.6u" */
	pushl	$0x00000075
	pushl	$0x362E3020
	pushl	$0x29433435
	pushl	$0x5028206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i586_quit

.ip24t:
/* "Pentium OverDrive (P24T) 0.6u" */
	pushl	$0x0075362E
	pushl	$0x30202954
	pushl	$0x34325028
	pushl	$0x20657669
	pushl	$0x72447265
	pushl	$0x764F206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i586_quit

.ip55c:
/* "Pentium MMX (P55C) 0.28u" */
	pushl	$0x00007538
	pushl	$0x322E3020
	pushl	$0x29433535
	pushl	$0x50282058
	pushl	$0x4D4D206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i586_quit

.ip54cs:
/* "Pentium (P54CS) 0.35u" */
	pushl	$0x00753533
	pushl	$0x2E302029
	pushl	$0x53433435
	pushl	$0x5028206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i586_quit

.itill:
/* "Pentium MMX (Tillamook) 0.25u" */
	pushl	$0x00753532
	pushl	$0x2E302029
	pushl	$0x6B6F6F6D
	pushl	$0x616C6C69
	pushl	$0x54282058
	pushl	$0x4D4D206D
	pushl	$0x7569746E
	pushw	$0x6550
/*	jmp	.i586_quit */

.i586_quit:
/* "Intel " */
	pushw	$0x206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_table_quit

.i686:
	cmpb	$0x00, %bl
	je	.ip6a
	cmpb	$0x01, %bl
	je	.ip6
	cmpb	$0x03, %bl
	je	.iklmt
	cmpb	$0x05, %bl
	je	.idess
	cmpb	$0x06, %bl
	je	.idixn
	cmpb	$0x07, %bl
	je	.ikatm
	cmpb	$0x08, %bl
	je	.icopp
	cmpb	$0x09, %bl
	je	.ibans
	cmpb	$0x0A, %bl
	je	.icasc
	cmpb	$0x0B, %bl
	je	.itual
	cmpb	$0x0D, %bl
	je	.idoth
	cmpb	$0x0E, %bl
	je	.iyonh
	cmpb	$0x0F, %bl
	je	.iconr
	cmpb	$0x16, %bl
	je	.iconl
	cmpb	$0x17, %bl
	je	.iwolf
	cmpb	$0x1A, %bl
	je	.inehl
	cmpb	$0x1B, %bl
	je	.inehl
	cmpb	$0x1C, %bl
	je	.iat20
	cmpb	$0x1D, %bl
	je	.idunn
/* "Intel [Pentium Pro class]" */
	pushl	$0x0000005D
	pushl	$0x7373616C
	pushl	$0x63206F72
	pushl	$0x50206D75
	pushl	$0x69746E65
	pushl	$0x505B206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_table_quit

.i686pp:
/* "Pentium Pro" */
	subl	$12, %esp
	pushl	$0x0000006F
	pushl	$0x7250206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i686_quit

.i686p2:
/* "Pentium II" */
	subl	$12, %esp
	pushl	$0x00000000
	pushl	$0x4949206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i686_quit

.i686p2od:
/* "Pentium II OverDrive" */
	subl	$4, %esp
	pushl	$0x00006576
	pushl	$0x69724472
	pushl	$0x65764F20
	pushl	$0x4949206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i686_quit

.i686p2x:
/* "Pentium II Xeon" */
	subl	$8, %esp
	pushl	$0x0000006E
	pushl	$0x6F655820
	pushl	$0x4949206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i686_quit

.i686c:
/* "Celeron" */
	subl	$16, %esp
	pushl	$0x0000006E
	pushl	$0x6F72656C
	pushw	$0x6543
	jmp	.i686_quit

.i686p3:
/* "Pentium III" */
	subl	$12, %esp
	pushl	$0x00000049
	pushl	$0x4949206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i686_quit

.i686p3x:
/* "Pentium III Xeon" */
	subl	$8, %esp
	pushl	$0x00006E6F
	pushl	$0x65582049
	pushl	$0x4949206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i686_quit

.i686pm:
/* "Pentium M" */
	subl	$16, %esp
	pushl	$0x004D206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i686_quit

.i686cm:
/* "Celeron M" */
	subl	$16, %esp
	pushl	$0x004D206E
	pushl	$0x6F72656C
	pushw	$0x6543
	jmp	.i686_quit

.i686c1d:
/* "Core Duo" */
	orl	$0x00010000, %esi
	subl	$16, %esp
	pushl	$0x00006F75
	pushl	$0x44206572
	pushw	$0x6F43
	jmp	.i686_quit

.i686c1s:
/* "Core Solo" */
	subl	$16, %esp
	pushl	$0x006F6C6F
	pushl	$0x53206572
	pushw	$0x6F43
	jmp	.i686_quit

.i686c2q:
/* "Core 2 Quad" */
	orl	$0x00130000, %esi
	subl	$12, %esp
	pushl	$0x00000064
	pushl	$0x61755120
	pushl	$0x32206572
	pushw	$0x6F43
	jmp	.i686_quit

.i686c2d:
/* "Core 2 Duo" */
	orl	$0x00010000, %esi
	subl	$12, %esp
	pushl	$0x00000000
	pushl	$0x6F754420
	pushl	$0x32206572
	pushw	$0x6F43
	jmp	.i686_quit

.i686pd:
/* "Pentium Duo" */
	orl	$0x00010000, %esi
	subl	$12, %esp
	pushl	$0x0000006F
	pushl	$0x7544206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.i686_quit

.i686cd:
/* "Celeron Duo" */
	orl	$0x00010000, %esi
	subl	$12, %esp
	pushl	$0x0000006F
	pushl	$0x7544206E
	pushl	$0x6F72656C
	pushw	$0x6543
	jmp	.i686_quit

.ip6:
/* P6 family (600nm and 350nm) */
	movl	%edi, %eax
	shrl	$4, %eax
	andb	$0x0F, %al
	cmpb	$0x02, %al
	ja	.ip6b
.ip6a:
/* 600nm steppings 1 and 2 of model 1, also all [if any] steppings of model 0
 * which are prototypes actually */
	pushl	$0x0000006D
	pushl	$0x6E303036
	jmp	.i686pp
.ip6b:
/* 350nm steppings 6, 7, 9 of model 1 */
	pushl	$0x0000006D
	pushl	$0x6E303533
	jmp	.i686pp

.iklmt:
/* Klamath family (280nm);
 * must test for Pentium II OverDrive (also known as P6T) which is a member of
 * the forthcoming 250nm Deschutes family (in fact, a Pentium II Xeon with
 * 512Kb of B-cache packaged for Socket 8 instead of Slot 2, though with 4-way
 * SMP disabled); a stepping check could also succeed (PII reports 3 or 4,
 * PIIOD -- 2) */
	movl	$1, %eax
	cpuid
	testw	$0x1000, %ax
	jnz	.ip6t
	pushl	$0x006D6E30
	pushl	$0x38322029
	pushl	$0x6874616D
	pushl	$0x616C4B28
	jmp	.i686p2
.ip6t:
	pushl	$0x006D6E30
	pushl	$0x35322029
	pushl	$0x54365028
	jmp	.i686p2od

.idess:
/* Deschutes family with Drake and Covington subfamilies (250nm);
 * 1) Pentium II has 512Kb of B-cache, Pentium II Xeon (also known as Drake)
 *    -- either 512Kb or 1Mb or 2Mb, and Celeron (also known as Covington) is
 *    of none at all;
 * 2) it's hardly possible to recognise a 512Kb Drake in software */
	movl	$2, %eax
	cpuid
	andb	$0xFF, %dl
	cmpb	$0x43, %dl
	jb	.icovg
	ja	.idrak
/* regular: steppings 0, 1, 2, 3 */
/* mobile: steppings 0 and 2 */
	pushl	$0x0000006D
	pushl	$0x6E303532
	pushl	$0x20297365
	pushl	$0x74756863
	pushl	$0x73654428
	jmp	.i686p2
.idrak:
/* steppings 2 and 3 */
	pushw	$0x0000006D
	pushl	$0x6E303532
	pushl	$0x2029656B
	pushl	$0x61724428
	jmp	.i686p2x
.icovg:
/* steppings 0 and 1 */
	pushl	$0x0000006D
	pushl	$0x6E303532
	pushl	$0x20296E6F
	pushl	$0x74676E69
	pushl	$0x766F4328
	jmp	.i686c

.idixn:
/* Dixon family (250nm or 180nm) and Mendocino subfamily (250nm);
 * there is mobile Pentium II (Dixon actually) or mobile Celeron (Dixon with
 * 1/2 of S-cache disabled), but this family is famous mostly because of
 * regular Celeron (also known as Mendocino) */
	movw	%di, %ax
	shrw	$4, %ax
	andb	$0x0F, %al
	cmpb	$0x00, %al
	je	.imend
	cmpb	$0x05, %al
	je	.imend
/* stepping A (all package types) */
/* S-cache size test; Pentium II has 256Kb, Celeron -- 128Kb */
	movl	$2, %eax
	cpuid
	andb	$0xFF, %dl
	cmpb	$0x42, %dl
	jb	.idixnc
/* NOTE: 400MHz BGA and mPGA parts only are 180nm */
	pushl	$0x00006D6E
	pushl	$0x30383120 
	pushl	$0x726F206D
	pushl	$0x6E303532
	pushl	$0x20296E6F
	pushl	$0x78694428
	jmp	.i686p2
.idixnc:
	pushl	$0x0000006D
	pushl	$0x6E303532
	pushl	$0x20296E6F
	pushl	$0x78694428
	jmp	.i686c
.imend:
/* stepping 0 (SEPP) and 5 (PGA) */
	pushl	$0x0000006D
	pushl	$0x6E303532
	pushl	$0x20296F6E
	pushl	$0x69636F64
	pushl	$0x6E654D28
	jmp	.i686c

.ikatm:
/* Katmai family with Tanner subfamily (250nm);
 * 1) Pentium III has 512Kb of B-cache, Pentium III Xeon (also known as
 *    Tanner) -- either 512Kb or 1Mb or 2Mb;
 * 2) it's hardly possible to recognise a 512Kb Tanner in software */
	movl	$2, %eax
	cpuid
	andb	$0xFF, %dl
	cmpb	$0x43, %dl
	ja	.itann
/* steppings 2 and 3 */
	pushl	$0x00006D6E
	pushl	$0x30353220
	pushl	$0x2969616D
	pushl	$0x74614B28
	jmp	.i686p3
.itann:
/* steppings 2 and 3 */
	pushl	$0x00006D6E
	pushl	$0x30353220
	pushl	$0x2972656E
	pushl	$0x6E615428
	jmp	.i686p3x

.icopp:
/* Coppermine family (180nm);
 * Pentium III (brand ID 0x02), Pentium III Xeon (brand ID 0x03) and Celeron
 * (brand ID 0x01) processors */
	pushl	$0x00006D6E
	pushl	$0x30383120
	pushl	$0x29656E69
	pushl	$0x6D726570
	pushl	$0x706F4328
	movl	$1, %eax
	cpuid
	andb	$0xFF, %bl
	cmpb	$0x02, %bl
/* steppings 1, 3, 6 */
	ja	.i686p3x
/* steppings 3, 6, A */
	jb	.i686c
/* steppings 1, 3, 6, A */
	je	.i686p3

.ibans:
/* Banias family (130nm);
 * Pentium M (brand ID 0x16) and Celeron M (brand ID 0x12) processors */
	pushl	$0x00006D6E
	pushl	$0x30333120
	pushl	$0x29736169
	pushl	$0x6E614228
	movl	$1, %eax
	cpuid
	andb	$0xFF, %bl
	cmpb	$0x12, %bl
	je	.i686cm
	jne	.i686pm

.icasc:
/* Cascades family (180nm);
 * Pentium III Xeon processors of steppings 0, 1, 4 */
	pushl	$0x00000000
	pushl	$0x6D6E3038
	pushl	$0x31202973
	pushl	$0x65646163
	pushl	$0x73614328
	jmp	.i686p3x

.itual:
/* Tualatin family (130nm);
 * processors and brand IDs: Pentium III -- 0x4 (regular, steppings 1 and 4)
 * or 0x6 (mobile, steppings 1 or 4), Celeron -- 0x3 (regular, stepping 1) or
 * 0x7 (mobile, steppings 1 or 4) */
	pushl	$0x00000000
	pushl	$0x6D6E3033
	pushl	$0x3120296E
	pushl	$0x6974616C
	pushl	$0x61755428
	movl	$1, %eax
	cpuid
	andb	$0xFF, %bl
	cmpb	$0x03, %bl
	je	.i686c
	cmpb	$0x07, %bl
	je	.i686c
	jne	.i686p3

.idoth:
/* Dothan family (90nm);
 * Pentium M (brand ID 0x16) and Celeron M (brand ID 0x12) processors */
	pushl	$0x0000006D
	pushl	$0x6E303920
	pushl	$0x296E6168
	pushl	$0x746F4428
	movl	$1, %eax
	cpuid
	andb	$0xFF, %bl
	cmpb	$0x12, %bl
	je	.i686cm
	jne	.i686pm

.iyonh:
/* Yonah family (65nm);
 * Core Duo and Core Solo as well as Xeon LV\ULV */
	pushl	$0x00000000
	pushl	$0x6D6E3536
	pushl	$0x20296861
	pushl	$0x6E6F5928
/* standard function 4 called with %ecx set to 0 returns the number of cores in
 * %eax [31:26] (0 stands for Solo, 1 -- for Duo) */
	movl	$0x00000004, %eax
	xorl	%ecx, %ecx
	cpuid
	shrl	$26, %eax
	cmpb	$0x00, %al
	je	.i686c1s
	jne	.i686c1d

.iconr:
/* Conroe family and Kentsfield subfamily (65nm);
 * 1) there are Core 2 Duo (Conroe actually) and Core 2 Quad (two Conroe dies;
 *    also known as Kentsfield) as well as Core 2 Extreme and various mobile
 *    (also known as Merom) and server (also known as Woodcrest) versions;
 * 2) there is also a Conroe derived core with S-cache of physical 2Mb as
 *    opposed to 4Mb, which is called Allendale (don't mistake with some
 *    Conroes which come with 1/2 of S-cache disabled);
 * CPUID steppings and related core revisions:
 * 0 -- A0 (Conroe, engineering sample)
 * 1 -- A1 (Conroe, engineering sample)
 * 2 -- L2 (Allendale)
 * 4 -- A4\B0 (Conroe, engineering sample)
 * 5 -- B1 (Conroe, engineering sample)
 * 6 -- B2 (Conroe)
 * 7 -- B3 (Conroe \ Kentsfield)
 * A -- E1 (Conroe \ Kentsfield)
 * B -- G0 (Conroe \ Kentsfield)
 * D -- M0 (Allendale) */
/* standard function 4 called with %ecx set to 0 returns the number of cores in
 * %eax [31:26] (1 stands for Duo, 3 -- for Quad; either one may be Extreme) */
	movl	$0x00000004, %eax
	xorl	%ecx, %ecx
	cpuid
	shrl	$26, %eax
	cmpb	$0x03, %al
	je	.ic2kent
/* Allendale doesn't support VMX, though a stepping check should also succeed */
	movl	$1, %eax
	cpuid
	testl	$0x00000020, %ecx
	jz	.ialln
	pushl	$0x0000006D
	pushl	$0x6E353620
	pushl	$0x29656F72
	pushl	$0x6E6F4328
	jmp	.i686c2d
.ic2kent:
	pushl	$0x0000006D
	pushl	$0x6E353620
	pushl	$0x29646C65
	pushl	$0x69667374
	pushl	$0x6E654B28
	jmp	.i686c2q

.ialln:
/* Allendale subfamily (65nm);
 * Core 2 Duo (no disabled parts in S-cache), Pentium Duo (1/2 of S-cache is
 * disabled) and Celeron Duo (3/4 of S-cache is disabled) processors */
	pushl	$0x00000000
	pushl	$0x6D6E3536
	pushl	$0x2029656C
	pushl	$0x61646E65
	pushl	$0x6C6C4128
/* Celeron Duo features S-cache of 512Kb (2-way, 64-byte lines) */
	pushw	$0x007F
	call	intel_parser
	popw	%dx
	xorw	%bx, %bx
	cmpw	%bx, %ax
	jne	.i686cd
/* Pentium Duo features S-cache of 1Mb (4-way, 64-byte lines) */
	pushw	$0x0078
	call	intel_parser
	popw	%dx
	cmpw	%bx, %ax
	jne	.i686pd
/* must be Core 2 Duo with S-cache of 2Mb (8-way, 64-byte lines) */
	je	.i686c2d

.iconl:
/* Conroe-L subfamily (65nm);
 * single-core Celeron 4xx and 5xx processors (5xx are Allendales actually with
 * one core and 1/2 of S-cache disabled), so that 4xx come with S-cache of
 * 512Kb (8-way, 64-byte lines) while 5xx have 1Mb (4-way, 64-byte lines) */
	pushw	$0x0078
	call	intel_parser
	popw	%dx
	cmpb	$0x78, %al
	je	.iconlal
	pushl	$0x006D6E35
	pushl	$0x3620294C
	pushl	$0x2D656F72
	pushl	$0x6E6F4328
	jmp	.i686c
.iconlal:
	pushl	$0x00000000
	pushl	$0x6D6E3536
	pushl	$0x2029656C
	pushl	$0x61646E65
	pushl	$0x6C6C4128
	jmp	.i686c

.iwolf:
/* Wolfdale family and Yorkfield subfamily (45nm);
 * Core 2 Duo (Wolfdale actually) and Core 2 Quad (two Wolfdale dies; also
 * known as Yorkfield) as well as Core 2 Extreme etc. */
/* standard function 4 called with %ecx set to 0 returns the number of cores in
 * %eax [31:26] (1 stands for Duo, 3 -- for Quad; either one may be Extreme) */
	movl	$0x00000004, %eax
	xorl	%ecx, %ecx
	cpuid
	shrl	$26, %eax
	cmpb	$0x03, %al
	je	.ic2york
	pushl	$0x006D6E35
	pushl	$0x34202965
	pushl	$0x6C616466
	pushl	$0x6C6F5728
	jmp	.i686c2d
.ic2york:
	pushl	$0x00000000
	pushl	$0x6D6E3534
	pushl	$0x2029646C
	pushl	$0x6569666B
	pushl	$0x726F5928
	jmp	.i686c2q

.inehl:
/* Nehalem family (45nm) (includes Clarksfield, Lynnfield, Bloomfield and Gainestown);
 * 1) 4 cores, four S-caches of 256Kb each and one T-cache of 8Mb are placed on
 * a single die, but some processor models may have 2 cores with two S-caches
 * as well as up to 4Mb of T-cache disabled;
 * 2) promoted as Core i7, Xeon 3500 and Xeon 5500 families */
	pushl	$0x00000000
	pushl	$0x6D6E3534
	pushl	$0x20296D65
	pushl	$0x6C616865
	pushl	$0x4E282037
	pushl	$0x69206572
	pushl	$0x6F43206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* processor core number estimation */
 	movl	$0x00000004, %eax
	xorl	%ecx, %ecx
	cpuid
	shrl	$26, %eax
	cmpb	$0x03, %al
	je	.inehl2c
	orl	$0x00330000, %esi
	jmp	.intel_table_quit
.inehl2c:
	orl	$0x00110000, %esi
	jmp	.intel_table_quit

.iat20:
/* Atom 200 family (45nm) */
 	pushl	$0x006D6E35
	pushl	$0x34203030
 	pushl	$0x32206D6F
	pushl	$0x7441206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_table_quit

.idunn:
/* Dunnington family (45nm);
 * 1) 6 cores, three S-caches of 1Mb each and one T-cache of 16Mb are placed on
 * a single die, but some processor models may have 2 cores with one S-cache as
 * well as up to 8Mb of T-cache disabled;
 * 2) promoted as Xeon 7400 family */
 	pushl	$0x006D6E35
	pushl	$0x3420296E
	pushl	$0x6F74676E
	pushl	$0x696E6E75
	pushl	$0x44282050
	pushl	$0x4D206E6F
	pushl	$0x6558206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* processor core number estimation */
 	movl	$0x00000004, %eax
	xorl	%ecx, %ecx
	cpuid
	shrl	$26, %eax
	cmpb	$0x03, %al
	je	.idunn4c
	orl	$0x00250000, %esi
	jmp	.intel_table_quit
.idunn4c:
	orl	$0x00130000, %esi
	jmp	.intel_table_quit

.i686_quit:
/* "Intel " */
	pushw	$0x206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-112(%ebp), %eax
	pushl	%eax
	call	printf
	leal	40(%esp), %eax
	pushl	%eax
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_table_quit

.iF86:
	cmpb	$0x00, %bl
	je	.iwill
	cmpb	$0x01, %bl
	je	.iwill
	cmpb	$0x02, %bl
	je	.inort
	cmpb	$0x03, %bl
	je	.ipres
	cmpb	$0x04, %bl
	je	.iprsm
	cmpb	$0x06, %bl
	je	.icdml
/* "Intel [Pentium 4 class]" */
	pushl	$0x005D7373
	pushl	$0x616C6320
	pushl	$0x34206D75
	pushl	$0x69746E65
	pushl	$0x505B206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_table_quit

.iF86p4:
/* "Pentium 4" */
	subl	$16, %esp
	pushl	$0x0034206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.iF86_quit

.iF86p4ee:
/* "Pentium 4 Extreme" */
	subl	$8, %esp
	pushl	$0x00656D65
	pushl	$0x72747845
	pushl	$0x2034206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.iF86_quit

.iF86pd:
/* "Pentium D" */
	orl	$0x00110000, %esi
	subl	$16, %esp
	pushl	$0x0044206D
	pushl	$0x7569746E
	pushw	$0x6550
	jmp	.iF86_quit

.iF86c:
/* "Celeron" */
	subl	$16, %esp
	pushl	$0x0000006E
	pushl	$0x6F72656C
	pushw	$0x6543
	jmp	.iF86_quit

.iF86x:
/* "Xeon" */
	subl	$20, %esp
	pushl	$0x00006E6F
	pushw	$0x6558
	jmp	.iF86_quit

.iF86xmp:
/* "Xeon MP" */
	subl	$16, %esp
	pushl	$0x00000050
	pushl	$0x4D206E6F
	pushw	$0x6558
	jmp	.iF86_quit

.iF86un:
/* "[unknown]" */
	subl	$16, %esp
	pushl	$0x005D6E77
	pushl	$0x6F6E6B6E
	pushw	$0x755B
	jmp	.iF86_quit

.iwill:
/* Willamette family (180nm);
 * brand IDs: Pentium 4 -- 0x08 or 0x09, Celeron -- 0x0A, Xeon (also known as
 * Foster) -- 0x0E, Xeon MP (also known as Foster MP) -- 0x0B */
	pushl	$0x00006D6E
	pushl	$0x30383120
	pushl	$0x29657474
	pushl	$0x656D616C
	pushl	$0x6C695728
	movl	$1, %eax
	cpuid
	andb	$0xFF, %bl
	cmpb	$0x08, %bl
	je	.iF86p4
	cmpb	$0x09, %bl
	je	.iF86p4
	cmpb	$0x0A, %bl
	je	.iF86c
	cmpb	$0x0E, %bl
	je	.iF86x
	cmpb	$0x0B, %bl
	je	.iF86xmp
	jmp	.iF86un

.inort:
/* Northwood family (130nm);
 * 1) brand IDs: Pentium 4 -- 0x09 (regular) or 0x0E (mobile), Celeron -- 0x08
 *    (regular) or 0x0F (mobile), Xeon (also known as Prestonia) -- 0x0B;
 * 2) Northwood + T-cache = Gallatin, and there are Xeon MP (brand ID 0x0C)
 *    and Pentium 4 Extreme Edition (brand ID of the regular Pentium 4) */
	pushw	$0x0040
	call	intel_parser
	popw	%dx
	xorw	%dx, %dx
	cmpw	%dx, %ax
	je	.igall
	pushl	$0x0000006D
	pushl	$0x6E303331
	pushl	$0x2029646F
	pushl	$0x6F776874
	pushl	$0x726F4E28
	movl	$1, %eax
	cpuid
	andb	$0xFF, %bl
	cmpb	$0x09, %bl
	je	.iF86p4
	cmpb	$0x0E, %bl
	je	.iF86p4
	cmpb	$0x08, %bl
	je	.iF86c
	cmpb	$0x0F, %bl
	je	.iF86c
	cmpb	$0x0B, %bl
	je	.iF86x
	jmp	.iF86un

.igall:
/* Gallatin subfamily (130nm) */
	pushl	$0x00000000
	pushl	$0x6D6E3033
	pushl	$0x3120296E
	pushl	$0x6974616C
	pushl	$0x6C614728
	movl	$1, %eax
	cpuid
	andb	$0xFF, %bl
	cmpb	$0x09, %bl
	je	.iF86p4ee
	cmpb	$0x0C, %bl
	je	.iF86xmp
	jmp	.iF86un

.ipres:
/* Prescott family (90nm) [initial];
 * brand IDs are no longer supported for some arcane reason */
	pushl	$0x006D6E30
	pushl	$0x39202974
	pushl	$0x746F6373
	pushl	$0x65725028
/* Celeron has S-cache of 256Kb (4-way, 64-byte lines, sectored) */
	pushw	$0x003C
	call	intel_parser
	popw	%dx
	cmpb	$0x3C, %al
	je	.iF86c
/* Pentium 4 has no support for AMD64 (EM64T) */
	movl	$0x80000001, %eax
	cpuid
	testl	$0x20000000, %edx
	jz	.iF86p4
/* must be Xeon (also known as Nocona) */
	jnz	.iF86x

.iprsm:
/* Prescott family (90nm) [continued];
 * there is a real hardware mess, not all processors can be detected for sure,
 * follow with a stepping first */
	movl	%edi, %eax
	shrl	$4, %eax
	andb	$0x0F, %al
	cmpb	$0x01, %al
	je	.ipr1m
	cmpb	$0x03, %al
	je	.ipr2m
	cmpb	$0x04, %al
	je	.ism
	cmpb	$0x08, %al
	je	.ism
	cmpb	$0x09, %al
	je	.ipr1m
	cmpb	$0x0A, %al
	je	.ipr2m
	pushl	$0x00000000
	pushl	$0x6D6E3039
	jmp	.iF86un

.ipr1m:
/* Prescott family (90nm) (includes Nocona and Cranford) */
/* Potomac comes with T-cache */
	pushw	$0x0040
	call	intel_parser
	popw	%dx
	cmpb	$0x40, %al
	je	.iptmc
	pushl	$0x006D6E30
	pushl	$0x39202974
	pushl	$0x746F6373
	pushl	$0x65725028
/* Celeron has S-cache of 256Kb (4-way, 64-byte lines, sectored) */
	pushw	$0x003C
	call	intel_parser
	popw	%dx
	cmpb	$0x3C, %al
	je	.iF86c
/* out of ideas */
 	jne	.iF86p4

.iptmc:
/* Potomac subfamily (90nm) */
	pushl	$0x00006D6E
	pushl	$0x30392029
	pushl	$0x63616D6F
	pushl	$0x746F5028
	jmp	.iF86xmp

.ipr2m:
/* Prescott 2M subfamily (90nm) (includes Irwindale) */
	pushl	$0x00006D6E
	pushl	$0x30392029
	pushl	$0x4D322074
	pushl	$0x746F6373
	pushl	$0x65725028
	jmp	.iF86p4

.ism:
/* Smithfield subfamily (90nm) (dual die Prescott) */
	pushl	$0x0000006D
	pushl	$0x6E303920
	pushl	$0x29646C65
	pushl	$0x69666874
	pushl	$0x696D5328
	jmp	.iF86pd

.icdml:
/* Cedar Mill family (65nm);
 * standard function 4 called with %ecx set to 0 returns the number of cores in
 * %eax [31:26] (1 stands for dual die) */
	movl	$0x00000004, %eax
	xorl	%ecx, %ecx
	cpuid
	shrl	$26, %eax
	cmpb	$0x01, %al
	je	.iprsl
	pushl	$0x0000006D
	pushl	$0x6E353620
	pushl	$0x296C6C69
	pushl	$0x4D207261
	pushl	$0x64654328
/* Celeron has S-cache of 512Kb (8-way, 64-byte lines, sectored) */
	pushw	$0x007B
	call	intel_parser
	popw	%dx
	cmpb	$0x7B, %al
	je	.iF86c
/* must be a Pentium 4 */
	jne	.iF86p4

.iprsl:
/* Presler subfamily (65nm) (dual die Cedar Mill) */
	pushl	$0x00006D6E
	pushl	$0x35362029
	pushl	$0x72656C73
	pushl	$0x65725028
	jmp	.iF86pd

.iF86_quit:
/* "Intel " */
	pushw	$0x206C
	pushl	$0x65746E49
	pushl	%esp
	leal	-112(%ebp), %eax
	pushl	%eax
	call	printf
	leal	40(%esp), %eax
	pushl	%eax
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/*	jmp	.intel_table_quit */

.intel_table_quit:
/* obtain and print processor clock speed if in privileged mode */
	testl	$0x80000000, %edi
	jz	.intel_notsc
	call	caltsc
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.intel_notsc
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_intelname
.intel_notsc:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf

.cpuinfo_intelname:
/* obtain and print a processor's name string if possible;
 * it isn't documented which Intel processors started to support this feature
 * (just "some IA-32 processors"), but it's related very much to what has been
 * implemented in all AMD processors since 1996 with the most noticeable
 * difference that it's hard-coded always */
	movl	$0x80000000, %eax
	cpuid
	cmpl	$0x80000004, %eax
	jb	.cpuinfo_intelcache
	pushl	$0x00000000
	movl	$0x80000004, %eax
	cpuid
	pushl	%edx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	movl	$0x80000003, %eax
	cpuid
	pushl	%edx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	movl	$0x80000002, %eax
	cpuid
	pushl	%edx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
.cpuinfo_intelname_fix:
/* unlike AMD which fills unused remaining bytes with 0x00, Intel pads unused
 * bytes (preceding or in the middle) with 0x20; have to fix that ugliness to
 * some extent in the output */
 	cmpl	$0x20202020, 0(%esp)
	jne	.cpuinfo_intelname_print
	addl	$4, %esp
	jmp	.cpuinfo_intelname_fix
.cpuinfo_intelname_print:
	pushl	%esp
	leal	-388(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_intelcache

.amd_table:
/* AMD processors */
	cmpb	$0x04, %bh
	je	.am486
	cmpb	$0x05, %bh
	je	.am586
	cmpb	$0x06, %bh
	je	.am686
	cmpb	$0x0F, %bh
	je	.amF86
	cmpb	$0x10, %bh
	je	.am1086
	cmpb	$0x11, %bh
	je	.am1186
/* "AMD [unknown]" */
	pushl	$0x0000005D
	pushl	$0x6E776F6E
	pushl	$0x6B6E755B
	pushl	$0x20444D41
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_table_quit

.am486:
	cmpb	$0x03, %bl
	je	.am486dx2
	cmpb	$0x07, %bl
	je	.am486dx2
	cmpb	$0x08, %bl
	je	.am486dx4
	cmpb	$0x09, %bl
	je	.am486dx4
	cmpb	$0x0E, %bl
	je	.am5x86
	cmpb	$0x0F, %bl
	je	.am5x86
/* "[486 class]" */
	pushl	$0x005D7373
	pushl	$0x616C6320
	pushl	$0x3638345B
	jmp	.am486_quit

.am486dx2:
/* "486DX2 0.7u" */
	pushl	$0x0075372E
	pushl	$0x30203258
	pushl	$0x44363834
	jmp	.am486_quit

.am486dx4:
/* "486DX4 0.5u" */
	pushl	$0x0075352E
	pushl	$0x30203458
	pushl	$0x44363834
	jmp	.am486_quit

.am5x86:
/* "5x86 0.35u" */
	pushl	$0x00007535
	pushl	$0x332E3020
	pushl	$0x36387835
/*	jmp	.am486_quit */

.am486_quit:
/* "AMD " */
	pushl	$0x20444D41
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_table_quit

.am586:
	cmpb	$0x00, %bl
	je	.amdssa5
	cmpb	$0x01, %bl
	je	.amd5k86
	cmpb	$0x02, %bl
	je	.amd5k86
	cmpb	$0x03, %bl
	je	.amd5k86
	cmpb	$0x06, %bl
	je	.amdk6
	cmpb	$0x07, %bl
	je	.amdk6a
	cmpb	$0x08, %bl
	je	.amdk62
	cmpb	$0x09, %bl
	je	.amdk63
	cmpb	$0x0D, %bl
	je	.amdk6p
/* "[K5 or K6 class]" */
	pushl	$0x00000000
	pushl	$0x5D737361
	pushl	$0x6C632036
	pushl	$0x4B20726F
	pushl	$0x20354B5B
	jmp	.am586_quit

.amdssa5:
/* "K5 (SSA/5) 350nm" */
	pushl	$0x00000000
	pushl	$0x6D6E3035
	pushl	$0x33202935
	pushl	$0x2F415353
	pushl	$0x2820354B
	jmp	.am586_quit

.amd5k86:
/* "K5 (5k86) 350nm" */
	pushl	$0x006D6E30
	pushl	$0x35332029
	pushl	$0x36386B35
	pushl	$0x2820354B
	jmp	.am586_quit

.amdk6:
/* "K6 350nm" */
	pushl	$0x00000000
	pushl	$0x6D6E3035
	pushl	$0x3320364B
	jmp	.am586_quit

.amdk6a:
/* "K6 250nm" */
	pushl	$0x00000000
	pushl	$0x6D6E3035
	pushl	$0x3220364B
	jmp	.am586_quit

.amdk62:
/* "K6-2 (Chambers) 250nm" */
	pushl	$0x0000006D
	pushl	$0x6E303532
	pushl	$0x20297372
	pushl	$0x65626D61
	pushl	$0x68432820
	pushl	$0x322D364B
	jmp	.am586_quit

.amdk63:
/* "K6-III (Sharptooth) 250nm" */
	pushl	$0x0000006D
	pushl	$0x6E303532
	pushl	$0x20296874
	pushl	$0x6F6F7470
	pushl	$0x72616853
	pushl	$0x28204949
	pushl	$0x492D364B
	jmp	.am586_quit

.amdk6p:
	movl	$0x80000006, %eax
	cpuid
	shrl	$16, %ecx
	cmpw	$256, %cx
	je	.amdk63p
/* "K6-2+ 180nm" */
	pushl	$0x006D6E30
	pushl	$0x3831202B
	pushl	$0x322D364B
	jmp	.am586_quit
.amdk63p:
/* "K6-III+ 180nm" */
	pushl	$0x0000006D
	pushl	$0x6E303831
	pushl	$0x202B4949
	pushl	$0x492D364B
/*	jmp	.am586_quit */

.am586_quit:
/* "AMD " */
	pushl	$0x20444D41
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_table_quit

.am686:
	cmpb	$0x01, %bl
	je	.amdk7
	cmpb	$0x02, %bl
	je	.amdk75
	cmpb	$0x03, %bl
	je	.amdsptf
	cmpb	$0x04, %bl
	je	.amdthdb
	cmpb	$0x06, %bl
	je	.amdplmn
	cmpb	$0x07, %bl
	je	.amdmrgn
	cmpb	$0x08, %bl
	je	.amdthrb
	cmpb	$0x0A, %bl
	je	.amdbrtn
/* "AMD [Athlon class]" */
	pushl	$0x00005D73
	pushl	$0x73616C63
	pushl	$0x206E6F6C
	pushl	$0x6874415B
	pushl	$0x20444D41
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_table_quit

.am686at:
/* "AMD Athlon" */
	subl	$20, %esp
	pushl	$0x00006E6F
	pushl	$0x6C687441
	jmp	.am686_quit

.am686atxp:
/* "AMD Athlon XP" */
	subl	$16, %esp
	pushl	$0x00000050
	pushl	$0x58206E6F
	pushl	$0x6C687441
	jmp	.am686_quit

.am686atmp:
/* "AMD Athlon MP" */
	subl	$16, %esp
	pushl	$0x00000050
	pushl	$0x4D206E6F
	pushl	$0x6C687441
	jmp	.am686_quit

.am686dr:
/* "AMD Duron" */
	subl	$20, %esp
	pushl	$0x0000006E
	pushl	$0x6F727544
	jmp	.am686_quit

.amdk7:
/* K7 family (250nm); Athlons only */
	pushl	$0x00006D6E
	pushl	$0x30353220
	pushl	$0x29374B28
	jmp	.am686at

.amdk75:
/* K75 family (180nm); Athlons only */
	pushl	$0x006D6E30
	pushl	$0x38312029
	pushl	$0x35374B28
	jmp	.am686at

.amdsptf:
/* Spitfire family (180nm); Durons only */
	pushl	$0x00000000
	pushl	$0x6D6E3038
	pushl	$0x31202965
	pushl	$0x72696674
	pushl	$0x69705328
	jmp	.am686dr

.amdthdb:
/* Thunderbird family (180nm); Athlons only */
	pushl	$0x006D6E30
	pushl	$0x38312029
	pushl	$0x64726962
	pushl	$0x7265646E
	pushl	$0x75685428
	jmp	.am686at

.amdplmn:
/* Palomino family (180nm); Athlons, but some cores were offered as Durons,
 * hence with 3/4 of S-cache disabled */
	pushl	$0x00000000
	pushl	$0x6D6E3038
	pushl	$0x3120296F
	pushl	$0x6E696D6F
	pushl	$0x6C615028
	movl	$0x80000006, %eax
	cpuid
	shrl	$16, %ecx
	cmpw	$0x0040, %cx
	je	.am686dr
/* bit 19 of %edx of extended function 1 reports MP capability */
	movl	$0x80000001, %eax
	cpuid
	testl	$0x00080000, %edx
	jnz	.am686atmp
	jz	.am686atxp

.amdmrgn:
/* Morgan family (180nm); Durons only */
	pushl	$0x00006D6E
	pushl	$0x30383120
	pushl	$0x296E6167
	pushl	$0x726F4D28
	jmp	.am686dr

.amdthrb:
/* Thoroughbred family (130nm); Athlons, but some cores were offered as
 * Durons, hence with 3/4 of S-cache disabled (also known as Applebreds) */
	pushl	$0x00000000
	pushl	$0x6D6E3033
	pushl	$0x31202964
	pushl	$0x65726268
	pushl	$0x67756F72
	pushl	$0x6F685428
	movl	$0x80000006, %eax
	cpuid
	shrl	$16, %ecx
	cmpw	$0x0040, %cx
	je	.am686dr
/* bit 19 of %edx of extended function 1 reports MP capability */
	movl	$0x80000001, %eax
	cpuid
	testl	$0x00080000, %edx
	jnz	.am686atmp
	jz	.am686atxp

.amdbrtn:
/* Barton family (130nm); Athlons only, but some cores were sold with 1/2 of
 * S-cache disabled (also known as Thortons) */
	pushl	$0x00006D6E
	pushl	$0x30333120
	pushl	$0x296E6F74
	pushl	$0x72614228
/* bit 19 of %edx of extended function 1 reports MP capability */
	movl	$0x80000001, %eax
	cpuid
	testl	$0x00080000, %edx
	jnz	.am686atmp
	jz	.am686atxp

.am686_quit:
/* "AMD " */
	pushl	$0x20444D41
	pushl	%esp
	leal	-112(%ebp), %eax
	pushl	%eax
	call	printf
	leal	40(%esp), %eax
	pushl	%eax
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_table_quit

.amF86:
/* search for a 8-bit brand ID (standard function 1);
 * 3 most significant bits identify a processor's model, 5 least significant
 * bits represent certain performance-related information */
	xorw	%si, %si
	movl	$1, %eax
	cpuid
	movb	%bl, %cl
	andb	$0xE0, %bl
	shrb	$3, %bl
	andb	$0x1F, %cl
	movb	%cl, %bh
	cmpw	$0x0000, %bx
	cmovaw	%bx, %si
/* search for a 12-bit brand ID (extended function 1);
 * 6 most significant bits identify a processor's model, 6 least significant
 * bits represent certain performance-related information */
	movl	$0x80000001, %eax
	cpuid
	movb	%bl, %cl
	shrw	$6, %bx
	andb	$0x3F, %bl
	andb	$0x3F, %cl
	movb	%cl, %bh
	cmpw	$0x0000, %bx
	cmovaw	%bx, %si
/* divert any DDR capable processor (standard model < 3) */
	movl	%eax, %edx
	shrl	$16, %edx
	cmpb	$0x03, %dl
	jb	.amF86_bid12
/* analyse a complex 20-bit brand ID of DDR2 capable processors;
 * extended function 1 through %ebx [13:9] identifies a processor model,
 * through %ebx [8:6,14] describes a power limit, through %ebx [15,5:0]
 * represents certain performance-related information; in addition, two less
 * significant bits of standard model identify a processor physical package
 * (3 -- Socket AM2, 1 -- Socket F, 0 -- Socket S1) and extended function 8
 * through %ecx [1:0] reports a number of processor cores active (1 -- dual,
 * 0 -- single) */
	xorw	%si, %si
	movl	$0x80000001, %eax
	cpuid
	shrw	$9, %bx
	andw	$0x001F, %bx
	orw	%bx, %si
	shlw	$4, %ax
	andw	$0x0300, %ax
	orw	%ax, %si
	movl	$0x80000008, %eax
	cpuid
	shlw	$12, %cx
	andw	$0x3000, %cx
	orw	%cx, %si
/* reveal a processor's name now */
	cmpw	$0x0301, %si
	je	.amds64
	cmpw	$0x0304, %si
	je	.amda64
	cmpw	$0x0306, %si
	je	.amds64
	cmpw	$0x1301, %si
	je	.amdo64upx2
	cmpw	$0x1304, %si
	je	.amda64x2
	cmpw	$0x1305, %si
	je	.amda64fx
	cmpw	$0x1101, %si
	je	.amdo64dpx2
	cmpw	$0x1104, %si
	je	.amdo64mpx2
	cmpw	$0x1002, %si
	je	.amdt64x2
/* "[Athlon 64 class]" */
	pushl	$0x0000005D
	pushl	$0x7373616C
	pushl	$0x63203436
	pushl	$0x206E6F6C
	pushl	$0x6874415B
	jmp	.amF86cont

.amF86_bid12:
/* find out a processor's name by the brand ID */
	movw	%si, %ax
	cmpb	$0x0C, %al
	je	.amdo64up
	cmpb	$0x0D, %al
	je	.amdo64up
	cmpb	$0x0E, %al
	je	.amdo64up
	cmpb	$0x0F, %al
	je	.amdo64up
	cmpb	$0x10, %al
	je	.amdo64dp
	cmpb	$0x11, %al
	je	.amdo64dp
	cmpb	$0x12, %al
	je	.amdo64dp
	cmpb	$0x13, %al
	je	.amdo64dp
	cmpb	$0x14, %al
	je	.amdo64mp
	cmpb	$0x15, %al
	je	.amdo64mp
	cmpb	$0x16, %al
	je	.amdo64mp
	cmpb	$0x17, %al
	je	.amdo64mp
	cmpb	$0x24, %al
	je	.amda64fx
	cmpb	$0x04, %al
	je	.amda64
	cmpb	$0x08, %al
	je	.amda64
	cmpb	$0x09, %al
	je	.amda64
	cmpb	$0x18, %al
	je	.amda64
	cmpb	$0x21, %al
	je	.amds64
	cmpb	$0x22, %al
	je	.amds64
	cmpb	$0x23, %al
	je	.amds64
	cmpb	$0x26, %al
	je	.amds64
	cmpb	$0x0A, %al
	je	.amdt64
	cmpb	$0x0B, %al
	je	.amdt64
	cmpb	$0x29, %al
	je	.amdo64upx2
	cmpb	$0x2C, %al
	je	.amdo64upx2
	cmpb	$0x2D, %al
	je	.amdo64upx2
	cmpb	$0x2E, %al
	je	.amdo64upx2
	cmpb	$0x2F, %al
	je	.amdo64upx2
	cmpb	$0x38, %al
	je	.amdo64upx2
	cmpb	$0x2A, %al
	je	.amdo64dpx2
	cmpb	$0x30, %al
	je	.amdo64dpx2
	cmpb	$0x31, %al
	je	.amdo64dpx2
	cmpb	$0x32, %al
	je	.amdo64dpx2
	cmpb	$0x33, %al
	je	.amdo64dpx2
	cmpb	$0x39, %al
	je	.amdo64dpx2
	cmpb	$0x2B, %al
	je	.amdo64mpx2
	cmpb	$0x34, %al
	je	.amdo64mpx2
	cmpb	$0x35, %al
	je	.amdo64mpx2
	cmpb	$0x36, %al
	je	.amdo64mpx2
	cmpb	$0x37, %al
	je	.amdo64mpx2
	cmpb	$0x3A, %al
	je	.amdo64mpx2
	cmpb	$0x05, %al
	je	.amda64x2
	cmpb	$0x02, %al
	je	.amdt64x2
/* "[Athlon 64 class]" */
	pushl	$0x0000005D
	pushl	$0x7373616C
	pushl	$0x63203436
	pushl	$0x206E6F6C
	pushl	$0x6874415B
	jmp	.amF86cont

.amdo64up:
/* "Opteron UP" */
	pushl	$0x00005055
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.amF86cont

.amdo64dp:
/* "Opteron DP" */
	pushl	$0x00005044
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.amF86cont

.amdo64mp:
/* "Opteron MP" */
	pushl	$0x0000504D
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.amF86cont

.amda64fx:
/* "Athlon 64 FX" */
	pushl	$0x00000000
	pushl	$0x58462034
	pushl	$0x36206E6F
	pushl	$0x6C687441
	jmp	.amF86cont

.amda64:
/* "Athlon 64" */
	pushl	$0x00000034
	pushl	$0x36206E6F
	pushl	$0x6C687441
	jmp	.amF86cont

.amds64:
/* "Sempron" */
	pushl	$0x006E6F72
	pushl	$0x706D6553
	jmp	.amF86cont

.amdt64:
/* "Turion" */
	pushl	$0x00006E6F
	pushl	$0x69727554
	jmp	.amF86cont

.amdo64upx2:
/* "Opteron UP X2" */
	pushl	$0x00000032
	pushl	$0x58205055
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.amF86cont

.amdo64dpx2:
/* "Opteron DP X2" */
	pushl	$0x00000032
	pushl	$0x58205044
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.amF86cont

.amdo64mpx2:
/* "Opteron MP X2" */
	pushl	$0x00000032
	pushl	$0x5820504D
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.amF86cont

.amda64x2:
/* "Athlon 64 X2" */
	pushl	$0x00000000
	pushl	$0x32582034
	pushl	$0x36206E6F
	pushl	$0x6C687441
	jmp	.amF86cont

.amdt64x2:
/* "Turion X2" */
	pushl	$0x00000032
	pushl	$0x58206E6F
	pushl	$0x69727554
	jmp	.amF86cont

.amF86cont:
/* "AMD " */
	pushl	$0x20444D41
	pushl	%esp
	leal	-112(%ebp), %eax
	pushl	%eax
	call	printf
/* identify by extended model */
	movw	%di, %ax
	shrw	$8, %ax
	cmpb	$0x04, %al
	je	.amdclaw
	cmpb	$0x05, %al
	je	.amdsldg
	cmpb	$0x07, %al
	je	.amdclaw
	cmpb	$0x08, %al
	je	.amdnewc
	cmpb	$0x0B, %al
	je	.amdnewc
	cmpb	$0x0C, %al
	je	.amdnewc
	cmpb	$0x0E, %al
	je	.amdnewc
	cmpb	$0x0F, %al
	je	.amdnewc
	cmpb	$0x14, %al
	je	.amdwnch
	cmpb	$0x15, %al
	je	.amdwnch
	cmpb	$0x17, %al
	je	.amdwnch
	cmpb	$0x18, %al
	je	.amdwnch
	cmpb	$0x1B, %al
	je	.amdwnch
	cmpb	$0x1C, %al
	je	.amdwnch
	cmpb	$0x1F, %al
	je	.amdwnch
	cmpb	$0x21, %al
	je	.amdegpt
	cmpb	$0x23, %al
	je	.amdtold
	cmpb	$0x24, %al
	je	.amdvenc
	cmpb	$0x25, %al
	je	.amdathn
	cmpb	$0x27, %al
	je	.amdsand
	cmpb	$0x2B, %al
	je	.amdmnch
	cmpb	$0x2C, %al
	je	.amdvenc
	cmpb	$0x2F, %al
	je	.amdvenc
	cmpb	$0x41, %al
	je	.amdrosa
	cmpb	$0x43, %al
	je	.amdwdsr
	cmpb	$0x48, %al
	je	.amdwdsr
	cmpb	$0x4B, %al
	je	.amdwdsr
	cmpb	$0x4C, %al
	je	.amdwdsr
	cmpb	$0x4F, %al
	je	.amdorln
	cmpb	$0x5F, %al
	je	.amdorln
	cmpb	$0x68, %al
	je	.amdbrsb
	cmpb	$0x6B, %al
	je	.amdbrsb
	cmpb	$0x7F, %al
	je	.amdlima
/* "(unknown)" */
	pushl	$0x00000029
	pushl	$0x6E776F6E
	pushl	$0x6B6E7528
	jmp	.amF86_quit

.amdclaw:
/* Clawhammer family (130nm);
 * CPUID steppings and related core revisions:
 * 0 -- B0, 1 -- B3, 8 -- C0, A -- C3 */
	pushl	$0x00006D6E
	pushl	$0x30333120
	pushl	$0x2972656D
	pushl	$0x6D616877
	pushl	$0x616C4328
	jmp	.amF86_quit

.amdsldg:
/* Sledgehammer family (130nm);
 * CPUID steppings and related core revisions:
 * 0 -- B0, 8 -- C0, A -- CG */
	pushl	$0x00000000
	pushl	$0x6D6E3033
	pushl	$0x31202972
	pushl	$0x656D6D61
	pushl	$0x68656764
	pushl	$0x656C5328
	jmp	.amF86_quit

.amdnewc:
/* Newcastle family (130nm);
 * all processors are of CG core revision */
	pushl	$0x0000006D
	pushl	$0x6E303331
	pushl	$0x2029656C
	pushl	$0x74736163
	pushl	$0x77654E28
	jmp	.amF86_quit

.amdwnch:
/* Winchester family (90nm);
 * all processors are of D0 core revision */
	pushl	$0x0000006D
	pushl	$0x6E303920
	pushl	$0x29726574
	pushl	$0x73656863
	pushl	$0x6E695728
	jmp	.amF86_quit

.amdegpt:
/* Egypt family (90nm) (includes Italy);
 * CPUID steppings and related core revisions:
 * 0 -- E1, 2 -- E6 */
	orl	$0x00110000, %esi
	pushl	$0x00000000
	pushl	$0x6D6E3039
	pushl	$0x20297470
	pushl	$0x79674528
	jmp	.amF86_quit

.amdtold:
/* Toledo family (90nm) (includes Denmark);
 * all processors are of E6 core revision */
	orl	$0x00110000, %esi
	pushl	$0x0000006D
	pushl	$0x6E303920
	pushl	$0x296F6465
	pushl	$0x6C6F5428
	jmp	.amF86_quit

.amdathn:
/* Athens family (90nm) (includes Troy);
 * all processors are of E4 core revision */
	pushl	$0x0000006D
	pushl	$0x6E303920
	pushl	$0x29736E65
	pushl	$0x68744128
	jmp	.amF86_quit

.amdsand:
/* San Diego family (90nm) (includes Venus);
 * all processors are of E4 core revision */
	pushl	$0x00000000
	pushl	$0x6D6E3039
	pushl	$0x20296F67
	pushl	$0x65694420
	pushl	$0x6E615328
	jmp	.amF86_quit

.amdmnch:
/* Manchester family (90nm);
 * all processors are of E4 core revision */
	orl	$0x00110000, %esi
	pushl	$0x0000006D
	pushl	$0x6E303920
	pushl	$0x29726574
	pushl	$0x73656863
	pushl	$0x6E614D28
	jmp	.amF86_quit

.amdvenc:
/* Venice family (90nm) (includes Lancaster);
 * CPUID steppings and related core revisions:
 * 0 -- E3, 2 -- E5 (mobile) or E6 (regular) */
	pushl	$0x0000006D
	pushl	$0x6E303920
	pushl	$0x29656369
	pushl	$0x6E655628
	jmp	.amF86_quit

.amdrosa:
/* Santa Rosa family (90nm) */
	orl	$0x00110000, %esi
	pushl	$0x0000006D
	pushl	$0x6E303920
	pushl	$0x2961736F
	pushl	$0x52206174
	pushl	$0x6E615328
	jmp	.amF86_quit

.amdwdsr:
/* Windsor family (90nm) (includes Santa Ana and Taylor) */
	orl	$0x00110000, %esi
	pushl	$0x00006D6E
	pushl	$0x30392029
	pushl	$0x726F7364
	pushl	$0x6E695728
	jmp	.amF86_quit

.amdorln:
/* Orleans family (90nm) */
	pushl	$0x00006D6E
	pushl	$0x30392029
	pushl	$0x736E6165
	pushl	$0x6C724F28
	jmp	.amF86_quit

.amdbrsb:
/* Brisbane family (65nm) (includes Tyler) */
	orl	$0x00110000, %esi
	pushl	$0x006D6E35
	pushl	$0x36202965
	pushl	$0x6E616273
	pushl	$0x69724228
	jmp	.amF86_quit

.amdlima:
/* Lima family (65nm) (includes Sparta) */
	pushl	$0x006D6E35
	pushl	$0x36202961
	pushl	$0x6D694C28
/*	jmp	.amF86_quit */

.amF86_quit:
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_table_quit

.am1086:
/* analyse a complex 28-bit brand ID;
 * extended function 1 reports the following 5 fields through %ebx:
 * [3:0] -- power limit, [10:4] -- performance data, [14:11] -- processor
 * model, [15] -- page index, [31:28] -- processor physical package (1 --
 * Socket AM2, 0 -- Socket F); in addition, extended function 8 through
 * %ecx [7:0] reports a number of processor physical cores minus one */
	xorw	%si, %si
	movl	$0x80000001, %eax
	cpuid
	movl	%ebx, %edx
	shrw	$11, %dx
	andw	$0x000F, %dx
	orw	%dx, %si
	shrl	$24, %ebx
	andw	$0x00F0, %bx
	orw	%bx, %si
	movl	$0x80000008, %eax
	cpuid
	shlw	$8, %cx
	andw	$0xFF00, %cx
	orw	%cx, %si
/* reveal a processor name now */
	cmpw	$0x0300, %si
	je	.amdophmpx4
	cmpw	$0x0301, %si
	je	.amdophdpx4
	cmpw	$0x0302, %si
	je	.amdophmpx4
	cmpw	$0x0500, %si
	je	.amdophmpx6
	cmpw	$0x0501, %si
	je	.amdophdpx6
	cmpw	$0x0111, %si
	je	.amdphx2
	cmpw	$0x0113, %si
	je	.amdphiix2
	cmpw	$0x0117, %si
	je	.amdphiix2
	cmpw	$0x0210, %si
	je	.amdphx3
	cmpw	$0x0218, %si
	je	.amdphiix3
	cmpw	$0x0310, %si
	je	.amdophupx4
	cmpw	$0x0311, %si
	je	.amdphx4
	cmpw	$0x0312, %si
	je	.amdphx4
	cmpw	$0x0313, %si
	je	.amdphiix4
	cmpw	$0x0314, %si
	je	.amdphiix4
/* "[Phenom class]" */
	pushl	$0x00005D73
	pushl	$0x73616C63
	pushl	$0x206D6F6E
	pushl	$0x6568505B
	jmp	.am1086cont

.amdophupx4:
/* "Opteron UP X4" */
	orl	$0x00330000, %esi
	pushl	$0x00000034
	pushl	$0x58205055
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.am1086cont

.amdophdpx4:
/* "Opteron DP X4" */
	orl	$0x00330000, %esi
	pushl	$0x00000034
	pushl	$0x58205044
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.am1086cont

.amdophmpx4:
/* "Opteron MP X4" */
	orl	$0x00330000, %esi
	pushl	$0x00000034
	pushl	$0x5820504D
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.am1086cont

.amdophdpx6:
/* "Opteron DP X6" */
	orl	$0x00550000, %esi
	pushl	$0x00000036
	pushl	$0x58205044
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.am1086cont

.amdophmpx6:
/* "Opteron MP X6" */
	orl	$0x00550000, %esi
	pushl	$0x00000036
	pushl	$0x5820504D
	pushl	$0x206E6F72
	pushl	$0x6574704F
	jmp	.am1086cont

.amdphx2:
/* "Phenom X2" */
	orl	$0x00110000, %esi
	pushl	$0x00000032
	pushl	$0x58206D6F
	pushl	$0x6E656850
	jmp	.am1086cont

.amdphx3:
/* "Phenom X3" */
	orl	$0x00220000, %esi
	pushl	$0x00000033
	pushl	$0x58206D6F
	pushl	$0x6E656850
	jmp	.am1086cont

.amdphx4:
/* "Phenom X4" */
	orl	$0x00330000, %esi
	pushl	$0x00000034
	pushl	$0x58206D6F
	pushl	$0x6E656850
	jmp	.am1086cont

.amdphiix2:
/* "Phenom II X2" */
	orl	$0x00110000, %esi
	pushl	$0x00000000
	pushl	$0x32582049
	pushl	$0x49206D6F
	pushl	$0x6E656850
	jmp	.am1086cont

.amdphiix3:
/* "Phenom II X3" */
	orl	$0x00220000, %esi
	pushl	$0x00000000
	pushl	$0x33582049
	pushl	$0x49206D6F
	pushl	$0x6E656850
	jmp	.am1086cont

.amdphiix4:
/* "Phenom II X4" */
	orl	$0x00330000, %esi
	pushl	$0x00000000
	pushl	$0x34582049
	pushl	$0x49206D6F
	pushl	$0x6E656850
	jmp	.am1086cont

.am1086cont:
/" "AMD " */
	pushl	$0x20444D41
	pushl	%esp
	leal	-112(%ebp), %eax
	pushl	%eax
	call	printf
/* identify by standard model for now */
	movw	%di, %ax
	shrw	$8, %ax
	andb	$0x0F, %al
	cmpb	$0x02, %al
	je	.amdbarc
	cmpb	$0x04, %al
	je	.amdshan
	cmpb	$0x06, %al
	je	.amdistn
/* "(unknown)" */
	pushl	$0x00000029
	pushl	$0x6E776F6E
	pushl	$0x6B6E7528
	jmp	.am1086_quit

.amdbarc:
/* Barcelona family (65nm) (includes Agena, Toliman and Kuma);
 * CPUID steppings and related core revisions:
 * 2 -- B2, 3 -- B3, A -- BA */
	pushl	$0x00000000
	pushl	$0x6D6E3536
	pushl	$0x2029616E
	pushl	$0x6F6C6563
	pushl	$0x72614228
	jmp	.am1086_quit

.amdshan:
/* Shanghai family (45nm) (includes Deneb and Heka);
 * CPUID steppings and related core revisions:
 * 1 -- C1, 2 -- C2 */
	pushl	$0x006D6E35
	pushl	$0x34202969
	pushl	$0x6168676E
	pushl	$0x61685328
	jmp	.am1086_quit

.amdistn:
/* Istanbul family (45nm);
 * CPUID steppings and related core revisions:
 * 2 -- C2, 0 -- D0 */
	pushl	$0x006D6E35
	pushl	$0x3420296C
	pushl	$0x75626E61
	pushl	$0x74734928
/*	jmp	.am1086_quit */

.am1086_quit:
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_table_quit

.am1186:
/* analyse a complex 28-bit brand ID which is very much like in family 10
 * except of processor physical package (2 -- Socket S1) */
	xorw	%si, %si
	movl	$0x80000001, %eax
	cpuid
	movl	%ebx, %edx
	shrw	$11, %dx
	andw	$0x000F, %dx
	orw	%dx, %si
	shrl	$24, %ebx
	andw	$0x00F0, %bx
	orw	%bx, %si
	movl	$0x80000008, %eax
	cpuid
	shlw	$8, %cx
	andw	$0xFF00, %cx
	orw	%cx, %si
/* reveal a processor name now */
	cmpw	$0x0020, %si
	je	.amdsem
	cmpw	$0x0120, %si
	je	.amdturx2
	cmpw	$0x0121, %si
	je	.amdturx2
	cmpw	$0x0122, %si
	je	.amdathx2
/* "[Puma class]" */
	pushl	$0x00000000
	pushl	$0x5D737361
	pushl	$0x6C632061
	pushl	$0x6D75505B
	jmp	.am1186cont

.amdsem:
/* "Sempron" */
	pushl	$0x006E6F72
	pushl	$0x706D6553
	jmp	.am1186cont

.amdturx2:
/* "Turion X2" */
	orl	$0x00110000, %esi
	pushl	$0x00000032
	pushl	$0x58206E6F
	pushl	$0x69727554
	jmp	.am1186cont

.amdathx2:
/* "Athlon X2" */
	orl	$0x00110000, %esi
	pushl	$0x00000032
	pushl	$0x58206E6F
	pushl	$0x6C687441
	jmp	.am1186cont

.am1186cont:
/" "AMD " */
	pushl	$0x20444D41
	pushl	%esp
	leal	-112(%ebp), %eax
	pushl	%eax
	call	printf
/* identify by standard model for now */
	movw	%di, %ax
	shrw	$8, %ax
	andb	$0x0F, %al
	cmpb	$0x03, %al
	je	.amdgrif
/* "(unknown)" */
	pushl	$0x00000029
	pushl	$0x6E776F6E
	pushl	$0x6B6E7528
	jmp	.am1186_quit

.amdgrif:
/* Griffin family (65nm);
 * CPUID steppings and related core revisions:
 * 1 -- B1 */
	pushl	$0x00006D6E
	pushl	$0x35362029
	pushl	$0x6E696666
	pushl	$0x69724728
/*	jmp	.am1186_quit */

.am1186_quit:
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/*	jmp	.amd_table_quit */

.amd_table_quit:
/* obtain and print processor clock speed if in privileged mode */
	testl	$0x80000000, %edi
	jz	.amd_notsc
	call	caltsc
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.amd_notsc
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_amdname
.amd_notsc:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf

.cpuinfo_amdname:
/* obtain and print a processor's name string if possible;
 * the K5 and K6 family processors (excluding K5 model 0) contained those
 * name strings hard-coded, the Athlon family ones (excluding model 1) allowed
 * them additionally to be changed in software (say, by BIOS or OS) though use
 * of special MSRs (0xC0010030 to 0xC0010035), and the Athlon 64 family ones
 * contained no strings (all symbols are set to 0x00) but required them to be
 * constructed and programmed by BIOS in a recommended manner */
	movl	$0x80000000, %eax
	cpuid
	cmpl	$0x80000004, %eax
	jb	.cpuinfo_amdcache
	pushl	$0x00000000
	movl	$0x80000004, %eax
	cpuid
	pushl	%edx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	movl	$0x80000003, %eax
	cpuid
	pushl	%edx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	movl	$0x80000002, %eax
	cpuid
	pushl	%edx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	pushl	%esp
	leal	-388(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_amdcache

.cyrix_table:
/* Cyrix processors;
 * 1) most CPUs don't support CPUID at all, and even those which do may have
 *    it disabled after reset (bit 7 of %ccr4 set to 0);
 * 2) on the other hand, all CPUs support vendor-specific registers, DIR0 and
 *    DIR1, which should be used instead of CPUID;
 * 3) CPUs, though designed by Cyrix, were manufactured by IBM, NSC, Texas
 *    Instruments and SGS-Thomson using different technological processes,
 *    probably detectable via DIR1 but that information is missing;
 * 4) only GXm and GXlv support standard function 2 and extended functions 0
 *    to 5, and their derivatives too (NSC Geode GX1 and GX2);
 * 5) some VIA C3 CPUs were promoted as "Cyrix III" and carried "CyrixInstead"
 *    vendor ID, though in fact they were derivatives of the IDT C6 line and
 *    should be treated accordingly. */
/* use DIRs rather than CPUID in privileged mode */
	testl	$0x80000000, %edi
	jnz	.cyrix_dir
/* redirect to DIR-related data otherwise */
	cmpb	$0x44, %bl
	je	.cxmgx
	cmpb	$0x94, %bl
	je	.cxm1sc
	cmpb	$0x05, %bl
	je	.cxm1
	cmpb	$0x25, %bl
	je	.cxm1l
	cmpb	$0x45, %bl
	je	.cxgxm
	cmpb	$0x06, %bl
	je	.cxm2
	cmpb	$0x66, %bl
	je	.cntsam
	cmpb	$0x76, %bl
	je	.cntsam2
	pushl	$0x0000005D
	pushl	$0x6E776F6E
	pushl	$0x6B6E755B
	jmp	.cyrix_dir_quit

.centaur_table:
/* Centaur processors;
 * Centaur was a subsidiary of IDT, and after that of VIA, so its processors
 * were promoted under their brands, though carried the same vendor ID */
	movb	%bl, %al
	andb	$0x0F, %al
	cmpb	$0x05, %al
	je	.cnt586
	cmpb	$0x06, %al
	je	.cnt686
	pushl	$0x0000005D
	pushl	$0x6E776F6E
	pushl	$0x6B6E755B
	jmp	.via_table_quit

.cnt586:
	movb	%bl, %al
	shrb	$4, %al
	andb	$0x0F, %al
	cmpb	$0x04, %al
	je	.cntc6
	cmpb	$0x08, %al
	je	.cntc6p
	cmpb	$0x09, %al
	je	.cntc6pp
	pushl	$0x0000005D
	pushl	$0x36383520
	pushl	$0x6E776F6E
	pushl	$0x6B6E755B
	jmp	.idt_table_quit

.cntc6:
	pushl	$0x00007535
	pushl	$0x332E3020
	pushl	$0x29364328
	pushl	$0x20706968
	pushl	$0x436E6957
	jmp	.idt_table_quit

.cntc6p:
/* was either 0.35u or 0.25u */
	pushl	$0x00753532
	pushl	$0x2E302D75
	pushl	$0x35332E30
	pushl	$0x20292B36
	pushl	$0x43282032
	pushl	$0x20706968
	pushl	$0x436E6957
	jmp	.idt_table_quit

.cntc6pp:
	pushl	$0x00753532
	pushl	$0x2E302033
	pushl	$0x20706968
	pushl	$0x436E6957
	jmp	.idt_table_quit

.cnt686:
	movb	%bl, %al
	shrb	$4, %al
	andb	$0x0F, %al
	cmpb	$0x06, %al
	jmp	.cntsam
	cmpb	$0x07, %al
	je	.cntsam2
	cmpb	$0x08, %al
	je	.cntezrt
	cmpb	$0x09, %al
	je	.cntnehm
	pushl	$0x0000005D
	pushl	$0x36383620
	pushl	$0x6E776F6E
	pushl	$0x6B6E755B
	jmp	.via_table_quit

.cntsam:
	pushl	$0x00000075
	pushl	$0x38312E30
	pushl	$0x20296C65
	pushl	$0x756D6153
	pushl	$0x28203343
	jmp	.via_table_quit

.cntsam2:
/* Samuel has steppings < 8, while Ezra >= 8
 * (from "VIA C3 Ezra Processor Datasheet") */
	movw	%bx, %ax
	shrw	$8, %ax
	cmpb	$8, %al
	jae	.cntezr
	pushl	$0x00753531
	pushl	$0x2E302029
	pushl	$0x32206C65
	pushl	$0x756D6153
	pushl	$0x28203343
	jmp	.via_table_quit
.cntezr:
	pushl	$0x00753531
	pushl	$0x2E302029
	pushl	$0x61727A45
	pushl	$0x28203343
	jmp	.via_table_quit

.cntezrt:
	pushl	$0x00000075
	pushl	$0x33312E30
	pushl	$0x2029542D
	pushl	$0x61727A45
	pushl	$0x28203343
	jmp	.via_table_quit

.cntnehm:
	pushl	$0x00753331
	pushl	$0x2E302029
	pushl	$0x6861696D
	pushl	$0x6568654E
	pushl	$0x28203343
	jmp	.via_table_quit

.idt_table_quit:
	pushl	$0x20544449
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* obtain and print processor clock speed if in privileged mode */
	testl	$0x80000000, %edi
	jz	.idt_notsc
	call	caltsc
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.idt_notsc
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_amdcache
.idt_notsc:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_amdcache

.via_table_quit:
	pushl	$0x20414956
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* obtain and print processor clock speed if in privileged mode */
	testl	$0x80000000, %edi
	jz	.via_notsc
	call	caltsc
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.via_notsc
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_amdcache
.via_notsc:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_amdcache

.trmeta_table:
/* Transmeta processors */
	movb	%bl, %al
	cmpb	$0x45, %al
	je	.tmcrus
	pushl	$0x005D6E77
	pushl	$0x6F6E6B6E
	pushl	$0x755B2061
	pushl	$0x74656D73
	pushl	$0x6E617254
	jmp	.trmeta_table_quit

.tmcrus:
	pushl	$0x00000000
	pushl	$0x656F7375
	pushl	$0x72432061
	pushl	$0x74656D73
	pushl	$0x6E617254

.trmeta_table_quit:
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* obtain and print processor clock speed if in privileged mode */
	testl	$0x80000000, %edi
	jz	.trmeta_notsc
	call	caltsc
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.trmeta_notsc
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit
.trmeta_notsc:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

.rise_table:
/* Rise processors;
 * (from "Rise iDragon mP6 Microprocessor Data Sheet") */
	cmpb	$0x05, %bl
	je	.rsfrst
	cmpb	$0x25, %bl
	je	.rskirn
	pushl	$0x00005D6E
	pushl	$0x776F6E6B
	pushl	$0x6E755B20
	pushl	$0x65736952
	jmp	.rise_table_quit

.rsfrst:
	pushl	$0x00007535
	pushl	$0x322E3020
	pushl	$0x36506D20
	pushl	$0x6E6F6761
	pushl	$0x72446920
	pushl	$0x65736952
	jmp	.rise_table_quit

.rskirn:
	pushl	$0x00007538
	pushl	$0x312E3020
	pushl	$0x296E6972
	pushl	$0x694B2820
	pushl	$0x36506D20
	pushl	$0x6E6F6761
	pushl	$0x72446920
	pushl	$0x65736952

.rise_table_quit:
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* obtain and print processor clock speed if in privileged mode */
	testl	$0x80000000, %edi
	jz	.rise_notsc
	call	caltsc
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.rise_notsc
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit
.rise_notsc:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

.nexgen_table:
/* NexGen processors;
 * both 586 and 586FP have no hardware logic to support CPUID, but BIOS may
 * load an appropriate emulating microcode on start-up */
/* nothing to do here, go to the non-CPUID data */
	jmp	.nx586_print

.umc_table:
/* UMC processors */
	cmpb	$0x14, %bl
	je	.u5dx
	cmpb	$0x24, %bl
	je	.u5sx
	pushl	$0x0000005D
	pushl	$0x6E776F6E
	pushl	$0x6B6E755B
	jmp	.umc_table_quit

.u5dx:
	pushl	$0x00000075
	pushl	$0x362E3020
	pushl	$0x58443555
	jmp	.umc_table_quit

.u5sx:
	pushl	$0x00000075
	pushl	$0x362E3020
	pushl	$0x58533555

.umc_table_quit:
	pushl	$0x20434D55
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* obtain and print processor clock speed if in privileged mode;
 * TSC is unsupported, but may calculate alternatively
 * (no datasheet, estimated empirically) */
	testl	$0x80000000, %edi
	jz	.umc_nocnt
	pushw	$4
	call	calcnt
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.umc_nocnt
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit
.umc_nocnt:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

/* NSC (National Semiconductor) processors;
 * 1) only GX1 and GX2 are "Geode by NSC", others are "CyrixInstead";
 * 2) the whole processor department was sold to AMD in August of 2003. */
.nsc_table:
	cmpb	$0x45, %bl
	je	.nsgx1
	cmpb	$0x55, %bl
	je	.nsgx2
	pushl	$0x0000005D
	pushl	$0x6E776F6E
	pushl	$0x6B6E755B
	jmp	.nsc_table_quit

.nsgx1:
	pushl	$0x00753831
	pushl	$0x2E302031
	pushl	$0x58472065
	pushl	$0x646F6547
	jmp	.nsc_table_quit

.nsgx2:
	pushl	$0x00753331
	pushl	$0x2E302032
	pushl	$0x58472065
	pushl	$0x646F6547

.nsc_table_quit:
	pushl	$0x2043534E
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* obtain and print processor clock speed if in privileged mode */
	testl	$0x80000000, %edi
	jz	.nsc_notsc
	call	caltsc
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.nsc_notsc
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit
.nsc_notsc:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

.sis_table:
/* SiS processors;
 * a family of single-chip computer designs based upon the Rise mP6 core
 * (licenced to SiS in October of 1999) */
	pushl	$0x00000036
	pushl	$0x38783535
	pushl	$0x20536953
	pushl	%esp
	leal	-92(%ebp), %eax
	pushl	%eax
	call	printf
/* obtain and print processor clock speed if in privileged mode */
	testl	$0x80000000, %edi
	jz	.sis_notsc
	call	caltsc
	xorl	%edx, %edx
	cmpl	%edx, %eax
	je	.sis_notsc
	movl	$1000, %ecx
	divl	%ecx
	pushl	%edx
	pushl	%eax
	leal	-104(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit
.sis_notsc:
	leal	-108(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

/* obtain and print Intel extended information;
 * NOTE: implemented in Pentium Pro and up the way (from "Intel Processor
 *       Identification and the CPUID Instruction Application Note") */
.cpuinfo_intelcache:
	movl	$2, %eax
	cpuid
	movl	%eax, %edx
	andw	$0x00FF, %dx
	cmpw	$0x0000, %dx
	je	.cpuinfo_main_exit

/* Intel I-cache (in uops); trace cache actually */
	xorl	%ebx, %ebx
	pushw	$0x0070
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_tr1
	pushl	$0x00000008
	pushl	$0x0000000C
	jmp	.intel_trcache_print

.intel_tr1:
	pushw	$0x0071
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_tr2
	pushl	$0x00000008
	pushl	$0x00000010
	jmp	.intel_trcache_print

.intel_tr2:
	pushw	$0x0072
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_tr3
	pushl	$0x00000008
	pushl	$0x00000020
	jmp	.intel_trcache_print

.intel_tr3:
	pushw	$0x0073
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_icache
	pushl	$0x00000008
	pushl	$0x00000040
	jmp	.intel_trcache_print

.intel_trcache_print:
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_trcache_print_1x
	pushl	$2
	leal	-144(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_dcache
.intel_trcache_print_1x:
	leal	-140(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_dcache

.intel_icache:
/* Intel I-cache (in bytes) */
	xorl	%ebx, %ebx
	pushw	$0x0006
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_i1
	pushl	$0x00000020
	pushl	$0x00000004
	pushl	$0x00000008
	jmp	.intel_icache_print

.intel_i1:
	pushw	$0x0008
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_i2
	pushl	$0x00000020
	pushl	$0x00000004
	pushl	$0x00000010
	jmp	.intel_icache_print

.intel_i2:
	pushw	$0x0009
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_i3
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000020
	jmp	.intel_icache_print

.intel_i3:
	pushw	$0x0030
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_iunknown
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000020
	jmp	.intel_icache_print

.intel_iunknown:
	pushl	$0x00000049
	leal	-216(%ebp), %eax
	call	printf
	jmp	.intel_dcache

.intel_icache_print:
	pushl	$0x00000049
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_icache_print_1x
	incl	%eax
	pushl	%eax
	leal	-192(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_dcache
.intel_icache_print_1x:
	leal	-188(%ebp), %eax
	pushl	%eax
	call	printf

.intel_dcache:
/* Intel D-cache */
	xorl	%ebx, %ebx
	pushw	$0x000A
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_d1
	pushl	$0x00000020
	pushl	$0x00000002
	pushl	$0x00000008
	jmp	.intel_dcache_print

.intel_d1:
	pushw	$0x000C
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_d2
	pushl	$0x00000020
	pushl	$0x00000004
	pushl	$0x00000010
	jmp	.intel_dcache_print

.intel_d2:
	pushw	$0x000D
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_d3
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000010
	jmp	.intel_dcache_print

.intel_d3:
	pushw	$0x002C
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_d4
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000020
	jmp	.intel_dcache_print

.intel_d4:
	pushw	$0x0060
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_d5
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000010
	jmp	.intel_dcache_print

.intel_d5:
	pushw	$0x0066
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_d6
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000008
	jmp	.intel_dcache_print

.intel_d6:
	pushw	$0x0067
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_d7
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000010
	jmp	.intel_dcache_print

.intel_d7:
	pushw	$0x0068
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dunknown
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000020
	jmp	.intel_dcache_print

.intel_dunknown:
	pushl	$0x00000044
	leal	-216(%ebp),%eax
	pushl	%eax
	call	printf
	jmp	.intel_itlb_4k

.intel_dcache_print:
	pushl	$0x00000044
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_dcache_print_1x
	incl	%eax
	pushl	%eax
	leal	-192(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_itlb_4k
.intel_dcache_print_1x:
	leal	-188(%ebp), %eax
	pushl	%eax
	call	printf

.intel_itlb_4k:
/* Intel I-TLB (4Kb pages) */
	xorl	%ebx, %ebx
	pushw	$0x0001
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_it1_4k
	pushl	$0x00000004
	pushl	$0x00000020
	jmp	.intel_itlb_print_4k

.intel_it1_4k:
	pushw	$0x0050
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_it2_4k
	pushl	$0x00000040
	pushl	$0x00000040
	jmp	.intel_itlb_print_4k

.intel_it2_4k:
	pushw	$0x0051
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_it3_4k
	pushl	$0x00000080
	pushl	$0x00000080
	jmp	.intel_itlb_print_4k

.intel_it3_4k:
	pushw	$0x0052
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_it4_4k
	pushl	$0x00000100
	pushl	$0x00000100
	jmp	.intel_itlb_print_4k

.intel_it4_4k:
	pushw	$0x00B0
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_itunknown_4k
	pushl	$0x00000004
	pushl	$0x00000080
	jmp	.intel_itlb_print_4k

.intel_itunknown_4k:
	pushl	$0x0000004B
	pushl	$0x00000049
	leal	-364(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_itlb_4m

.intel_itlb_print_4k:
	pushl	$0x0000004B
	pushl	$0x00000049
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_itlb_print_1x_4k
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_itlb_4m
.intel_itlb_print_1x_4k:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf

.intel_itlb_4m:
/* Intel I-TLB (4Mb pages) */
	xorl	%ebx, %ebx
	pushw	$0x0002
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_it1_4m
	pushl	$0x00000002
	pushl	$0x00000002
	jmp	.intel_itlb_print_4m

.intel_it1_4m:
	pushw	$0x0050
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_it2_4m
	pushl	$0x00000040
	pushl	$0x00000040
	jmp	.intel_itlb_print_4m

.intel_it2_4m:
	pushw	$0x0051
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_it3_4m
	pushl	$0x00000080
	pushl	$0x00000080
	jmp	.intel_itlb_print_4m

.intel_it3_4m:
	pushw	$0x0052
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_it4_4m
	pushl	$0x00000100
	pushl	$0x00000100
	jmp	.intel_itlb_print_4m

.intel_it4_4m:
	pushw	$0x00B1
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_itunknown_4m
	pushl	$0x00000004
	pushl	$0x00000004
	jmp	.intel_itlb_print_4m

.intel_itunknown_4m:
	pushl	$0x0000004D
	pushl	$0x00000049
	leal	-364(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_dtlb_4k

.intel_itlb_print_4m:
	pushl	$0x0000004D
	pushl	$0x00000049
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_itlb_print_1x_4m
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_dtlb_4k
.intel_itlb_print_1x_4m:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf

.intel_dtlb_4k:
/* Intel D-TLB (4Kb pages) */
	xorl	%ebx, %ebx
	pushw	$0x0003
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt1_4k
	pushl	$0x00000004
	pushl	$0x00000040
	jmp	.intel_dtlb_print_4k

.intel_dt1_4k:
	pushw	$0x0057
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt2_4k
	pushl	$0x00000004
	pushl	$0x00000010
	jmp	.intel_dtlb_print_4k

.intel_dt2_4k:
	pushw	$0x005B
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt3_4k
	pushl	$0x00000040
	pushl	$0x00000040
	jmp	.intel_dtlb_print_4k

.intel_dt3_4k:
	pushw	$0x005C
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt4_4k
	pushl	$0x00000080
	pushl	$0x00000080
	jmp	.intel_dtlb_print_4k

.intel_dt4_4k:
	pushw	$0x005D
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt5_4k
	pushl	$0x00000100
	pushl	$0x00000100
	jmp	.intel_dtlb_print_4k

.intel_dt5_4k:
	pushw	$0x00B3
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt6_4k
	pushl	$0x00000004
	pushl	$0x00000080
	jmp	.intel_dtlb_print_4k

.intel_dt6_4k:
	pushw	$0x00B4
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dtunknown_4k
	pushl	$0x00000004
	pushl	$0x00000100
	jmp	.intel_dtlb_print_4k

.intel_dtunknown_4k:
	pushl	$0x0000004B
	pushl	$0x00000049
	leal	-364(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_dtlb_4m

.intel_dtlb_print_4k:
	pushl	$0x0000004B
	pushl	$0x00000044
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_dtlb_print_1x_4k
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_dtlb_4m
.intel_dtlb_print_1x_4k:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf

.intel_dtlb_4m:
/* Intel D-TLB (4Mb pages) */
	xorl	%ebx, %ebx
	pushw	$0x0004
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt1_4m
	pushl	$0x00000004
	pushl	$0x00000008
	jmp	.intel_dtlb_print_4m

.intel_dt1_4m:
	pushw	$0x0005
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt2_4m
	pushl	$0x00000004
	pushl	$0x00000020
	jmp	.intel_dtlb_print_4m

.intel_dt2_4m:
	pushw	$0x0056
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt3_4m
	pushl	$0x00000004
	pushl	$0x00000010
	jmp	.intel_dtlb_print_4m

.intel_dt3_4m:
	pushw	$0x005A
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt4_4m
	pushl	$0x00000004
	pushl	$0x00000020
	jmp	.intel_dtlb_print_4m

.intel_dt4_4m:
	pushw	$0x005B
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt5_4m
	pushl	$0x00000040
	pushl	$0x00000040
	jmp	.intel_dtlb_print_4m

.intel_dt5_4m:
	pushw	$0x005C
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dt6_4m
	pushl	$0x00000080
	pushl	$0x00000080
	jmp	.intel_dtlb_print_4m

.intel_dt6_4m:
	pushw	$0x005D
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_dtunknown_4m
	pushl	$0x00000100
	pushl	$0x00000100
	jmp	.intel_dtlb_print_4m

.intel_dtunknown_4m:
	pushl	$0x0000004D
	pushl	$0x00000049
	leal	-364(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_scache

.intel_dtlb_print_4m:
	pushl	$0x0000004D
	pushl	$0x00000044
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_dtlb_print_1x_4m
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_scache
.intel_dtlb_print_1x_4m:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf

.intel_scache:
/* Intel S-cache */
	xorl	%ebx, %ebx
	pushw	$0x0021
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s1
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000100
	jmp	.intel_scache_print

.intel_s1:
	pushw	$0x0039
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s2
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000080
	jmp	.intel_scache_print

.intel_s2:
	pushw	$0x003A
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s3
	pushl	$0x00000040
	pushl	$0x00000006
	pushl	$0x000000C0
	jmp	.intel_scache_print

.intel_s3:
	pushw	$0x003B
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s4
	pushl	$0x00000040
	pushl	$0x00000002
	pushl	$0x00000080
	jmp	.intel_scache_print

.intel_s4:
	pushw	$0x003C
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s5
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000100
	jmp	.intel_scache_print

.intel_s5:
	pushw	$0x003D
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s6
	pushl	$0x00000040
	pushl	$0x00000006
	pushl	$0x00000180
	jmp	.intel_scache_print

.intel_s6:
	pushw	$0x003E
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s7
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000200
	jmp	.intel_scache_print

.intel_s7:
	pushw	$0x0041
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s8
	pushl	$0x00000020
	pushl	$0x00000004
	pushl	$0x00000080
	jmp	.intel_scache_print

.intel_s8:
	pushw	$0x0042
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s9
	pushl	$0x00000020
	pushl	$0x00000004
	pushl	$0x00000100
	jmp	.intel_scache_print

.intel_s9:
	pushw	$0x0043
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s10
	pushl	$0x00000020
	pushl	$0x00000004
	pushl	$0x00000200
	jmp	.intel_scache_print

.intel_s10:
	pushw	$0x0044
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s11
	pushl	$0x00000020
	pushl	$0x00000004
	pushl	$0x00000400
	jmp	.intel_scache_print

.intel_s11:
	pushw	$0x0045
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s12
	pushl	$0x00000020
	pushl	$0x00000004
	pushl	$0x00000800
	jmp	.intel_scache_print

.intel_s12:
	pushw	$0x0048
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s13
	pushl	$0x00000040
	pushl	$0x0000000C
	pushl	$0x00000C00
	jmp	.intel_scache_print

.intel_s13:
/* not for Intel Xeon MP family F model 6 */
	movl	%edi, %eax
	shrl	$8, %eax
	cmpw	$0x0F06, %ax
	je	.intel_s14
	pushw	$0x0049
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s14
	pushl	$0x00000040
	pushl	$0x00000010
	pushl	$0x000001000
	jmp	.intel_scache_print

.intel_s14:
	pushw	$0x004E
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s15
	pushl	$0x00000040
	pushl	$0x00000018
	pushl	$0x00001800
	jmp	.intel_scache_print

.intel_s15:
	pushw	$0x0078
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s16
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000400
	jmp	.intel_scache_print

.intel_s16:
	pushw	$0x0079
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s17
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000080
	jmp	.intel_scache_print

.intel_s17:
	pushw	$0x007A
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s18
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000100
	jmp	.intel_scache_print

.intel_s18:
	pushw	$0x007B
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s19
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000200
	jmp	.intel_scache_print

.intel_s19:
	pushw	$0x007C
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s20
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000400
	jmp	.intel_scache_print

.intel_s20:
	pushw	$0x007D
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s21
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000800
	jmp	.intel_scache_print

.intel_s21:
	pushw	$0x007F
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s22
	pushl	$0x00000040
	pushl	$0x00000002
	pushl	$0x00000200
	jmp	.intel_scache_print

.intel_s22:
	pushw	$0x0082
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s23
	pushl	$0x00000020
	pushl	$0x00000008
	pushl	$0x00000100
	jmp	.intel_scache_print

.intel_s23:
	pushw	$0x0083
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s24
	pushl	$0x00000020
	pushl	$0x00000008
	pushl	$0x00000200
	jmp	.intel_scache_print

.intel_s24:
	pushw	$0x0084
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s25
	pushl	$0x00000020
	pushl	$0x00000008
	pushl	$0x00000400
	jmp	.intel_scache_print

.intel_s25:
	pushw	$0x0085
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s26
	pushl	$0x00000020
	pushl	$0x00000008
	pushl	$0x00000800
	jmp	.intel_scache_print

.intel_s26:
	pushw	$0x0086
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_s27
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000200
	jmp	.intel_scache_print

.intel_s27:
	pushw	$0x0087
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.cpuinfo_main_exit
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000400
/*	jmp	.intel_scache_print */

.intel_scache_print:
	pushl	$0x00000053
	movl	%esi, %eax
	shrl	$20, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_scache_print_1x
	incl	%eax
	pushl	%eax
	leal	-192(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_stlb
.intel_scache_print_1x:
	leal	-188(%ebp), %eax
	pushl	%eax
	call	printf

.intel_stlb:
/* Intel S-TLB */
	xorl	%ebx, %ebx
	pushw	$0x00CA
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_tcache
	pushl	$0x00000004
	pushl	$0x00000200

	pushl	$0x0000004B
	pushl	$0x00000053
	movl	%esi, %eax
	shrl	$20, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.intel_stlb_print_1x
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.intel_tcache
.intel_stlb_print_1x:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf

.intel_tcache:
/* Intel T-cache */
	xorl	%ebx, %ebx
	pushw	$0x0022
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t1
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000200
	jmp	.intel_tcache_print

.intel_t1:
	pushw	$0x0023
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t2
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000400
	jmp	.intel_tcache_print

.intel_t2:
	pushw	$0x0025
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t3
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000800
	jmp	.intel_tcache_print

.intel_t3:
	pushw	$0x0029
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t4
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00001000
	jmp	.intel_tcache_print

.intel_t4:
	pushw	$0x0046
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t5
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00001000
	jmp	.intel_tcache_print

.intel_t5:
	pushw	$0x0047
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t6
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00002000
	jmp	.intel_tcache_print

.intel_t6:
/* Intel Xeon MP family 0x0F model 0x06 only */
	movl	%edi, %eax
	shrl	$8, %eax
	cmpw	$0x0F06, %ax
	jne	.intel_t7
	pushw	$0x0049
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t7
	pushl	$0x00000040
	pushl	$0x00000010
	pushl	$0x000001000
	jmp	.intel_tcache_print

.intel_t7:
	pushw	$0x004A
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t8
	pushl	$0x00000040
	pushl	$0x0000000C
	pushl	$0x00001800
	jmp	.intel_tcache_print

.intel_t8:
	pushw	$0x004B
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t9
	pushl	$0x00000040
	pushl	$0x00000010
	pushl	$0x00002000
	jmp	.intel_tcache_print

.intel_t9:
	pushw	$0x004C
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t10
	pushl	$0x00000040
	pushl	$0x0000000C
	pushl	$0x00003000
	jmp	.intel_tcache_print

.intel_t10:
	pushw	$0x004D
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t11
	pushl	$0x00000040
	pushl	$0x00000010
	pushl	$0x00004000
	jmp	.intel_tcache_print

.intel_t11:
	pushw	$0x00D0
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t12
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000200
	jmp	.intel_tcache_print

.intel_t12:
	pushw	$0x00D1
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t13
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000400
	jmp	.intel_tcache_print

.intel_t13:
	pushw	$0x00D2
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t14
	pushl	$0x00000040
	pushl	$0x00000004
	pushl	$0x00000800
	jmp	.intel_tcache_print

.intel_t14:
	pushw	$0x00D6
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t15
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000400
	jmp	.intel_tcache_print

.intel_t15:
	pushw	$0x00D7
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t16
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00000800
	jmp	.intel_tcache_print

.intel_t16:
	pushw	$0x00D8
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t17
	pushl	$0x00000040
	pushl	$0x00000008
	pushl	$0x00001000
	jmp	.intel_tcache_print

.intel_t17:
	pushw	$0x00DC
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t18
	pushl	$0x00000040
	pushl	$0x0000000C
	pushl	$0x00000600
	jmp	.intel_tcache_print

.intel_t18:
	pushw	$0x00DD
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t19
	pushl	$0x00000040
	pushl	$0x0000000C
	pushl	$0x00000C00
	jmp	.intel_tcache_print

.intel_t19:
	pushw	$0x00DE
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t20
	pushl	$0x00000040
	pushl	$0x0000000C
	pushl	$0x00001800
	jmp	.intel_tcache_print

.intel_t20:
	pushw	$0x00E2
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t21
	pushl	$0x00000040
	pushl	$0x00000010
	pushl	$0x00000800
	jmp	.intel_tcache_print

.intel_t21:
	pushw	$0x00E3
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t22
	pushl	$0x00000040
	pushl	$0x00000010
	pushl	$0x00001000
	jmp	.intel_tcache_print

.intel_t22:
	pushw	$0x00E4
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t23
	pushl	$0x00000040
	pushl	$0x00000010
	pushl	$0x00002000
	jmp	.intel_tcache_print

.intel_t23:
	pushw	$0x00EA
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t24
	pushl	$0x00000040
	pushl	$0x00000018
	pushl	$0x00003000
	jmp	.intel_tcache_print

.intel_t24:
	pushw	$0x00EB
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.intel_t25
	pushl	$0x00000040
	pushl	$0x00000018
	pushl	$0x00004800
	jmp	.intel_tcache_print

.intel_t25:
	pushw	$0x00EC
	call	intel_parser
	popw	%dx
	cmpl	%ebx, %eax
	je	.cpuinfo_main_exit
	pushl	$0x00000040
	pushl	$0x00000018
	pushl	$0x00006000
/*	jmp	.intel_tcache_print */

.intel_tcache_print:
	pushl	$0x00000054
	leal	-188(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.cpuinfo_main_exit

/* obtain and print AMD extended information;
 * implemented in K5 and up the way, also in IDT WinChips and VIA C3s
/* (from "AMD Processor Recognition Application Note") */
.cpuinfo_amdcache:
	movl	$0x80000000, %eax
	cpuid
	cmpl	$0x80000005, %eax
	jb	.cpuinfo_main_exit
/* AMD I-cache */
	movl	$0x80000005, %eax
	cpuid
	movl	%edx, %eax
	andl	$0x000000FF, %eax
	pushl	%eax
	movl	%edx, %eax
	andl	$0x0000FF00, %eax
	shrl	$8, %eax
	pushl	%eax
	movl	%edx, %eax
	andl	$0x00FF0000, %eax
	shrl	$16, %eax
	pushl	%eax
	movl	%edx, %eax
	andl	$0xFF000000, %eax
	shrl	$24, %eax
	pushl	%eax
	pushl	$0x00000049
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_icache_print_1x
	incl	%eax
	pushl	%eax
	leal	-284(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_dcache
.amd_icache_print_1x:
	leal	-280(%ebp), %eax
	pushl	%eax
	call	printf
.amd_dcache:
/* AMD D-cache */
	movl	$0x80000005, %eax
	cpuid
	movl	%ecx, %eax
	andl	$0x000000FF, %eax
	pushl	%eax
	movl	%ecx, %eax
	andl	$0x0000FF00, %eax
	shrl	$8, %eax
	pushl	%eax
	movl	%ecx, %eax
	andl	$0x00FF0000, %eax
	shrl	$16, %eax
	pushl	%eax
	movl	%ecx, %eax
	andl	$0xFF000000, %eax
	shrl	$24, %eax
	pushl	%eax
	pushl	$0x00000044
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_dcache_print_1x
	incl	%eax
	pushl	%eax
	leal	-284(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_itlb
.amd_dcache_print_1x:
	leal	-280(%ebp), %eax
	pushl	%eax
	call	printf
.amd_itlb:
/* AMD I-TLB (4Kb and 4Mb pages) */
	movl	$0x80000005, %eax
	cpuid
	movl	%ebx, %edx
	andl	$0x0000FF00, %edx
	shrl	$8, %edx
	pushl	%edx
	movl	%ebx, %edx
	andl	$0x000000FF, %edx
	pushl	%edx
	cmpb	$0xFF, 4(%esp)
	jne	.amd_itlb_print_4k
	movw	%dx, 4(%esp)
.amd_itlb_print_4k:
	movl	%eax, %ebx
	pushl	$0x0000004B
	pushl	$0x00000049
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_itlb_print_1x_4k
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_itlb_4m
.amd_itlb_print_1x_4k:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf
.amd_itlb_4m:
	movl	%ebx, %edx
	andl	$0x0000FF00, %edx
	shrl	$8, %edx
	pushl	%edx
	andl	$0x000000FF, %ebx
/* number of entries reported is for 2Mb pages, need to divide by 2 for 4Mb ones */
	shrl	$1, %ebx
	pushl	%ebx
	cmpb	$0xFF, 4(%esp)
	jne	.amd_itlb_print_4m
	movw	%bx, 4(%esp)
.amd_itlb_print_4m:
	pushl	$0x0000004D
	pushl	$0x00000049
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_itlb_print_1x_4m
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_dtlb
.amd_itlb_print_1x_4m:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf
.amd_dtlb:
/* AMD D-TLB (4Kb and 4Mb pages) */
	movl	$0x80000005, %eax
	cpuid
	movl	%ebx, %edx
	andl	$0xFF000000, %edx
	shrl	$24, %edx
	pushl	%edx
	movl	%ebx, %edx
	andl	$0x00FF0000, %edx
	shrl	$16, %edx
	pushl	%edx
	cmpb	$0xFF, 4(%esp)
	jne	.amd_dtlb_print_4k
	movw	%dx, 4(%esp)
.amd_dtlb_print_4k:
	movl	%eax, %ebx
	pushl	$0x0000004B
	pushl	$0x00000044
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_dtlb_print_1x_4k
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_dtlb_4m
.amd_dtlb_print_1x_4k:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf
.amd_dtlb_4m:
	movl	%ebx, %edx
	andl	$0xFF000000, %edx
	shrl	$24, %edx
	pushl	%edx
	andl	$0x00FF0000, %ebx
/* number of entries reported is for 2Mb pages, need to divide by 2 for 4Mb ones */
	shrl	$17, %ebx
	pushl	%ebx
	cmpb	$0xFF, 4(%esp)
	jne	.amd_dtlb_print_4m
	movw	%bx, 4(%esp)
.amd_dtlb_print_4m:
	pushl	$0x0000004D
	pushl	$0x00000044
	movl	%esi, %eax
	shrl	$16, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_dtlb_print_1x_4m
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_scache
.amd_dtlb_print_1x_4m:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf
.amd_scache:
/* AMD S-cache */
	movl	$0x80000000, %eax
	cpuid
	cmpl	$0x80000006, %eax
	jb	.cpuinfo_main_exit
	movl	$0x80000006, %eax
	cpuid
	movl	%ecx, %eax
	andl	$0x000000FF, %eax
	pushl	%eax
	movl	%ecx, %eax
	andl	$0x00000F00, %eax
	shrl	$8, %eax
	pushl	%eax
	movl	%ecx, %eax
	andl	$0x0000F000, %eax
	shrl	$12, %eax
	pushl	%eax
	call	amd_conv
	movb	%al, 0(%esp)
	movl	%ecx, %eax
	andl	$0xFFFF0000, %eax
	shrl	$16, %eax
	pushl	%eax
	pushl	$0x00000053
	movl	%esi, %eax
	shrl	$20, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_scache_print_1x
	incl	%eax
	pushl	%eax
	leal	-284(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_stlb
.amd_scache_print_1x:
	leal	-280(%ebp), %eax
	pushl	%eax
	call	printf
.amd_stlb:
/* AMD S-TLB (4Kb and 4Mb pages) */
	movl	$0x80000006, %eax
	cpuid
	movl	%eax, %ecx
	movl	%ebx, %edx
	andl	$0x0000F000, %edx
	shrl	$12, %edx
	pushl	%edx
	call	amd_conv
	cmpb	$0x00, %al
	je	.amd_tcache
	movb	%al, 0(%esp)
	andl	$0x00000FFF, %ebx
	pushl	%ebx
/* adjust for full associativity */
	cmpb	$0xFF, 4(%esp)
	jne	.amd_stlb_print_4k
	movw	%bx, 4(%esp)
.amd_stlb_print_4k:
	movl	%ecx, %ebx
	pushl	$0x0000004B
	pushl	$0x00000053
	movl	%esi, %eax
	shrl	$20, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_stlb_print_1x_4k
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_stlb_4m
.amd_stlb_print_1x_4k:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf
.amd_stlb_4m:
	movl	%ebx, %edx
	andl	$0x0000F000, %edx
	shrl	$12, %edx
	pushl	%edx
	call	amd_conv
	cmpb	$0x00, %al
	je	.amd_tcache
	movb	%al, 0(%esp)
	andl	$0x00000FFF, %ebx
/* number of entries reported is for 2Mb pages, need to divide by 2 for 4Mb ones */
	shrl	$1, %ebx
	pushl	%ebx
/* adjust for full associativity */
	cmpb	$0xFF, 4(%esp)
	jne	.amd_stlb_print_4m
	movw	%si, 4(%esp)
.amd_stlb_print_4m:
	pushl	$0x0000004B
	pushl	$0x00000053
	movl	%esi, %eax
	shrl	$20, %eax
	andw	$0x000F, %ax
	cmpw	$0x0000, %ax
	je	.amd_stlb_print_1x_4m
	incl	%eax
	pushl	%eax
	leal	-332(%ebp), %eax
	pushl	%eax
	call	printf
	jmp	.amd_tcache
.amd_stlb_print_1x_4m:
	leal	-328(%ebp), %eax
	pushl	%eax
	call	printf
.amd_tcache:
/* AMD T-cache */
	movl	$0x80000006, %eax
	cpuid
	movl	%edx, %eax
	andl	$0x000000FF, %eax
	pushl	%eax
	movl	%edx, %eax
	andl	$0x00000F00, %eax
	shrl	$8, %eax
	pushl	%eax
	movl	%edx, %eax
	andl	$0x0000F000, %eax
	shrl	$12, %eax
	pushl	%eax
	call	amd_conv
	cmpb	$0x00, %al
	je	.cpuinfo_main_exit
	movb	%al, 0(%esp)
	movl	%edx, %eax
	andl	$0xFFFC0000, %eax
/* T-cache size is reported in 512Kb blocks */
	shrl	$9, %eax
	pushl	%eax
	pushl	$0x00000054
	leal	-280(%ebp), %eax
	pushl	%eax
	call	printf

.cpuinfo_main_exit:
/* move processor feature data from %edi to %eax */
	andl	$0x3FFFFFFF, %edi
	movl	%edi, %eax
/* pick a number of processor physical cores from %esi */
	shll	$8, %esi
	andl	$0x0F000000, %esi
	orl	%esi, %eax

	movl	%ebp, %esp
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

/* a parsing routine to help retrieving extended information from Intel CPUs
 * (using standard function 2); it has got to be written because those cache
 * and TLB descriptors have no fixed locations (??!)
 * INPUT: byte-wide descriptor to search for (in stack)
 * OUTPUT: descriptor if found, zero if not (in %eax) */
.globl intel_parser
intel_parser:
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
	pushl	%edi
	movw	20(%esp), %si
	movl	$2, %eax
	cpuid
	testl	$0x80000000, %eax
	jnz	.intel_parser_stage1
	shrl	$8, %eax
	movl	%eax, %ebp
	movl	%eax, %edi
	andw	$0x00FF, %ax
	shrl	$8, %ebp
	andw	$0x00FF, %bp
	shrl	$16, %edi
	andw	$0x00FF, %di
	cmpw	%si, %ax
	je	.intel_parser_found
	cmpw	%si, %bp
	je	.intel_parser_found
	cmpw	%si, %di
	je	.intel_parser_found
.intel_parser_stage1:
	testl	$0x80000000, %ebx
	jnz	.intel_parser_stage2
	movl	%ebx, %eax
	movl	%ebx, %ebp
	movl	%ebx, %edi
	andw	$0x00FF, %bx
	shrl	$8, %eax
	andw	$0x00FF, %ax
	shrl	$16, %ebp
	andw	$0x00FF, %bp
	shrl	$24, %edi
	andw	$0x00FF, %di
	cmpw	%si, %bx
	je	.intel_parser_found
	cmpw	%si, %ax
	je	.intel_parser_found
	cmpw	%si, %bp
	je	.intel_parser_found
	cmpw	%si, %di
	je	.intel_parser_found
.intel_parser_stage2:
	testl	$0x80000000, %ecx
	jnz	.intel_parser_stage3
	movl	%ecx, %eax
	movl	%ecx, %ebp
	movl	%ecx, %edi
	andw	$0x00FF, %cx
	shrl	$8, %eax
	andw	$0x00FF, %ax
	shrl	$16, %ebp
	andw	$0x00FF, %bp
	shrl	$24, %edi
	andw	$0x00FF, %di
	cmpw	%si, %cx
	je	.intel_parser_found
	cmpw	%si, %ax
	je	.intel_parser_found
	cmpw	%si, %bp
	je	.intel_parser_found
	cmpw	%si, %di
	je	.intel_parser_found
.intel_parser_stage3:
	testl	$0x80000000, %edx
	jnz	.intel_parser_notfound
	movl	%edx, %eax
	movl	%edx, %ebp
	movl	%edx, %edi
	andw	$0x00FF, %dx
	shrl	$8, %eax
	andw	$0x00FF, %ax
	shrl	$16, %ebp
	andw	$0x00FF, %bp
	shrl	$24, %edi
	andw	$0x00FF, %di
	cmpw	%si, %dx
	je	.intel_parser_found
	cmpw	%si, %ax
	je	.intel_parser_found
	cmpw	%si, %bp
	je	.intel_parser_found
	cmpw	%si, %di
	je	.intel_parser_found
.intel_parser_notfound:
	xorl	%eax, %eax
	jmp	.intel_parser_quit
.intel_parser_found:
	xorl	%eax, %eax
	movw	%si, %ax
.intel_parser_quit:
	popl	%edi
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

/* converts a S-cache, T-cache or S-TLB associativity descriptor employed by
 * AMD processors of the Athlon and Athlon 64 microarchitectures to an actual
 * number of ways
 * INPUT: a halfbyte-wide descriptor (in stack)
 * OUTPUT: actual number of ways or 0xFF if fully associative (in %eax) */
.globl amd_conv
amd_conv:
	xorl	%eax, %eax
	movb	4(%esp), %al
	cmpb	$0x06, %al
	je	.amd_conv_8w
	cmpb	$0x08, %al
	je	.amd_conv_16w
	cmpb	$0x0A, %al
	je	.amd_conv_32w
	cmpb	$0x0B, %al
	je	.amd_conv_48w
	cmpb	$0x0C, %al
	je	.amd_conv_64w
	cmpb	$0x0D, %al
	je	.amd_conv_96w
	cmpb	$0x0E, %al
	je	.amd_conv_128w
	cmpb	$0x0F, %al
	je	.amd_conv_fa
	jmp	.amd_conv_end
.amd_conv_8w:
/* 8-way set associative */
	movb	$0x08, %al
	jmp	.amd_conv_end
.amd_conv_16w:
/* 16-way set associative */
	movb	$0x10, %al
	jmp	.amd_conv_end
.amd_conv_32w:
/* 32-way set associative */
	movb	$0x20, %al
	jmp	.amd_conv_end
.amd_conv_48w:
/* 48-way set associative */
	movb	$0x30, %al
	jmp	.amd_conv_end
.amd_conv_64w:
/* 64-way set associative */
	movb	$0x40, %al
	jmp	.amd_conv_end
.amd_conv_96w:
/* 96-way set associative */
	movb	$0x60, %al
	jmp	.amd_conv_end
.amd_conv_128w:
/* 128-way set associative */
	movb	$0x80, %al
	jmp	.amd_conv_end
.amd_conv_fa:
/* fully associative */
	movb	$0xFF, %al
.amd_conv_end:
	ret

/* calculate a processor's clock speed using its Time-Stamp Counter and a
 * standard i8254-compatible timer (use counter 2)
 * INPUT: none
 * OUTPUT: processor's clock speed in KHz or zero if the calculation is
 * impossible (in %eax)
 * (for further information on i8254 refer to "Intel 8254 Programmable
 * Interval Timer" datasheet; TSC is documented in various datasheets)
 * NOTE: it's a caller's resposibility to verify support for CPUID */
.globl caltsc
caltsc:
/* save the registers */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi

/* verify support for TSC */
	movl	$1, %eax
	cpuid
	testw	$0x0010, %dx
	jz	.tscnot

/* filter out CPUs with broken TSCs */
	xorl	%eax, %eax
	cpuid
/* AMD K5 model 0 */
	cmpl	$0x444D4163, %ecx
	jne	.tscidt
	movl	$1, %eax
	cpuid
	andw	$0x0FF0, %ax
	cmpw	$0x0500, %ax
	jne	.tscgood
	jmp	.tscnot
.tscidt:
/* IDT WinChip */
	cmpl	$0x736C7561, %ecx
	jne	.tscgood
	movl	$1, %eax
	cpuid
	andw	$0x0FF0, %ax
	cmpw	$0x0540, %ax
	jne	.tscgood
	jmp	.tscnot

.tscgood:
/* set the initial loop count */
	movl	$0x00002000, %ebp
/* disable interrupts */
	cli
/* disable clock to the counter */
	inb	$0x61, %al
	andb	$0xFE, %al
	outb	%al, $0x61

.xloop:
/* advance the loop count */
	shll	$1, %ebp
	movl	%ebp, %ecx
/* set up the counter for a non-repeating countdown from 0xFFFF (mode 0,
 * non-BCD, LSB first, MSB second) */
	movb	$0xB0, %al
	outb	%al, $0x43
	movb	$0xFF, %al
	outb	%al, $0x42
	outb	%al, $0x42
/* enable clock to the counter */
	inb	$0x61, %al
	orb	$0x01, %al
	outb	%al, $0x61
/* obtain and save the initial TSC value;
 * don't care about the high double word, only a 157GHz or faster CPU may
 * spend 2^32 or more cycles during 0x7F00 ticks of i8254 */
	rdtsc
	movl	%eax, %esi
/* the delay loop;
 * integer signed divide is the most expensive [integer] instruction, also
 * it's non-pipelined or pipelined partially usually */
	xorl	%edx, %edx
	xorl	%eax, %eax
	movl	$1, %ebx
.yloop:
	idivl	%ebx
	idivl	%ebx
	idivl	%ebx
	idivl	%ebx
	idivl	%ebx
	loopl	.yloop

/* obtain and save the final TSC value */
	rdtsc
	movl	%eax, %edx
/* disable clock to the counter */
	inb	$0x61, %al
	andb	$0xFE, %al
	outb	%al, $0x61
/* send the latch command to the counter */
	movb	$0x80, %al
	outb	%al, $0x43
/* read the count (LSB first, MSB second) */
	inb	$0x42, %al
	movb	%al, %bl
	inb	$0x42, %al
	movb	%al, %bh
/* calculate the clocks elapsed;
 * auto-calibration: if %bx < 0x7F00, increase the loop count by 2, and
 * rewind */
	notw	%bx
	cmpw	$0x7F00, %bx
	jb	.xloop

/* reset and stop the counter */
	movb	$0xB0, %al
	outb	%al, $0x43
	xorb	%al, %al
	outb	%al, $0x42
	outb	%al, $0x42
/* enable clock to the counter */
	inb	$0x61, %al
	orb	$0x01, %al
	outb	%al, $0x61
/* enable interrupts */
	sti
/* calculate the TSC delta */
	cmpl	%esi, %edx
	jbe	.tsccross
	subl	%esi, %edx
	jmp	.tsccalc

.tsccross:
	notl	%esi
	addl	%esi, %edx

.tsccalc:
/* calculate the clock speed (in KHz, to avoid overflowing) */
	movl	%edx, %eax
	movl	$1193182, %ecx
	mull	%ecx
	imull	$1000, %ebx
	divl	%ebx
	jmp	.tscret

.tscnot:
/* not able to use TSC */
	xorl	%eax, %eax
.tscret:
/* restore the registers and return */
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret

/* calculate a processor's clock speed using instruction clock count method and
 * a standard i8254-compatible timer (use counter 2)
 * INPUT: processor's code (in stack)
 *   0x1 -- Cyrix 486 series;
 *   0x2 -- Cyrix 5x86, MediaGX, GXm, GXlv;
 *   0x3 -- Cyrix 6x86, 6x86L, 6x86MX, 6x86MII;
 *   0x4 -- UMC U5DX, U5SX;
 * OUTPUT: processor's clock speed in KHz or zero if the calculation is
 * impossible (in %eax) */
.globl calcnt
calcnt:
/* save the registers */
	pushl	%ebx
	pushl	%ebp
	pushl	%esi
/* take a processor's code from stack */
	movw	16(%esp), %si
/* return if the code is < 0x1 or > 0x4 */
	xorl	%eax, %eax
	movw	$0x0001, %dx
	cmpw	%dx, %si
	jb	.cntret
	movw	$0x0004, %dx
	cmpw	%dx, %si
	ja	.cntret
/* set the initial loop count */
	movl	$0x00001000, %ebp
/* disable interrupts */
	cli
/* disable clock to the counter */
	inb	$0x61, %al
	andb	$0xFE, %al
	outb	%al, $0x61

.cxloop:
/* advance the loop count */
	shll	$1, %ebp
	movl	%ebp, %ecx
/* set up the counter for a non-repeating countdown from 0xFFFF (mode 0,
 * non-BCD, LSB first, MSB second) */
	movb	$0xB0, %al
	outb	%al, $0x43
	movb	$0xFF, %al
	outb	%al, $0x42
	outb	%al, $0x42
/* enable clock to the counter */
	inb	$0x61, %al
	orb	$0x01, %al
	outb	%al, $0x61
/* the master loop */
	xorl	%edx, %edx
	xorl	%eax, %eax
	movl	$1, %ebx
.cyloop:
	idivl	%ebx
	idivl	%ebx
	idivl	%ebx
	idivl	%ebx
	idivl	%ebx
	loopl	.cyloop

/* disable clock to the counter */
	inb	$0x61, %al
	andb	$0xFE, %al
	outb	%al, $0x61
/* send the latch command to the counter */
	movb	$0x80, %al
	outb	%al, $0x43
/* read the count (LSB first, MSB second) */
	inb	$0x42, %al
	movb	%al, %bl
	inb	$0x42, %al
	movb	%al, %bh
/* calculate clocks elapsed;
 * auto-calibration: if %bx < 0x7F00, increase the loop count by 2, and
 * rewind */
	notw	%bx
	cmpw	$0x7F00, %bx
	jb	.cxloop

/* reset and stop the counter */
	movb	$0xB0, %al
	outb	%al, $0x43
	xorb	%al, %al
	outb	%al, $0x42
	outb	%al, $0x42
/* enable clock to the counter */
	inb	$0x61, %al
	orb	$0x01, %al
	outb	%al, $0x61
/* enable interrupts */
	sti
/* define the count multipliers;
 * (clocks per IDIV are in %ecx, per LOOP -- in %edx) */
	cmpw	$1, %si
	je	.calcx486
	cmpw	$2, %si
	je	.calcx586
	cmpw	$3, %si
	je	.calcx686
	cmpw	$4, %si
	je	.calu5
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	jmp	.calnum

.calcx486:
	movl	$40, %ecx
	movl	$8, %edx
	jmp	.calnum

.calcx586:
	movl	$45, %ecx
	movl	$2, %edx
	jmp	.calnum

.calcx686:
	movl	$17, %ecx
	movl	$1, %edx
	jmp	.calnum

.calu5:
	movl	$7, %ecx
	movl	$4, %edx

.calnum:
/* calculate the number of clocks spent */
	imull	$5, %ebp, %eax
	imull	%ecx, %eax
	imull	%edx, %ebp
	addl	%ebp, %eax
/* calculate the clock speed (in KHz, though overflowing isn't the issue) */
	movl	$1193182, %ecx
	mull	%ecx
	imull	$1000, %ebx
	divl	%ebx
.cntret:
/* restore the registers and return */
	popl	%esi
	popl	%ebp
	popl	%ebx
	ret
