/* Declarations */
%{
    #include "18227023.tab.h"
    #include <stdio.h>
	int yyerror(char*); /* function declaration */
%}

/* Rules */
%%
"BEGINNING"		{printf("token: BEGINNING"); return BEGINNING;}
"INPUT"         {printf("token: INPUT"); return INPUT;}
"PRINT"         {printf("token: OUTPUT"); return OUTPUT;}
"BODY"          {printf("token: BODY"); return BODY;}
"MOVE"          {printf("token: MOVE"); return MOVE;}
"ADD"           {printf("token: ADD"); return ADD;}
"END"			{printf("token: END"); return END;}
"TO"            {printf("token: TO"); return TO;}
"\""            {printf("token: QUOTE"); return QUOTE;}
\n				{printf("token: NEWLINE"); return NEWLINE;}
[\t ]+          {printf("token: WHITESPACE"); return WHITESPACE};
";"             {printf("token: SEMICOLON"); return SEMICOLON;}
"-"				{printf("token: HYPHEN"); return HYPHEN;}
[xX]+           {printf("token: SIZESTRING"); return SIZESTRING;}
[0-9]+			{printf("token: NUM"); yyval = atoi(yytext); return NUM; }
[a-zA-Z]+		{printf("token: IDENTIFIER"); return IDENTIFIER;}
.;
%%

/* Functions */
