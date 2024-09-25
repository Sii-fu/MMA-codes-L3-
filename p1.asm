.model small
.stack 100h
.data
    prompt db 'Enter the amount in taka (0 to 495): $'
    result50 db 0ah, 0dh, 'Number of 50 takas: $'
    result10 db 0ah, 0dh, 'Number of 10 takas: $'
    result5 db 0ah, 0dh, 'Number of 5 takas: $'
    taka db 0
    
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt the user to input the amount
    mov ah, 09h
    lea dx, prompt
    int 21h
    
    ; Input decimal number from user
    call dec_input
    
    ; Calculate the number of 50, 10, and 5 taka notes
    mov bl, taka ; Move user input to BL
    call calc_exchange
    
    ; Display results
    call display_result

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp

; Procedure to input a decimal number
dec_input proc
    xor cx, cx          ; Clear CX to store the decimal input
    xor ax, ax          ; Clear AX
input_loop:
    mov ah, 01h         ; Function to read a character
    int 21h             ; Call interrupt
    
    cmp al, 0Dh         ; Check if Enter is pressed (CR - Carriage Return)
    je done_input       ; If so, jump to done_input

    sub al, '0'         ; Convert ASCII to number
    mov ah, 0           ; Clear AH
    mov bx, 10          ; Prepare to multiply previous number by 10
    mul bx              ; AX = AX * 10
    add cx, ax          ; Add result to CX (accumulate the value)
    jmp input_loop      ; Repeat the loop
    
done_input:
    mov taka, cl        ; Store the final input value in "taka"
    ret
dec_input endp

; Procedure to calculate exchange in 50, 10, and 5 taka
calc_exchange proc
    ; Calculate number of 50 taka notes
    mov ax, bl
    mov cx, 50
    xor dx, dx          ; Clear DX
    div cx              ; AX = AX / 50, remainder in DX
    mov bh, al          ; Store number of 50 taka notes in BH
    mov bl, dl          ; Store remainder (less than 50) in BL
    
    ; Calculate number of 10 taka notes
    mov ax, bl
    mov cx, 10
    xor dx, dx          ; Clear DX
    div cx              ; AX = AX / 10, remainder in DX
    mov ch, al          ; Store number of 10 taka notes in CH
    mov cl, dl          ; Store remainder (less than 10) in CL
    
    ; Calculate number of 5 taka notes
    mov al, cl
    mov cx, 5
    xor dx, dx          ; Clear DX
    div cx              ; AX = AX / 5, remainder in DX
    mov cl, al          ; Store number of 5 taka notes in CL
    ret
calc_exchange endp

; Procedure to display results
display_result proc
    ; Display number of 50 takas
    lea dx, result50
    mov ah, 09h
    int 21h
    mov al, bh
    call display_digit

    ; Display number of 10 takas
    lea dx, result10
    mov ah, 09h
    int 21h
    mov al, ch
    call display_digit

    ; Display number of 5 takas
    lea dx, result5
    mov ah, 09h
    int 21h
    mov al, cl
    call display_digit
    ret
display_result endp

; Procedure to display a single digit
display_digit proc
    add al, '0'         ; Convert number to ASCII
    mov ah, 02h         ; DOS function to display character
    int 21h             ; Call DOS interrupt
    ret
display_digit endp

end main





-------------------decimal io


.MODEL SMALL
.DATA
.STACK 100H
.CODE
    
DEC_IN PROC
    XOR BX,BX
    
    MOV AH,01H
    INT 21H
    WHILE:
        CMP AL,0DH
        JE BREAK1
        PUSH AX
        
        MOV AX,10   ; AX = 10
        MUL BX      ; AX = 10 x BX
        MOV BX,AX   ; BX = BX x 10
        
        POP AX
        ;AND AX,000FH ;CONVERSION WAY1
        MOV AH,0
        SUB AX,48     ;CONVERSION WAY2
        ADD BX,AX
        
        MOV AH,01H
        INT 21H
        JMP WHILE
        
    BREAK1:
    RET

DEC_IN ENDP

DEC_OUT PROC
    MOV CX,0
    MOV BX, 10
    DIVISION:
        
        XOR DX, DX      ; CLEARING DX            
        DIV BX          ; QUOTIENT => AX & REMAINDER => DX                  
        PUSH DX         ; REMAINDER SAVED IN STACK
        INC CX          ; NO. OF DIGITS IN THE NUMBER
        CMP AX,0        
        JE PRINT
    JMP DIVISION 
           
    PRINT:
        POP DX
        ADD DX, 30H
        MOV AH, 02H
        INT 21H
        LOOP PRINT    
       
    RET
    
DEC_OUT ENDP
    
    
MAIN PROC
    CALL DEC_IN     ; INPUT FROM USER STORED IN BX
    
    MOV AH,02H
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    MOV AX,BX       ;  OUTPUT TO CONSOLE MUST BE STORED IN AX
    CALL DEC_OUT
    
       
MAIN ENDP
END MAIN




