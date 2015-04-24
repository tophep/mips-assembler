#ifndef binarystring_h
#define binarystring_h

#include <string.h>
#include <stdlib.h>

struct _BinaryString {
	char value[2048];
	int length;
};

typedef struct _BinaryString BinaryString;

void bStringFromString(BinaryString* bstring, char* src, int size);
void bStringFromInt(BinaryString* bstring, int src, int size);
void convertString(char* dest, char* src, int size);
void convertInteger(char* dest, int src, int size);

#endif