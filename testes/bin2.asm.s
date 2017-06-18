section .data
DOIS: dw 10
section .bss
NEW_DATA: resdw 50
OLD_DATA: resdw 50
TMP_DATA: resdw 1
section .text 
global _start 
_start:
L1:
SUB AX, word[TMP_DATA]
ADD AX, word[OLD_DATA+4]
MOV word[NEW_DATA+0], word[OLD_DATA+0]
MOV AX, word[DOIS]
MOV EAX, 1
MOV EBX, 0
INT 80h
