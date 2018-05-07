all: lex.yy.c y.tab.c
	gcc -std=c89 lex.yy.c y.tab.c -o calc -lfl -lm

lex.yy.c: calc.l
	lex calc.l

y.tab.c: calc.y
	yacc -d calc.y

clean:
	rm -f lex.yy.c y.tab.c y.tab.h calc