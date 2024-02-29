.global _start

.data

.array:
	.quad 75
	.quad 95, 64
	.quad 17, 47, 82
	.quad 18, 35, 87, 10
	.quad 20, 4 , 82, 47, 65
	.quad 19, 1 , 23, 75, 3 , 34
	.quad 88, 2 , 77, 73, 7 , 63, 67
	.quad 99, 65, 4 , 28, 6 , 16, 70, 92
	.quad 41, 41, 26, 56, 83, 40, 80, 70, 33
	.quad 41, 48, 72, 33, 47, 32, 37, 16, 94, 29
	.quad 53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14
	.quad 70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57
	.quad 91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48
	.quad 63, 66, 4 , 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31
	.quad 4 , 62, 98, 27, 23, 9 , 70, 98, 73, 93, 38, 53, 60, 4 , 23

.text

_start:
	movq %rsp, %rbp

	leaq .array(%rip), %r11
	movq $16, %rcx
	movq $(120 * 8), %rbx

outer_loop:
	decq %rcx

	movq %rcx, %rax
	movq $8, %rsi
	mulq %rsi
	subq %rax, %rbx

	movq %rbx, %r10
	movq %rcx, %r12

inner_loop:
	decq %r12
	addq $8, %r10

	movq %rcx, %rax
	movq $8, %rsi
	mulq %rsi

	movq %r10, %rdi
	subq %rax, %rdi
	movq %rdi, %rax

	movq %r10, %rsi
	subq $8, %rsi
	movq (%r11, %rsi), %rsi

	cmpq %rsi, (%r11, %r10)
	jle left_greater

	movq (%r11, %r10), %rsi

left_greater:
	addq %rsi, (%r11, %rax)

inner_loop_end:
	cmpq $1, %r12
	jg inner_loop

	cmpq $1, %rcx
	jg outer_loop

	/* The result is in %rax / 2. */
	movq (%r11), %rax

	call _exit

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
