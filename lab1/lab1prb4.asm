.stack 100h
.data
.code

STR_VAR DB "Enter a num: $"
STR_VAR2 DB "Enter another num: $"
var1 DB ?
var2 DB ?
ans DB ?

MAIN PROC

    MOV AX, @data
    MOV DS, AX

    MOV AH, 09h
    LEA DX, STR_VAR
    INT 21H
         
         
    MOV AH, 01h
    INT 21H
    ; SUB AL,30H

    MOV var1, AL

    MOV AH, 02H
    MOV DL, 0DH
    INT 21H

    MOV AH, 02H
    MOV DL, 0AH
    INT 21H

    MOV AH, 09h
    LEA DX, STR_VAR2
    INT 21H

    MOV AH, 01h
    INT 21H
    ; SUB AL,30H

    MOV var2, AL
    ;MOV ans, var1
    MOV AL, var1
    MOV ans, AL
    cmp AL, var2

    jl print

    MOV AL, var2
    MOV ans, AL
    
    print:
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H

    MOV AH, 02H
    MOV DL, 0AH
    INT 21H

    MOV AH, 02H
    MOV DL, ans
    INT 21H

MAIN ENDP

END MAIN