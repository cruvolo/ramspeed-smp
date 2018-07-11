/*
**  CPUinfo, a processor information retrieving tool
**
**  (extension evaluating functions; UNIX release [i386])
**
**
**  This software is distributed under the terms of The Alasir Licence (TAL).
**  You should have received a copy of the licence together with the software.
**  If not, you should download it from http://www.alasir.com/licence/TAL.txt
**
**
**  Copyright (c) 2007-08 Paul V. Bolotoff <walter@alasir.com>
**
**  All rights reserved.
**
*/

/* evaluate processor scalar extensions through CPUID
 * INPUT: operating mode (in stack) -- verbose (1) or silent (0)
 * OUTPUT: bit mask of those extensions detected (in %eax)
 *   bit 0 -- FPU
 *   bit 1 -- CMOV
 *   bit 2 -- CX8
 *   bit 3 -- CX16
 *   bit 4 -- AMD64 (EM64T)
 *   bits 5 to 31 are reserved for future use
 * NOTE: it's a caller's resposibility to verify support for CPUID */
.globl cpuinfo_scalar_ext
cpuinfo_scalar_ext:
	pushl	%ebx
	pushl	%ebp
	pushl	%edi
	movl	%esp, %ebp
	xorl	%edi, %edi
/* "%s " is at -4(%ebp) */
	pushl	$0x00207325
/* "\n" is at -8(%ebp) */
	pushl	$0x0000000A
/* check for CPUID extended function 1 (extended function 0 is supposed to
 * return the maximal supported extended function in %eax) */
	movl	$0x80000000, %eax
	cpuid
	cmpl	$0x80000001, %eax
	jb	.cpuinfo_scalar_cyrix
	movl	$0x80000001, %eax
	cpuid
/* AMD64 (EM64T; bit 29 of %edx) */
	testl	$0x20000000, %edx
	jz	.cpuinfo_scalar_cyrix
	orw	$0x0010, %di
.cpuinfo_scalar_cyrix:
/* initialise a work-around for Cyrix processors with trashed %ecx of CPUID
 * standard function 1 */
	xorl	%eax, %eax
	cpuid
	pushl	%ecx
/* continue with CPUID standard function 1 */
	movl	$1, %eax
	cpuid
/* apply the Cyrix work-around by cleaning %ecx if necessary */
	popl	%eax
	cmpl	$0x64616574, %eax
	jne	.cpuid_cx16
	xorl	%ecx, %ecx
.cpuid_cx16:
/* CX16 (bit 13 of %ecx) */
	testl	$0x00002000, %ecx
	jz	.cpuid_cx8
	orw	$0x0008, %di
.cpuid_cx8:
/* CX8 (bit 8 of %edx) */
	testl	$0x00000100, %edx
	jz	.cpuid_cmov
	orw	$0x0004, %di
.cpuid_cmov:
/* CMOV (bit 15 of %edx) */
	testl	$0x00008000, %edx
	jz	.cpuid_fpu
	orw	$0x0002, %di
.cpuid_fpu:
/* FPU (bit 0 of %edx) */
	testl	$0x00000001, %edx
	jz	.cpuinfo_scalar_print
	orw	$0x0001, %di
.cpuinfo_scalar_print:
/* evaluate the mode bit and behave accordingly */
	movb	16(%ebp), %al
	testb	$0x01, %al
	jz	.cpuinfo_scalar_exit
	leal	-4(%ebp), %ebx
	pushl	$0x003A7261
	pushl	$0x6C616353
	pushl	%esp
	pushl	%ebx
	call	printf
	testw	$0x0001, %di
	jz	.cpuinfo_cmov_print
	pushl	$0x00555046
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_cmov_print:
	testw	$0x0002, %di
	jz	.cpuinfo_cx8_print
	pushl	$0x00000000
	pushl	$0x564F4D43
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_cx8_print:
	testw	$0x0004, %di
	jz	.cpuinfo_cx16_print
	pushl	$0x00385843
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_cx16_print:
	testw	$0x0008, %di
	jz	.cpuinfo_amd64_print
	pushl	$0x00000000
	pushl	$0x36315843
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_amd64_print:
	testw	$0x0010, %di
	jz	.cpuinfo_scalar_print_end
	pushl	$0x00000034
	pushl	$0x36444D41
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_scalar_print_end:
	leal	-8(%ebp), %ebx
	pushl	%ebx
	call	printf
