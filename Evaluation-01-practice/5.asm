.MODEL small
.stack 100h
.data
    ; larger number between two numbers
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


; .MODEL SMALL
; .STACK 100H
; .DATA
; S DB 10,13,'LARGER NUM IS $'
; P DB 10,13,'EQULA $'
; .CODE 
; MAIN PROC
;     MOV AX,@DATA
;     MOV DS,AX
    
;     MOV AH,1
;     INT 21H
;     MOV BL,AL
    
;     MOV AH,1
;     INT 21H
;     MOV BH,AL
    
;     CMP BL,BH
;     JE L2
;     JG L1
    
;     MOV AH,9
;     LEA DX,S
;     INT 21H
    
;     MOV AH,2
;     MOV DL,BH
;     INT 21H
;     JMP EXIT
    
;     L2:
;     MOV AH,9
;     LEA DX,P 
;     INT 21H
;     JMP EXIT
    
    
;     L1:
;     MOV AH,9
;     LEA DX,S
;     INT 21H
    
;     MOV AH,2
;     MOV DL,BL
;     INT 21H
    
;     EXIT:
;     MOV AH,4CH
;     INT 21H
    
;     MAIN ENDP
; END MAIN