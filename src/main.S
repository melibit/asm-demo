.att_syntax

.section .data 
  msg: .ascii "Assembly Experiments: (x86_64, linux)\n"
  msg_len = . - msg

  max_msg: .ascii "\nmax.S:\n"
  max_msg_len = . - max_msg
  
  power_msg: .ascii "\npower.S:\n"
  power_msg_len = . - power_msg

  palindrome_msg: .ascii "\npalindrome.S:\n"
  palindrome_msg_len = . - palindrome_msg 

.section .text
  .global _start

_start:
  lea msg(%rip), %rsi
  mov $msg_len, %rdx
  call print
  
  lea max_msg(%rip), %rsi
  mov $max_msg_len, %rdx
  call print
   
  call max 
 
  lea power_msg(%rip), %rsi
  mov $power_msg_len, %rdx
  call print

  call power

  lea palindrome_msg(%rip), %rsi
  mov $palindrome_msg_len, %rdx
  call print

  call palindrome 
    
 exit:
  mov $60, %rax # sys_exit
  xor %rdi, %rdi
  syscall
