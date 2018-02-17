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
    c db 5
    d dd 20
    e dq 15
; our code starts here
;2/(a+b*c-9)+e-d
;a,b,c-byte; d-doubleword; e-qword
segment code use32 class=code
    start:
        ; ...
        mov eax,0;we clear registers eax,ebx,ecx,edx
        mov ebx,0
        mov ecx,0
        mov edx,0
        mov bl,[a];we move the value of a to bl
        mov al,[b];we move the value of b to al
        mul byte [c];we multiply al with the byte c
        sub ax,word 9;we subtract from ax 9
        mov cx,ax;we move in cx the value stored in ax
        mov eax,0;clear eax
        mov al,bl;mov in al the value of bl
        add cx,ax;we add to cx the value of ax
        mov eax,0;we clear eax
        mov eax,2;we move to eax the value 2
        div word cx;;we divide eax with the word cx
        mov edx,0;we clear edx,we dont need the rest of the division
        add eax,[e];we add to eax the value of e
        adc edx,[e+4];we add with carry to edx the value of e+4
        sub ax,[d];we subtract from ax the value of d
        sbb dx,[d+2];we subtract from dx the value of d+2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
