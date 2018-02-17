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
    a db 2
    b db 12
    c db 8
    d dw 6
; our code starts here
;((a+b-c)*2 + d-5)*d
segment code use32 class=code
    start:
        ; ...
        mov eax,0 ;golim eax
        mov ebx,0; golim ebx
        mov al,[a]; mutam in al pe a
        add al,[b]; adaugam in al pe b
        sub al,[c]; scadem din al pe c
        mov bl,2; mutam in bl pe 2
        mul bl;inmultim al cu bl
        add ax,[d];adaugam la ax pe d
        sub ax,5;scadem din ax pe 5
        mul word [d];inumltim ax cu d
        ;mov ebx,0
        ;mov bx,dx
        ;shl ebx,16
        ;mov bx,ax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
