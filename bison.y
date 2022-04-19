/* Declarations */
%{
    #include <stdio.h>
	#include <stdlib.h>
	#include <ctype.h>
	#include <string.h>
	#include <stdbool.h>
	#include <math.h>

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
	void check_size(int size1, int size2);
	int get_size(char *identifier);
	int get_int_size(int value);
	void exit_with_error(char *error);

	/* Global variables */
	#define MAX_STORAGE 250
	char identifiers[MAX_STORAGE][30]; //max characters
	int sizes[MAX_STORAGE];
	int current_index = 0;
%}

%union {  /* define stack type */
  int ival;
  char *string;
}

/* Declare tokens */
%token BEGINNING BODY END
%token INPUT OUTPUT MOVE ADD TO
%token SEMICOLON PERIOD INVALID
%token<string> IDENTIFIER
%token<string> STRING
%token<ival> INTEGER
%token<ival> SIZESTRING

/* Defining rules */
%%
program: BEGINNING PERIOD 
		 declarations 
		 BODY PERIOD statements 
		 END PERIOD {printf("This is a well formed program!\n");}

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

move_statement: MOVE IDENTIFIER TO IDENTIFIER PERIOD {check_size(get_size($2), get_size($4));}
			  | MOVE INTEGER TO IDENTIFIER PERIOD {check_size(get_int_size($2), get_size($4));}

add_statement: ADD IDENTIFIER TO IDENTIFIER PERIOD {check_size(get_size($2), get_size($4));}
			 | ADD INTEGER TO IDENTIFIER PERIOD {check_size(get_int_size($2), get_size($4));}

input: INPUT input_exp {}

input_exp: IDENTIFIER PERIOD {find($1);}
		 | IDENTIFIER SEMICOLON input_exp {find($1);}

output: OUTPUT output_exp {}

output_exp: STRING SEMICOLON output_exp {}
		  | STRING PERIOD {}
		  | IDENTIFIER SEMICOLON output_exp {find($1);}
		  | IDENTIFIER PERIOD {find($1);}

%%

int main(int argc, char **argv){	
	if (argc > 1) { /* if more then one argument: open file for reading, otherwise use stdin */
		yyin = fopen(argv[1], "r");
	}
	else {
		yyin = stdin;
	}

	yyparse();
	return 0;
}

/* Function to compare sizes (of identifiers) */
void check_size(int size1, int size2) {

	if(size1 > size2) { /* if the size of var1 is bigger than var2 then exit parsing */
		exit_with_error("Value does not fit in identifier");
	}
	/* if the function runs without error we can continue */
}

/* Function to find the identifier in the array and return its size. If not found by end of array we quit */
int get_size(char *identifier) {
	format_identifier(identifier);

	int i;

	int len = sizeof(identifiers)/sizeof(identifiers[0]);

	for(i = 0; i < len; ++i) {
		if(strcmp(identifiers[i], identifier) == 0) {
			return sizes[i];
		}
	}
	exit_with_error("Identifier does not exist.");
}

/* Function that gets the number of digits in a number e.g. 1000: 4, 999: 3*/
int get_int_size(int value) {
	int nDigits = floor(log10(abs(value))) + 1;
	return nDigits;
}

/* Function that exits if identifier doesnt exist */
void find(char *identifier) {
	if(!does_exist(identifier)) {
		exit_with_error("Identifier does not exist.");
	}
}

/* Function that trys to find identifier, returns true if found*/
bool does_exist(char *identifier) {
	format_identifier(identifier);

	int i;

	int len = sizeof(identifiers)/sizeof(identifiers[0]);

	for(i = 0; i < len; ++i) {
		if(strcmp(identifiers[i], identifier) == 0) { /* standard library function to compare strings*/
			return true;
		}
	}
	return false;
}

/* Fixes up identifier by removing incorrect characters e.g. '.', ';' */
void format_identifier(char *identifier) {
	int i;

	for(i = 0; i < strlen(identifier); i++) {
		char c = identifier[i];
		if(c == '.' || c == ';' || c ==' ') {
			identifier[i] = 0;
		}
	} 
}

/* Checks if identifier exists already and adds it and its size to array */
void add_identifier(int sizestring, char *identifier) {
	format_identifier(identifier);

	if(does_exist(identifier)) {
		exit_with_error("Identifier was already declared.");
	}

	strcpy(identifiers[current_index], identifier);
	sizes[current_index] = sizestring;
	current_index++;
}

void yyerror(const char *error) {
	fprintf(stderr, "Parse error: %s\nError occured on line: %d\n", error, yylineno);
}

void exit_with_error(char *error) {
	yyerror(error);
	exit(0);
}
