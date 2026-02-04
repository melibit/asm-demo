.att_syntax

.section .data
  prompt:      .ascii "Enter number: "
  prompt_len = . - prompt
  result_msg:  .ascii "Maximum is: "
  result_len = . - result_msg

.section .text
  .global max

max:
  lea prompt(%rip), %rsi
  mov $prompt_len, %rdx
  call print
  call read_int
  mov %rax, %r12       
  
  lea prompt(%rip), %rsi
  mov $prompt_len, %rdx
  call print
  call read_int
  mov %rax, %r13       

  cmp %r13, %r12
  jge .first_is_max
  mov %r13, %rax
  jmp .print_res
.first_is_max:
  mov %r12, %rax

.print_res:
  push %rax
  lea result_msg(%rip), %rsi
  mov $result_len, %rdx
  call print
  pop %rax
  call print_int
  ret
