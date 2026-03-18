	.global _start
	.data
string:
	.asciz "cafebabe\n"
  len = . - string
  .text
_start:
	push %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movq $1, %rdi
	movq $string, %rsi
	#movq string(%rip), %rsi
	movq $len, %rdx
	movq $1, %rax
	syscall
	pop %rbp
	movq $60, %rax
	xor  %rdi, %rdi
	syscall
