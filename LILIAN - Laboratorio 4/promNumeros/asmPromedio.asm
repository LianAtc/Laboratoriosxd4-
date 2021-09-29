
global asmPromedio
    section .text
    
asmPromedio:
    ; Prologo
    push rbp
    mov rbp, rsp
    push rsi
    push rdi
    push rbx
        
    ; Calling conv 64 bits -> LEN: rdi, *v: rsi, *asmprom: rdx
    
    xorps xmm0, xmm0
    xorps xmm1, xmm1             ; sum = 0.0
    xorps xmm2, xmm2
    
    cvtsi2ss xmm2, rdi           ; LEN
    
    cmp rdi, 0                   ; Si no tenemos datos slaimos
    je fin
    
bucle:
    movss xmm0, [rsi]              ; Direccion primer elemento
    addss xmm1, xmm0
    add rsi, 4
    dec rdi                        ; Cuando este llegue a cero se levantara la bandera de cero
    jnz bucle
    
    
    divss xmm1, xmm2             ; sum/LEN
    
fin:
    movss [rdx], xmm1            ; 
    
    ; Epilogo
    pop rdx
    pop rdi
    pop rsi
    mov rsp, rbp
    pop rbp
    
    ret
    