.cpuinfo_scalar_exit:
	movl	%ebp, %esp
	movl	%edi, %eax
	popl	%edi
	popl	%ebp
	popl	%ebx
	ret

/* evaluate processor vector extensions through CPUID
 * INPUT: operating mode (in stack) -- verbose (1) or silent (0)
 * OUTPUT: bit mask of those extensions detected (in %eax)
 *   bit 0 -- MMX
 *   bit 1 -- Extended MMX (MMX+)
 *   bit 2 -- 3DNow!
 *   bit 3 -- Extended 3DNow! (3DNow!+)
 *   bit 4 -- SSE
 *   bit 5 -- SSE2
 *   bit 6 -- SSE3
 *   bits 7 to 31 are reserved for future use
 * NOTE: it's a caller's resposibility to verify support for CPUID */
.globl cpuinfo_vector_ext
cpuinfo_vector_ext:
	pushl	%ebx
	pushl	%ebp
	pushl	%edi
	movl	%esp, %ebp
	xorl	%edi, %edi
/* "%s " is at -4(%ebp) */
	pushl	$0x00207325
/* "\n" is at -8(%ebp) */
	pushl	$0x0000000A
/* check for CPUID extended function 1 (extended function 0 is supposed to
 * return the maximal supported extended function in %eax) */
	movl	$0x80000000, %eax
	cpuid
	cmpl	$0x80000001, %eax
	jb	.cpuinfo_vector_cyrix
	movl	$0x80000001, %eax
	cpuid
/* 3DNow!+ (bit 30 of %edx) */
	testl	$0x80000000, %edx
	jz	.cpuid_3dn
	orw	$0x0008, %di
.cpuid_3dn:
/* 3DNow! (bit 31 of %edx) */
	testl	$0x80000000, %edx
	jz	.cpuid_mmxp
	orw	$0x0004, %di
.cpuid_mmxp:
/* MMX+ (bit 22 of %edx) */
	testl	$0x00400000, %edx
	jz	.cpuinfo_vector_cyrix
	orw	$0x0002, %di
.cpuinfo_vector_cyrix:
/* initialise a work-around for Cyrix processors with trashed %ecx of CPUID
 * standard function 1 */
	xorl	%eax, %eax
	cpuid
	pushl	%ecx
/* continue with CPUID standard function 1 */
	movl	$1, %eax
	cpuid
/* apply the Cyrix work-around by cleaning %ecx if necessary */
	popl	%eax
	cmpl	$0x64616574, %eax
	jne	.cpuid_sse3
	xorl	%ecx, %ecx
.cpuid_sse3:
/* SSE3 (bit 0 of %ecx) */
	testl	$0x00000001, %ecx
	jz	.cpuid_sse2
	orw	$0x0040, %di
.cpuid_sse2:
/* SSE2 (bit 26 of %edx) */
	testl	$0x04000000, %edx
	jz	.cpuid_sse
	orw	$0x0020, %di
.cpuid_sse:
/* SSE (bit 25 of %edx) */
	testl	$0x02000000, %edx
	jz	.cpuid_mmx
	orw	$0x0010, %di
/* SSE implies MMX+ as well */
	orw	$0x002, %di
.cpuid_mmx:
/* MMX (bit 23 of %edx) */
	testl	$0x00800000, %edx
	jz	.cpuinfo_vector_print
	orw	$0x0001, %di
	pushl	$0x584D4D20
