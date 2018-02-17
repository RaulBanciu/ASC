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
    s1 dd 'a','c','e','g','r'
    l1 equ ($-s1)/4
    s2 dd 'b','d','f','x','y','z'
    l2 equ ($-s2)/4
    l3 equ (l1+l2)
    s3 resd l3
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi,0;clear esi
        mov ebx,0;clear ebx
        mov edi,s3;mov edi address of s3
        cld;clear direction flag
        
        
        mov ecx,l1;mov ecx, l1
        jecxz step2;jump to step2 if ecx is zero
        mov eax,[s1];mov eax value of s1
        mov ecx,l2;mov ecx, l2
        jecxz step;jump to step if ecx is zero
        mov edx,[s2];mov edx value of s2
        mov ecx,l3;mov ecx l3
        
        bucla:
            cmp eax,edx;compare eax with edx
            jb first;jump to first if eax is below edx
            jmp second;jump to second otherwise
            first:
                stosd;store eax
                inc esi;esi+1
                mov eax,[s1+esi*4];mov in eax next value from s1
                cmp esi,l1;compare esi to l1
                je step2;jump if equal to step2
                jmp next;jump to next otherwise
            second:
                push eax;put eax on stack in order to save its value
                mov eax,edx;mov edx in eax
                stosd;store eax
                pop eax;put the original value of eax back
                inc ebx;ebx+1
                mov edx,[s2+ebx*4];mov in edx the next value from s2
                cmp ebx,l2;compare ebx to l2
                je step;jump if equal to step
            next:
        loop bucla;loop
        step:
            mov ecx,l1;mov ecx l1
            sub ecx,esi;subtract from ecx esi
            jecxz final;if ecx is zero jump to final
            do1:
                stosd;store eax
                inc esi;esi+1
                mov eax,[s1+esi*4];mov in eax the next value of s1
            loop do1;loop
            jmp final;jump to final
        step2:
            mov ecx,l2;mov in ecx l2
            sub ecx,ebx;subtract from ecx,ebx
            jecxz final;if ecx is zero jump to final
            mov eax,edx;mov edx in eax
            do2:
                stosd;store eax
                inc ebx;ebx+1
                mov eax,[s2+ebx*4];mov in eax next value of s2
            loop do2;loop
            jmp final;jump to final
            
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
