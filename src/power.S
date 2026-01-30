.att_syntax

.section .data
  prompt:   .ascii "Enter number: "
  prompt_len = . - prompt
  result_msg:  .ascii "Power is: "
  result_len = . - result_msg
  

.section .text 
  .global power

power:
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

  movq $1, %rax 
  testq %r13, %r13
  jz power_done
power_loop:
  imulq %r12, %rax
  decq %r13
  jnz power_loop
power_done:
 
  push %rax
  lea result_msg(%rip), %rsi
  mov $result_len, %rdx
  call print
  pop %rax
  call print_int
  ret
