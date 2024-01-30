.global _start

.text

_start:
	movq %rsp, %rbp

	movq $999, %r10
	movq $999, %r11
	movq $10, %rcx
	# The result is in r15.
	xorq %r15, %r15

LOOP_START:
	movq %r10, %rax
	mulq %r11
	movq %rax, %rbx
	movq %rax, %r12
	xorq %r13, %r13

IS_PALINDROME:
	movq %r12, %rax
	xorq %rdx, %rdx
	divq %rcx

	movq %rax, %r12
	movq %r13, %rax
	movq %rdx, %r14
	mulq %rcx
	movq %rax, %r13
	addq %r14, %r13

	cmpq $0, %r12
	jne IS_PALINDROME

	cmpq %rbx, %r13
	jne NOT_PALINDROME

	cmpq %rbx, %r15
	jge NOT_PALINDROME

	movq %rbx, %r15

NOT_PALINDROME:

	cmpq $100, %r11
	jne END

	decq %r10
	movq $1000, %r11

END:
	decq %r11

	cmpq $99, %r10
	jne LOOP_START

	movq $60, %rax
	movq $32, %rdi
	syscall

	pop %rbp
