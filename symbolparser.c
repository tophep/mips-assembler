#include "symbolparser.h"

SymbolList LIST = {0};
Symbol SYMBOLS[256] = {0};
BinaryString DATA_STRINGS[256] = {0};

int SYM_COUNT;
int DS_COUNT;
int TEXT_SYM_COUNT;
int DATA_SYM_COUNT;
int INPUT_PARSED = 0;


SymbolList* getSymbols() {
	if (!INPUT_PARSED){
		parseSymbols();
	}
	return &LIST;
}

void parseSymbols() {
	SYM_COUNT = 0;

	FILE* textFile = fopen(TEXT_SOURCE, "r");
	FILE* dataFile = fopen(DATA_SOURCE, "r");
	
	parseTextSymbols(textFile);
	parseDataSymbols(dataFile);

	for (int i = 0; i < SYM_COUNT-1; i++) {
		SYMBOLS[i].next = &SYMBOLS[i+1];
	}
	SYMBOLS[SYM_COUNT-1].next = NULL;
	LIST.size = SYM_COUNT;
	LIST.symbols = (Symbol*) &SYMBOLS;

	fclose(textFile);
	fclose(dataFile);
	INPUT_PARSED = 1;
}

void parseTextSymbols(FILE* textFile) {

	int address = TEXT_BASE_ADDRESS;
	char line[257] = {'\0'};
	while (fgets(line, 257, textFile) != NULL){
		char* label = strchr(line, ':'); 
		if (label) {
			label = strtok(line, ":");
			Symbol* newSym = &SYMBOLS[SYM_COUNT];
			newSym->address = address;
			strcpy((char*)(&newSym->label), label);
			strcpy((char*)(&newSym->type), "t");
			SYM_COUNT++;
			TEXT_SYM_COUNT++;
		}
		else {
			address += 4;
		}
		memset(line, '\0', sizeof(line));
	}
}

void parseDataSymbols(FILE* dataFile){

	int address = DATA_BASE_ADDRESS;
	char line[257] = {'\0'};

	while (fgets(line, 257, dataFile) != NULL){
		parseDataLine(line, address);
		Symbol* sym = &SYMBOLS[SYM_COUNT-1];
		address = sym->address + sym->size;
		memset(line, '\0', sizeof(line));
	}

}

void parseDataLine(char* line, int address) {
	char* data = strchr(line, ':') + 1;
	char* label = strtok(line, ":");
	char* dataType = strtok(data, " \t\n");

	if (strcmp(dataType, ".word") == 0) {
		char* values = dataType + 6;
		parseWLine(values, label, address);
	}

	else if (strcmp(dataType, ".asciiz") == 0) {
		char* values = dataType + 8;
		parseALine(values, label, address);
	}
}

void parseWLine(char* values, char* label, int address) {
	
	Symbol* newSym = &SYMBOLS[SYM_COUNT];
	
	if (address % 4 != 0) {
		address += 4 - address%4;
	}
	newSym->address = address;
	strcpy((char*)(&newSym->label), label);

	if (strchr(values, ',')) {
		BinaryString* data = &DATA_STRINGS[DS_COUNT];
		char* value = strtok(values, ", \t\n");

		while (value) {
			int intvalue = (int)strtol(value,(char **)NULL,10);
			bStringFromInt(data, intvalue, 4);
			data++;
			DS_COUNT++;
			newSym->numvalues++;
			value = strtok(NULL, ", \t\n");
		}
		strcpy((char*)(&newSym->type), "w2");
		newSym->size = newSym->numvalues*4;
		newSym->data = data - (newSym->numvalues);
	}

	else if (strchr(values, ':')) {
		char* value = strtok(values, ": \t\n");
		int intvalue = (int)strtol(value,(char **)NULL,10);
		BinaryString* data = &DATA_STRINGS[DS_COUNT];
		bStringFromInt(data, intvalue, 4);
		DS_COUNT++;

		strcpy((char*)(&newSym->type), "w1");
		newSym->numvalues = (int)strtol(strtok(NULL, ": \t\n"),(char **)NULL,10);
		newSym->size = newSym->numvalues * 4;
		newSym->data = data;
	}

	else {
		char* value = strtok(values, " \t\n");
		int intvalue = (int)strtol(value,(char **)NULL,10);
		BinaryString* data = &DATA_STRINGS[DS_COUNT];
		bStringFromInt(data, intvalue, 4);
		DS_COUNT++;

		strcpy((char*)(&newSym->type), "w0");
		newSym->numvalues = 1;
		newSym->size = 4;
		newSym->data = data;
	}
	SYM_COUNT++;
	DATA_SYM_COUNT++;
}

void parseALine(char* values, char* label, int address) {
	Symbol* newSym = &SYMBOLS[SYM_COUNT];
	BinaryString* data = &DATA_STRINGS[DS_COUNT];
	char* asciiString = strtok(strchr(values,'"'), "\"");
	int size = strlen(asciiString);
	bStringFromString(data, asciiString, size);

	strcpy((char*)(&newSym->label), label);
	strcpy((char*)(&newSym->type), "a");
	newSym->address = address;
	newSym->numvalues = 1;
	newSym->size = size + 1;
	newSym->data = data;

	SYM_COUNT++;
	DS_COUNT++;
	DATA_SYM_COUNT++;
}

