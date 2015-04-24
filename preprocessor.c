#include "Preprocessor.h"

void preprocess(FILE* source) {

	FILE* data = fopen(DATA_FILE, "w+");
	FILE* text = fopen(TEXT_FILE, "w+");
	FILE* output = NULL;

	if(source && data && text) {
		char line[257] = {'\0'}; 
		while( fgets(line,sizeof line,source) != NULL) {
			char* strippedLine = stripLine(line);
			if (strncmp(".data", strippedLine, 5) == 0) output = data;
			else if (strncmp(".text", strippedLine, 5) == 0) output = text;
			else if (output) fprintf(output, "%s", stripLine(line));
			memset(line, '\0', sizeof(line));
		}
	}

	fclose(data);
	fclose(text);
}

char* stripLine(char* line) {
	rmComment(line);
	return rmLeadingSpace(line);
}

void rmComment(char* line ) {
	char* ret = strchr(line,'#');
	if(ret != NULL) {
		*ret = '\n';
		*(ret+1) = '\0'; 
	}
}

char* rmLeadingSpace(char* line) {
	while(isspace(*line) || *line == '\n') {
		line++;
	}
	return line;
}
