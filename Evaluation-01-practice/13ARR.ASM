.MODEL SMALL
.STACK 100H
.DATA
    VAR DB '*'
    ANS DW 0
    arr DW 1, 2, 1, 1, 1, 2
    ARR_SIZE DW $ - arr
;STR_VAR DB "ENTER A LINE "
.CODE
MAIN PROC

    ; ARRAY OF 10 ELEMENTS

    MOV AX,@DATA
    MOV DS,AX

    LEA SI, arr

    mov dx, ARR_SIZE

    add dx, '0'
    mov ah , 02H
    int 21H

    MOV CX,6

    loop:
        ;Loop forever
        MOV AX, [SI]
        ADD ANS, AX
        ADD SI, 2
        
        CMP CX,0
        JE END
        DEC CX
        nop
        jmp loop

    END: 
    ; Add the value of ANS to '0' to convert it to ASCII
    ADD ANS, '0'
    
    ; Display the result stored in ANS
    MOV AH, 02
    MOV DX, ANS
    INT 21H
MAIN ENDP
END