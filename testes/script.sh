nasm -f elf -o escreverchar.o escreverchar.s
ld -m elf_i386 -o escreverchar escreverchar.o io.o

