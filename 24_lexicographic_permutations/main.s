.global _start

.text

_start:
	movq %rsp, %rbp
	subq $7096 * 8, %rsp
	
main_loop:				# do


	cmpq $1000000
	jl main_loop

	call _exit

_exit:
	movq $60, %rax
	movq $32, %rdi
	syscall
