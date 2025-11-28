.model small
.stack 100h
.data

introMsg db 0Dh,0Ah
         db '   ==============================',0Dh,0Ah
         db '       What should I read?      ',0Dh,0Ah
         db '   ==============================',0Dh,0Ah,0Dh,0Ah,'$'

menu     db ' Choose a genre:',0Dh,0Ah,0Dh,0Ah
         db '  1) Romance',0Dh,0Ah
         db '  2) Mystery',0Dh,0Ah
         db '  3) Fantasy',0Dh,0Ah
         db '  4) Classic',0Dh,0Ah
         db '  5) Self-help',0Dh,0Ah,0Dh,0Ah,'$'

prompt   db ' Enter your choice (1-5): $'
invalid  db 0Dh,0Ah,' Invalid choice! Try again.',0Dh,0Ah,'$'
askAgain db 0Dh,0Ah,' Another recommendation? (Y/N): $'
goodbye  db 0Dh,0Ah,0Dh,0Ah
         db ' Thanks for using Book Suggestor!',0Dh,0Ah
         db ' Happy Reading! ',1Fh,1Fh,1Fh,0Dh,0Ah,'$'
nl       db 0Dh,0Ah,'$'


R1 db 'Pride and Prejudice - Jane Austen$'
R2 db 'Me Before You - Jojo Moyes$'
R3 db 'The Notebook - Nicholas Sparks$'
R4 db 'Outlander - Diana Gabaldon$'
R5 db 'Red, White & Royal Blue - Casey McQuiston$'

M1 db 'The Girl with the Dragon Tattoo - Stieg Larsson$'
M2 db 'Gone Girl - Gillian Flynn$'
M3 db 'Sherlock Holmes - Arthur Conan Doyle$'
M4 db 'The Da Vinci Code - Dan Brown$'
M5 db 'And Then There Were None - Agatha Christie$'

F1 db 'Harry Potter Series - J.K. Rowling$'
F2 db 'The Lord of the Rings - J.R.R. Tolkien$'
F3 db 'The Name of the Wind - Patrick Rothfuss$'
F4 db 'A Game of Thrones - George R.R. Martin$'
F5 db 'The Hobbit - J.R.R. Tolkien$'

C1 db '1984 - George Orwell$'
C2 db 'To Kill a Mockingbird - Harper Lee$'
C3 db 'The Great Gatsby - F. Scott Fitzgerald$'
C4 db 'Jane Eyre - Charlotte Bront?$'
C5 db 'Crime and Punishment - Dostoevsky$'

S1 db 'Atomic Habits - James Clear$'
S2 db 'The 7 Habits - Stephen Covey$'
S3 db 'How to Win Friends - Dale Carnegie$'
S4 db 'The Power of Now - Eckhart Tolle$'
S5 db 'Think and Grow Rich - Napoleon Hill$'

RomPtrs dw offset R1, offset R2, offset R3, offset R4, offset R5
MysPtrs dw offset M1, offset M2, offset M3, offset M4, offset M5
FanPtrs dw offset F1, offset F2, offset F3, offset F4, offset F5
ClsPtrs dw offset C1, offset C2, offset C3, offset C4, offset C5
SelfPtrs dw offset S1, offset S2, offset S3, offset S4, offset S5

history     dw -1, -1, -1
hist_cnt    db 0

.code
main proc
    mov ax, @data
    mov ds, ax

    mov dx, offset introMsg
    mov ah, 09h
    int 21h

mainloop:
    mov dx, offset menu
    mov ah, 09h
    int 21h

    mov dx, offset prompt
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'

    cmp al, 1
    je r
    cmp al, 2
    je m
    cmp al, 3
    je f
    cmp al, 4
    je c
    cmp al, 5
    je s
    jmp err

r:  mov bx, offset RomPtrs
    jmp go
m:  mov bx, offset MysPtrs
    jmp go
f:  mov bx, offset FanPtrs
    jmp go
c:  mov bx, offset ClsPtrs
    jmp go
s:  mov bx, offset SelfPtrs

go:
    call pick_book
    jmp ask

err:
    mov dx, offset invalid
    mov ah, 09h
    int 21h
    jmp mainloop

ask:
    mov dx, offset askAgain
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    and al, 0DFh
    cmp al, 'Y'
    je mainloop

    mov dx, offset goodbye
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
main endp

pick_book proc
    push ax bx cx dx si di

try:
    mov ah, 00h
    int 1Ah
    mov ax, dx
    xor dx, dx
    mov cx, 5
    div cx
    mov si, dx
    shl si, 1
    mov di, [bx + si]

    ; check history
    mov cx, 3
    mov si, offset history
chk:
    cmp word ptr [si], -1
    je ok
    cmp di, [si]
    je try
    add si, 2
    loop chk

ok:
    mov dx, offset nl
    mov ah, 09h
    int 21h

    mov dx, di
    mov ah, 09h
    int 21h

    mov dx, offset nl
    mov ah, 09h
    int 21h

    ; update history
    mov ax, word ptr history[2]
    mov word ptr history[4], ax
    mov ax, word ptr history[0]
    mov word ptr history[2], ax
    mov word ptr history[0], di

    cmp hist_cnt, 3
    jae done
    inc hist_cnt
done:
    pop di si dx cx bx ax
    ret
pick_book endp

end main