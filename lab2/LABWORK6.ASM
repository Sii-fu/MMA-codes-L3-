.MODEL SMALL
.STACK 100H
.DATA

; STR_CAP DB "CAPITAL LETTERS: $"
; STR_SML DB "small letters: $"
; STR_NUM DB "Numeric Characters: $"
IT DW ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV DL,'*'
    MOV AH,02H
    MOV IT,0

    OUTER:
        INC IT
        MOV CX,IT
        
        INNER:
            MOV DL,'*'
            INT 21H
        LOOP INNER

        MOV DL,0AH
        INT 21H
        MOV DL,013
        INT 21H

    CMP IT,10
    JLE OUTER

MAIN ENDP
END