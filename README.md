# JIBUC-Parser

### Description

Parser I created with flex and bison to parse the JIBUC programming language

### How to get executable

1. Run `flex flex.l` to get the lex.yy.c file
2. Run `bison -d bison.y` to get bison.tab.c and bison.tab.h
3. Run `gcc -c lex.yy.c bison.tab.c`
4. Run `gcc -o parser lex.yy.o bison.tab.o`
5. (a) Run `parser` to input language instance on the command line to check if its a well formed language instance
   (b) Run `parser < test.txt` where test.txt contains a language instance
