.stack 100h
.data
.code

STR_VAR DB "Enter a num: $"
STR_odd DB "This is a ODD number$"
STR_even DB "This is a EVEN number$"
var1 DB ?

MAIN PROC

    MOV AX, @data
    MOV DS, AX

    start:
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H

    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    
    MOV AH, 09h
    LEA DX, STR_VAR
    INT 21H
         
         
    MOV AH, 01h
    INT 21H
    SUB AL,30H

    MOV var1, AL

    cmp var1, 1
    jz odd
    cmp var1, 3
    jz odd
    cmp var1, 5
    jz odd
    cmp var1, 7
    jz odd
    cmp var1, 9
    jz odd
    cmp var1, 2
    jz even
    cmp var1, 4
    jz even
    cmp var1, 6
    jz even
    cmp var1, 8
    jz even
    cmp var1, 0
    jz even
    

    odd:
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H

    MOV AH, 02H
    MOV DL, 0AH
    INT 21H

    MOV AH, 09h
    LEA DX, STR_odd
    INT 21H
    jmp start
    even:
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H

    MOV AH, 02H
    MOV DL, 0AH
    INT 21H

    MOV AH, 09h
    LEA DX, STR_even
    INT 21H
    jmp start

MAIN ENDP

END MAIN