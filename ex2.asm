.global _start

.section .text
_start:
  xor %rcx, %rcx
  main_loop:
  inc %rcx
  movq %rcx, %rax
  mulq (a)
  divq (b)
  cmp $0, %rdx
  je end
  xor %rdx, %rdx
  jmp main_loop
  
  end:
  movq %rax, c
  
