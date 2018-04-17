%{
void yyerror (char *s);
#include <bits/stdc++.h>     
using namespace std;
map<string,vector<double> > symbols;


%}

%union {vector<double> num; string id;}        
%start Line
%token Print
%token Help
%token Plot
%token SIN
%token COS
%token TAN
%token ABS
%token POW
%token LOG
%token EXP
%token Exit
%token <id>VAR
%token <num>NUM
%token Circle
%token Parabola
%token Ellipse
%type <num>  Expr Term Field Var
%type <id>  Assignment Command

%%
Line :     Assignment ';'
	|  Line  Assignment ';'
	|  Print Expr ';' 
	|  Line Print Expr ';' 
	|  Plot Expr ',' Expr  ';' 
	|  Line Plot  Expr ',' Expr  ';' 
	|  Circle   Expr   ';' 
	|  Line Circle   Expr   ';' 
	|  Parabola  Expr  ';' 
	|  Line Parabola  Expr  ';' 
	|  Ellipse  Expr  ';' 
	|  Line Ellipse  Expr  ';' 
	|  Help ';' 
	|  Line Help ';'
	|  Help Command ';' 
	|  Line Help Command ';' 
        |  Exit ';' 
	| Line Exit ';'
	;

Assignment : Var '=' Expr 
        ;
Expr  : Expr '+' Term 
        | Expr '-' Term 
        | Term
        ;
Term : Term '*' Field 
        | Term '/' Field 
        | Field
        ;
Field : '(' Expr ')'
        | Var 
        | NUM 
        | COS  Expr  
        | SIN  Expr  
        | TAN  Expr  
        | ABS Expr  
        | POW  Expr ',' Expr  
        | LOG Expr
        ; 
 Var : VAR 
        | VAR '[' Expr ',' Expr ']' 
        | VAR '[' Expr ',' Expr ',' Expr ']'
        ;
Command : Plot 
        | Print 
        | Help 
        | Exit 
        | SIN 
        | COS 
        | TAN 
        | ABS 
        | EXP 
        | POW
        ;



%%                    


int main (void) {
	

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

