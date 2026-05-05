.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    msg_len db 'Nhap so luong phan tu: $'
    msg_num db 'Nhap so: $'
    msg_sum db 13, 10, 'TONG CAC SO DA NHAP: $'
    base_dec dw 10
    x dw 0
    SUM dw 0

.Code
Main Proc    
    mov ax, @data
    mov ds, ax
    
    ; --- Nhap so luong phan tu ---
    mov ah, 9
    lea dx, msg_len
    int 21h
    call Input
    mov cx, x       ; CX giu so lan lap
    
    cmp cx, 0       ; Neu nhap 0 phan tu thi ket thuc luon
    je Exit_Prog

    ; --- Vong lap nhap mang ---
Input_Array:
    push cx         ; Cat CX vao Stack de tranh bi ham Input lam thay doi
    mov ah, 9
    lea dx, crlf
    int 21h
    lea dx, msg_num
    int 21h
    
    call Input
    mov ax, x
    add SUM, ax     ; Cong don vao SUM
    pop cx          ; Lay lai CX de tiep tuc vong lap
    loop Input_Array 
    
    ; --- In ket qua ---
    mov ah, 9
    lea dx, msg_sum
    int 21h
    call Output
    
Exit_Prog:
    mov ah, 4ch
    int 21h
Main endp 

; --- Ham nhap so tu ban phim (Luu ket qua vao x) ---
Input Proc
    mov x, 0
Loop_Input:
    mov ah, 1 
    int 21h
    cmp al, 13      ; Neu la phim Enter
    je End_Input
    cmp al, 32      ; Neu la phim Space (dau cach)
    je End_Input
    
    sub al, '0'     ; Chuyen tu ky tu sang so
    mov ah, 0
    mov bx, ax      ; Luu tam chu so vua nhap vao bx
    
    mov ax, x
    mul base_dec    ; x = x * 10
    add ax, bx      ; x = x * 10 + chu so moi
    mov x, ax
    jmp Loop_Input
End_Input:
    ret      
Input Endp

; --- Ham in gia tri tu SUM ra man hinh ---
Output Proc
    mov ax, SUM
    mov cx, 0       ; Bien dem so chu so
    
    cmp ax, 0
    jne Divide
    ; Neu tong bang 0 thi in luon so 0
    mov ah, 2
    mov dl, '0'
    int 21h
    ret

Divide:
    mov dx, 0
    div base_dec    ; AX = thuong, DX = so du
    push dx         ; Day so du vao Stack
    inc cx
    cmp ax, 0
    jne Divide

Show:
    pop dx
    add dl, '0'     ; Chuyen so sang ky tu
    mov ah, 2
    int 21h
    loop Show
    ret    
Output Endp

END MAIN