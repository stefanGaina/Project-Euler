.global _start

.text

_start:
	movq %rsp, %rbp

	# The result is in r10.
	movq $2519, %r10

LOOP_START:
	incq %r10
	movq $0, %rcx

IS_DIV:
	movq %r10, %rax
	xorq %rdx, %rdx
	incq %rcx
	divq %rcx

	cmpq $0, %rdx
	jne LOOP_START

	cmpq $20, %rcx
	jne IS_DIV

	movq $60, %rax
	movq $32, %rdi
	syscall

	pop %rbp
