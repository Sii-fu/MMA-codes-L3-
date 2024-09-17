.MODEL small
.stack 100h
.data
    ; Variables and arrays
    CHAR DB 0
.code 
MAIN PROC
    
    ; IF SMALL THEN MAKE CAPITAL AND VICE VERSAS

    MOV AX,@Data
    MOV DS,AX
    ;code here
    MOV AH, 01H
    INT 21H

    MOV CHAR, AL

    ;MOVE CURSOR
    MOV AH,02h

    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H

    CMP CHAR,61H
    JLE CAPITAL

    SUB CHAR,20H
    JMP PRINT
CAPITAL:
    ADD CHAR,20H

PRINT:
    MOV AH,02H
    MOV DL, CHAR
    INT 21H






MAIN ENDP
END MAIN
