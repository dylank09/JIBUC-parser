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
program: BEGINNING declarations BODY statements END	{printf("This is a correctly formed program!\n");}

declarations: declaration {}
			| declaration declarations {}

declaration: SIZESTRING IDENTIFIER PERIOD {}

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

output: OUTPUT print_exp {}

print_exp: STRING SEMICOLON print_exp {}
		 | STRING PERIOD {}
		 | IDENTIFIER SEMICOLON print_exp {}
		 | IDENTIFIER PERIOD {}

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

void yyerror(const char *error) {
	fprintf(stderr, "Parse error: %s\n Error occured on line: %d\n", error, yylineno);
}
