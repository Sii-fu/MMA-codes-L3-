.MODEL SMALL
.STACK 100H
.DATA
    VAR DB '*'
    ANS DW 0
    arr DW 1, 2, 1, 2, 2, 1
;STR_VAR DB "ENTER A LINE "
.CODE
MAIN PROC

    ; NUMBER OF VOWELS IN INPUT

    MOV AX,@DATA
    MOV DS,AX

    LEA SI, arr
    MOV ANS, 0
    MOV CX,5

    
    loop:
        ;Loop forever
        MOV AX, [SI]

        AND AX, 1
        CMP AX, 0
        JNE next

        INC ANS
        ; MOV AH, 02
        ; MOV DX, [SI]
        ; ADD DX, '0'
        ; INT 21H

        next:
        
        ADD SI, 2
        CMP CX,0
        JE END
        DEC CX
        nop
        jmp loop

    END:
        ADD ANS, '0'
        MOV AH, 02
        MOV DX, ANS
        INT 21H
    
  
MAIN ENDP
END