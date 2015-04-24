#ifndef preprocessor_h
#define preprocessor_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void preprocess(FILE* source);
char* stripLine(char* line);
void rmComment(char* line);
char* rmLeadingSpace(char* line);

const static char* TEXT_FILE = "text.txt";
const static char* DATA_FILE = "data.txt";

#endif