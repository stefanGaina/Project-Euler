# make
# gdb s23
# layout regs
# br 73
# r
# the solution is in [28123 * (28123 + 1) / 2] - %r9

.global _start

.text

_start:
	movq %rsp, %rbp
	subq $7096 * 8, %rsp

	movq $12, %rsi			# number = 12
	xorq %rdi, %rdi			# offset = 0

abundant_loop:				# do
	movq %rsi, %rbx
	call _sum_of_divisors	# sum_of_divisors(number)

	cmpq %rax, %rsi			# if number < sum_of_divisors(number)
	jge not_abundant

	movq %rsi, (%rsp, %rdi)	# stack[offset] = number
	addq $8, %rdi			# ++offset

not_abundant:
	incq %rsi				# ++number

	cmpq $28123, %rsi		# while 28123 >= number
	jle abundant_loop

	movq $12, %rsi			# number = 12
	xorq %r9, %r9			# sum = 0

sum_loop:					# do
	xorq %r10, %r10			# index = 0

number_loop:				# do
	cmpq %rsi, (%rsp, %r10)	# if number > stack[index]
	jge not_solution

	movq %rsi, %r11			# temp_number = number
	subq (%rsp, %r10), %r11	# temp_number -= stack[index]
	movq %r10, %r12			# temp_index = index

find_loop:					# do
	cmpq %r11, (%rsp, %r12)	# if temp_number == stack[temp_index]
	jne not_found

	addq %rsi, %r9			# sum += number
	jmp not_solution		# break

not_found:
	addq $8, %r12			# ++temp_index

	cmpq %r12, %rdi			# while temp_index <= offset
	jge find_loop

	addq $8, %r10			# ++index

	cmpq %r10, %rdi			# while index <= offset
	jge number_loop

not_solution:
	incq %rsi				# ++number

	cmpq $28123, %rsi		# while 28123 >= number
	jle sum_loop

	call _exit

# %rbx - input
# %rax - the sum of its proper divisors
# Change %rcx, %rdx, %r8, %r9
_sum_of_divisors:
	xorq %r8, %r8			# sum = 0
	movq $1, %r9			# divisor = 1

divisor_loop:				# do
	movq %rbx, %rax
	xorq %rdx, %rdx
	movq %r9, %rcx
	divq %rcx

	cmpq $0, %rdx			# if 0 == input % divisor
	jne not_divisor

	addq %r9, %r8			# sum += divisor

not_divisor:
	incq %r9				# ++divisor

	cmpq %r9, %rbx			# while divisor < input
	jg divisor_loop

	movq %r8, %rax
	ret						# return sum

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