.cpuinfo_vector_print:
/* evaluate the mode bit and behave accordingly */
	movb	16(%ebp), %al
	testb	$0x01, %al
	jz	.cpuinfo_vector_exit
	leal	-4(%ebp), %ebx
	pushl	$0x003A726F
	pushl	$0x74636556
	pushl	%esp
	pushl	%ebx
	call	printf
	testw	$0x0001, %di
	jz	.cpuinfo_mmxp_print
	pushl	$0x00584D4D
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_mmxp_print:
	testw	$0x0002, %di
	jz	.cpuinfo_3dn_print
	pushl	$0x00000000
	pushl	$0x2B584D4D
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_3dn_print:
	testw	$0x0004, %di
	jz	.cpuinfo_3dnp_print
	pushl	$0x00002177
	pushl	$0x6F4E4433
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_3dnp_print:
	testw	$0x0008, %di
	jz	.cpuinfo_sse_print
	pushl	$0x002B2177
	pushl	$0x6F4E4433
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_sse_print:
	testw	$0x0010, %di
	jz	.cpuinfo_sse2_print
	pushl	$0x00455353
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_sse2_print:
	testw	$0x0020, %di
	jz	.cpuinfo_sse3_print
	pushl	$0x00000000
	pushl	$0x32455353
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_sse3_print:
	testw	$0x0040, %di
	jz	.cpuinfo_vector_print_end
	pushl	$0x00000000
	pushl	$0x33455353
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_vector_print_end:
	leal	-8(%ebp), %ebx
	pushl	%ebx
	call	printf
.cpuinfo_vector_exit:
	movl	%ebp, %esp
	movl	%edi, %eax
	popl	%edi
	popl	%ebp
	popl	%ebx
	ret

/* evaluate processor general extensions through CPUID
 * INPUT: operating mode (in stack) -- verbose (1) or silent (0)
 * OUTPUT: bit mask of those extensions detected (in %eax)
 *   bit 0 -- MSR
 *   bit 1 -- FXSR
 *   bit 2 -- CLFSH
 *   bit 3 -- SENTER (SEP)
 *   bit 4 -- SCALL
 *   bit 5 -- VMX
 *   bit 6 -- SVM
 *   bits 7 to 31 are reserved for future use
 * NOTE: it's a caller's resposibility to verify support for CPUID */
.globl cpuinfo_general_ext
cpuinfo_general_ext:
	pushl	%ebx
	pushl	%ebp
	pushl	%edi
	movl	%esp, %ebp
	xorl	%edi, %edi
/* "%s " is at -4(%ebp) */
	pushl	$0x00207325
/* "\n" is at -8(%ebp) */
	pushl	$0x0000000A
/* check for CPUID extended function 1 (extended function 0 is supposed to
 * return the maximal supported extended function in %eax) */
	movl	$0x80000000, %eax
	cpuid
	cmpl	$0x80000001, %eax
	jb	.cpuinfo_general_cyrix
	movl	$0x80000001, %eax
	cpuid
/* SVM (bit 2 of %ecx) */
	testl	$0x00000004, %ecx
	jz	.cpuid_scall
	orw	$0x0040, %di
.cpuid_scall:
/* SCALL (bit 11 of %edx) */
	testl	$0x00000800, %edx
	jz	.cpuinfo_general_cyrix
	orw	$0x0010, %di
.cpuinfo_general_cyrix:
/* initialise a work-around for Cyrix processors with trashed %ecx of CPUID
 * standard function 1 */
	xorl	%eax, %eax
	cpuid
	pushl	%ecx
/* continue with CPUID standard function 1 */
	movl	$1, %eax
	cpuid
/* apply the Cyrix work-around by cleaning %ecx if necessary */
	popl	%eax
	cmpl	$0x64616574, %eax
	jne	.cpuid_vmx
	xorl	%ecx, %ecx
.cpuid_vmx:
/* VMX (bit 5 of %ecx) */
	testl	$0x00000020, %ecx
	jz	.cpuid_senter
	orw	$0x0020, %di
.cpuid_senter:
/* SENTER (SEP; bit 11 of %edx) */
	testl	$0x00000800, %edx
	jz	.cpuid_clfsh
	orw	$0x0008, %di
.cpuid_clfsh:
/* CLFSH (bit 19 of %edx) */
	testl	$0x00080000, %edx
	jz	.cpuid_fxsr
	orw	$0x0004, %di
