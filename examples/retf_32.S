    .global write32

    .data
buffer:
    .space 0x100

    .text
write32:
    push  %rbp
    movq  %rsp, %rbp
    push  %rdi
    movq  $buffer, %rdi
    xor   %rax, %rax
    call  strncpy
    pop   %rdi
    movq  $buffer, %rsi
    lea   do_write32, %rax
    movq  $0x2300000000, %rcx
    xor   %rcx, %rax
    push  %rax
    retf

do_write32:
    xor   %eax, %eax
    movl  $4, %eax
    movl  %edi, %ebx
    movl  %esi, %ecx
    int   $0x80

    xor   %eax, %eax
    movl  $1, %eax
    xor   %ebx, %ebx
    int   $0x80
