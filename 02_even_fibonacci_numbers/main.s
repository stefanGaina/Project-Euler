.global _start

.text

_start:
	movq %rsp, %rbp

	movq $1, %r10
	movq $1, %r11

LOOP:
	movq %r11, %rax
	xorq %rdx, %rdx
	movq $2, %rcx
	divq %rcx

	cmpq $0, %rdx
	jne LOOP_END

	# The result is in rbx.
	addq %r11, %rbx

LOOP_END:
	movq %r11, %rcx
	addq %r10, %r11
	movq %rcx, %r10
	cmpq $4000000, %r11
	jle LOOP

	movq $60, %rax
	movq $32, %rdi
	syscall

	pop %rbp
