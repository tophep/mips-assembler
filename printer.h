#ifndef printer_h
#define printer_h

#include <stdio.h>
#include "symbol.h"

void printSymbolTable(FILE* output, SymbolList* symlist);
void printDataSection(FILE* output, SymbolList* symlist);
void printWordData(FILE* output, Symbol* symbol);
Symbol* printStringData(FILE* output, Symbol* symbol);
Symbol* combineAndAlign(Symbol* symbol, BinaryString* combined);
void printTextSection();

#endif