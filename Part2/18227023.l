/* Declarations */
%{
    #include "18227023.tab.h"
    #include <stdio.h>
%}

/* Rules */
%%
"BEGINNING"		            {printf("token: BEGINNING\n"); return BEGINNING;}
"beginning"		            {printf("token: BEGINNING\n"); return BEGINNING;}
"INPUT"                     {printf("token: INPUT\n"); return INPUT;}
"input"                     {printf("token: INPUT\n"); return INPUT;}
"PRINT"                     {printf("token: OUTPUT\n"); return OUTPUT;}
"print"                     {printf("token: OUTPUT\n"); return OUTPUT;}
"BODY"                      {printf("token: BODY\n"); return BODY;}
"body"                      {printf("token: BODY\n"); return BODY;}
"MOVE"                      {printf("token: MOVE\n"); return MOVE;}
"move"                      {printf("token: MOVE\n"); return MOVE;}
"ADD"                       {printf("token: ADD\n"); return ADD;}
"add"                       {printf("token: ADD\n"); return ADD;}
"END"			            {printf("token: END\n"); return END;}
"end"			            {printf("token: END\n"); return END;}
"TO"                        {printf("token: TO\n"); return TO;}
"to"                        {printf("token: TO\n"); return TO;}
\.                          {printf("token: PERIOD\n"); return PERIOD;}
\n				            {printf("token: NEWLINE\n"); return NEWLINE;}
[\t ]+                      {printf("token: WHITESPACE\n"); return WHITESPACE;}
";"                         {printf("token: SEMICOLON\n"); return SEMICOLON;}
[xX]+                       {printf("token: SIZESTRING"); yyval = yyleng; return SIZESTRING;}
[0-9]+			            {printf("token: NUMBER\n"); yyval = yyleng; return NUMBER;}
\"([^\\\"]|\\.)*\"          {printf("token: STRING\n"); return STRING;}
[a-zA-Z][a-zA-Z0-9\-]*      {printf("token: IDENTIFIER\n"); return IDENTIFIER;}
.                           {printf("Not a valid token\n"); return INVALID;}
%%

/* Functions */
