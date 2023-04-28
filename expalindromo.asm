section .data
msg     db      'Ingrese una cadena: '
len     equ     $ - msg
msg2    db      'La cadena es un palindromo'
msg3    db      'La cadena no es un palindromo'

section .bss
buffer  resb    255

section .text
global  _start

; Función para calcular la longitud de la cadena
strLEN:
        push    ebx
        mov     ebx, eax
sigChar:
        cmp     byte[eax], 0
        jz      finLen
        inc     eax
        jmp     sigChar
finLen:
        sub     eax, ebx
        pop     ebx
        ret

; Función para comprobar si la cadena es un palíndromo
strPalindromo:
        push    ebp
        mov     ebp, esp
        push    ebx
        push    esi
        push    edi
        mov     eax, [ebp+8]    ; dirección de la cadena
        call    strLEN          ; calcular la longitud de la cadena
        mov     ebx, eax        ; ebx = longitud
        mov     esi, eax        ; esi = longitud
        shr     esi, 1          ; esi = longitud / 2
        xor     edi, edi        ; contador
        cmp     ebx, 1
        jle     esPalindromo    ; si la longitud de la cadena es 0 o 1, es un palíndromo

        mov     edi, eax        ; contador = longitud
        dec     edi             ; contador = longitud - 1
        xor     ecx, ecx        ; índice del primer carácter
        mov     edx, eax        ; índice del último carácter
        dec     edx             ; índice del último carácter
        cmp     esi, 0
        jle     esPalindromo
        xor     esi, esi        ; índice del carácter actual
compararCaracteres:
        mov     al, [eax + ecx]
        mov     bl, [eax + edx]
        cmp     al, bl
        jne     noEsPalindromo
        inc     ecx
        dec     edx
        inc     esi
        cmp     esi, esi
        jl      compararCaracteres
esPalindromo:
        mov     eax, msg2
        call    printStr        ; imprimir mensaje "La cadena es un palindromo"
        jmp     finPrograma
noEsPalindromo:
        mov     eax, msg3
        call    printStr        ; imprimir mensaje "La cadena no es un palindromo"
finPrograma:
        pop     edi
        pop     esi
        pop     ebx
        mov     esp, ebp
        pop     ebp
        ret

; Función para imprimir una cadena
printStr:
        push    edx
        push    ecx
        push    ebx
        push    eax
        call    strLEN          ; calcular la longitud de la cadena
        mov     edx, eax
        pop     eax
        mov     ecx, eax
        mov     ebx, 1          ; salida estándar (STDOUT)
        mov     eax, 4          ; llamada al sistema SYS_WRITE
        int     0x80
        pop     ebx
        pop     ecx
        pop     edx
        ret

