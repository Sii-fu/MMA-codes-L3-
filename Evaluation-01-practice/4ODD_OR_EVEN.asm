.MODEL small
.stack 100h
.data
    ; Variables and arrays
    CHAR DB 0
    EVENMSG DB "EVEN$"
    ODDMSG DB "ODD$"

.code 
MAIN PROC

    ; ODD OR EVEN

    MOV AX,@Data
    MOV DS,AX
    ;code here
    MOV AH, 01H
    INT 21H

    MOV CHAR, AL

    ;MOVE CURSOR
    MOV AH,02h

    MOV DL, 0DH
    INT 21H

    MOV DL, 0AH
    INT 21H



    MOV AL, CHAR

    AND AL, 01H
    CMP AL, 0
    JE EVEN
    JMP ODD

    ODD:
    MOV AH,09H
    LEA DX, ODDMSG
    INT 21H
    JMP EXIT

    EVEN:
    MOV AH,09h

    LEA DX, EVENMSG
    INT 21H
    JMP EXIT

    EXIT:









MAIN ENDP
END MAIN