.cpuid_fxsr:
/* FXSR (bit 24 of %edx) */
	testl	$0x01000000, %edx
	jz	.cpuid_msr
	orw	$0x0002, %di
.cpuid_msr:
/* MSR (bit 5 of %edx) */
	testl	$0x00000020, %edx
	jz	.cpuinfo_general_print
	orw	$0x0001, %di
.cpuinfo_general_print:
/* evaluate the mode bit and behave accordingly */
	movb	16(%ebp), %al
	testb	$0x01, %al
	jz	.cpuinfo_general_exit
	leal	-4(%ebp), %ebx
	pushl	$0x00000000
	pushl	$0x3A6C6172
	pushl	$0x656E6547
	pushl	%esp
	pushl	%ebx
	call	printf
	testw	$0x0001, %di
	jz	.cpuinfo_fxsr_print
	pushl	$0x0052534D
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_fxsr_print:
	testw	$0x0002, %di
	jz	.cpuinfo_clfsh_print
	pushl	$0x00000000
	pushl	$0x52535846
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_clfsh_print:
	testw	$0x0004, %di
	jz	.cpuinfo_senter_print
	pushl	$0x00000048
	pushl	$0x53464C43
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_senter_print:
	testw	$0x0008, %di
	jz	.cpuinfo_scall_print
	pushl	$0x00005245
	pushl	$0x544E4553
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_scall_print:
	testw	$0x0010, %di
	jz	.cpuinfo_vmx_print
	pushl	$0x0000004C
	pushl	$0x4C414353
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_vmx_print:
	testw	$0x0020, %di
	jz	.cpuinfo_svm_print
	pushl	$0x00584D56
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_svm_print:
	testw	$0x0020, %di
	jz	.cpuinfo_general_print_end
	pushl	$0x004D5653
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_general_print_end:
	leal	-8(%ebp), %ebx
	pushl	%ebx
	call	printf
.cpuinfo_general_exit:
	movl	%edi, %eax
	movl	%ebp, %esp
	popl	%edi
	popl	%ebp
	popl	%ebx
	ret

/* evaluate processor addressing extensions through CPUID
 * INPUT: operating mode (in stack) -- verbose (1) or silent (0)
 * OUTPUT: bit mask of those extensions detected (in %eax)
 *   bit 0 -- PSE
 *   bit 1 -- PSE36
 *   bit 2 -- PAE
 *   bit 3 -- PGE
 *   bit 4 -- PAT
 *   bit 5 -- MTRR
 *   bits 6 to 31 are reserved for future use
 * NOTE: it's a caller's resposibility to verify support for CPUID */
.globl cpuinfo_address_ext
cpuinfo_address_ext:
	pushl	%ebx
	pushl	%ebp
	pushl	%edi
	movl	%esp, %ebp
	xorl	%edi, %edi
/* "%s " is at -4(%ebp) */
	pushl	$0x00207325
/* "\n" is at -8(%ebp) */
	pushl	$0x0000000A
/* start with CPUID standard function 1 */
	movl	$1, %eax
	cpuid
/* MTRR (bit 12 of %edx) */
	testl	$0x00001000, %edx
	jz	.cpuid_pat
	orw	$0x0020, %di
.cpuid_pat:
/* PAT (bit 16 of %edx) */
	testl	$0x00010000, %edx
	jz	.cpuid_pge
	orw	$0x0010, %di
.cpuid_pge:
/* PGE (bit 13 of %edx) */
	testl	$0x00002000, %edx
	jz	.cpuid_pae
	orw	$0x0008, %di
.cpuid_pae:
/* PAE (bit 6 of %edx) */
	testl	$0x00000040, %edx
	jz	.cpuid_pse36
	orw	$0x0004, %di
.cpuid_pse36:
/* PSE36 (bit 17 of %edx) */
	testl	$0x00020000, %edx
	jz	.cpuid_pse
	orw	$0x0002, %di
.cpuid_pse:
/* PSE (bit 3 of %edx) */
	testl	$0x00000008, %edx
	jz	.cpuinfo_address_print
	orw	$0x0001, %di
