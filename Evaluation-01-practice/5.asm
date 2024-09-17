.MODEL small
.stack 100h
.data
    ; Variables and arrays
    CHAR1 DB 0
    CHAR2 DB 0
    EVENMSG DB "EVEN$"
    ODDMSG DB "ODD$"

.code 
MAIN PROC

    ; LARGEST NUMBER

    MOV AX,@Data
    MOV DS,AX
    ;code here
    
    MOV AH,01
    INT 21H

    MOV CHAR1,AL

    INT 21H

    MOV CHAR2,AL

    MOV AH,02h

    MOV DL, 0DH
    INT 21H

    MOV DL, 0AH
    INT 21H

    MOV AL,CHAR2

    CMP AL,CHAR1
    JE EQU
    JG L1
    JL L2
    L2:
    MOV DL,CHAR1
    MOV AH,02
    INT 21H
    JMP EXIT
    L1:
    MOV DL,AL
    MOV AH,02
    INT 21H
    JMP EXIT
    EQU:
    MOV DL,'E'
    MOV AH,02
    INT 21H
    JMP EXIT

    ; Repeat the code inside the loop
    EXIT:
    JMP MAIN
    









MAIN ENDP
END MAIN
