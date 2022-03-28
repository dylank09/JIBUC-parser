/* Declarations */
%{
    #include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	#include <string.h>
	#include <stdbool.h>

	extern int yylex();
	extern int yyparse();
	extern FILE *yyin;
	extern int yylineno;

	/* Functions */
	void yyerror(const char* error);
	void add_identifier(int sizestring, char *identifier);
	void find(char *identifier);
	bool does_exist(char *identifier);
	void format_identifier(char *identifier);

	/* Global variables */
	#define MAX_STORAGE 250
	char identifiers[MAX_STORAGE][30]; //max characters
	int sizes[MAX_STORAGE];

	int current_index = 0;
%}

%union {              /* define stack type */
  int ival;
  char *string;
}

%token BEGINNING BODY END
%token INPUT OUTPUT MOVE ADD TO
%token SEMICOLON PERIOD INVALID
%token<string> IDENTIFIER
%token<string> STRING
%token<ival> INTEGER
%token<ival> SIZESTRING

%%
program: BEGINNING PERIOD 
		 declarations 
		 BODY PERIOD statements 
		 END PERIOD {printf("This is a correctly formed program!\n");}

declarations: declaration {}
			| declaration declarations {}

declaration: SIZESTRING IDENTIFIER PERIOD {add_identifier($1, $2);}

statements: statement {}
		  | statement statements {}

statement: assignment {}
		 | input {}
		 | output{}

assignment: move_statement {}
		  | add_statement {}

move_statement: MOVE IDENTIFIER TO IDENTIFIER PERIOD {}
			  | MOVE INTEGER TO IDENTIFIER PERIOD {}

add_statement: ADD IDENTIFIER TO IDENTIFIER PERIOD {}
			 | ADD INTEGER TO IDENTIFIER PERIOD {}

input: INPUT input_exp {}

input_exp: IDENTIFIER PERIOD {}
		 | IDENTIFIER SEMICOLON input_exp {}

output: OUTPUT output_exp {}

output_exp: STRING SEMICOLON output_exp {}
		  | STRING PERIOD {}
		  | IDENTIFIER SEMICOLON output_exp {find($1);}
		  | IDENTIFIER PERIOD {find($1);}

%%

int main(int argc, char **argv){	
	if (argc > 1) {
		yyin = fopen(argv[1], "r");
	}
	else {
		yyin = stdin;
	}

	yyparse();
	return 0;
}

void find(char *identifier) {
	if(!does_exist(identifier)) {
		printf(identifier);
		yyerror("Identifier does not exist.");
		exit(0);
	}
}

bool does_exist(char *identifier) {
	format_identifier(identifier);

	int i;

	int len = sizeof(identifiers)/sizeof(identifiers[0]);

	for(i = 0; i < len; ++i) {
		if(strcmp(identifiers[i], identifier) == 0) {
			return true;
		}
	}
	return false;
}

void format_identifier(char *identifier) {
	int i;

	for(i = 0; i < strlen(identifier); i++) {
		char c = identifier[i];
		if(c == '.' || c == ';' || c ==' ') {
			identifier[i] = 0;
		}
	} 
}

void add_identifier(int sizestring, char *identifier) {
	format_identifier(identifier);

	if(does_exist(identifier)) {
		yyerror("Identifier was already declared.");
		exit(0);
	}

	strcpy(identifiers[current_index], identifier);
	current_index++;
	
	printf("Adding Identifier: %s  with size %d\n", identifier, sizestring);
}

void yyerror(const char *error) {
	fprintf(stderr, "Parse error: %s\nError occured on line: %d\n", error, yylineno);
}
