nasm -f elf -o escreverint.o escreverint.s
ld -m elf_i386 -o escreverint escreverint.o io.o

