section .data
minus: db 45
DOIS: dw 2
section .bss
buff: resw 500
NEW_DATA: resw 50
OLD_DATA: resw 50
TMP_DATA: resw 1
section .text

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

		escreverchar:
		enter 0,0
		push ebx
		push ecx
		push edx
		mov eax, 4
		mov ebx, 1
		mov ecx, [ebp+8]
		mov edx, 1
		int 80h
		pop edx
		pop ecx
		pop ebx
		leave
		ret

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

global _start 
_start:
L1:
SUB CX, word[TMP_DATA]
LEA EBX, [OLD_DATA]
PUSH EBX
PUSH dword 20
CALL lerstring
ADD ESP, 8
LEA EBX, [OLD_DATA]
PUSH EBX
PUSH dword 20
CALL escrevestring
ADD ESP, 8
MOV EAX, 1
MOV EBX, 0
INT 80h
