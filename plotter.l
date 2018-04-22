%{

#include "y.tab.h"
void yyerror (char *s);
int yylex();
%}
digit [0-9]
digits {digit}+
fract ([\.]{digit}+)?
exp ([eE][\+\-]?{digits})?
num [\+\-]?{digits}{fract}{exp}
letter [a-zA-Z_]
var {letter}({letter}|{digit})*
%%

("print") {return Print;}
("help")  {return Help;}
("plot")  {return Plot;}
("sin")   {return SIN;}
("cos")   {return COS;}
("tan")   {return TAN;}
("abs")   {return ABS;}
("pow")   {return POW;}
("log")   {return LOG;}
("exp")   {return EXP;}
("exit")  {return Exit;}
("circle") {return Circle;}
("parabola") {return Parabola;}
("ellipse")  {return Ellipse;}
{var}     {yylval.id=yytext;return VAR;}
{num}     {yylval.number = atof(yytext);return NUM;}
[ \t\n]  ;
[\+\-\*\/\(\)\[\]\,\;\=]   {return yytext[0];}

.        {ECHO;printf("No match found");}
%%
int yywrap(){return 1;}
