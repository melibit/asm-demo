.att_syntax

.section .data 
  prompt:      .ascii "Enter number: "
  prompt_len = . - prompt
  pass_msg:   .ascii "Is prime\n"
  pass_msg_len = . - pass_msg 
  fail_msg:   .ascii "Isn't prime\n"
  fail_msg_len = . - fail_msg 

.section .text 
  .global prime 

prime:
  lea prompt(%rip), %rsi
  mov $prompt_len, %rdx
  call print 
  call read_int
  mov %rax, %r12

  cmpq $2, %r12
  jl .fail
  je .pass

  movq $2, %rbx 
.prime_loop:
  movq %r12, %rax
  xorq %rdx, %rdx
  movq $2, %rcx
  divq %rcx 
  cmpq %rbx, %rax
  jl .pass

  movq %r12, %rax
  xorq %rdx, %rdx
  divq %rbx 
  testq %rdx, %rdx
  jz .fail

  incq %rbx 
  jmp .prime_loop

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

