.MODEL SMALL
.STACK 100H
.DATA
    N DB 0
    COUNT DB 0
.CODE


MAIN PROC

    MOV AX, @DATA
    MOV DS,AX

    XOR CX,CX ; COUNTER
    XOR DX,DX ; TO STORE THE RESULT


    CALL DEC_INP
    

    CALL DECIMAL_OUTPUT
    


MAIN ENDP

DEC_INP PROC

    For:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE END_FOR
        SUB AL,'0'
        MOV N, AL
        MOV AL,10
        MUL DL
        ADD AL,N
        MOV DL,AL

        INC COUNT
        JMP For

    END_FOR:

    MOV AH,2
    MOV N,DL
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H

    RET
DEC_INP ENDP



DECIMAL_OUTPUT PROC

    XOR CX,CX
    MOV CL,COUNT

    XOR AH,AH
    MOV BL,10
    MOV AL,N
    FOR1:
        XOR DX,DX
        DIV BL
        MOV DL,AH
        ADD DL,'0'
        PUSH DX
    LOOP FOR1

    XOR CX,CX
    MOV CL,COUNT

    MOV AH,02H

    FOR2:
        POP DX
        INT 21H
    LOOP FOR2


    RET
DECIMAL_OUTPUT ENDP
