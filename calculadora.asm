; Calculadora en asm

section .data
    msg             db      'Ingrese una opcion: ',0
    invalid_input   db      'Entrada no valida.',0
    num1            db      'Ingrese el primer numero: ',0
    num2            db      'Ingrese el segundo numero: ',0
    result          db      'El resultado es: ',0

section .bss
    opcion          resb 1
    numero1         resb 10
    numero2         resb 10
    resultado       resb 10

section .text
    global      _start

_start:
    ; muestra el mensaje de bienvenida
    mov             eax, 4
    mov             ebx, 1
    mov             ecx, msg
    mov             edx, len_msg
    int 80h

    ; lee la opcion seleccionada por el usuario
    mov             eax, 3
    mov             ebx, 0
    mov             ecx, opcion
    mov             edx, 1
    int 80h

    ; determina la operacion a realizar
    cmp     byte [opcion], '+'
    je      suma
    cmp     byte [opcion], '-'
    je      resta
    cmp     byte [opcion], '*'
    je      multiplicacion
    cmp     byte [opcion], '/'
    je      division
    jmp     error

suma:
    ; solicita el primer numero
    mov         eax, 4
    mov         ebx, 1
    mov         ecx, num1
    mov         edx, len_num1
    int 80h

    ; lee el primer numero
    mov         eax, 3
    mov         ebx, 0
    mov         ecx, numero1
    mov         edx, 10
    int 80h

    ; solicita el segundo numero
    mov         eax, 4
    mov         ebx, 1
    mov         ecx, num2
    mov         edx, len_num2
    int 80h

    ; lee el segundo numero
    mov         eax, 3
    mov         ebx, 0
    mov         ecx, numero2
    mov         edx, 10
    int 80h

    ; convierte los numeros a enteros
    mov         eax, numero1
    sub         eax, '0'
    mov         ebx, numero2
    sub         ebx, '0'

    ; realiza la suma
    add         eax, ebx

    ; convierte el resultado a una cadena
    add         eax, '0'
    mov         [resultado], eax

    ; muestra el resultado
    mov         eax, 4
    mov         ebx, 1
    mov         ecx, result
    mov         edx, len_result
    int 80h

    mov         eax, 4
    mov         ebx, 1
    mov         ecx, resultado
    mov         edx, 1
    int 80h

    ; sale del programa
    jmp         exit

resta:
    ; solicita el primer numero
    mov         eax, 4
    mov         ebx, 1
    mov         ecx, num1
    mov         edx, len_num1
    int 80h

    ; lee el primer numero
    mov         eax, 3
    mov         ebx, 0
    mov         ecx, numero1
    mov         edx, 10
    int 80h

    ; solicita el segundo numero
    mov         eax, 4
    mov         ebx, 1
    mov         ecx, num2
    mov         edx, len_num2
    int 80h

    ; lee el segundo numero
    mov         eax, 3
    mov         ebx, 0
    mov         ecx, numero2
    mov         edx, 10