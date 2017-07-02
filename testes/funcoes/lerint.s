%include "io.mac"

.DATA
texto: db "olar como vai voce",0
teste: dw 1242
.UDATA
buff: resw 2
num: resw 1
count: resw 1
.CODE

lerinteiro:
enter 0,0
push ebx
push edx
push ecx
mov eax, 3
mov ebx, 0
mov ecx, buff
mov edx, 9
int 80h
mov bx, 0
mov ecx, 0
mov edx, 8
cmp byte[buff], byte 45
jne read_int_loop
mov ecx, 1
mov edx, 9
read_int_loop:
cmp ecx, edx
je end_read_int
cmp byte[buff + ecx], byte 10
je end_read_int
mov ax, bx
shl ax, 1
shl bx, 3
add bx, ax
mov eax, 0
mov al, [buff+ecx]
sub al, 0x30
add bx, ax
inc ecx
jmp read_int_loop
end_read_int:
cmp edx, 9
jne encerra_int
neg bx
encerra_int:
mov esi, [ebp+8]
mov [esi], ebx
mov eax, ecx
pop ecx
pop edx
pop ebx
leave
ret


.STARTUP
PutStr texto
nwln
LEA EBX, [num]
push ebx
call lerinteiro
pop ebx
PutInt word[num]
nwln
.EXIT
