%{
	#include <stdio.h>
	#include <stdlib.h>
	#include"lex.yy.c"
	#include<ctype.h>

	int yyparse();
	void yyerror(const char* msg);
	int c=0,c1=0;
	char ch;
	FILE* fp;
%}

%{
	int yylex();
	int yywrap(void)
	{
		return 1;
	}
%}

%union 
{
    int intValue;
    char *str; 
};

%token <str> ID ARRAY TEXT RETURN
%token <intValue> NUM
%token COMMA ASG SEMI SUM SUBSTRACT MULTIPLY DIVIDE INT CHAR WHILE IF ELSE DOT OPENP CLOSEP OPENB CLOSEB TRUE FALSE

%right ASG
%left EQ NE
%%

start:  Function {if(c1==0)fprintf(fp,"Function end \n"); c1=0;}
    | Declaration {fprintf(fp,"\n");}
    | start Function {if (c1==0)fprintf(fp,"Function end \n"); c1=0;}
    ;

/* Declaration block */
Declaration: Type Assignment SEMI 
    | Type ArrayUsage SEMI 
    | Assignment SEMI 
    | FunctionCall SEMI {fprintf(fp,"Function call");}
    | return1 SEMI 
    ;

/* Assignment block */
Assignment: ID {fprintf(fp,"var-%s ", $1);} startID
    | ArrayUsage ASG {fprintf(fp," = ");} Assignment
    | NUM {fprintf(fp,"const-%d ", $1);} COMMA Assignment
    | NUM {fprintf(fp,"const-%d ", $1);} arithmetic Assignment {fprintf(fp," %c ",ch);}
    | TEXT {fprintf(fp,"TEXT-%s ", $1);}
    | ArrayUsage arithmetic Assignment {fprintf(fp," %c ",ch);}
    | OPENP Assignment CLOSEP
    | SUBSTRACT OPENP Assignment CLOSEP  {fprintf(fp," - ");}
    | SUBSTRACT NUM {fprintf(fp,"const-(-%d) ", $2);}
    | SUBSTRACT ID {fprintf(fp,"var-(-%s) ", $2);}
    | NUM  {fprintf(fp,"const-%d ", $1);}
    ;

startID: assg 
    | COMMA Assignment
    | arithmetic Assignment {fprintf(fp," %c ",ch);}
    |
;

assg: ASG Assignment {fprintf(fp," = ");}
    | ASG FunctionCall {fprintf(fp," = ");}
    | ASG ArrayUsage {fprintf(fp," = ");}

arithmetic: SUM {ch='+';}
    |SUBSTRACT {ch='-';}
    |MULTIPLY {ch='*';}
    |DIVIDE {ch='/';}

/* Function Call Block */
FunctionCall : ID OPENP CLOSEP {fprintf(fp,"funct-%s ", $1);}
    | ID OPENP Assignment CLOSEP {fprintf(fp,"funct-%s ", $1);}
    ;

/* Array Usage */
ArrayUsage : ARRAY  {fprintf(fp,"array-%s ",$1);}
    ;

/* Function block */
Function:  Type ID {fprintf(fp,"funct-%s \n", $2);} rest 
    ;

rest: OPENP ArgListOpt CLOSEP SEMI {c1=1;fprintf(fp,"Function declaration \n");}
    |OPENP ArgListOpt CLOSEP{fprintf(fp,"Function body \n");} CompoundStmt
    ;

ArgListOpt: ArgList {fprintf(fp,"\n");}
    |
    ;

ArgList:  ArgList COMMA Arg 
    | Arg 
    ; 

Arg:  Type ID {fprintf(fp,"var-%s FUNC-ARG ",$2);}
    ;

CompoundStmt:  OPENB StmtList CLOSEB 
    | Stmt
    ;

StmtList:   StmtList Stmt
    |
    ;

Stmt:   WhileStmt
    | Declaration {if (c==0)fprintf(fp,"\n");}
    | IfStmt
    | SEMI
    ;

WhileStmt: {c=1;} WhileStmt1;

IfStmt: {c=1;} IfStmt1;

/* Type Identifier block */
Type: INT {fprintf(fp,"INT ");}
    | CHAR {fprintf(fp,"CHAR* ");}
    ;

/* Loop Blocks */
WhileStmt1: WHILE {fprintf(fp,"conditional-while body\n");}  OPENP Expr CLOSEP CompoundStmt {c=0;fprintf(fp,"\nwhile end \n");}
    ;

/* IfStmt Block */
IfStmt1 : IF {fprintf(fp,"conditional-if ");}  OPENP Expr CLOSEP {fprintf(fp,"\nif body\n");} CompoundStmt else1 {c=0;fprintf(fp," \nif end \n");}
    ;

else1: ELSE {fprintf(fp,"\nconditional-else Body\n");}  else2 
	| 
	;

else2: Stmt 
	| CompoundStmt 

/*Expression Block*/
Expr:
    | Expr NE Expr {fprintf(fp," != ");}
    | Expr EQ Expr {fprintf(fp," == ");}
	| TRUE         {fprintf(fp,"TRUE ");}    
	| FALSE        {fprintf(fp,"FALSE ");} 
    | Assignment
    | ArrayUsage
    ;

return1: RETURN NUM {fprintf(fp,"RET %d",$2);}
    |
;

%%

int main(int argc, char *argv[])
{
	extern FILE *yyout,*yyin;
	
    yyin  = fopen(argv[1], "r");
    yyout = fopen("Lexer.txt","w");
	fp    = fopen("Parser.txt","w");

    if(!yyparse())
        printf("\nSUCCESSFULLY COMPILED!\n");
    else
        printf("\nCOMPILATION FAILED!\n");

    fclose(yyin);
	fclose(yyout);
	fclose(fp);
    return 0;
}

void yyerror(const char* msg)
{
    fprintf(fp,"\nLine %d : Syntactical Error - unrecognised %s\n", yylineno, yytext);
}