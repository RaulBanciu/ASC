bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

extern printf
import printf msvcrt.dll
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 dd 1,2,3,4
    l1 equ ($-s1)/4
    s2 dd 5,6,7
    l2 equ ($-s2)/4
    l2b equ $-s2
    l3 equ l1+l2
    d times l3 dd 0
    format db "%d",10,13,0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, l1 ;punem lungimea in ECX pentru a putea realiza bucla loop de ecx ori
        mov esi, 0;mutam 0 in esi
        mov ebx, 0;mutam 0 in ebx
        jecxz step2;jump if ecx not 0 to step 2
        Repeta:
            mov eax,[s1+esi];mutam in eax element cu element din s1
            mov [d+ebx],eax;mutam in d pe pozitia curenta valoarea din eax
            add ebx,4;adaugam la ebx 4
            add esi,4;adaugam la esi 4
        loop Repeta
        
        step2:
        mov ecx,l2;mutam in ecx l2
        mov esi,l2b;mutam in esi l2b
        sub esi,4;scadem din esi 4
        jecxz final
        Repeta2:
            mov eax,[s2+esi];mutam in eax valoare din s2+esi
            mov [d+ebx],eax;mutam in d pe pozitia corecta pe eax
            add ebx,4;adaugam la ebx 4
            sub esi,4;scadem din esi 4
        loop Repeta2
        ; exit(0)
        
        ;afisare(optional)
        mov ecx,l3
        cmp ecx,0
        je final
        mov ebx,0
        bucla:
            
            mov eax,[d+ebx]
            add ebx,4
            push dword ecx
            push dword eax
            push dword format
            call [printf]
            add esp,4*2
            pop dword ecx

            
            dec ecx
            cmp ecx,0
            jne bucla
        ; exit(0)
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
