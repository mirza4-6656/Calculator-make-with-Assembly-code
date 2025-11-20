.MODEL SMALL
.STACK 100H
.DATA

msg_title   DB 13,10, '---------------------------------------------',13,10
            DB '        SIMPLE ASSEMBLY CALCULATOR',13,10
            DB '---------------------------------------------',13,10,'$'

msg_num1    DB 13,10, 'Enter first number: $'
msg_num2    DB 13,10, 'Enter second number: $'

msg_menu    DB 13,10,13,10, 'Choose an operation:',13,10
            DB '1. Addition',13,10
            DB '2. Subtraction',13,10
            DB '3. Multiplication',13,10
            DB '4. Division',13,10,'$'

msg_result  DB 13,10, 'Result: $'
msg_end     DB 13,10,13,10,'Thank you for using the calculator!',13,10,'$'


result  DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Show title
    LEA DX, msg_title
    MOV AH, 09H
    INT 21H

    ; -----------------------------
    ; Input first number
    ; -----------------------------
    LEA DX, msg_num1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H      ; read char
    INT 21H
    SUB AL, '0'      ; convert to number
    MOV BL, AL       ; store first number

    ; -----------------------------
    ; Input second number
    ; -----------------------------
    LEA DX, msg_num2
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV CL, AL       ; store second number

    ; -----------------------------
    ; Show menu
    ; -----------------------------
    LEA DX, msg_menu
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    MOV DL, AL       ; choice

    ; -----------------------------
    ; Perform operation
    ; -----------------------------
    CMP DL, '1'
    JE ADDITION

    CMP DL, '2'
    JE SUBTRACTION

    CMP DL, '3'
    JE MULTIPLICATION

    CMP DL, '4'
    JE DIVISION

    JMP END_PROGRAM ; invalid choice

ADDITION:
    MOV AL, BL
    ADD AL, CL
    JMP SHOW_RESULT

SUBTRACTION:
    MOV AL, BL
    SUB AL, CL
    JMP SHOW_RESULT

MULTIPLICATION:
    MOV AL, BL
    MUL CL
    JMP SHOW_RESULT

DIVISION:
    MOV AL, BL
    XOR AH, AH
    DIV CL
    JMP SHOW_RESULT

; -----------------------------
; Print result
; -----------------------------
SHOW_RESULT:
    MOV result, AL

    LEA DX, msg_result
    MOV AH, 09H
    INT 21H

    MOV AL, result
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

; -----------------------------
; End message
; -----------------------------
END_PROGRAM:
    LEA DX, msg_end
    MOV AH, 09H
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
