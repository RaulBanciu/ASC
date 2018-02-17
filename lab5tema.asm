bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
extern scanf
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    n dd 0
    m dd 0
    format db "%d",0
    rezultat resd 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword n;punem pe stiva n-valoarea in care se citeste prima valoare
        push dword format;punem pe stiva formatul pentru citire %d
        call [scanf];apelam functia de citire
        add esp,4*2;eliberam stiva
        
        push dword m;punem pe stiva m-valoarea in care se citeste a doua valoare
        push dword format;punem pe stiva formatul pentru citire %d
        call [scanf];apelam functia de citire
        add esp,4*2;eliberam stiva
        
        mov eax,[n];mutam pe n in eax
        mov ebx,[m];mutam pe m in ebx 
        imul ebx;inmultim cu semn eax cu ebx
        
        mov [rezultat+4],edx;mutam in rezultat+4 pe edx
        mov [rezultat],eax;mutam in rezultat pe eax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
