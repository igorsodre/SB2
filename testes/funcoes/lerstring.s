%include "io.mac"

.DATA
texto: db "olar como vai voce",0
.UDATA
buff: resb 500
char: resb 500
.CODE

lerstring:
enter 0,0
push ebx
push ecx
push edx
mov eax, 3
mov ebx, 0
mov ecx, buff
mov edx, dword[ebp+8]
int 80h
mov ecx, 0
mov esi, [ebp+12]
looplerstring:
cmp ecx, dword[ebp+8]
je looplerstring_end
cmp byte[buff+ecx], 10
je looplerstring_end
mov eax, 0
mov al, byte[buff+ecx]
mov byte[esi+ecx], al
inc ecx
jmp looplerstring
looplerstring_end:
mov byte[esi+ecx+1], 0
mov eax, ecx
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
push dword 20
call lerstring
add esp, 8
PutStr char
nwln
.EXIT
