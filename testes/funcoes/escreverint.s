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
mov ecx, 8 ; imprime 8 characteres
mov ebx, [ebp+8] ;pega numero passado como paramentro
mov ebx, [ebx]
push bx	;adiciona numero na pilha
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
jne print_number
mov eax, 4
mov ebx, 1
mov ecx, minus
inc ecx
mov edx, 1 ;// escreve 8 characteres
int 80h
;///*chamada de escrita na entrada padrao*/
print_number:
mov eax, 4
mov ebx, 1
mov ecx, buff
inc ecx
mov edx, 8 ;// escreve 8 characteres
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
