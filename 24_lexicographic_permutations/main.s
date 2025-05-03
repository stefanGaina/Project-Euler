# make
# gdb s24
# layout regs
# br 38
# r
# x/16b $rsp
# after 6 zeros the result will be seen

.global _start

.text

_start:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movb $0, -10(%rbp)
	movb $1, -9(%rbp)
	movb $2, -8(%rbp)
	movb $3, -7(%rbp)
	movb $4, -6(%rbp)
	movb $5, -5(%rbp)
	movb $6, -4(%rbp)
	movb $7, -3(%rbp)
	movb $8, -2(%rbp)
	movb $9, -1(%rbp)		# uint8_t array = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }

	xorq %rbx, %rbx			# counter = 0

.main_loop:					# do
	lea -10(%rbp), %rdi
	call _next_permutation	# _next_permutation(array)

	incq %rbx
	cmpq $1000000, %rbx
	jl .main_loop			# while (1000000 > counter)

	leave
	jmp _exit

_next_permutation:			# (uint8_t[10] array)
	pushq %rbp
	movq %rsp, %rbp

	movq $8, %r8			# k = 8

.while_loop_1:
	movq %r8, %r9
	incq %r9
	movb (%rdi, %r8), %r10b
	movb (%rdi, %r9), %r11b
	cmpb %r10b, %r11b
	jg .end_while_loop_1	# while (array[k] >= array[k + 1])

	decq %r8				# --k

	jmp .while_loop_1
.end_while_loop_1:

	movq $9, %r9			# l = 9

.while_loop_2:
	movb (%rdi, %r8), %r10b
	movb (%rdi, %r9), %r11b
	cmpb %r10b, %r11b
	jg .end_while_loop_2	# while (array[k] >= array[l])

	decq %r9				# --l

	jmp .while_loop_2
.end_while_loop_2:

	movb (%rdi, %r8), %r10b
	movb (%rdi, %r9), %r11b
	movb %r10b, (%rdi, %r9)
	movb %r11b, (%rdi, %r8)	# swap(array[k], array[l])

	incq %r8
	movq %r8, %rsi
	movq $9, %rdx
	call _reverse			# _reverse(array, k + 1, 9)

	leave
	ret

_reverse:					# (uint8_t[10] array, start, end)
	pushq %rbp
	movq %rsp, %rbp

.while_loop:
	cmpq %rdx, %rsi
	jge .end_while_loop		# while (end > start)

	movb (%rdi, %rsi), %r8b
	movb (%rdi, %rdx), %r9b
	movb %r8b, (%rdi, %rdx)
	movb %r9b, (%rdi, %rsi)	# swap(array[start], array[end])

	incq %rsi				# ++start
	decq %rdx				# --end

	jmp .while_loop
.end_while_loop:

	leave
	ret

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
