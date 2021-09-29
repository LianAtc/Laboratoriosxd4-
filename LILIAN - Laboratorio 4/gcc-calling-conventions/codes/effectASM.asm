global effectASM        ;IGUAL AL NOMBRE DE LA FUNCION
    section .text

effectASM:
    xor r8, r8
    xor r9, r9
    xor r10, r10
    xor rax, rax

    ; rdi << *A
    ; rsi << *B
    ; rdx << *Casm
    ; xmm0 << alpha
    ; rcx << imgSize

bucle:
    cmp ecx, r8d        ; MENOR A 0
    jle final

    mov r9b, [rsi+r8]   ; B[i] <- contador
    mov al, [rdi+r8]    ; A[i]
    mov r10b, r9b
    cvtsi2ss xmm2, r9   ; float(B[i])
    sub r10b, al        ; (B[i]-A[i])
    cvtsi2ss xmm1, r10  ; float(B[i]-A[i])
    mulss xmm1, xmm0    ; alpha * float(B[i]-A[i])
    addss xmm1, xmm2    ; float(B[i]) + alpha * float(B[i]-A[i])
    cvttss2si rax, xmm1 ; uchar(float(B[i]) + alpha * float(B[i]-A[i]))
    mov [rdx+r8], al    ; Casm[i]
    inc r8              ; Siguiente pixel
    jmp bucle
final:
    ret