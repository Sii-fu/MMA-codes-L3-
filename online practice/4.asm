.MODEL SMALL
.STACK 100H
.DATA
    var1 db 0
    var2 db 0
    OBIG DB 10,13,'FIRST NUMBER IS BIG$'
    TBIG DB 10,13,'SECOND NUMBER IS BIG$'
    EAL DB 10,13,'BOTH NUMBERS ARE EQUAL$'

.CODE 
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 01H
    INT 21H
    MOV BL, AL

    
    MOV AH, 01H
    INT 21H
    MOV BH, AL

    CMP BL, BH
    JE EQU
    JL TWOBIG


    MOV AH, 09H
    LEA DX, OBIG
    INT 21H
    JMP EXIT

EQU:
    MOV AH, 09H
    LEA DX, EAL
    INT 21H
    JMP EXIT

TWOBIG:
    MOV AH, 09H
    LEA DX, TBIG
    INT 21H 

EXIT:
    MOV AH, 4CH
    INT 21H

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