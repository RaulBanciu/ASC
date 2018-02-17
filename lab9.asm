bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fread,fclose ,fprintf            ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    fis db 'D:\Arhitectura Sistemelor de Calcul\asm_tools\programele\fisiere\lab9.txt',0
    mode db 'w+',0
    descr dd -1
    len equ 100
    spec db '`~!@#$%^&*()-_+=[]\;,./{}|:<>?'
    lens equ $-spec
    text db 'Ana are mere.Eu am 5$.Ce-ai facut azi?',0
    leng equ $-text
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword mode;put the mode on stack                   ;
        push dword fis;put the path to file on stack            ; 
        call [fopen];open file                                  ;
        add esp, 4*2;clear stack                                ; deschidere fisier
        mov [descr],eax;mov eax in descr                        ;    
        cmp eax, 0;cmp eax with 0                               ;
        je final;if equal jump to final                         ;
        mov ebx,0;move in ebx 0
        mov esi,0;move in esi 0
        mov ecx,leng;move in ecx leng
        bucla:
            buclas:
                mov dl,[spec+ebx];move in dl each symbol from spec
                cmp BYTE [text+esi],dl;compare all characters in the text with the current symbol
                je special;if equal jump to special
                inc ebx;ebx+1
                cmp ebx,lens;compare ebx with length of special
                jne buclas;if not equal repeat
            jmp next;jump to next
            special:
                mov [text+esi],byte 'X';change the value of current character to X
            next:
                inc esi;esi+1
                mov ebx,0;ebx becomes 0
            cmp esi,ecx;compare esi with ecx
            jne bucla;if not equal repeat
        
        
        ; exit(0)
        final:
        push dword text;put the text on the stack                       ;
        push dword [descr];put the filepath on the stack                ; 
        call [fprintf];call printf                                      ; print in file
        add esp, 4*2;clear stack                                        ;
        push dword [descr];put filepath on stack                        ;;
        call [fclose];close file                                        ;;clear stack
        add esp, 4;clear stack                                          ;;
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
