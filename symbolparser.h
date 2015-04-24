#ifndef symbolparser_h
#define symbolparser_h

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"
#include "binarystring.h"

void parseSymbols();
void parseTextSymbols(FILE* textFile);
void parseDataSymbols(FILE* dataFile);
void parseDataLine(char* line, int address);
void parseWLine(char* values, char* label, int address);
void parseALine(char* value, char* label, int address);
SymbolList* getSymbols();

const static int TEXT_BASE_ADDRESS = 0;
const static int DATA_BASE_ADDRESS = 8192;
const static char* TEXT_SOURCE = "text.txt";
const static char* DATA_SOURCE = "data.txt";

#endif