.cpuinfo_address_print:
/* evaluate the mode bit and behave accordingly */
	movb	16(%ebp), %al
	testb	$0x01, %al
	jz	.cpuinfo_address_exit
	leal	-4(%ebp), %ebx
	pushl	$0x003A676E
	pushl	$0x69737365
	pushl	$0x72646441
	pushl	%esp
	pushl	%ebx
	call	printf
	testw	$0x0001, %di
	jz	.cpuinfo_pse36_print
	pushl	$0x00455350
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_pse36_print:
	testw	$0x0002, %di
	jz	.cpuinfo_pae_print
	pushl	$0x00000036
	pushl	$0x33455350
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_pae_print:
	testw	$0x0004, %di
	jz	.cpuinfo_pge_print
	pushl	$0x00454150
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_pge_print:
	testw	$0x0008, %di
	jz	.cpuinfo_pat_print
	pushl	$0x00454750
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_pat_print:
	testw	$0x0010, %di
	jz	.cpuinfo_mtrr_print
	pushl	$0x00544150
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_mtrr_print:
	testw	$0x0020, %di
	jz	.cpuinfo_address_print_end
	pushl	$0x00000000
	pushl	$0x5252544D
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_address_print_end:
	leal	-8(%ebp), %ebx
	pushl	%ebx
	call	printf
.cpuinfo_address_exit:
	movl	%edi, %eax
	movl	%ebp, %esp
	popl	%edi
	popl	%ebp
	popl	%ebx
	ret

/* evaluate processor monitoring extensions through CPUID
 * INPUT: operating mode (in stack) -- verbose (1) or silent (0)
 * OUTPUT: bit mask of those extensions detected (in %eax)
 *   bit 0 -- TSC
 *   bit 1 -- TMSC (ACPI)
 *   bit 2 -- TM
 *   bit 3 -- TM2
 *   bit 4 -- MNTR (MONITOR)
 *   bits 5 to 31 are reserved for future use
 * NOTE: it's a caller's resposibility to verify support for CPUID */
.globl cpuinfo_monitor_ext
cpuinfo_monitor_ext:
	pushl	%ebx
	pushl	%ebp
	pushl	%edi
	movl	%esp, %ebp
	xorl	%edi, %edi
/* "%s " is at -4(%ebp) */
	pushl	$0x00207325
/* "\n" is at -8(%ebp) */
	pushl	$0x0000000A
/* initialise a work-around for Cyrix processors with trashed %ecx of CPUID
 * standard function 1 */
	xorl	%eax, %eax
	cpuid
	pushl	%ecx
/* continue with CPUID standard function 1 */
	movl	$1, %eax
	cpuid
/* apply the Cyrix work-around by cleaning %ecx if necessary */
	popl	%eax
	cmpl	$0x64616574, %eax
	jne	.cpuid_mntr
	xorl	%ecx, %ecx
.cpuid_mntr:
/* MNTR (MONITOR; bit 3 of %ecx) */
	testl	$0x00000008, %ecx
	jz	.cpuid_tm2
	orw	$0x0010, %di
.cpuid_tm2:
/* TM2 (bit 8 of %ecx) */
	testl	$0x00000100, %ecx
	jz	.cpuid_tm
	orw	$0x0008, %di
.cpuid_tm:
/* TM (bit 29 of %edx) */
	testl	$0x20000000, %edx
	jz	.cpuid_tmsc
	orw	$0x0004, %di
.cpuid_tmsc:
/* TMSC (ACPI; bit 22 of %edx) */
	testl	$0x00400000, %edx
	jz	.cpuid_tsc
	orw	$0x0002, %di
.cpuid_tsc:
/* TSC (bit 4 of %edx) */
	testl	$0x00000010, %edx
	jz	.cpuinfo_monitor_print
	orw	$0x0001, %di
