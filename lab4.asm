bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 1101001101101000b
    b dw 0000110111111100b
    c dd 0
; our code starts here
; Se dau cuvintele A si B. Sa se obtina dublucuvantul C:
; bitii 0-4 ai lui C coincid cu bitii 11-15 ai lui A
; bitii 5-11 ai lui C au valoarea 1
; bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B
; bitii 16-31 ai lui C coincid cu bitii lui A
segment code use32 class=code
    start:
        ; ...
        mov eax,0;we clear eax,ebx,ecx
        mov ebx,0
        mov ecx,0
        mov ax,[a];mov ax the value of a
        mov bx,[b];mov in bx the value of b
        ror ax,11;we rotate to right ax with 11 bits
        mov cl,al;we mov al to cl
        or ecx,00000000000000000000111111100000b;we use or to get the bits 5-11 to be 1
        ror bx,8;we rotate bx with 8 bits to right
        ror ecx,12;we rotate with 12 bits ecx to right
        or cl,bl;we get bits 12-15 from b  to c
        rol ecx,12;rotate ecx with 12 bits to left
        ror ecx,16;rotate ecx with 16 bits to right
        mov cx,[a];mov in cx value of a
        rol ecx,16;;rotate to left ecx with 16 bits
        mov [c],ecx;mov ecx in c
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
