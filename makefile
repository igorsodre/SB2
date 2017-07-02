all: compile_montador

montador: compile_montador
	./prog "./testes/bin.asm"

ligador: compile_ligador
	./ligador "executaveis/fat_mod_A.o" "executaveis/fat_mod_B.o" fat.e

compile_montador:
	g++ main.cpp -o prog -std=c++14 -Wall


compile_ligador:
	g++ ligador.cpp -o ligador -std=c++14 -Wall

preprocess:
	./prog -p "arquivos_teste_moodle/bin.asm" bin

exec_bin:
	nasm -f elf -o "./testes/bin.o" "./testes/bin.asm.s" && ld -m elf_i386 -o "./testes/bin"  "./testes/bin.o"
