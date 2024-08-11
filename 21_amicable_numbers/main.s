# make
# gdb s21
# layout regs
# br 40
# r
# the result is in %rsi

.global _start

.text

_start:
	movq %rsp, %rbp

	xorq %rsi, %rsi			# sum = 0
	movq $1, %rdi			# current = 0

main_loop:					# do

	movq %rdi, %rbx
	call _sum_of_divisors	# sum_of_divisors(current)

	cmpq %rax, %rdi			# if current != divisor_sum
	je not_amicable_number

	movq %rax, %rbx
	call _sum_of_divisors	# sum_of_divisors(divisor_sum)

	cmpq %rax, %rdi			# if current == divisor_sum
	jne not_amicable_number

	addq %rax, %rsi			# sum += current

not_amicable_number:
	incq %rdi				# ++current

	cmpq $10000, %rdi		# while 10000 <= current
	jle main_loop

	call _exit

# %rbx - input
# %rax - the sum of its proper divisors
# Does not change %rsi, %rdi
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
