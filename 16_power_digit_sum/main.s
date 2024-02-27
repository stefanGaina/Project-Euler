.global _start

.equ STRING_SIZE, 256
.equ TERMINATOR, 99

.text

_start:
	movq %rsp, %rbp
	subq $STRING_SIZE, %rsp
	movq $1, (%rsp)
	movq $TERMINATOR, 1(%rsp)

	xorq %rcx, %rcx
	xorq %r11, %r11
	movq $10, %rsi

outer_loop:
	incq %rcx
	xorq %rbx, %rbx

inner_loop:
	movb (%rsp, %rbx), %r10b
	addb %r10b, %r10b
	addb %r11b, %r10b

	movq %r10, %rax
	xorq %rdx, %rdx
	divq %rsi

	movb %dl, (%rsp, %rbx)
	movb %al, %r11b

	incq %rbx
	cmpb $TERMINATOR, (%rsp, %rbx)
	jne inner_loop

	movb %r11b, (%rsp, %rbx)
	xorq %r11, %r11
	movb $TERMINATOR, 1(%rsp, %rbx)

	cmpq $1000, %rcx
	jl outer_loop

	xorq %rbx, %rbx
	/* The result is in rax. */
	xorq %rax, %rax

digit_sum_loop:
	movb (%rsp, %rbx), %r11b
	addq %r11, %rax

	incq %rbx
	cmpb $TERMINATOR, (%rsp, %rbx)
	jne digit_sum_loop

	call _exit

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
