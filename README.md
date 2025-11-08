## Practical No. 1 - Implement a lexical analyzer for a subset of C using LEX Implementation should 

### pract1.l
```lex
%{
    #include <math.h>
    FILE *fp;
%}

digit       [0-9]+
header      "#include<"[a-z]+".h>"
inbuilt     [\t]*"printf(".*")"|[\t]*"scanf(".*")"|[\t]*"clrscr()"|[\t]*"getch()"|[\t]*"exit(.+)"\n
comment     [\t ]*"/*".*"*/"[\t]*\n
main_function   "void main()"
function        [\t]*[a-zA-Z]+"(".*")"[\t]*\n
datatype        [\t ]*"int"|[\t ]*"char"|[\t ]*"float"
operator        "+"|"-"|"*"|"/"
terminator      ";"
bracket1        [\t]*"{"[\t]*
bracket2        [\t]*"}"[\t]*
loop            [\t ]*"if(".*")"|[\t ]*"else"|[\t ]*"for"|[\t ]*"while"|[\t ]*"do"
relational      [\t]*"<"|">"|"<="|">="|"=="|"="|"!="|"%"
logical         [\t]*"&&"|"||"
word            [a-z]+[a-z0-9]*

%%

{digit}         { printf("\n Numbers :: %s", yytext); }
{header}        { printf("\n Header File :: %s", yytext); }
{inbuilt}       { printf("\n Function :: %s", yytext); }
{comment}       { printf("\n Comment :: %s", yytext); }
{main_function} { printf("\n Main Function :: %s", yytext); }
{function}      { printf("\n User function :: %s", yytext); }
{datatype}      { printf("\n Datatype :: %s", yytext); }
{operator}      { printf("\n Operator :: %s", yytext); }
{terminator}    { printf("\n Terminator :: %s", yytext); }
{bracket1}      { printf("\n Opening curly bracket :: %s", yytext); }
{bracket2}      { printf("\n Closing curly bracket :: %s", yytext); }
{relational}    { printf("\n Relational operator :: %s", yytext); }
{loop}          { printf("\n Loop Statement :: %s", yytext); }
{logical}       { printf("\n Logical Operator :: %s", yytext); }
{word}          { printf("\n Variables :: %s", yytext); }

%%

int main(int argc, char *argv[])
{
    fp = fopen(argv[1], "r");
    if (fp != NULL)
    {
        yyin = fp;
        yylex();
    }
    return 0;
}
```

### How to run
```
lex pract1.l
yacc -d pract1.y
gcc lex.yy.c y.tab.c -o pract1
./pract1
```
---

## Practical No. 2 - To Implement a lexical analyzer for identification of numbers

### pract2.l
```lex
%{
    #include <math.h>
    FILE *fp;
%}

Binary      [0-1]+
Oct         [0-7]+
Dec         [0-9]+
Hex         [0-9A-F]+
Positive    [+]?[1-9][0-9]*
Negative    [-]?[1-9][0-9]*
PositiveF   [+]?[1-9][0-9]*\.[0-9]+
NegativeF   [-]?[1-9][0-9]*\.[0-9]+
Exponent    [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]*\.?[0-9]+)?

%%

{Binary}      { printf("This is a Binary number : %s\n", yytext); }
{Oct}         { printf("This is an Octal number : %s\n", yytext); }
{Dec}         { printf("This is a Decimal number : %s\n", yytext); }
{Hex}         { printf("This is a Hexadecimal number : %s\n", yytext); }
{Positive}    { printf("This is a Positive number : %s\n", yytext); }
{Negative}    { printf("This is a Negative number : %s\n", yytext); }
{PositiveF}   { printf("This is a Positive Float number : %s\n", yytext); }
{NegativeF}   { printf("This is a Negative Float number : %s\n", yytext); }
{Exponent}    { printf("This is an Exponent number : %s\n", yytext); }

%%

int main(int argc, char *argv[])
{
    fp = fopen(argv[1], "r");

    if (fp != NULL)
    {
        yyin = fp;
        yylex();
    }

    return 0;
}
```

### how to run
```
lex pract2.l 
cc lex.yy.c -ll 
./a.out input.txt
```
---
## Practical No. 3 - To Implement a Calculator using LEX and YACC
### ✅ LEX File (`calc.l`)

```lex


%{
    /* Definition section */
    #include <stdio.h>
    #include "y.tab.h"
    extern int yylval;
%}

/* Rule Section */
%%
[0-9]+ {
            yylval = atoi(yytext);
            return NUMBER;
        }

[\t]      ;

[\n]      return 0;

.         return yytext[0];

%%

int yywrap()
{
    return 1;
}
```

---

### ✅ YACC File (`calc.y`)

```yacc
%{
    /* Definition section */
    #include <stdio.h>
    int flag = 0;
%}

%{
    int yylex();
    void yyerror();
%}

%token NUMBER

%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

/* Rule Section */
%%
ArithmeticExpression: E {
                        printf("\nResult = %d\n", $$);
                        return 0;
                     };

E : E '+' E   { $$ = $1 + $3; }
  | E '-' E   { $$ = $1 - $3; }
  | E '*' E   { $$ = $1 * $3; }
  | E '/' E   { $$ = $1 / $3; }
  | E '%' E   { $$ = $1 % $3; }
  | '(' E ')' { $$ = $2; }
  | NUMBER    { $$ = $1; }
  ;

%%

// Driver Code
void main()
{
    printf("\nEnter Any Arithmetic Expression which can include ");
    printf("Addition, Subtraction, Multiplication, Division, Modulus and Brackets:\n");

    yyparse();

    if (flag == 0)
        printf("\nEntered arithmetic expression is Valid\n\n");
}

void yyerror()
{
    printf("\nEntered arithmetic expression is Invalid\n\n");
    flag = 1;
}
```

