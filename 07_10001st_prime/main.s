.global _start

.text

_start:
	movq %rsp, %rbp

	movq $1, %r12
	# The result is in r13.
	movq $3, %r13

LOOP_START:
	movq %r13, %rdi
	call _is_prime

	cmpq $0, %rax
	je NOT_PRIME

	incq %r12

NOT_PRIME:
	addq $2, %r13

	cmpq $10001, %r12
	jl LOOP_START

	call exit
	pop %rbp

_is_prime:
	movq %rdi, %rax
	xorq %rdx, %rdx
	movq $2, %rcx
	divq %rcx

	cmpq $0, %rcx
	je IS_PRIME_RETURN_FALSE

	movq %rax, %rsi
	incq %rcx

IS_PRIME_LOOP:
	movq %rdi, %rax
	xorq %rdx, %rdx
	addq $2, %rcx
	divq %rcx

	cmpq $0, %rdx
	je IS_PRIME_RETURN_FALSE

	cmpq %rcx, %rsi
	jg IS_PRIME_LOOP

	movq $1, %rax
	ret

IS_PRIME_RETURN_FALSE:
	xorq %rax, %rax
	ret

exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
