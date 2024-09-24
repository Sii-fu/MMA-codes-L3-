.MODEL SMALL
.STACK 100H
.DATA
    char DB 'F'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV CX, 5         ; Set outer loop counter to 5 for the LOP loop
LOP:
    PUSH CX           ; Save outer loop counter before calling PRINT_CHAR
    CALL PRINT_CHAR   ; Call the procedure to print character 10 times
    POP CX            ; Restore outer loop counter

    MOV AH, 02h
    MOV DL, 0DH       ; Carriage return
    INT 21H
    MOV DL, 0AH       ; Line feed
    INT 21H

    LOOP LOP          ; Loop 5 times

    MOV AH, 4CH       ; Terminate program
    INT 21H
MAIN ENDP

PRINT_CHAR PROC
    ;PUSH CX           ; Save the value of CX (for safety)
    MOV CX, 10        ; Set inner loop counter to 10 for PRINT_CHAR
PRINT_LOOP:
    MOV AH, 02H       ; Function to print character
    MOV DL, char      ; Load character 'F' into DL
    INT 21H           ; Print character
    LOOP PRINT_LOOP   ; Loop until CX = 0
    ;POP CX            ; Restore original CX (though not necessary here, just a safety)
    RET
PRINT_CHAR ENDP

END MAIN
