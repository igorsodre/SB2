%include "io.mac"

.DATA
texto: db "olar como vai voce",0
minus: db 45
teste: dw -1234
.UDATA
buff: resw 500
num: resw 1
count: resw 1
.CODE

escreverinteiro:
enter 0,0
push ebx
push ecx
push edx
mov ebx, 0
mov ecx, 8
mov ebx, [ebp+8]
mov ebx, [ebx]
push bx
cmp bx, 0
jge escreveintloop
mov esi, 1
neg bx
mov word[esp], bx
escreveintloop:
cmp ecx, 0
je escreveintloop_end
mov ax, [esp]
mov dx, 0
mov bx, 10
div bx
add dx, 0x30
mov byte[buff+ecx], dl
mov word[esp], ax
dec ecx
jmp escreveintloop
escreveintloop_end:
cmp esi, 1
jne start_acha_zero
mov eax, 4
mov ebx, 1
mov ecx, minus
mov edx, 1
int 80h
start_acha_zero:
mov esi, 1
acha_zero:
mov bl, byte[buff+esi]
cmp bl, 0x30
jne print_number
cmp esi, 8
je print_number
inc esi
jmp acha_zero
print_number:
mov eax, 4
mov ebx, 1
mov ecx, buff
add ecx, esi
mov edx, 8
sub edx, esi
inc edx
int 80h
pop edx
pop ecx
pop ebx
leave
ret

.STARTUP
PutStr texto
nwln
LEA EBX, [teste]
push ebx
call escreverinteiro
pop ebx
nwln
.EXIT
