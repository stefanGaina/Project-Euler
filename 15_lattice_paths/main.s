.global _start

.text

_start:
	movq %rsp, %rbp

	xorq %rdi, %rdi
	xorq %rsi, %rsi
	call _lattice_paths

	/* The result is in rax. */
	call _exit

_lattice_paths:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp

	cmpq $20, %rdi
	je LATTIE_PATHS_RETURN_1

	cmpq $20, %rsi
	je LATTIE_PATHS_RETURN_1

	movq %rdi, (%rsp)
	movq %rsi, 8(%rsp)
	movq $0, 16(%rsp)

	incq %rdi
	call _lattice_paths

	addq %rax, 16(%rsp)

	movq (%rsp), %rdi
	movq 8(%rsp), %rsi
	incq %rsi
	call _lattice_paths

	addq 16(%rsp), %rax
	jmp LATTIE_PATHS_RETURN

LATTIE_PATHS_RETURN_1:
	movq $1, %rax

LATTIE_PATHS_RETURN:
	movq %rbp, %rsp
	popq %rbp
	ret

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
