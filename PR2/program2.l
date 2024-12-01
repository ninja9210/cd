%{ 
#include<math.h>
    FILE *fp;
%}
Binary [0-1]+
Oct [0-7]+
Dec [0-9]+
Hex [0-9A-F]+
Float [-+]?[0-9]*\.[0-9]+
Exponent [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?

%%
{Binary} {printf("this is an binary number : %s", yytext);}
{Oct} {printf("this is an octal number : %s", yytext);}
{Dec} {printf("this is a Decimal number : %s", yytext);}
{Hex} {printf("this is an hexadecimal number : %s", yytext);}
{Float}  {printf("this is an Float number : %s", yytext);}
{Exponent} {printf("this is an Exponent number : %s", yytext);}
%%

int main(int argc,char *argv[])
{
   fp=fopen(argv[1],"r");

   if(fp!=NULL)
   {
      yyin=fp;
      yylex();
   }
   return(0);
}
