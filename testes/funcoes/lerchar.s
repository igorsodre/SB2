%include "io.mac"

.DATA
texto: db "olar como vai voce",0
.UDATA
buff: resw 2
char: resb 1
.CODE

lerchar:
enter 0,0
push ebx
push ecx
push edx
mov eax, 3
mov ebx, 0
mov ecx, buff
mov edx, 2
int 80h
mov esi, [ebp+8]
mov eax, 0
mov al, byte[buff]
mov [esi], eax
pop edx
pop ecx
pop ebx
leave
ret


.STARTUP
PutStr texto
nwln
LEA EBX, [char]
push ebx
call lerchar
pop ebx
PutCh byte[char]
nwln
.EXIT
