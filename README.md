# JIBUC-Parser

### Description

Parser I created with flex and bison to parse the JIBUC programming language

### How to get executable

1. Run _flex flex.l_ to get the lex.yy.c file
2. Run _bison -d bison.y_ to get bison.tab.c and bison.tab.h
3. Run _gcc -c lex.yy.c bison.tab.c_
4. Run _gcc -o parser lex.yy.o bison.tab.o_
5. (a) Run _parser_ to input language instance on the command line to check if its a well formed language instance
   (b) Run _parser < test.txt_ where test.txt contains a language instance
