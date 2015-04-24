#ifndef symbol_h
#define symbol_h

#include "binarystring.h"

struct _Symbol {
	char label[33];
	char type[3];
	int address;
	int size;
	int numvalues;
	BinaryString* data;
	struct _Symbol* next;
};

typedef struct _Symbol Symbol;

struct _Symbol_List {
	Symbol* symbols;
	int size;
};

typedef struct _Symbol_List SymbolList;


#endif