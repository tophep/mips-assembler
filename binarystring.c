#include "binarystring.h"
#include <stdio.h>


void bStringFromString(BinaryString* bstring, char* src, int size) {
	bstring->length = (size+1)*8;
	convertString(bstring->value, src, size);
}

void bStringFromInt(BinaryString* bstring, int src, int size) {
	bstring->length = size*8;
	convertInteger(bstring->value, src, size);
}

void convertString(char* dest, char* src, int size) {
	while (*src && size) {
		for(int bitmask = 1<<7; bitmask > 0; bitmask >>= 1) {
			*dest = ((*src & bitmask) == bitmask) + '0';
			dest++;
		}
		src++;
		size--;
	}
	memset(dest, '0', 8);
	dest[8] = '\0';
}

void convertInteger(char* dest, int src, int size) {
	for(unsigned int bitmask = 1<<((size * 8) - 1); bitmask > 0; bitmask >>= 1) {
		*dest = ((src & bitmask) == bitmask) + '0';
		dest++;
	}
	*dest = '\0';
}
