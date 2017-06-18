#include <iostream>
#include <fstream>
#include "constantes.hpp"
#include "helper.cpp"
#include "preprocessador.cpp"
#include "montador.cpp"

using namespace std;

void exec(int argc, char *argv[]);

int verfica_argumentos(char *argv[]);

int inicializa_arquivo(char *argv[], fstream &fonte);

int preprocessa_arquivo(fstream &fonte, fstream &saida_pre, char *argv[]);

int verifica_extensao(string &s);

string get_estencao(string s);

int montagem(fstream &fonte, fstream &saida_pre, char *argv[]);

int main(int argc, char *argv[])
{
	exec(argc, argv);
	return 0;
}


/*********************************************************************************
 * Funcao que verifica a quantidade e a validade dos arguetos passados ao programa
 ********************************************************************************/
int verifica_argumentos(int argc, char *argv[]){
	if(argc != 2){
		cout << RED << "Numero incorreto de argumentos!!!!\n\nexecute o programa novamente com o numero correto de argumentos\n" << RESET;
		return 0;
	}
	return 1;
}

/*******************************************************************
 * retorna extencao do arquivo relativa ao arquivo passado como
 * parametro
 * ****************************************************************/
string get_estencao(string s){
	return s.substr(s.length()-4, s.length());
}

/**********************************************************************************
 * verifica se a entecao do arquivo passado para o programa = .asm
 * ********************************************************************************/
int verifica_extensao(string &s){
	return (s.substr(s.length()-4, s.length()).find(".asm") != string::npos);
}

/**********************************************************************************
 * funcao que inicializa o arquivo fonte, vereficando a sua existencia e se possui
 * a extencao adequada
 **********************************************************************************/
int inicializa_arquivo(char *argv[], fstream &fonte){
	string s(argv[1]);
	string line;
	if (verifica_extensao(s)){ // verifica se a extencao do arquivo esta correta
		fonte.open(s);
		if(fonte.is_open()){
			cout << GRN << "Arquivo aberto com sucesso\n" << RESET;
			return 1;
		}
		else {
			cout << RED << "Nao foi possivel abrir arquivo \n" << RESET;
		}
	} else {
		cout << RED << "arquivo passado nao possui extensao .asm \n" << RESET;
	}
	return 0;
}

int montagem(fstream &fonte, fstream &saida_pre, char *argv[]){
	preprocessa_arquivo(fonte, saida_pre, argv);
	monta_arquivo(saida_pre, string(argv[1]));
	return 1;
}

/**********************************************************************************
 * roda o montador/ligador
 * *******************************************************************************/
void exec(int argc, char *argv[]){
	fstream fonte;
	fstream pre_processado;

	if(verifica_argumentos(argc, argv) && inicializa_arquivo(argv, fonte)){
		montagem(fonte, pre_processado, argv);
	}
	fonte.close();
	pre_processado.close();
}
