.DATA
STR1 DB 'Enter string: $'
MAX DB 0
CURRENT DB 1 ; Start with 1 because a single char is a sequence of length 1
PREV_CHAR DB 0

.CODE
; Assume AX is already set up for DS

MOV AH,09h
LEA DX, STR1
INT 21H

MOV AH,01H
MOV DL,00H
MOV BL,00H
MOV MAX,00H
MOV CURRENT,01H

INPUT:
    INT 21H
    CMP AL,0DH ; Check for Enter key
    JE UPDATE_MAX
    CMP AL,PREV_CHAR
    JG INCREASE ; If current char is greater than previous, it's increasing
    JE INPUT ; If they are equal, just read the next character without resetting

; If not increasing or equal, update MAX if needed and reset CURRENT
RESET:
    CMP CURRENT,MAX
    JLE SKIP_RESET
    MOV MAX,CURRENT
SKIP_RESET:
    MOV CURRENT,1
    JMP CONTINUE

INCREASE:
    INC CURRENT

CONTINUE:
    MOV PREV_CHAR,AL
    JMP INPUT

UPDATE_MAX: ; Final update for MAX before printing
    CMP CURRENT,MAX
    JLE PRINT
    MOV MAX,CURRENT

PRINT:
    MOV AH,02
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    MOV DL,MAX
    ADD DL,30H ; Convert to ASCII
    INT 21H

MAIN ENDP
END MAIN