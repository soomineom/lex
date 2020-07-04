%{
#include <stdio.h>
int preprocessor=0;
int octal_number=0;
int negative_decimal_number=0;
int positive_decimal_number=0;
int operator=0;
int comment=0;
int equal=0;
int open_brace=0;
int close_brace=0;
int word=0;
int wordcase1=0;
int wordcase2=0;
int mark=0;
%}

%%

"#".+[\n]  {preprocessor++;}
"-"[1-9][0-9]*   {negative_decimal_number++;}
("+")?[1-9][0-9]*      {positive_decimal_number++;}
0[1-7][0-9]*       {octal_number++;}
"+"|"-"|"*"|"/"|"%"     {operator++;}
"&&"|"||"|"!"   {operator++;}
">"|"<"|">="|"<="|"=="|"!="     {operator++;}
"++"|"--"|","|"&"|"*"   {operator++;}
"//"(.*[ \t]*.*)*[\n]+  {comment++;}
"/*"(.|\n)*"*/" {comment++;}
"="     {equal++;}
"{"     {open_brace++;}
"}"     {close_brace++;}
([a-oq-zA-OQ-Z_][0-9a-oq-zA-OQ-Z_]*)*(p|P)[0-9a-oA-OQ-Z_]*(p|P)[0-9a-oq-zA-OQ-Z_]*    {wordcase1++;}
e[A-Za-z_0-9]*m     {wordcase2++;}
[A-Za-z_][A-Za-z_0-9]*        {word++;}
.|\n       {mark++;}

%%

int main(){
        yylex();
        printf("preprocessor = %d\n",preprocessor);
        printf("octal number = %d\n",octal_number);
        printf("negative decimal number = %d\n",negative_decimal_number);
        printf("positive decimal number = %d\n",positive_decimal_number);
        printf("operator = %d\n",operator);
        printf("comment = %d\n",comment);
        printf("‘=’ = %d\n",equal);
        printf("‘{‘ = %d\n",open_brace);
        printf("‘}’ = %d\n",close_brace);
        printf("wordcase1 = %d\n",wordcase1);
        printf("wordcase2 = %d\n",wordcase2);
        printf("word = %d\n",word);
        printf("mark = %d\n",mark);
        return 0;
}

int yywrap(){
        return 1;
}
