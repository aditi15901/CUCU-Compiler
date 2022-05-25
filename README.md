# Compiler Design for CUCU
 
Aim: To learn to write a compiler for a simple language.

Desciption:

    CUCU is a toy language, and it is similar to C (a subset of C  language). This compiler basically compiles the .cu files and 
    displays the lexical and parsing errors (if there), or successfully compiles the program. 


Running the files:

    1.) To compile Sample1.cu (which contains correct CUCU code), type the following line in terminal:-
    
    make 1

    2.) To compile Sample2.cu  (which contains incorrect CUCU code), type the following line in terminal:-
    
    make 2
 
Files:
 
    1.) cucu.l: :-
 
     Description: Prints the token type along with it’s value in the output file (Lexer.txt), one per line.
     Returns the token type and it’s value to Yacc file cucu.y. Any lexical errors is displayed in the 
     Lexer.txt file along with the line no. at which the lexical error occurred. 
 
    2.) cucu.y :-

       Description: Lists all the terminals/non-terminals/expressions and statements that it parses successfully
       from the source code in output file Parser.txt. Any syntactical errors is displayed in the Parser.txt file.


    * makefile:-
        It contains commands to compile and run the lex and yacc files.


Output files:

    1.) Lexer.txt :- Contains the token type along with it’s value, one per line. Also displays any lexical errors
    encountered along with its line no..

    2.) Parser.txt :- All the terminals/non-terminals/expressions and statements that the parser parses 
    successfully from the source code is listed here in post-fix. The function body and end is properly denoted.
    Same for if else block and while block. Also displays any syntactical errors encountered along with its line no.

________________________________________________________________________________________________________________
