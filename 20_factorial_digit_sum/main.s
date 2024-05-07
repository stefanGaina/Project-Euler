.global _start

.equ TERMINATOR, 9999999

.text

_start:
	movq %rsp, %rbp
	subq $256 * 8, %rsp

	movq $1, %rsi
	movq $10, %rcx
	movq $1, %r11
	xorq %rdi, %rdi

outer_loop:
	cmpq $0, %r11
	je no_carry

	movq %r11, (%rsp, %rdi)
	addq $8, %rdi
	movq $TERMINATOR, (%rsp, %rdi)

no_carry:
	incq %rsi
	xorq %rdi, %rdi
	xorq %r11, %r11

inner_loop:
	movq (%rsp, %rdi), %rax
	mulq %rsi
	addq %r11, %rax

	xorq %rdx, %rdx
	divq %rcx

	198 * 99
	  11502 C9 C7 + 9

	movq %rdx, (%rsp, %rdi)
	movq %rax, %r11

	addq $8, %rdi
	cmpq $TERMINATOR, (%rsp, %rdi)
	jne inner_loop

	cmpq $100, %rsi
	jne outer_loop

	xorq %rdi, %rdi
	/* The result is in rax. */
	#movq %r11, %rax
	xorq %rax, %rax

digit_sum_loop:
	movq (%rsp, %rdi), %r11
	addq %r11, %rax

	addq $8, %rdi
	cmpq $TERMINATOR, (%rsp, %rdi)
	jne digit_sum_loop

	call _exit

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
