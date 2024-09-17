.MODEL small
.stack 100h
.data
    ; Variables and arrays
    CHAR DW 0
    disp DW "Enter a binary number: $"

.code 
MAIN PROC

    ; taking binary input

    MOV AX,@Data
    MOV DS,AX
    ;code here

    MOV AH, 09H
    LEA DX, disp
    INT 21H
    XOR BX, BX

    inp:
        MOV AH, 01H
        INT 21H

        CMP AL, 0DH
        JE PRINT1

        SUB AL, 30H

        SHL BX, 1

        OR BX, AL
    JMP inp
    
    PRINT1:
        MOV CX, 16
        MOV CHAR, 0
        MOV AL, 0DH
        MOV AH, 02H
        INT 21H
        MOV AL, 0AH
        INT 21H
        JMP PRINT


    ; displaying the binary number 
    
    PRINT: 
        ROL BX, 1
        JC ONE
        MOV DL, '0'
        JMP CONTPRINT
        ONE:
            MOV DL, '1'
        CONTPRINT:
            MOV AH,02H
            INT 21H
    LOOP PRINT
            
    EXIT:

MAIN ENDP
END MAIN
