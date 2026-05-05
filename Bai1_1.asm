.Model Small
.Stack 100H
.Data
    English db "Hello$"
    VietNam db "Xin chao$"
    crlf    db 13, 10, '$' ; Ký tự về đầu dòng (13) và xuống dòng (10)

.Code
Main Proc    
    ; --- Khoi tao doan du lieu ---
    mov ax, @data
    mov ds, ax
    
    ; --- In chuoi tieng Anh ---
    mov ah, 9           ; Ham 9 cua ngat 21h dung de in chuoi
    lea dx, English     ; Lay dia chi bien English vao DX
    int 21h             
    
    ; --- In dau xuong dong ---
    lea dx, crlf
    int 21h
    
    ; --- In chuoi tieng Viet ---
    lea dx, VietNam
    int 21h
    
    ; --- Ket thuc chuong trinh ---
    mov ah, 4ch         ; Ham 4ch dung de thoat ve DOS
    int 21h
Main endp 

END MAIN
