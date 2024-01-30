.global _start

.text

_start:
	movq %rsp, %rbp

	xorq %r10, %r10
	xorq %r11, %r11
	xorq %r12, %r12

LOOP_START:
	incq %r10

	movq %r10, %rax
	mulq %r10

	addq %rax, %r11
	addq %r10, %r12

	cmpq $100, %r10
	jl LOOP_START

	movq %r12, %rax
	mulq %r12

	# The result is in rax.
	subq %r11, %rax

	movq $60, %rax
	movq $32, %rdi
	syscall

	pop %rbp
