.global _start

.text

_start:
	movq %rsp, %rbp

	/* This is a. */
	xorq %r10, %r10

LOOP_1:
	incq %r10
	/* This is b. */
	movq %r10, %r11

	movq %r10, %rax
	mulq %r10
	movq %rax, %rbx

LOOP_2:
	movq %r10, %r13
	incq %r11
	addq %r11, %r13

	cmpq $999, %r13
	jg LOOP_1

	/* This is c. */
	movq $1000, %r12
	subq %r13, %r12

	movq %r11, %rax
	mulq %r11
	movq %rax, %rcx
	addq %rbx, %rcx

	movq %r12, %rax
	mulq %r12

	cmpq %rax, %rcx
	jne LOOP_2

	/* The result is in rax. */
	movq %r10, %rax
	mulq %r11
	mulq %r12

	call _exit

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
