# make
# r
# the solution is in %rax

.global _start

.text

_start:
	pushq %rbp
	movq %rsp, %rbp
	subq $2000, %rsp

	movb $99, %al
	movq $2000, %rcx
	lea 0(%rsp), %rdi
	rep stosb				## Initialize memory to 0

	movb $1, 0(%rsp)
	movb $1, 1000(%rsp)

	lea 0(%rsp), %rdi
	lea 1000(%rsp), %rsi
	call _find_fibonacci_1000

	leave
	jmp _exit

_find_fibonacci_1000:		## uint64_t (uint8_t[1000] first, uint8_t[1000] second)
	pushq %rbp
	movq %rsp, %rbp

	movq $2, %rax			## counter = 2

while_loop_1:
	cmpb $99, 999(%rdi)
	jne end_while_loop_1	## while (99 == first[999])

	xorq %r8, %r8			## index = 0

while_loop_2:
	cmpb $99, (%rdi, %r8)
	je end_while_loop_2		## while (99 != first[index])

	movb (%rdi, %r8), %r10b
	addb %r10b, (%rsi, %r8)	## second[index] += first[index]

	cmpb $10, (%rsi, %r8)
	jl is_not_carry			## if (10 <= second[index])

	cmpb $99, 1(%rsi, %r8)
	jne not_99				## if (99 == second[index + 1])

	movb $0, 1(%rsi, %r8)

not_99:
	subb $10, (%rsi, %r8)	## second[index] -= 10
	incb 1(%rsi, %r8)		## ++second[index + 1]

is_not_carry:
	incq %r8				## ++index

	jmp while_loop_2
end_while_loop_2:

	cmpb $10, (%rsi, %r8)
	jl not_10				## if (10 <= second[index])

	cmpb $99, (%rsi, %r8)
	je not_10

	subb $10, (%rsi, %r8)
	movb $1, 1(%rsi, %r8)

not_10:
	movq %rdi, %r9
	movq %rsi, %rdi
	movq %r9, %rsi			## swap(first, second)

	incq %rax				## ++counter

	jmp while_loop_1
end_while_loop_1:

	leave
	ret						## return counter

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
