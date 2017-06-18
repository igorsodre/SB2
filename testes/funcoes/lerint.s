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

;///*chamada de leitura da entrada padrao*/
mov eax, 3
mov ebx, 0
mov ecx, buff
mov edx, 9
int 80h

mov bx, 0
mov ecx, 0 ;/ecx eh o contador do loop
mov edx, 8
cmp byte[buff], byte 45 ;// ve se eh o caracter "menus"
jne read_int_loop
mov ecx, 1 ;// se negativo aumenta o contador
mov edx, 9 ;// se negativo entao posso ler ate 9 caracteres

read_int_loop:
cmp ecx, edx ;// 9 ou 8 caracteres no maximo
je end_read_int
cmp byte[buff + ecx], byte 10 ;// ve se eh um barra n
je end_read_int

;//multiplica acumulador por 10
mov ax, bx
shl ax, 1
shl bx, 3
add bx, ax
;// adiciona o numero lido ao acumulador
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
mov [esi], ebx ;// coloca numero lido no endereco passado como paramentro
mov eax, ecx ;// retorna numero de caracteres lidos
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