.cpuinfo_monitor_print:
/* evaluate the mode bit and behave accordingly */
	movb	16(%ebp), %al
	testb	$0x01, %al
	jz	.cpuinfo_monitor_exit
	leal	-4(%ebp), %ebx
	pushl	$0x003A676E
	pushl	$0x69726F74
	pushl	$0x696E6F4D
	pushl	%esp
	pushl	%ebx
	call	printf
	testw	$0x0001, %di
	jz	.cpuinfo_tmsc_print
	pushl	$0x00435354
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_tmsc_print:
	testw	$0x0002, %di
	jz	.cpuinfo_tm_print
	pushl	$0x00000000
	pushl	$0x43534D54
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_tm_print:
	testw	$0x0004, %di
	jz	.cpuinfo_tm2_print
	pushl	$0x00004D54
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_tm2_print:
	testw	$0x0008, %di
	jz	.cpuinfo_mntr_print
	pushl	$0x00324D54
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_mntr_print:
	testw	$0x0008, %di
	jz	.cpuinfo_monitor_print_end
	pushl	$0x00000000
	pushl	$0x52544E4D
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_monitor_print_end:
	leal	-8(%ebp), %ebx
	pushl	%ebx
	call	printf
.cpuinfo_monitor_exit:
	movl	%edi, %eax
	movl	%ebp, %esp
	popl	%edi
	popl	%ebp
	popl	%ebx
	ret

/* evaluate processor other extensions through CPUID
 * INPUT: operating mode (in stack) -- verbose (1) or silent (0)
 * OUTPUT: bit mask of those extensions detected (in %eax)
 *   bit 0 -- VME
 *   bit 1 -- DE
 *   bit 2 -- MCE
 *   bit 3 -- MCA
 *   bit 4 -- APIC
 *   bit 5 -- DS
 *   bit 6 -- SS
 *   bit 7 -- NX (XD)
 *   bit 8 -- DCA
 *   bits 9 to 31 are reserved for future use
 * NOTE: it's a caller's resposibility to verify support for CPUID */
.globl cpuinfo_other_ext
cpuinfo_other_ext:
	pushl	%ebx
	pushl	%ebp
	pushl	%edi
	movl	%esp, %ebp
	xorl	%edi, %edi
/* "%s " is at -4(%ebp) */
	pushl	$0x00207325
/* "\n" is at -8(%ebp) */
	pushl	$0x0000000A
/* check for CPUID extended function 1 (extended function 0 is supposed to
 * return the maximal supported extended function in %eax) */
	movl	$0x80000000, %eax
	cpuid
	cmpl	$0x80000001, %eax
	jb	.cpuinfo_other_cyrix
	movl	$0x80000001, %eax
	cpuid
/* NX (XD; bit 20 of %edx) */
	testl	$0x00100000, %edx
	jz	.cpuinfo_other_cyrix
	orw	$0x0080, %di
.cpuinfo_other_cyrix:
/* initialise a work-around for Cyrix processors with trashed %ecx of CPUID
 * standard function 1 */
	xorl	%eax, %eax
	cpuid
	pushl	%ecx
/* continue with CPUID standard function 1 */
	movl	$1, %eax
	cpuid
/* apply the Cyrix work-around by cleaning %ecx if necessary */
	popl	%eax
	cmpl	$0x64616574, %eax
	jne	.cpuid_dca
	xorl	%ecx, %ecx
.cpuid_dca:
/* DCA (bit 18 of %ecx) */
	testl	$0x00040000, %ecx
	jz	.cpuid_nx
	orw	$0x0100, %di
.cpuid_nx:
/* NX (XD; text push) */
	testw	$0x0080, %di
	jz	.cpuid_ss
	orw	$0x0080, %di
.cpuid_ss:
/* SS (bit 27 of %edx) */
	testl	$0x08000000, %edx
	jz	.cpuid_ds
	orw	$0x0040, %di
.cpuid_ds:
/* DS (bit 21 of %edx) */
	testl	$0x00200000, %edx
	jz	.cpuid_apic
	orw	$0x0020, %di
.cpuid_apic:
/* APIC (bit 9 of %edx) */
	testl	$0x00000200, %edx
	jz	.cpuid_mca
	orw	$0x0010, %di
.cpuid_mca:
/* MCA (bit 14 of %edx) */
	testl	$0x00004000, %edx
	jz	.cpuid_mce
	orw	$0x0008, %di
