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


; TAKE DECIMAL INPUT FROM USER AND PRINT THE GCD, PRINT SUBSEQUENT LINES FOR BETTER UNDERSTANDING

; 



.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'ENTER M=$'       ; MESSAGE TO PROMPT M
MSG2 DB 10,13,'ENTER N=$' ; MESSAGE TO PROMPT N    
MSG4 DB 10,13, 'ENTER :$'
MSG3 DB 10,13,'GCD IS=$'  ; MESSAGE TO DISPLAY GCD
A DW ?                    ; VARIABLE TO TEMPORARILY STORE VALUE
B DW ?                    ; VARIABLE TO STORE DIVISOR

        
ARR DW 10 DUP(?)     
SUM DW ?
SUM2 DW ?

    
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
        AND AX,000FH; CONVERSION
        ADD BX,AX   ; BX = DECIMAL INPUT
        
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
        POP DX          ; EVERYTIME IT POPS THE VALUE OF STACK IN DX
        ADD DX, 30H
       
        MOV AH, 02H     ; PRINT DX
        INT 21H
        LOOP PRINT      ; CONTINUE LOOP TILL COUNT
       
    RET
                       
                       
                       
DEC_OUT ENDP  
               
               

DIGIT_SUM PROC
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
        POP DX          ; EVERYTIME IT POPS THE VALUE OF STACK IN DX
        ADD DX, 30H
        
        ADD SUM2, DX
        
        MOV AH, 02H     ; PRINT DX
        INT 21H
        LOOP PRINT      ; CONTINUE LOOP TILL COUNT
       
    RET
                       
                       
                       
DIGIT_SUM ENDP  
             
               
               


PRINT_SUM PROC  
    LEA DX,MSG4           ; LOAD ADDRESS OF MSG1 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT
            
    
    MOV CX, 5
    
    LEA SI, ARR
    
    MOV AH, 01H
    INT 21H
    
    INPUT_ARR:
       
        CALL DEC_IN  
        
        ADD SUM, BX
        
        MOV [SI], BX
        INC SI
        
        LOOP INPUT_ARR   
        
        
    LEA SI, ARR
    
    PRINT_ARR:
        
        MOV AX, [SI]
        INC SI
        
        CALL DEC_OUT
        
        
        
    
    PRINT_S:
        MOV AX, SUM
        CALL DEC_OUT
        
    
    
     RET

PRINT_SUM ENDP    
    
    
  


MAIN PROC
    MOV AX,@DATA          ; INITIALIZE DATA SEGMENT
    MOV DS,AX  
    
    LEA DX,MSG1           ; LOAD ADDRESS OF MSG1 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT
             
             
             
    CALL DEC_IN           ; INPUT M      
    
    MOV AX, BX
    
    PUSH AX               ; SAVE M ON STACK   
    
    

    LEA DX,MSG2           ; LOAD ADDRESS OF MSG2 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT
                                            
                                            
                                            
                                            
    CALL DEC_IN           ; INPUT N
    
    MOV AX, BX
    
    PUSH AX               ; SAVE N ON STACK
                                            
                                            
                                            
    XOR BX,BX             ; CLEAR BX     
    
    POP BX                ; POP N INTO BX    BX = N
    
    POP AX                ; POP M INTO AX    AX = M
         
          
    CMP AX,BX             ; COMPARE M AND N     
    
    JLE SWAP               ; IF M < N, SWAP THEM  
    
    JMP GCD               ; OTHERWISE, START GCD CALCULATION

SWAP:       
    ; SWAP BETWEEN M AND N

    MOV A,AX              ; STORE AX IN A
    MOV AX,BX             ; MOVE BX TO AX
    MOV BX,A              ; MOVE A (ORIGINAL AX) TO BX

GCD:
    XOR DX,DX             ; CLEAR DX FOR REMAINDER
    
    MOV B,BX              ; STORE DIVISOR IN B
    
    DIV B                 ; DIVIDE AX BY BX  
    
    ; AX = AX / B , DX = REMAINDER
    

    CMP DX,0              ; CHECK IF REMAINDER IS ZERO 
    
    JE GO                 ; IF ZERO, GCD FOUND              
    
    MOV AX,BX             ; REPLACE DIVIDEND WITH DIVISOR  
    
    MOV BX,DX             ; REPLACE DIVISOR WITH REMAINDER 
    
    JMP GCD               ; REPEAT GCD CALCULATION

GO:
    LEA DX,MSG3           ; LOAD ADDRESS OF MSG3 INTO DX
    MOV AH,9              ; DOS FUNCTION TO DISPLAY STRING
    INT 21H               ; CALL DOS INTERRUPT               
    
    MOV AX, B             ; MOVE GCD INTO AX
    
    CALL DEC_OUT          ; PRINT GCD      
  
    

    MOV AH,4CH            ; DOS FUNCTION TO TERMINATE PROGRAM
    INT 21H               ; CALL DOS INTERRUPT   
    
    
        
    
    

MAIN ENDP                                               


END MAIN
