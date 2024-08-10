# make
# gdb s20
# layout regs
# br 77
# the result is in %rax

.global _start

.equ TERMINATOR, 9999999

.text

_start:
	movq %rsp, %rbp
	subq $512 * 8, %rsp

	movq $2, %rsi				   # factor = 2
	movq $10, %rcx				   # DIVIDER = 10
	xorq %r11, %r11				   # carry = 0
	xorq %rdi, %rdi				   # offset = 0

	movq $1, (%rsp)
	movq $TERMINATOR, 8(%rsp)

outer_loop:						   # do
multiply_loop:					   # do
	movq (%rsp, %rdi), %rax		   # digit = stack[offset]
	mulq %rsi					   # digit *= factor
	addq %r11, %rax				   # digit += carry

	cmpq $10, %rax				   # if 10 <= digit
	jl else

	xorq %rdx, %rdx
	divq %rcx
	movq %rax, %r11				   # carry  = digit / 10
	movq %rdx, %rax				   # digit %= 10
	jmp endif

else:
	xorq %r11, %r11				   # carry = 0

endif:
	movq %rax, (%rsp, %rdi)		   # stack[offset] = digit
	addq $8, %rdi				   # ++offset

	cmpq $TERMINATOR, (%rsp, %rdi) # while TERMINATOR != stack[offset]
	jne multiply_loop

carry_loop_begin:
	cmpq $0, %r11				   # while 0 != carry
	je carry_loop_end

	movq %r11, %rax
	xorq %rdx, %rdx
	divq %rcx
	movq %rax, %r11				   # carry /= 10

	movq %rdx, (%rsp, %rdi)		   # stack[offset] = carry % 10
	addq $8, %rdi				   # ++offset

	jmp carry_loop_begin

carry_loop_end:
	movq $TERMINATOR, (%rsp, %rdi) # stack[offset] = TERMINATOR
	xorq %rdi, %rdi				   # offset = 0
	incq %rsi					   # ++factor

	cmpq $100, %rsi				   # while 100 >= factor
	jle outer_loop

	xorq %rdi, %rdi				   # offset = 0
	xorq %rax, %rax				   # result = 0

digit_sum_loop:					   # do
	movq (%rsp, %rdi), %r11		   # digit = stack[offset]
	addq %r11, %rax				   # result += digit
	addq $8, %rdi				   # ++offset

	cmpq $TERMINATOR, (%rsp, %rdi) # while TERMINATOR != stack[offset]
	jne digit_sum_loop

	call _exit

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
