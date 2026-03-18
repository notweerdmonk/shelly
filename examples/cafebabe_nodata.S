  .global _start
  .text
_start:
  push %rbp
  mov %rsp, %rbp
  subq $16, %rsp
  movl $0x65666163, -0x10(%rbp)
  movl $0x65626162, -0x0c(%rbp)
  movl $0x0a, -0x8(%rbp)
  mov $1, %rdi    # stdout
  mov %rsp, %rsi  # &"cafebabe\n"
  mov $9, %rdx    # sizeof("cafebabe\n") - 1
  mov $1, %rax    # __NR_write
  syscall
  pop %rbp
  mov $60, %rax   # __NR_exit
  xor %rdi, %rdi  # 0
  syscall
