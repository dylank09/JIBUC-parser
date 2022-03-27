/* Declarations */
%{
    #include <stdio.h>
%}

%option noyywrap
%option caseless

/* Rules */
%%
"BEGINNING"		            {printf("token: BEGINNING\n"); /* return BEGINNING; */}
"INPUT"                     {printf("token: INPUT\n"); /* return INPUT; */}
"PRINT"                     {printf("token: OUTPUT\n"); /* return OUTPUT; */}
"BODY"                      {printf("token: BODY\n"); /* return BODY; */}
"MOVE"                      {printf("token: MOVE\n"); /* return MOVE; */}
"ADD"                       {printf("token: ADD\n"); /* return ADD; */}
"END"			            {printf("token: END\n"); /* return END; */}
"TO"                        {printf("token: TO\n"); /* return TO; */}
\n				            {/* ignore newlines */}
[\t ]+                      {/* ignore whitespace */}
[X]+                        {printf("token: SIZESTRING length is %d\n", yyleng); /* return SIZESTRING; */}
[-+]?[0-9]+			        {printf("token: INTEGER value is %d\n", atoi(yytext)); /* return INTEGER; */}
\"([^\\\"]|\\.)*\"          {printf("token: STRING\n"); /* return STRING; */}
[a-zA-Z][a-zA-Z0-9\-]*	    {printf("token: IDENTIFIER\n"); /* return IDENTIFIER; */}
";"                         {printf("token: SEMICOLON\n"); /* return SEMICOLON; */}
\.                          {printf("token: PERIOD\n"); /* return PERIOD; */}
.                           {printf("Invalid token\n"); return 0;}
%%

/* Functions */

int main(){
    printf("Input here ");

    yylex();
    return 0;
}
