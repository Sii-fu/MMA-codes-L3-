.stack 100h
.data
.code

STR_VAR DB "Enter a String: $"
STR_VAR2 DB "The string is: $"
inp_str DB 50
        DB ?
        DB 50 DUP(0)

MAIN PROC

    MOV AX, @data
    MOV DS, AX

    MOV AH, 09h
    LEA DX, STR_VAR
    INT 21H
         
         
    MOV AH,0AH
    INT 21H

    MOV inp_str, AL

    ; cmp var, 61H
    ; jge lowerTocapital

    ; ADD var, 20H
    ; JMP Print
    
    ; lowerTocapital:
    ;     SUB var, 20H
    
    print:
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H

    MOV AH, 02H
    MOV DL, 0AH
    INT 21H

    MOV AH, 09H
    LEA DX, inp_str
    INT 21H

MAIN ENDP

END MAIN