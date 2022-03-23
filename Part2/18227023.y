/* Declarations */
%{
    #include <stdio.h>
	#include <stdlib.h>

	int yyerror(const char* error)
%}

%token BEGINNING BODY END
%token INPUT OUTPUT MOVE ADD TO
%token SEMICOLON PERIOD
%token NEWLINE WHITESPACE 
%token SIZESTRING IDENTIFIER STRING
%token INVALID
%token<ival> NUMBER

%%
program: BEGINNING declarations BODY statements END	{printf("This is a correctly formed program!\n");}

declarations: declaration | declaration declarations

declaration: SIZESTRING WHITESPACE IDENTIFIER PERIOD NEWLINE

statements: statement | statement statements

statement: assignment | input | output

assignment: 

input: 

output:

%%
extern FILE *yyin;
extern int yylex();
extern int yyparse();

main(){	
	do yyparse();
		while(!feof(yyin));
}

int yyerror(char *error) {
	fprintf(stderr, "Parse error: %s\n", error);
	return 0;
}
