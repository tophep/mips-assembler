#include "printer.h"

void printSymbolTable(FILE* output, SymbolList* symlist) {

	fprintf(output, "Address\t\tSymbol\n------------------------\n");
	if (symlist->size == 0) {
		fprintf(output, "\t%s\n", "*** NO SYMBOLS DETECTED ***");
	}
	else {
		Symbol* symbol = symlist->symbols;
		for (int i = 0; i < symlist->size; i++) {
			fprintf(output, "0x%08X\t%s\n", symbol->address, symbol->label);
			symbol = symbol->next;
		}
	}
}

void printDataSection(FILE* output, SymbolList* symlist) {
	Symbol* symbol = symlist->symbols;
	while (symbol) {
		if (symbol->type[0] == 'w') {
			printWordData(output, symbol);
			symbol = symbol->next;
		}
		else if (symbol->type[0] == 'a') {
			symbol = printStringData(output, symbol);
		}
		else {
			symbol = symbol->next;
		}
	}
}

void printWordData(FILE* output, Symbol* symbol) {
	if (symbol->type[1] == '0') {
		fprintf(output,"%s\n", symbol->data->value);
	}
	else if (symbol->type[1] == '1') {
		for (int count = 0; count < symbol->numvalues; count++) {
			fprintf(output,"%s\n", symbol->data->value);	
		}
	}
	else if (symbol->type[1] == '2') {
		BinaryString* data = symbol->data;
		for (int count = 0; count < symbol->numvalues; count++) {
			fprintf(output,"%s\n", data->value);
			data++;	
		}
	}
}

Symbol* printStringData(FILE* output, Symbol* symbol) {
	BinaryString combinedString = {0};
	symbol = combineAndAlign(symbol, &combinedString);

	char* data = combinedString.value;
	int lines = combinedString.length/32;
	for (int i = 0; i < lines; i++) {
		int base = i*32;
		int index = base+24;
		for (;index>=base; index-=8) {
			fprintf(output, "%.8s", &data[index]);	
		}
		fprintf(output, "\n");
	}
	return symbol;
}

Symbol* combineAndAlign(Symbol* symbol, BinaryString* combined) {
	while (symbol && symbol->type[0] == 'a') {
		BinaryString* old = symbol->data;
		combined->length += old->length;
		strcat((char*)&combined->value, (char*)&old->value);
		symbol = symbol->next;
	}
	
	int hangingbytes = combined->length%32;
	
	if (hangingbytes) {
		int padbytes = 32 - hangingbytes;
		for (int i = 0; i < padbytes; i++) {
			combined->value[combined->length] = '0';
			combined->length++;
		}
	}
	
	return symbol;
}


void printTextSection() {

}

