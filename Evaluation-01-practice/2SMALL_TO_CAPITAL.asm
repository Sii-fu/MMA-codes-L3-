.MODEL small
.stack 100h
.data
    ; Variables and arrays
    CHAR DB 0
.code 
MAIN PROC

    ;MAKING SMALL LETTER TO CAPITAL LETTER

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

    SUB CHAR, 20H


    MOV DL, CHAR
    INT 21H








MAIN ENDP
END MAIN
