1: lexer parser run execute1

2: lexer parser run execute2

lexer:
		lex cucu.l

parser:
		yacc -d cucu.y

run: 
		gcc y.tab.c -o cucu

execute1:
		./cucu Sample1.cu

execute2:
		./cucu Sample2.cu

clean:
		rm -rf *.tab.c *.tab.h *.out *.yy.c
