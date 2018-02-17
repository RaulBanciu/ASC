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
    a db 4
    b db 6
    c db -5
    d dd 20
    e dq 15
; our code starts here
;2/(a+b*c-9)+e-d
;a,b,c-byte; d-doubleword; e-qword
segment code use32 class=code
    start:
        ; ...
        mov eax,0;we clear the registers eax,ebx,ecx,edx
        mov ebx,0
        mov ecx,0
        mov edx,0
        mov al,[b];we move in al the value of b
        imul byte [c];we multiply with sign the value in the register ax with the value of c
        sub ax,word 9;we subtract from ax the value 9
        mov bx,ax; we move ax in bx
        mov eax,0;we clear eax
        mov al,[a];move the value of a to al
        cbw;convert al to ax
        add ax,bx;add to ax the value of register bx
        mov bx,ax;we move in bx the value of ax
        mov eax,dword 2;we move in ax the value 2
        idiv bx;we do a signed divison of eax with bx
        cwd;we convert ax to the double word dx:ax
        sub ax,[d];we subtract ax the value of d
        sbb dx,[d+2];we subtract with carry from dx the value of d+2
        push dx;we push on the stack dx
        push ax;we push on the stack ax
        pop eax;we put in eax the doubleword dx:ax
        cdq;convert eax to qword edx:eax
        add eax,[e];add to eax the value of e
        adc edx,[e+4];add to edx the value of e+4
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
