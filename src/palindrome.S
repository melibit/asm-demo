.att_syntax

.section .data 
  prompt:      .ascii "Enter number: "
  prompt_len = . - prompt
  pass_msg:   .ascii "Is a palindrome\n"
  pass_msg_len = . - pass_msg 
  fail_msg:   .ascii "Isn't a palindrome\n"
  fail_msg_len = . - fail_msg 

.section .text 
  .global palindrome 

palindrome:
  lea prompt(%rip), %rsi
  mov $prompt_len, %rdx
  call print 
  call read_int
  mov %rax, %r12

  xor %rcx, %rcx 
  movq $10, %rbx
.reverse_loop:
  cmpq $0, %rax    
  je .compare 
  xorq %rdx, %rdx        
  divq %rbx            
  imulq $10, %rcx      
  addq %rdx, %rcx       
  jmp .reverse_loop

.compare:
  cmpq %r12, %rcx      
  je .pass 
.fail:
  lea fail_msg(%rip), %rsi
  mov $fail_msg_len, %rdx
  call print
  ret

.pass:
  lea pass_msg(%rip), %rsi
  mov $pass_msg_len, %rdx
  call print
  ret