.cpuid_mce:
/* MCE (bit 7 of %edx) */
	testl	$0x00000080, %edx
	jz	.cpuid_de
	orw	$0x0004, %di
.cpuid_de:
/* DE (bit 2 of %edx) */
	testl	$0x00000004, %edx
	jz	.cpuid_vme
	orw	$0x0002, %di
.cpuid_vme:
/* VME (bit 1 of %edx) */
	testl	$0x00000002, %edx
	jz	.cpuinfo_other_print
	orw	$0x0001, %di
.cpuinfo_other_print:
/* evaluate the mode bit and behave accordingly */
	movb	16(%ebp), %al
	testb	$0x01, %al
	jz	.cpuinfo_other_exit
	leal	-4(%ebp), %ebx
	pushl	$0x00003A72
	pushl	$0x6568744F
	pushl	%esp
	pushl	%ebx
	call	printf
	testw	$0x0001, %di
	jz	.cpuinfo_de_print
	pushl	$0x00454D56
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_de_print:
	testw	$0x0002, %di
	jz	.cpuinfo_mce_print
	pushl	$0x00004544
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_mce_print:
	testw	$0x0004, %di
	jz	.cpuinfo_mca_print
	pushl	$0x0045434D
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_mca_print:
	testw	$0x0008, %di
	jz	.cpuinfo_apic_print
	pushl	$0x0041434D
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_apic_print:
	testw	$0x0010, %di
	jz	.cpuinfo_ds_print
	pushl	$0x00000000
	pushl	$0x43495041
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_ds_print:
	testw	$0x0020, %di
	jz	.cpuinfo_ss_print
	pushl	$0x00005344
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_ss_print:
	testw	$0x0040, %di
	jz	.cpuinfo_nx_print
	pushl	$0x00005353
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_nx_print:
	testw	$0x0080, %di
	jz	.cpuinfo_dca_print
	pushl	$0x0000584E
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_dca_print:
	testw	$0x0100, %di
	jz	.cpuinfo_other_print_end
	pushl	$0x00414344
	pushl	%esp
	pushl	%ebx
	call	printf
.cpuinfo_other_print_end:
	leal	-8(%ebp), %ebx
	pushl	%ebx
	call	printf
.cpuinfo_other_exit:
	movl	%edi, %eax
	movl	%ebp, %esp
	popl	%edi
	popl	%ebp
	popl	%ebx
	ret

/* evaluates support for the Hyper-Threading Technology
 * INPUT: operating mode (in stack) -- verbose (1) or silent (0)
 * OUTPUT: number of logical cores detected, zero if unsupported
 * NOTE: it's a caller's responsibility to make sure that this
 * function is only called for the Intel Pentium 4 processors */
.globl cpuinfo_htt_check
cpuinfo_htt_check:
	pushl	%ebx
	pushl	%ebp
	pushl	%edi
	movl	%esp, %ebp
	xorl	%edi, %edi
/* "HTT: %X logical core(s) supported" is at -36(%ebp) */
	pushl	$0x00000A64
	pushl	$0x6574726F
	pushl	$0x70707573
	pushl	$0x20297328
	pushl	$0x65726F63
	pushl	$0x206C6163
	pushl	$0x69676F6C
	pushl	$0x20582520
	pushl	$0x3A545448
/* HTT (bit 28 of %edx; standard function 1) */
	movl	$1, %eax
	cpuid
	testl	$0x10000000, %edx
	jz	.cpuinfo_htt_exit
/* obtain the number of logical cores */
	movl	$1, %eax
	cpuid
	shrl	$16, %ebx
	andw	$0x00FF, %bx
	movl	%ebx, %edi
/* evaluate the mode bit and behave accordingly */
	movb	16(%ebp), %al
	testb	$0x01, %al
	jz	.cpuinfo_htt_exit
	pushl	%ebx
	leal	-36(%ebp), %eax
	pushl	%eax
	call	printf
.cpuinfo_htt_exit:
	movl	%edi, %eax
	movl	%ebp, %esp
	popl	%edi
	popl	%ebp
	popl	%ebx
	ret
