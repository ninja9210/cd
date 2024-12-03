%{
#include"stdio.h"
#include"string.h"
#include"stdlib.h"
int yylex();
void yyerror();
void fcloseall();

FILE *fpOut;
%}

%union
{
  char vname[10];
  int val;
}

%left '+' '-'
%left '*' '/'

%token <vname> NAME
%type <vname> expression
%%

input : line '\n' input
| '\n' input
| ;

line : NAME '=' expression {
fprintf(fpOut,"MOV %s, AX\n",$1);
}

expression: NAME '+' NAME {
fprintf(fpOut,"MOV AX, %s\n",$1);
fprintf(fpOut,"ADD AX, %s\n",$3);
}
| NAME '-' NAME {
fprintf(fpOut,"MOV AX, %s\n",$1);
fprintf(fpOut,"SUB AX, %s\n",$3);
}
| NAME '*' NAME {
fprintf(fpOut,"MOV AX, %s\n",$1);
fprintf(fpOut,"MUL AX, %s\n",$3);
}
| NAME '/' NAME {
fprintf(fpOut,"MOV AX, %s\n",$1);
fprintf(fpOut,"DIV AX, %s\n",$3);
}
| NAME {
fprintf(fpOut,"MOV AX, %s\n",$1);
strcpy($$, $1);
}
;
%%
FILE *yyin;

int main()
{
FILE *fpInput;
fpInput = fopen("input.txt","r");
if(fpInput=='\0')
{
printf("file read error");
exit(0);
}
fpOut = fopen("output.txt","w");
//printf("%s",msg);
if(fpOut=='\0')
{
printf("file creation error");
exit(0);
}
yyin = fpInput;
yyparse();
void fcloseall();
return 0;
}
void yyerror()
{
}
