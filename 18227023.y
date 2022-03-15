/* Declarations */
%{
    #include <stdio.h>
	#include <stdlib.h>

	int yyerror(const char* error)
%}

%token BEGINNING BODY END
%token INPUT PRINT MOVE ADD TO
%token QUOTE SEMICOLON HYPHEN
%token NEWLINE WHITESPACE
%token SIZESTRING NUM IDENTIFIER
%token<ival> NUM
 
%%
program: BEGINNING declarations BODY statements END	{printf("This is a correctly formed program!\n");}

declaration:

statements:

newlines: 

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
