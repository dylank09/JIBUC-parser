/* Declarations */
%{
    #include "18227023.tab.h"
    #include <stdio.h>
%}

%option caseless

/* Rules */
%%
"BEGINNING"		            {return BEGINNING;}
"INPUT"                     {return INPUT;}
"PRINT"                     {return OUTPUT;}
"BODY"                      {return BODY;}
"MOVE"                      {return MOVE;}
"ADD"                       {return ADD;}
"END"			            {return END;}
"TO"                        {return TO;}
\.                          {return PERIOD;}
\n				            {return NEWLINE;}
[\t ]+                      {return WHITESPACE;}
";"                         {return SEMICOLON;}
[X]+                        {yyval = yyleng; return SIZESTRING;}
[-+]?[0-9]+			        {yyval = atoi(yytext); return INTEGER;}
\"([^\\\"]|\\.)*\"          {return STRING;}
[a-zA-Z][a-zA-Z0-9\-]*	    {return IDENTIFIER;}
.                           {return INVALID;}
%%

/* Functions */
