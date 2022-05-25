%{
    #include <stdio.h>
    #include <string.h>
    #include "y.tab.h"
    extern YYSTYPE yylval;
    
%}

alpha [a-zA-Z]
digit [0-9]

%%
[ \t]                                   ;
[ \n]                                   { yylineno = yylineno + 1;}
([a-zA-Z][a-zA-Z_0-9]*)(\[[0-9]+\])+    { fprintf(yyout,"ARRAY: %s \n",yytext);      yylval.str = strdup(yytext);      return ARRAY;    }
true                                    { fprintf(yyout,"BOOLEAN: true\n");                                            return TRUE;     }
false                                   { fprintf(yyout,"BOOLEAN: false\n");                                           return FALSE;    }
"int"                                   { fprintf(yyout,"TYPE: int \n");                                               return INT;      }
"char *"                                { fprintf(yyout,"TYPE: char * \n");                                            return CHAR;     }
return                                  { fprintf(yyout,"KEYWORD: return \n");       yylval.str = strdup(yytext);      return RETURN;   }
while                                   { fprintf(yyout,"CONTROL STMT.: while \n");                                    return WHILE;    }
if                                      { fprintf(yyout,"CONTROL STMT.: if \n");                                       return IF;       }
else                                    { fprintf(yyout,"CONTROL STMT.: else \n");                                     return ELSE;     }
","                                     { fprintf(yyout,"COMMA: , \n");                                                return COMMA;    }
{digit}+                                { fprintf(yyout,"NUM: %d \n",atoi(yytext));  yylval.intValue = atoi(yytext);   return NUM;      }
[\",\']+(.*?)[\",\']+                   { fprintf(yyout,"TEXT: %s \n",yytext);       yylval.str = strdup(yytext);      return TEXT;     }
";"                                     { fprintf(yyout,"SEMICOLON: %s \n",yytext);                                    return SEMI;     }
{alpha}({alpha}|{digit})*               { fprintf(yyout,"ID: %s \n",yytext);         yylval.str = strdup(yytext);      return ID;       }
"("                                     { fprintf(yyout,"OPENING PARENTHESIS: %s \n",yytext);                          return OPENP;    }
")"                                     { fprintf(yyout,"ENDING PARENTHESIS: %s \n",yytext);                           return CLOSEP;   }
"{"                                     { fprintf(yyout,"OBRACE: %s \n",yytext);                                       return OPENB;    }
"}"                                     { fprintf(yyout,"EBRACE: %s \n",yytext);                                       return CLOSEB;   }
"+"                                     { fprintf(yyout,"SUM: +\n");                 yylval.str = strdup(yytext);      return SUM;      }
"-"                                     { fprintf(yyout,"SUBSTRACT: -\n");           yylval.str = strdup(yytext);      return SUBSTRACT;}
"/"                                     { fprintf(yyout,"DIVIDE: /\n");              yylval.str = strdup(yytext);      return DIVIDE;   } 
"*"                                     { fprintf(yyout,"MULTIPLY: *\n");            yylval.str = strdup(yytext);      return MULTIPLY; }
"="                                     { fprintf(yyout,"ASSIGN: =\n");                                                return ASG;      }
"=="                                    { fprintf(yyout,"EQUALS: == \n");                                              return EQ;       }
"!="                                    { fprintf(yyout,"NOT EQUALS: != \n");                                          return NE;       }
"."                                     return DOT;
\/\/.*                                  ; //single-line comments which are ignored by lexer
\/\*(.*\n)*.*\*\/                       ; //multi-line comments which are ignored by lexer
.                                       { fprintf(yyout,"\nLine %d : Lexical Error - unrecognised %s\n", yylineno, yytext);printf("\nCOMPILATION FAILED!\n");exit(0); }
%%
