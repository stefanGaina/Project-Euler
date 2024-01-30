.global _start

.text

_start:
	movq %rsp, %rbp

	movq $775145, %r10

LOOP_START:
	# The result is in r10.
	subq $2, %r10

	movq $600851475143, %rax
	xorq %rdx, %rdx
	movq %r10, %rcx
	divq %rcx

	cmpq $0, %rdx
	jne LOOP_START

	movq %r10, %rax
	xorq %rdx, %rdx
	movq $2, %rcx
	divq %rcx

	movq %rax, %r11
	decq %rcx

IS_PRIME:
	movq %r10, %rax
	xorq %rdx, %rdx
	addq $2, %rcx
	divq %rcx

	cmpq $0, %rdx
	je LOOP_START

	cmpq %rcx, %r11
	jg IS_PRIME

	movq $60, %rax
	movq $32, %rdi
	syscall

	pop %rbp
