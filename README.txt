CS202-Programming Paradigms & Pragmatics
Lab 8: Compiler Design for CUCU
 
Name: Aditi Das 
Entry Number: 2020CSB1064
 
Aim: To learn to write a compiler for a simple language.

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

Assumptions:

1.) Multiple variable can be defined under a single datatype at a time.
2.) Texts can be enclosed within single or double quotes.
3.) Logical and Bitwise Operators are assumed to be not defined in the CUCU language.
4.) Multiple function arguments can be passed.
5.) If-elseif is not defined.
6.) Comments are considered and are ignored by lexer.
7.) Expressions can be boolean true /false.
8.) Declarations can be done before defining a function.
9.) Only relational operators are: == (equals) and != (not equals).
10.)The rules not included in the desciption of the language are assumed to not be defined in CUCU.
11.) Arrays can be defined only in the form of ID[NUM].
12.) Only +, -, *, / are the arithmetic operators defined. 

Output files:

1.) Lexer.txt :- Contains the token type along with it’s value, one per line. Also displays any lexical errors
encountered along with its line no..

2.) Parser.txt :- All the terminals/non-terminals/expressions and statements that the parser parses 
successfully from the source code is listed here in post-fix. The function body and end is properly denoted.
Same for if else block and while block. Also displays any syntactical errors encountered along with its line no..

________________________________________________________________________________________________________________