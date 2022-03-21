/* Declarations */
%{
    #include <stdio.h>
%}

%option noyywrap

/* Rules */
%%
"BEGINNING"		                {printf("token: BEGINNING\n");}
"beginning"		                {printf("token: BEGINNING\n");}
"INPUT"                         {printf("token: INPUT\n");}
"input"                         {printf("token: INPUT\n");}
"PRINT"                         {printf("token: OUTPUT\n");}
"print"                         {printf("token: OUTPUT\n");}
"BODY"                          {printf("token: BODY\n");}
"body"                          {printf("token: BODY\n");}
"MOVE"                          {printf("token: MOVE\n");}
"move"                          {printf("token: MOVE\n");}
"ADD"                           {printf("token: ADD\n");}
"add"                           {printf("token: ADD\n");}
"END"			                {printf("token: END\n");}
"end"			                {printf("token: END\n");}
"TO"                            {printf("token: TO\n");}
"to"                            {printf("token: TO\n");}
\.                              {printf("token: PERIOD\n");}
\n				                {printf("token: NEWLINE\n");}
[\t ]+                          {printf("token: WHITESPACE\n");}
";"                             {printf("token: SEMICOLON\n");}
[xX]+                           {printf("token: SIZESTRING length is %d\n", yyleng);}
[0-9]+			                {printf("token: NUMBER length is %d\n", yyleng);}
\"([^\\\"]|\\.)*\"              {printf("token: STRING\n");}
[a-zA-Z][a-zA-Z0-9\-]*	        {printf("token: IDENTIFIER\n");}
.                               {printf("Not a valid token\n"); return 0;}
%%

/* Functions */

int main(){
    printf("Input here ");

    yylex();
    return 0;
}
