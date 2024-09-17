.model small
.stack 100h
.data  

.code 

MAIN PROC
    ;code 
    
    MOV AX,@Data
    MOV DS,AX
    
    MOV AH,01H
    INT 21H 
    
    
    MOV AH,02H
    MOV DL,AL
    INT 21H     
     
    MOV AH,02H
    MOV DL,79H
    INT 21H
    
MAIN ENDP
    END MAIN