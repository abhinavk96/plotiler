%{
void yyerror (char *s);
#include <bits/stdc++.h>     
using namespace std;
map<string,double *> symbols;


%}

%union {int num; string id;}        
%start Line
%token print
%token exit
%token print
%token help
%token plot
%token SIN
%token COS
%token TAN
%token ABS
%token POW
%token LOG
%token EXIT
%token <id>VAR
%token <num>NUM
%token CIRCLE
%token PARABOLA
%token ELLIPSE

%%
Line :  Var '=' Expr ';'
`	|  Line  Var = Expr ';'
	|  Print Expr ';' 
	|  Line Print Expr ';' 
	|  Plot Expr , Expr  ';' 
	|  Line Plot  Expr , Expr  ';' 
	|  Circle   Expr   ';' 
	|  Line Circle   Expr   ';' 
	|  Parabola  Expr  ';' 
	|  Line Parabola  Expr  ';' 
	|  Ellipse  Expr  ';' 
	|  Line Ellipse  Expr  ';' 
	|  Help ';' 
	|  Line Help ';'
	|  Help Command';' 
	|  Line Help Command';' 
        |  Exit ';' 
	| Line Exit ';'
	;



%%                    


int main (void) {
	

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

