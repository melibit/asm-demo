.att_syntax

.section .data 
  msg: .ascii "Assembly Experiments: (x86_64, linux)\n"
  msg_len = . - msg

  options_msg: .ascii "\nSelect Experiment:\n[0] exit\n[1] max.S\n[2] power.S\n[3] palindrome.S\nEnter number: "
  options_len = . - options_msg

  max_msg: .ascii "\nmax.S:\n"
  max_msg_len = . - max_msg
  
  power_msg: .ascii "\npower.S:\n"
  power_msg_len = . - power_msg

  palindrome_msg: .ascii "\npalindrome.S:\n"
  palindrome_msg_len = . - palindrome_msg 
  
  fail_msg: .ascii "\nInvalid input\n"
  fail_msg_len = . - fail_msg

  exit_msg: .ascii "\nGoodbye\n"
  exit_len = . - exit_msg

.section .text
  .global _start

_start:
  lea msg(%rip), %rsi
  mov $msg_len, %rdx
  call print

loop:
  lea options_msg(%rip), %rsi
  mov $options_len, %rdx
  call print 
  call read_int
  
  cmpq $0, %rax
  je exit

  cmpq $1, %rax
  je ex_max

  cmpq $2, %rax
  je ex_power 

  cmpq $3, %rax
  je ex_palindrome
 
  lea fail_msg(%rip), %rsi
  mov $fail_msg_len, %rdx
  call print

  jmp loop

ex_max:
  lea max_msg(%rip), %rsi
  mov $max_msg_len, %rdx
  call print
  call max 
  jmp loop

ex_power:
  lea power_msg(%rip), %rsi
  mov $power_msg_len, %rdx
  call print
  call power
  jmp loop

ex_palindrome:
  lea palindrome_msg(%rip), %rsi
  mov $palindrome_msg_len, %rdx
  call print
  call palindrome 
  jmp loop
  
 exit:
  lea exit_msg(%rip), %rsi
  mov $exit_len, %rdx
  call print

  mov $60, %rax # sys_exit
  xor %rdi, %rdi
  syscall
