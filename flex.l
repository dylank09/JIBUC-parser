/* Declarations */
%{
    #include "bison.tab.h"
    #include <stdio.h>
    #include <ctype.h>
	#include <string.h>
%}

%option noyywrap
%option caseless
%option yylineno

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
\n  			            {/* ignore newlines */}
[\t ]+                      {/* ignore whitespace */}
[X]+                        {yylval.ival = yyleng; return SIZESTRING;}
[-+]?[0-9]+			        {yylval.ival = atoi(yytext); return INTEGER;}
\"([^\\\"]|\\.)*\"          {return STRING;}
[a-zA-Z][a-zA-Z0-9\-]*	    {yylval.string = yytext; return IDENTIFIER;}
";"                         {return SEMICOLON;}
\.                          {return PERIOD;}
.                           {return INVALID;}
%%
