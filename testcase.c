#include "symbolparser.h"
#include "preprocessor.h"
#include "printer.h"

void printSymbol(Symbol* symbol);

int main(int argc, char** argv) {
	char* sourceFileName = argv[1];
	FILE* source = fopen(sourceFileName, "r");
	preprocess(source);
	SymbolList* symlist = getSymbols();
	Symbol* symbols = symlist->symbols;
	// printf("Number of symbols: %d\n", symlist->size);
	// for (int i = 0; i < symlist->size; i++) {
	// 	printf("\n\n");
	// 	printSymbol(symbols);
	// 	symbols++;
	// }

	FILE* datasection = fopen("binarydata.txt", "w+");
	printDataSection(datasection, symlist);
	fclose(source);
}

void printSymbol(Symbol* symbol) {
	printf("Label: %s\n", symbol->label);
	printf("Type: %s\n", symbol->type);
	printf("Address: %08X\n", symbol->address);
	printf("Size: %d\n", symbol->size);
	printf("Number of Values: %d\n", symbol->numvalues);
}