----------------------------palindrome check
.MODEL SMALL
.STACK 100H
.DATA 
COUNT DW 0
MSG1 DB "Enter an input number:$"
MSGP DB 0DH,0AH, "It's a Palindrome Number$"  
MSGNP DB 0DH,0AH, "It's not a Palindrome Number$" 
ARR DB 20 DUP(?)

.CODE
    

    
    
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV CX,0
    MOV SI,OFFSET ARR
    
    MOV AH,1
    INT 21H
    L1:
    CMP AL,0DH
    JE EXIT_L1
    PUSH AX
    MOV [SI],AL
    INC SI
    INC COUNT
    INT 21H
    JMP L1
    
    EXIT_L1:
    
    MOV CX,COUNT
    MOV SI,OFFSET ARR
    MOV AH,2
    R_PRINT:
    POP DX
    CMP [SI],DL
    JNE E_D
       DEC COUNT
    E_D:
    INC SI
    
    LOOP R_PRINT   
    
    CMP COUNT,0
    JE P
    LEA DX,MSGNP
    JMP PRINT
    P:
    LEA DX,MSGP
    PRINT:
    MOV AH,9
    INT 21H
    
       
MAIN ENDP
END MAIN



-----------------------------REVERSE AN INPUT NUMBER
.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "Enter an input number:$"
MSG2 DB 0DH,0AH, "Reverse:$"
.CODE
    

    
    
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV CX,0
    
    MOV AH,1
    INT 21H
    L1:
    CMP AL,0DH
    JE EXIT_L1
    PUSH AX
    INC CX
    INT 21H
    JMP L1
    
    EXIT_L1:
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    
    MOV AH,2
    R_PRINT:
    POP DX
    INT 21H
    LOOP R_PRINT   
    
    
       
MAIN ENDP
END MAIN


-------------------todays ques a section
.model small
.stack 100h
.data
    prompt db 'Enter the amount in taka (0 to 495): $'
    result50 db 0ah, 0dh, 'Number of 50 takas: $'
    result10 db 0ah, 0dh, 'Number of 10 takas: $'
    result5 db 0ah, 0dh, 'Number of 5 takas: $'
    taka db 0
    
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt the user to input the amount
    mov ah, 09h
    lea dx, prompt
    int 21h
    
    ; Input decimal number from user
    call dec_input
    
    ; Calculate the number of 50, 10, and 5 taka notes
    mov bl, taka ; Move user input to BL
    call calc_exchange
    
    ; Display results
    call display_result

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp

; Procedure to input a decimal number
dec_input proc
    xor cx, cx          ; Clear CX to store the decimal input
    xor ax, ax          ; Clear AX
input_loop:
    mov ah, 01h         ; Function to read a character
    int 21h             ; Call interrupt
    
    cmp al, 0Dh         ; Check if Enter is pressed (CR - Carriage Return)
    je done_input       ; If so, jump to done_input

    sub al, '0'         ; Convert ASCII to number
    mov ah, 0           ; Clear AH
    mov bx, 10          ; Prepare to multiply previous number by 10
    mul bx              ; AX = AX * 10
    add cx, ax          ; Add result to CX (accumulate the value)
    jmp input_loop      ; Repeat the loop
    
done_input:
    mov taka, cl        ; Store the final input value in "taka"
    ret
dec_input endp

; Procedure to calculate exchange in 50, 10, and 5 taka
calc_exchange proc
    ; Calculate number of 50 taka notes
    mov ax, bl
    mov cx, 50
    xor dx, dx          ; Clear DX
    div cx              ; AX = AX / 50, remainder in DX
    mov bh, al          ; Store number of 50 taka notes in BH
    mov bl, dl          ; Store remainder (less than 50) in BL
    
    ; Calculate number of 10 taka notes
    mov ax, bl
    mov cx, 10
    xor dx, dx          ; Clear DX
    div cx              ; AX = AX / 10, remainder in DX
    mov ch, al          ; Store number of 10 taka notes in CH
    mov cl, dl          ; Store remainder (less than 10) in CL
    
    ; Calculate number of 5 taka notes
    mov al, cl
    mov cx, 5
    xor dx, dx          ; Clear DX
    div cx              ; AX = AX / 5, remainder in DX
    mov cl, al          ; Store number of 5 taka notes in CL
    ret
calc_exchange endp

; Procedure to display results
display_result proc
    ; Display number of 50 takas
    lea dx, result50
    mov ah, 09h
    int 21h
    mov al, bh
    call display_digit

    ; Display number of 10 takas
    lea dx, result10
    mov ah, 09h
    int 21h
    mov al, ch
    call display_digit

    ; Display number of 5 takas
    lea dx, result5
    mov ah, 09h
    int 21h
    mov al, cl
    call display_digit
    ret
display_result endp

; Procedure to display a single digit
display_digit proc
    add al, '0'         ; Convert number to ASCII
    mov ah, 02h         ; DOS function to display character
    int 21h             ; Call DOS interrupt
    ret
display_digit endp

end main