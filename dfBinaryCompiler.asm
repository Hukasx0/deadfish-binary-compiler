;       https://github.com/Hukasx0
;   ~ Hubert Hukasx0 Kasperek
;

section .text
    global _start

_start:
    push rbp
    mov rbp,rsp
    mov rax,508
    mov [byteSize],rax
    mov rax,2
    mov rdi,[rbp+24]
    mov rsi,0
    syscall
    cmp rax,0
    jl _exit
    mov rdi,rax
    mov rax,0
    lea rsi,fileBuffer
    mov rdx,100000
    syscall
    push rax
    xor rcx,rcx
    push rcx
    mov rax,85
    mov rdi,[rbp+32]
    mov rsi,600o
    syscall
    mov rax,2
    mov rsi,1
    syscall
    mov [fileId],rax
    jmp _simpleCompiler

_simpleCompiler:
    pop rcx
    pop rax
    cmp rax,rcx
    je _fileEnd
    push rax
    mov al,[fileBuffer+rcx]
    inc rcx
    push rcx
    cmp al,105
    je _i
    cmp al,100
    je _d
    cmp al,115
    je _s
    cmp al,111
    je _o
    jmp _simpleCompiler
_i:
    mov rax,0xc0fe
    mov [instruction],rax
    lea rax,[instruction]
    mov rdx,2
    call _writeToFile
    mov rax,[byteSize]
    sub rax,2
    mov [byteSize],rax
    jmp _simpleCompiler
_d:
    mov rax,0xc8fe
    mov [instruction],rax
    lea rax,[instruction]
    mov rdx,2
    call _writeToFile
    mov rax,[byteSize]
    sub rax,2
    mov [byteSize],rax
    jmp _simpleCompiler
_s:
    ; TODO
    jmp _simpleCompiler
_o:
    mov rax,0x10cd0eb4
    mov [instruction],rax
    lea rax,[instruction]
    mov rdx,4
    call _writeToFile
    mov rax,[byteSize]
    sub rax,4
    mov [byteSize],rax
    jmp _simpleCompiler

_fileEnd:
    mov rax,0xfeeb
    mov [instruction],rax
    lea rax,[instruction]
    mov rdx,2
    call _writeToFile
    mov rax,[byteSize]
    xor rcx,rcx
    call _null
    mov rax,0xaa55
    mov [instruction],rax
    lea rax,[instruction]
    mov rdx,2
    call _writeToFile
    jmp _exit

_null:
    cmp rax,rcx
    je _ret
    push rax
    inc rcx
    push rcx
    mov rax,0x00
    mov [instruction],rax
    lea rax,[instruction]
    mov rdx,1
    call _writeToFile
    pop rcx
    pop rax
    jmp _null
_ret:
    ret

_writeToFile:
    mov rsi,rax
    mov rax,1
    mov rdi,[fileId]
    syscall
    ret

_exit:
    mov rax,60
    xor rdi,rdi
    syscall

section .bss
fileBuffer: resb 100000
fileId: resb 5
instruction: resb 100
byteSize: resb 10