.global _start

.text

_start:
	movq %rsp, %rbp

	/* The result is in r10. */
	xorq %r10, %r10
	xorq %r11, %r11

LOOP:
	incq %r11
	addq %r11, %r10

	movq %r10, %rdi
	call _is_highly_divisible

	cmpq $0, %rax
	je LOOP

	call _exit

_is_highly_divisible:
	movq %rdi, %rax
	xorq %rdx, %rdx
	movq $2, %rcx
	divq %rcx

	movq %rax, %rbx
	movq $2, %rsi

IS_HIGHLY_DIVISIBLE_LOOP:
	cmpq %rcx, %rbx
	jl IS_HIGHLY_DIVISIBLE_RETURN

	movq %rdi, %rax
	xorq %rdx, %rdx
	divq %rcx

	cmpq $0, %rdx
	jne IS_HIGHLY_DIVISIBLE_NOT_DIVISOR

	incq %rsi

IS_HIGHLY_DIVISIBLE_NOT_DIVISOR:
	incq %rcx
	jmp IS_HIGHLY_DIVISIBLE_LOOP

IS_HIGHLY_DIVISIBLE_RETURN:
	cmpq $500, %rsi
	jl IS_HIGHLY_DIVISIBLE_RETURN_FALSE

	movq $1, %rax
	ret

IS_HIGHLY_DIVISIBLE_RETURN_FALSE:
	movq $0, %rax
	ret

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
