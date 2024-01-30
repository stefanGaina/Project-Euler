.global _start

.text

_start:
	movq %rsp, %rbp

	movq $999, %r10
	xorq %rbx, %rbx

LOOP:
	movq %r10, %rax
	xorq %rdx, %rdx
	movq $3, %rcx
	divq %rcx

	cmpq $0, %rdx
	je IS_DIV

	movq %r10, %rax
	xorq %rdx, %rdx
	movq $5, %rcx
	divq %rcx

	cmpq $0, %rdx
	je IS_DIV

	jmp END

IS_DIV:
	# The result is in rbx.
	addq %r10, %rbx

END:
	decq %r10
	cmpq $0, %r10
	jne LOOP

	movq $60, %rax
	movq $32, %rdi
	syscall

	pop %rbp
