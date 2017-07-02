%include "io.mac"

.DATA
texto: db "olar como vai voce",0
.UDATA
buff: resw 2
char: resb 500
.CODE

escrevestring:
enter 0,0
push ebx
push ecx
push edx
mov eax, 4
mov ebx, 1
mov ecx, [ebp+12]
mov edx, [ebp+8]
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
GetStr char
push ebx
push dword 50
call escrevestring
add esp, 8
nwln
.EXIT

