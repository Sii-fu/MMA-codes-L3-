.Model small
.stack 100H
.data

DAT DB 0


.code
MAIN PROC

    ;must do it 
    MOV AX, @data
    MOV DS,AX

    ;code here

    MOV AH, 01H
    INT 21H

    MOV DAT, AL

    MOV AH, 02H

    MOV DL, 0AH
    INT 21H

    MOV DL, 0DH
    INT 21H

    MOV DL, DAT
    INT 21H


MAIN ENDP
END MAIN