---

### ⚙️ Compilation Steps

Run these commands:

```sh
lex calc.l
yacc -d calc.y
gcc lex.yy.c y.tab.c -o calc
./calc
```

---
## Practical No. 4 - Implementation of Context Free Grammar

### ✅ LEX File (`cfg.l`)

```lex


%{
    #include "y.tab.h"
%}

%%

"0"     { return ZERO; }
"1"     { return ONE; }
[\n]    { return NL; }
.       ;

%%

int yywrap()
{
    return 1;
}
```

---

### ✅ YACC File (`cfg.y`)

```yacc
%{
    /* Definition section */
    #include <stdio.h>
    int flag = 0;
%}

%{
    int yylex();
    void yyerror();
%}

%token ONE ZERO NL

/* Rule Section */
%%
str1: str2 n1         { }
    ;

str2: ZERO str2 ONE   { }
    | ZERO ONE        { }
    ;

n1: NL                { return 0; }
    ;
%%

// Driver Code
void main()
{
    printf("\nEnter string (any combination of 0 and 1):\n");
    yyparse();

    if (flag == 0)
        printf("\nEntered string is Valid for L = [0^n 1^n]\n\n");
}

void yyerror()
{
    printf("\nEntered string is Invalid for L = [0^n 1^n]\n\n");
    flag = 1;
}
```

### ⚙️ Compilation Steps

Run these commands in terminal:

```sh
lex cfg.l
yacc -d cfg.y
gcc lex.yy.c y.tab.c -o cfg
./cfg
```

---

// Practical No. 5 - Implementation of Code Generator

### ✅ `codegen.l` (LEX File)

```lex


%{
    #include <stdio.h>
    #include "y.tab.h"
%}

%%

[a-z][a-zA-Z0-9]* | [0-9]+ {
        strcpy(yylval.vname, yytext);
        return NAME;
}

[ \t]      ;

.|\n        { return yytext[0]; }

%%

int yywrap()
{
    return 1;
}
```

---

### ✅ `codegen.y` (YACC File)

```yacc
%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>

    int yylex();
    void yyerror();
    void fcloseall();

    FILE *fpOut;
%}

%union { char vname[10]; int val; }

%left '+' '-'
%left '*' '/'

%token <vname> NAME
%type <vname> expression

%%

input:
        line '\n' input
    |   '\n' input
    |
    ;

line: NAME '=' expression {
        printf("MOV %s, AX\n", $1);
    }
    ;

expression:
        NAME '+' NAME {
            printf("MOV AX, %s\n", $1);
            printf("ADD AX, %s\n", $3);
        }
    |   NAME '-' NAME {
            printf("MOV AX, %s\n", $1);
            printf("SUB AX, %s\n", $3);
        }
    |   NAME '*' NAME {
            printf("MOV AX, %s\n", $1);
            printf("MUL AX, %s\n", $3);
        }
    |   NAME '/' NAME {
            printf("MOV AX, %s\n", $1);
            printf("DIV AX, %s\n", $3);
        }
    |   NAME {
            printf("MOV AX, %s\n", $1);
            strcpy($$, $1);
        }
    ;

%%

FILE *yyin;

int main()
{
    FILE *fpInput;

    fpInput = fopen("input.txt", "r");
    if (fpInput == NULL)
    {
        printf("File read error");
        exit(0);
    }

    yyin = fpInput;
    yyparse();

    fclose(fpInput);
    return 0;
}

void yyerror()
{
    // Error Handler
}
```

---

### ⚙️ How To Run

```sh
lex codegen.l
yacc -d codegen.y
gcc lex.yy.c y.tab.c -o codegen
./codegen
```

Place expressions in `input.txt`, e.g.:

```
a = x + y
b = a * z
```

### Output Example

```
MOV AX, x
ADD AX, y
MOV a, AX
```

---
## Practical No. 6 - Implementation of Deterministic Finite Automaton (DFA) DFA checks divisibility of a number by 3
### ✅ `dfa.l` (LEX File)

```lex


%{
    #include "y.tab.h"
%}

%%

[0369]      { return ZERO; }
[147]       { return ONE; }
[258]       { return TWO; }
[\n]        { return NL; }
.           ;

%%

int yywrap()
{
    return 1;
}
```

---

### ✅ `dfa.y` (YACC File)

```yacc
%{
    /* Definition Section */
    #include <stdio.h>
    int flag = 0;
%}

%{
    int yylex();
    void yyerror();
%}

%token ZERO ONE TWO NL
%start q0

%%

q0 :
        ZERO q0     { $$ = $2; }
    |   ONE  q1     { $$ = $2; }
    |   TWO  q2     { $$ = $2; }
    |   NL {
                printf("Number is divisible by 3\n");
                return 0;
            }
    ;

q1 :
        ZERO q1     { $$ = $2; }
    |   ONE  q2     { $$ = $2; }
    |   TWO  q0     { $$ = $2; }
    |   NL {
                printf("Number is not divisible by 3, remainder is 1\n");
                return 0;
            }
    ;

q2 :
        ZERO q2     { $$ = $2; }
    |   ONE  q0     { $$ = $2; }
    |   TWO  q1     { $$ = $2; }
    |   NL {
                printf("Number is not divisible by 3, remainder is 2\n");
                return 0;
            }
    ;

%%

void main()
{
    printf("\nEnter Decimal number to check divisibility by 3:\n");
    yyparse();
}

void yyerror()
{
    // Error handler
}
```

---

### ⚙️ How To Run

```sh
lex dfa.l
yacc -d dfa.y
gcc lex.yy.c y.tab.c -o dfa
./dfa
```

---
