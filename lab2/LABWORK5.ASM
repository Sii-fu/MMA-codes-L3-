.MODEL SMALL
.STACK 100H
.DATA

STR_CAP DB "CAPITAL LETTERS: $"
STR_SML DB "small letters: $"
STR_NUM DB "Numeric Characters: $"
VAR DB 'A'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,09
    LEA DX,STR_CAP
    INT 21H
    MOV AH,02
    MOV DL,' '
    INT 21H
    
    MOV CX,26           
    
    STAR:
        MOV DL,VAR
        INT 21H
        MOV DL,' '
        INT 21H
        INC VAR
    LOOP STAR
               
    
    MOV DL,0AH
    INT 21H
    MOV DL,013
    INT 21H
               
    
    MOV VAR,'a'
    MOV AH,09
    LEA DX,STR_SML
    INT 21H
    MOV AH,02
    MOV DL,' '
    INT 21H
    
    MOV CX,26           
    
    STAR2:
        MOV DL,VAR
        INT 21H
        MOV DL,' '
        INT 21H
        INC VAR
    LOOP STAR2


    MOV DL,0AH
    INT 21H
    MOV DL,013
    INT 21H
               
    
    MOV VAR,'0'
    MOV AH,09
    LEA DX,STR_NUM
    INT 21H
    MOV AH,02
    MOV DL,' '
    INT 21H
    
    MOV CX,10          
    
    STAR3:
        MOV DL,VAR
        INT 21H
        MOV DL,' '
        INT 21H
        INC VAR
    LOOP STAR3

MAIN ENDP
END