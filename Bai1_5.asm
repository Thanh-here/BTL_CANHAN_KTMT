.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    ; Cau truc chuan: Max - Actual - Buffer
    str_buf db 100, 0, 101 dup ('$')
    msg1 db 'Chuoi viet thuong: $'
    msg2 db 13, 10, 'Chuoi viet hoa: $'

.Code
Main Proc
    mov ax, @data
    mov ds, ax

    ; Nhap chuoi
    mov ah, 10
    lea dx, str_buf
    int 21h

    ; In thong bao 1
    mov ah, 9
    lea dx, crlf
    int 21h
    lea dx, msg1
    int 21h

    ; Chuan bi thanh ghi de in chuoi viet thuong
    mov ch, 0
    mov cl, [str_buf + 1] ; Lay do dai thuc te da nhap
    lea si, str_buf + 2
    call Lowercase

    ; In thong bao 2
    mov ah, 9
    lea dx, msg2
    int 21h

    ; Chuan bi thanh ghi de in chuoi viet hoa
    mov ch, 0
    mov cl, [str_buf + 1]
    lea si, str_buf + 2
    call Uppercase

    mov ah, 4ch
    int 21h
Main endp

Lowercase Proc
    cmp cx, 0          ; Kiem tra neu chuoi rong
    je end_lower
loop_lower:
    mov dl, [si]
    cmp dl, 'A'
    jl print_lower
    cmp dl, 'Z'
    jg print_lower
    add dl, 32         ; Doi thanh chu thuong
print_lower:
    mov ah, 2
    int 21h
    inc si
    loop loop_lower
end_lower:
    ret
Lowercase Endp

Uppercase Proc
    cmp cx, 0
    je end_upper
loop_upper:
    mov dl, [si]
    cmp dl, 'a'
    jl print_upper
    cmp dl, 'z'
    jg print_upper
    sub dl, 32         ; Doi thanh chu hoa
print_upper:
    mov ah, 2
    int 21h
    inc si
    loop loop_upper
end_upper:
    ret
Uppercase Endp

END MAIN