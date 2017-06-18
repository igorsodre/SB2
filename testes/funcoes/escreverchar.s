
%include "io.mac"

.DATA
texto: db "olar como vai voce",0
.UDATA
buff: resw 2
char: resb 1
.CODE

escreverchar:
enter 0,0
push ebx
push ecx
push edx

;///*chamada de escrita na entrada padrao*/
mov eax, 4
mov ebx, 1
mov ecx, [ebp+8]
mov edx, 1 ;// le 2 caracteres da entrada padrao
int 80h

pop edx
pop ecx
pop ebx
leave
ret


.STARTUP
PutStr texto
nwln
LEA EBX, [char]
GetCh byte[char]
push ebx
call escreverchar
pop ebx
nwln
.EXIT
