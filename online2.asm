.MODEL SMALL
.STACK 100H
.DATA
    CORMSG DB "Correctly bracketed$"
    INCORMSG DB "Incorrect in position $"
    INP DB 10 DUP(?) 
    C DB 0
    
.CODE

MAIN PROC
    MOV AX , @DATA
    MOV DS , AX
                        
                    
    MOV AH,01H 
    INT 21H
    FOR1:
        CMP AL, 13
        JE END1
        
        CMP AL,'('
        JE PR
        CMP AL,'{'
        JE CB
        CMP AL,'['
        JE TB 
        
        CMP AL,')'
        JE CHECK
        CMP AL,'}'
        JE CHECK
        CMP AL,']'
        JE CHECK
        
        JMP CONT
        
        PR:        
            MOV BX,')'
            PUSH BX
        JMP CONT
        
        CB:
            MOV BX,'}'
            PUSH BX
        JMP CONT
        
        TB: 
            MOV BX,']'
            PUSH BX
        JMP CONT
        
        CHECK:
            POP BX            
            CMP BL,AL
            JE CONT
        JMP INCORR
        
        CONT:
            MOV AH,01H
            INC C
            INT 21H
        JMP FOR1
    END1:               
         
        MOV AH,2
        MOV DL, 13
        INT 21H
        MOV DL, 10
        INT 21H                                                                                       
    CORR:
        LEA DX,CORMSG
        MOV AH,09H
        INT 21H
        JMP TT  
        
    INCORR:
        MOV AH,2
        MOV DL, 13
        INT 21H
        MOV DL, 10
        INT 21H
        
        LEA DX,INCORMSG
        MOV AH,09H
        INT 21H
        
        MOV AH,02H
        MOV DL,C
        ADD DL,'0'
        INT 21H
        JMP TT
     
    TT:
    
MAIN ENDP    
