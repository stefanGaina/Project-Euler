.global _start

.text

_start:
	movq %rsp, %rbp

	movq $3, %r10
	/* The result is in r11. */
	movq $2, %r11

LOOP:
	movq %r10, %rdi
	call _is_prime

	cmpq $0, %rax
	je LOOP_END

	addq %r10, %r11

LOOP_END:
	addq $2, %r10

	cmpq $2000000, %r10
	jle LOOP

	call _exit

_is_prime:
	movq %rdi, %rax
	xorq %rdx, %rdx
	movq $2, %rcx
	divq %rcx

	cmpq $0, %rdx
	je IS_PRIME_RETURN_FALSE

	movq %rax, %rsi
	decq %rcx

IS_PRIME_LOOP:
	addq $2, %rcx
	cmpq %rcx, %rsi
	jl IS_PRIME_RETURN_TRUE

	movq %rdi, %rax
	xorq %rdx, %rdx
	divq %rcx

	cmpq $0, %rdx
	je IS_PRIME_RETURN_FALSE
	jmp IS_PRIME_LOOP

IS_PRIME_RETURN_TRUE:
	movq $1, %rax
	ret

IS_PRIME_RETURN_FALSE:
	xorq %rax, %rax
	ret

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
