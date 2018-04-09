%{
#include"plotter.h"
#include"y.tab.h"

%}
digit [0-9]
digits {digit}+
fract ([\.]{digit}+)?
exp ([eE][\+\-]?{digits})?
num {digits}{fract}{exp}
%%

("print") {return print;}
("help")  {return help;}
("plot")  {return plot;}
("sin")   {return SIN;}
("cos")   {return COS;}
("tan")   {return TAN;}
("abs")   {return ABS;}
("pow")   {return POW;}
("log")   {return LOG;}
("exit")  {return EXIT;}
[a-zA-Z] {return VAR;}
{num}    {return NUM;}
[ \t\n]  ;
[+-*/()\[\],;]   {return yytext[0];}

.        {ECHO;yyerror("No match found");}
%%
int yywrap(){return 1;}
