.global _start

.text

_start:
	movq %rsp, %rbp

	xorq %r10, %r10
	xorq %r11, %r11
	/* The result is in r12. */
	xorq %r12, %r12

LOOP:
	incq %r10
	movq %r10, %rdi
	call _collatz_length

	cmpq %rax, %r11
	jge LOOP_END

	movq %rax, %r11
	movq %r10, %r12

LOOP_END:
	cmpq $1000000, %r10
	jl LOOP

	call _exit

_collatz_length:
	xorq %rsi, %rsi
	movq $2, %rcx
	movq $3, %rbx

COLLATZ_LENGTH_LOOP:
	cmpq $1, %rdi
	je COLLATZ_LENGTH_RETURN

	movq %rdi, %rax
	xorq %rdx, %rdx
	divq %rcx
	incq %rsi

	cmpq $0, %rdx
	jne COLLATZ_LENGTH_ODD

	movq %rax, %rdi
	jmp COLLATZ_LENGTH_LOOP

COLLATZ_LENGTH_ODD:
	movq %rdi, %rax
	mulq %rbx
	movq %rax, %rdi
	incq %rdi

	jmp COLLATZ_LENGTH_LOOP

COLLATZ_LENGTH_RETURN:
	movq %rsi, %rax
	ret

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
