;;;;;; pattern
.model small
.stack 100h

.data 

msg1 db 'Enter a number: $'
msg2 db 'Result: $' 
var db ?

.code


main proc
    
   
   mov ax,@data
   mov ds,ax 
   
   mov ah,9
   mov dl,offset msg1
   int 21h 
   
   mov ah,1
   int 21h 
   sub al,48
   mov var,al 
   
   call newline
   
   mov ah,9
   mov dl,offset msg2
   int 21h
   
   call newline 
   
   
   mov bl,1
   mov bh,var
   
   l1:
       cmp bl,bh
       ja exit1
       
       mov cl,1
   
       l2:
           cmp cl,bl
           ja exit2
           
           mov ah,2
           mov dl,'*'
           int 21h
           
           inc cl
           jmp l2
   
       exit2: 
       
       call newline
       
       inc bl
       jmp l1
   
   exit1: 
    
    
main endp


newline proc
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h     
    ret
    
newline endp


        
end main  





;;;;;; deci i/o


.model small
.stack 100h


.data

msg1 db 'Enter a number: $'  
msg2 db 'The number is: $'
var dw ?

.code


main proc
     
     mov ax,@data
     mov ds,ax
     
     mov ah,9
     mov dl,offset msg1
     int 21h
     
     call din
     mov var,bx 
     
     call newline 
     
     mov ah,9
     mov dl,offset msg2
     int 21h
     
     mov ax,var
     call dout
    
    
    
    
main endp  
          
          
          
;newline print          
newline proc
     mov ah,2
     mov dl,10
     int 21h
     mov dl,13
     int 21h  
    ret    
newline endp


;decimal input which save in 'bx'
din proc
    
    xor bx,bx
    xor cx,cx
    
    input: 
    
        mov ah,1
        int 21h
        
        cmp al,13
        je exit
        
        and ax,15  ; ascii to hexa covert
        mov cx,ax
        mov ax,10 
        
        mul bx
        
        add ax,cx
        mov bx,ax
            
        jmp input
        
    exit:
    

    ret    
din endp  


;decimal output print from 'ax'
dout proc
    
    xor bx,bx
    xor cx,cx  
    xor dx,dx
    
    output:
    
        xor dx,dx
        
        mov bx,10
        div bx
        
        push dx   
        inc cx
          
        cmp ax,0
        je exit1
        jmp output
    
    exit1:
    
    
    print:
    
        mov ah,2
        pop dx 
        add dx,48
        int 21h
    
    loop print    
            
    
    ret
dout endp



end main







;;;;;; palindrome


.model small
.stack 200h


.data

msg1 db 'Enter a string: $'  
msg2 db 'The number is: $' 

msg3 db 'Not Palindrome$' 
msg4 db 'Plaindrome$'

var dw ?       

arr db 10 dup(0)
arr1 db 10 dup(0)

.code


main proc
     
     mov ax,@data
     mov ds,ax
     
     mov ah,9
     mov dl,offset msg1
     int 21h
     
     mov cx,0
     mov si,offset arr
     
     ar_input:
         
         
         mov ah,1
         int 21h
         
         cmp al,13
         je exit2
         
         mov [si],al
         push [si]
         inc cx 
         inc si
         jmp ar_input 
         
     exit2: 
       
     call newline 
     
 
     mov di,offset arr1     
     mov bx,cx
     
     rev_array:
          
        pop dx
        mov [di],dl
        inc di
        
     loop rev_array
     
     mov cx,bx  
     
     mov si, offset arr
     mov di,offset arr1
     
     ar_print:
     
        mov dh,[si]
        mov dl,[di]
        
        cmp dh,dl
        jne exit4
        
        inc di 
        inc si
        
     loop ar_print 
     
     mov ah,9
     mov dx,offset msg4
     int 21h
             
     jmp exit5
     
     exit4:
        mov ah,9
        mov dx,offset msg3
        int 21h
     
     exit5:
    
main endp  
          
;newline print          
newline proc
     mov ah,2
     mov dl,10
     int 21h
     mov dl,13
     int 21h  
    ret    
newline endp



end main



;;;;; sum


.model small
.stack 100h


.data

msg1 db 'Enter a number: $'  
msg2 db 'The array: $'   
msg3 db 'The sum: $'
var dw 0  
var1 dw 0

sum dw 0

arr dw 100 dup(0)

.code


main proc
     
     mov ax,@data
     mov ds,ax
     
     mov ah,9
     mov dl,offset msg1
     int 21h
     
     call din  
     
     mov var,bx
     mov var1,bx 
     
     call newline  
     
     mov si,offset arr     
     
     mov cx,var
     n_input:
         mov var,cx    
         
         call din
         mov [si],bx
         inc si
         inc si
         call newline
         
         mov cx,var 
     loop n_input
     
     mov ah,9
     mov dl,offset msg2
     int 21h
     
     mov si,offset arr 
     
     mov cx,var1
     n_print:
         mov var1,cx    
         
         mov ax,[si]
         inc si
         inc si
         
         add sum,ax
         
         call dout
         
         mov ah,2
         mov dl,' '
         int 21h
         
         mov cx,var1 
     loop n_print
     
     call newline
            
     mov ah,9
     mov dl,offset msg3
     int 21h
    
     mov ax,sum
     call dout
    
    
