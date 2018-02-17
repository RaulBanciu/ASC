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
    a db 5
    b db 8
    c db 9
    d db 4
; our code starts here
;a*d+b*c
segment code use32 class=code
    start:
        ; ...
        mov eax,0;golim eax
        mov ebx,0;golim ebx
        mov al,[a];mutam in al pe a
        mul byte [d];inmultim al cu d
        mov bx,ax;mutam ax in bx
        mov ax,0;golim ax
        mov al,[b];mutam in al pe b
        mul byte [c];inmultim al cu c
        add bx,ax;adaugam la bx pe ax
        mov ax,bx;mutam in bx pe ax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
