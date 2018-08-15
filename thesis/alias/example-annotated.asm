g:
  subq    $8, %rsp
  movl    $1, %edi
  |~ { RAX -> {dyn@5, dyn@13}; sp+24@f -> dyn@1 } |
  call    malloc ; &dyn@5
  |~ { ||!RAX -> dyn@5;||~ sp+24@f -> dyn@13 }|
  addq    $8, %rsp
  ret

f:
  subq    $40, %rsp
  movl    $1, %edi
  call    malloc ; &dyn@13
  |~ {||+ RAX -> dyn@13 ||~}|
  movq    %rax, 24(%rsp)
  |~ { RAX -> dyn@13; ||+sp+24@f -> dyn@1||~}|
  movb    $97, (%rax) ; Safe
  call    g
  |~ { RAX -> dyn@5; sp+24@f -> dyn@13}|
  movq    %rax, 16(%rsp)
  |~ { RAX -> dyn@5; sp+24@f -> dyn@13;
     ||+sp+16@f -> dyn@5||~}|
  movb    $97, (%rax) ; Safe
  call    g
  |~ { ||!RAX -> dyn@5;||~ sp+24@f -> dyn@13;
     sp+16@f -> dyn@5}|
  movq    %rax, 8(%rsp)
  |~ { RAX -> dyn@5; sp+24@f -> dyn@13;
     sp+16@f -> dyn@5; ||+sp+8@f -> dyn@0||~}|
  movb    $97, (%rax) ; Safe
  movq    24(%rsp), %rdi
  |~ { RAX -> dyn@5; sp+24@f -> dyn@13;
     sp+16@f -> dyn@5; sp+8@f -> dyn@0;
     ||+RDI -> dyn@13||~ }|
  call    free ;; frees memory pointed to by RDI
  |~ { RAX -> dyn@5; sp+24@f -> dyn@13;
     sp+16@f -> dyn@5; sp+8@f -> dyn@0;
     RDI -> dyn@13; ||+dyn@1 -> free@35||~ }|
  movq    16(%rsp), %rdi
  |~ { RAX -> dyn@5; sp+24@f -> dyn@13;
     sp+16@f -> dyn@5; sp+8@f -> dyn@0;
     ||!RDI -> dyn@5;||~ dyn@13 -> free@35 } |
  call    free
  |~ { RAX -> dyn@5; sp+24@f -> dyn@13;
     sp+16@f -> dyn@5; sp+8@f -> dyn@0;
     RDI -> dyn@5; dyn@13 -> free@35;
     ||+dyn@5 -> free@43 }|
  movq    24(%rsp), %rax
  |~ { ||!RAX -> dyn@13;||~ sp+24@f -> dyn@1;
     sp+16@f -> dyn@5; sp+8@f -> dyn@0;
     RDI -> dyn@5; dyn@13 -> free@35;
     dyn@5 -> free@43} |
  movb    $98, (%rax) ; UaF
  movq    8(%rsp), %rax
  |~ { ||!RAX -> dyn@5;||~ sp+24@f -> dyn@13;
      sp+16@f -> dyn@5; sp+8@f -> dyn@0;
      RDI -> dyn@5; dyn@13 -> free@35;
      dyn@5 -> free@43 }|
  movb    $98, (%rax) ; Safe, but needs context
  addq    $40, %rsp
  ret
