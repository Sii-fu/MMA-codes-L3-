.model small
.stack 100H
.data
    var db 0
    odd db "it is an odd number$"
    even db "it is an even number$"

.code 

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 01h
    INT 21H

    MOV var, AL

    MOV AH, 02h
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    AND var, 01h

    CMP var, 0
    JE EVENN
    JMP ODDD

EVENN:
    MOV AH, 09h
    LEA DX, even
    INT 21H
    JMP EXIT
ODDD:
    MOV AH, 09h
    LEA DX, odd
    INT 21H
    JMP EXIT

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN