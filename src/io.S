.att_syntax

.section .data

.section .bss
  .comm buffer, 32
  .comm out_str, 32

.section .text
  .global print
  .global read_int
  .global print_int


print:
  mov $1, %rax # sys_write
  mov $1, %rdi # stdout
  syscall
  ret

print_int:
  lea out_str(%rip), %rdi
  add $31, %rdi
  movb $10, (%rdi)     
  mov $10, %rbx
 
  xor %r8, %r8        
  test %rax, %rax
  jns .conv_loop       
  inc %r8              
  neg %rax            
.conv_loop:
  xor %rdx, %rdx
  div %rbx
  add $'0', %dl
  dec %rdi
  movb %dl, (%rdi)
  test %rax, %rax
  jnz .conv_loop

  test %r8, %r8
  jz .do_print
  dec %rdi
  movb $'-', (%rdi)
.do_print:
  lea out_str(%rip), %rsi
  add $32, %rsi
  sub %rdi, %rsi       
  mov %rsi, %rdx       
  mov %rdi, %rsi      
  call print
  ret

read_int:
  mov $0, %rax # sys_read
  mov $0, %rdi # stdin
  lea buffer(%rip), %rsi
  mov $32, %rdx
  syscall

  xor %rax, %rax
  xor %r8, %r8
  lea buffer(%rip), %rcx
 
  movzx (%rcx), %rdx
  cmp $'-', %dl
  jne .parse_loop     
  inc %r8              
  inc %rcx             

.parse_loop:
  movzx (%rcx), %rdx
  cmp $10, %dl         
  je .apply_sign
  cmp $'0', %dl
  jb .next
  cmp $'9', %dl
  ja .next
  sub $'0', %dl
  imul $10, %rax
  movzx %dl, %rdx
  add %rdx, %rax
.next:
  inc %rcx
  jmp .parse_loop
.apply_sign:
  test %r8, %r8        
  jz .done              
  neg %rax            
.done:
  ret
