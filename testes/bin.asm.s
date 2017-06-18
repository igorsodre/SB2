section .data
DOIS: dw 16
section .bss
buff: resb 20
NEW_DATA: resw 1
OLD_DATA: resw 1
TMP_DATA: resw 1
section .text 
global _start 
_start:
LEA EBX, [OLD_DATA]
PUSH EBX
CALL lerinteiro
POP EBX
MOV AX, word[OLD_DATA]
L1:
DIV word[DOIS]
MOV word[NEW_DATA], AX
MUL word[DOIS]
MOV word[TMP_DATA], AX
MOV AX, word[OLD_DATA]
SUB AX, word[TMP_DATA]
MOV word[TMP_DATA], AX
LEA EBX, [TMP_DATA]
PUSH EBX
CALL escreverinteiro
POP EBX
MOV word[OLD_DATA+0], word[NEW_DATA+0]
MOV AX, word[OLD_DATA]
CMP AX, 0
JG L1
MOV EAX, 1
MOV EBX, 0
INT 80h