main endp  
          
          
          
;newline print          
newline proc
     mov ah,2
     mov dl,10
     int 21h
     mov dl,13
     int 21h  
    ret    
newline endp


;decimal input which save in 'bx'
din proc
    
    xor bx,bx
    xor cx,cx
    
    input: 
    
        mov ah,1
        int 21h
        
        cmp al,13
        je exit
        
        and ax,15  ; ascii to hexa covert
        mov cx,ax
        mov ax,10 
        
        mul bx
        
        add ax,cx
        mov bx,ax
            
        jmp input
        
    exit:
    

    ret    
din endp  


;decimal output print from 'ax'
dout proc
    
    xor bx,bx
    xor cx,cx  
    xor dx,dx
    
    output:
    
        xor dx,dx
        
        mov bx,10
        div bx
        
        push dx   
        inc cx
          
        cmp ax,0
        je exit1
        jmp output
    
    exit1:
    
    
    print:
    
        mov ah,2
        pop dx 
        add dx,48
        int 21h
    
    loop print    
            
    
    ret
dout endp



end main





;;;;;;; check even




.model small
.stack 100h


.data

msg1 db 'Enter a number: $'  
msg2 db 'The Number of even: $'   
msg3 db 'The sum: $'
var dw 0  
var1 dw 0  
var2 dw 0 


.code


main proc
     
     mov ax,@data
     mov ds,ax
     
     mov ah,9
     mov dl,offset msg1
     int 21h
     
     call din  
     
     mov var,bx
     mov var1,bx 
     
     call newline  
     
     mov si,offset arr     
     
     mov cx,var
     
     n_input:
         mov var,cx   
         
         call din
         and bx,0001h
         
         cmp bx,0
         je even 
         
         jmp not_even
         
         even:
         mov dx,var2
         inc dx
         mov var2,dx
         
         not_even:
                 
         call newline
         
         mov cx,var 
     loop n_input
     
     mov ah,9
     mov dl,offset msg2
     int 21h
    
     mov ax,var2
     call dout
    
    
main endp  
          
          
          
;newline print          
newline proc
     mov ah,2
     mov dl,10
     int 21h
     mov dl,13
     int 21h  
    ret    
newline endp


;decimal input which save in 'bx'
din proc
    
    xor bx,bx
    xor cx,cx
    
    input: 
    
        mov ah,1
        int 21h
        
        cmp al,13
        je exit
        
        and ax,15  ; ascii to hexa covert
        mov cx,ax
        mov ax,10 
        
        mul bx
        
        add ax,cx
        mov bx,ax
            
        jmp input
        
    exit:
    

    ret    
din endp  


;decimal output print from 'ax'
dout proc
    
    xor bx,bx
    xor cx,cx  
    xor dx,dx
    
    output:
    
        xor dx,dx
        
        mov bx,10
        div bx
        
        push dx   
        inc cx
          
        cmp ax,0
        je exit1
        jmp output
    
    exit1:
    
    
    print:
    
        mov ah,2
        pop dx 
        add dx,48
        int 21h
    
    loop print    
            
    
    ret
dout endp



end main



;;;;;; word decimal sum


.model small
.stack 100h


.data

msg1 db 'Enter a string: $'  
msg2 db 'The Number of even: $'   
msg3 db 'The sum: $'
var dw 0  
var1 dw 0  
var2 dw 0

sum dw 0 


.code


main proc
     
     mov ax,@data
     mov ds,ax
     
     mov ah,9
     mov dl,offset msg1
     int 21h
     
     s_input: 
    
        mov ah,1
        int 21h
        
        cmp al,13
        je s_exit
        
        cmp al,48
        jl s_input 
        
        cmp al,57
        jg s_input
        
        and ax,15  ; ascii to hexa covert
        add sum,ax
            
        jmp s_input
        
     s_exit:  
     
     call newline  
     
     mov ah,9
     mov dl,offset msg3
     int 21h
    
     mov ax,sum
     call dout
    
    
main endp  
          
          
          
;newline print          
newline proc
     mov ah,2
     mov dl,10
     int 21h
     mov dl,13
     int 21h  
    ret    
newline endp


;decimal input which save in 'bx'
din proc
    
    xor bx,bx
    xor cx,cx
    
    input: 
    
        mov ah,1
        int 21h
        
        cmp al,13
        je exit
        
        and ax,15  ; ascii to hexa covert
        mov cx,ax
        mov ax,10 
        
        mul bx
        
        add ax,cx
        mov bx,ax
            
        jmp input
        
    exit:
    

    ret    
din endp  


;decimal output print from 'ax'
dout proc
    
    xor bx,bx
    xor cx,cx  
    xor dx,dx
    
    output:
    
        xor dx,dx
        
        mov bx,10
        div bx
        
        push dx   
        inc cx
          
        cmp ax,0
        je exit1
        jmp output
    
    exit1:
    
    
    print:
    
        mov ah,2
        pop dx 
        add dx,48
        int 21h
    
    loop print    
            
    
    ret
dout endp



end main

