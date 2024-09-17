 .model small
.stack 100h
.data  
;.vars and arrays
.code       

STR_VAR DB "Enter a charecter: $",0
VAR DB ?

MAIN PROC
    ;code 
    
    MOV AX,@Data
    MOV DS,AX
    
    MOV AH,09H  
    LEA DX, STR_VAR
    INT 21H 
    
    ;taking input    
    MOV AH,01H
    INT 21H 
               
    ;storing the input in var           
    MOV VAR,AL    
               
    SUB VAR,20H  ;making lowercase to uppercase
    
    MOV AH,02H 
    MOV DL,0DH
    INT 21H 
    MOV DL,0AH
    INT 21H  
    
    MOV DL,VAR
    INT 21H
    
MAIN ENDP
    END MAIN