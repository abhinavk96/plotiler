%{
void yyerror (char *s);
struct vecto {
        int len;
        double arr[1000];
        
};
int yylex();
void plot_func(struct vecto x,struct vecto y);
void dec(char *id,struct vecto v1,struct vecto v2);
void dec_step(char *id,struct vecto v1,struct vecto v2,struct vecto v3);
void plot_parabola(struct vecto x);
void plot_circle(struct vecto x);
void plot_ellipse(struct vecto x,struct vecto y);
#include <bits/stdc++.h>     
#include <unistd.h>
#include <string>
using namespace std;

map<string,struct vecto > symbols;
map<char *,char *> help;
map<string,struct vecto > ::iterator it;
map<char *,char * > ::iterator it1;
%}

%union {struct vecto num;char *id;double number;}       
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
%token <number>NUM
%token Circle
%token Parabola
%token Ellipse
%type <num>  Expr Term Field 
%type <id>  Assignment Command 

%%
Line :     Assignment ';'
	|  Line  Assignment ';'
	|  Declaration ';'
	|  Line Declaration ';'
	|  Print Expr ';' {/*cout<<$2.len<<endl;*/cout<<"[ ";for(int i=0;i<$2.len;i++){cout<<$2.arr[i]<<" ";}cout<<"]\n";}
	|  Line Print Expr ';' {/*cout<<$3.len<<endl;*/cout<<"[ ";for(int i=0;i<$3.len;i++){cout<<$3.arr[i]<<" ";}cout<<"]\n";}
	|  Plot Expr ',' Expr  ';' {plot_func($2,$4);}
	|  Line Plot  Expr ',' Expr  ';' {plot_func($3,$5);}
	|  Circle   Expr   ';' {plot_circle($2);}
	|  Line Circle   Expr   ';' {plot_circle($3);}
	|  Parabola  Expr  ';' {plot_parabola($2);}
	|  Line Parabola  Expr  ';' {plot_parabola($3);}
	|  Ellipse  Expr ',' Expr ';' {plot_ellipse($2,$4);}
	|  Line Ellipse  Expr ',' Expr  ';' {plot_ellipse($3,$5);}
	|  Help ';' {for(it1=help.begin();it1!=help.end();it1++){cout<<it1->second<<endl;}}
	|  Line Help ';' {for(it1=help.begin();it1!=help.end();it1++){cout<<it1->second<<endl;}}
	|  Help Command ';' {cout<<$2<<endl;}
	|  Line Help Command ';' {cout<<$3<<endl;}
        |  Exit ';' {cout<<"Exiting PIC\n";exit(0);}
	| Line Exit ';' {cout<<"Exiting PIC\n";exit(0);}
	;

Assignment : VAR '=' Expr {string s="";
        int i;
        for(i=0;$1[i]!='\0';i++){
                if($1[i]==' '||$1[i]=='='){
                        
                        break;
                }
                s+=$1[i];
        }
        
        //cout<<s<<"lhhhh"<<endl;
        
        symbols[s]=$3;}
        ;
Expr  : Expr '+' Term {
                if(!($1.len==1||$3.len==1)&&($1.len!=$3.len)){
                        cout<<"dimension error\n";
                }else if($1.len==$3.len){
                        struct vecto v;
                        v.len=$1.len;
                        for(int i=0;i<$1.len;i++){
                                v.arr[i]=$1.arr[i]+$3.arr[i];
                        }
                        $$=v;
                }else{
                        struct vecto v,v1;
                        double x;
                        if($1.len==1){
                                x=$1.arr[0];
                                v=$3;
                        }
                        else{
                                x=$3.arr[0];
                                v=$1;
                                
                        }
                        v1.len=v.len;
                        for(int i=0;i<v.len;i++){
                                v1.arr[i]=v.arr[i]+x;
                        }
                        $$=v1;
                }
        }
        | Expr '-' Term {
                if(!($1.len==1||$3.len==1)&&($1.len!=$3.len)){
                        cout<<"dimension error\n";
                }else if($1.len==$3.len){
                        struct vecto v;
                        v.len=$1.len;
                        for(int i=0;i<$1.len;i++){
                                v.arr[i]=$1.arr[i]-$3.arr[i];
                        }
                        $$=v;
                }else{
                        struct vecto v,v1;
                        double x;
                        if($1.len==1){
                                x=$1.arr[0];
                                v=$3;
                        }
                        else{
                                x=$3.arr[0];
                                v=$1;
                                
                        }
                        v1.len=v.len;
                        for(int i=0;i<v.len;i++){
                                v1.arr[i]=v.arr[i]-x;
                        }
                        $$=v1;
                }
        }
        | Term {$$=$1;}
        ;
Term : Term '*' Field {
                if(!($1.len==1||$3.len==1)){
                        cout<<"dimension error\n";
                }else{
                        struct vecto v,v1;
                        double x;
                        if($1.len==1){
                                x=$1.arr[0];
                                v=$3;
                        }
                        else{
                                x=$3.arr[0];
                                v=$1;
                                
                        }
                        v1.len=v.len;
                        for(int i=0;i<v.len;i++){
                                v1.arr[i]=v.arr[i]*x;
                        }
                        $$=v1;
                }
        }
        | Term '/' Field {
                if(!($1.len==1||$3.len==1)){
                        cout<<"dimension error\n";
                }else{
                        struct vecto v,v1;
                        double x;
                        if($1.len==1){
                                x=$1.arr[0];
                                v=$3;
                        }
                        else{
                                x=$3.arr[0];
                                v=$1;
                                
                        }
                        if(x==0){
                                cout<<"Divide by zero error\n";
                        }
                        else{
                                v1.len=v.len;
                                for(int i=0;i<v.len;i++){
                                        v1.arr[i]=v.arr[i]/x;
                                }
                                $$=v1;
                        }
                }
        }
        | Field {$$=$1;}
        ;
Field : '(' Expr ')'{$$=$2;}
        | VAR {if(symbols.find($1)==symbols.end()){cout<<$1<<" not found\n";}else{$$=symbols[$1];}}
        | NUM {struct vecto v;v.len=1;v.arr[0]=$1;$$=v;}
        | COS  Expr {struct vecto v;v.len=$2.len;for(int i=0;i<$2.len;i++){v.arr[i]=cos($2.arr[i]);}$$=v;} 
        | SIN  Expr {struct vecto v;v.len=$2.len;for(int i=0;i<$2.len;i++){v.arr[i]=sin($2.arr[i]);}$$=v;} 
        | TAN  Expr {struct vecto v;v.len=$2.len;for(int i=0;i<$2.len;i++){v.arr[i]=tan($2.arr[i]);}$$=v;} 
        | ABS Expr  {struct vecto v;v.len=$2.len;for(int i=0;i<$2.len;i++){v.arr[i]=abs($2.arr[i]);}$$=v;} 
        | POW  Expr ',' Expr  {
                if($4.len!=1){
                        cout<<"Power must be scalar\n";
                }else{
                
                        struct vecto v;
                        v.len=$2.len;
                        for(int i=0;i<$2.len;i++){
                                v.arr[i]=pow($2.arr[i],$4.arr[0]);
                        }
                        $$=v;
               }
          }
        | LOG Expr  {struct vecto v;v.len=$2.len;for(int i=0;i<$2.len;i++){v.arr[i]=log($2.arr[i]);}$$=v;} 
        | EXP Expr  {struct vecto v;v.len=$2.len;for(int i=0;i<$2.len;i++){v.arr[i]=exp($2.arr[i]);}$$=v;} 
        ; 
 Declaration : VAR '=' '[' Expr ',' Expr ']' {dec($1,$4,$6);}
        | VAR '=' '[' Expr ',' Expr ',' Expr ']' {dec_step($1,$4,$6,$8);}
        ;
Command : Plot {$$=help["Plot"];}
        | Print {$$=help["Print"];}
        | Help {$$=help["Help"];}
        | Exit {$$=help["Exit"];}
        | SIN {$$=help["SIN"];}
        | COS {$$=help["COS"];}
        | TAN {$$=help["TAN"];}
        | ABS {$$=help["ABS"];}
        | EXP {$$=help["EXP"];}
        | LOG {$$=help["LOG"];}
        | POW {$$=help["POW"];}
        ;



%%                    
void dec(char *id,struct vecto v1,struct vecto v2) {
        if(v1.len!=1||v2.len!=1){
                cout<<"VAR[X,Y]; X and Y must be scalar\n";
                exit(0);
        }
        vecto v;
        
        v.len=(v2.arr[0]-v1.arr[0]);
        //cout<<v.len<<endl;
        for(int i=0;i<v.len;i++){
                v.arr[i]=i+v1.arr[0];
        }
        
        string s="";
        int i;
        for(i=0;id[i]!='\0';i++){
                if(id[i]==' '||id[i]=='='){
                        
                        break;
                }
                s+=id[i];
        }
        
        //cout<<s<<"lhhhh"<<endl;
        
        symbols[s]=v;
        
        
        
}
void dec_step(char *id,struct vecto v1,struct vecto v2,struct vecto v3) {
        if(v1.len!=1||v2.len!=1||v3.len!=1){
                cout<<"VAR[X,Y,Z]; X and Y and Z must be scalar\n";
                exit(0);
        }
        vecto v;
        v.len=(v2.arr[0]-v1.arr[0])/v3.arr[0];
        double val=v1.arr[0];;
        for(int i=0;i<v.len;i++){
                v.arr[i]=val;
                val=val+v3.arr[0];
        }
        string s="";
        for(int i=0;id[i]!='\0';i++){
                if(id[i]==' '||id[i]=='='){
                        
                        break;
                }
                s+=id[i];
        }
        //cout<<s<<endl;
        symbols[s]=v;
        
}
void plot_func(struct vecto x,struct vecto y){
        string xx="",yy="";
        int i;
        for(i=0;i<x.len;i++){
                xx+=to_string(x.arr[i]);
                if(i!=x.len-1){
                        xx+=",";
                }
        }
        
        for(i=0;i<y.len;i++){
                yy+=to_string(y.arr[i]);
                if(i!=y.len-1){
                        yy+=",";
                }
        }
        int t=fork();
        if(t==0){
                
                string comm="python3 plot.py general "+xx+" "+yy;
                //cout<<comm<<endl;
                system(comm.c_str());
        }
}
void plot_circle(struct vecto x){
        string xx="";
        if(x.len!=1){
                cout<<"circle radius must be a scalar\n";
        }
        else{
                        xx+=to_string(x.arr[0]);
                        int t=fork();
                if(t==0){
                        
                        string comm="python3 plot.py circle "+xx;
                        //cout<<comm<<endl;
                        system(comm.c_str());
                }
        }
        

}
void plot_ellipse(struct vecto x,struct vecto y){
        string xx="",yy="";
        if(x.len!=1||y.len!=1){
                cout<<"ellipse parameters must be scalars\n";
        }
        else{
                        xx+=to_string(x.arr[0]);
                        yy+=to_string(y.arr[0]);
                        int t=fork();
                if(t==0){
                        
                        string comm="python3 plot.py ellipse "+xx+" "+yy;
                        //cout<<comm<<endl;
                        system(comm.c_str());
                }
        }
        

}
void plot_parabola(struct vecto x){
        string xx="";
        if(x.len!=1){
                cout<<"parabola 'a' must be a scalar\n";
        }
        else{
                        xx+=to_string(x.arr[0]);
                        int t=fork();
                if(t==0){
                        
                        string comm="python3 plot.py parabola "+xx;
                        //cout<<comm<<endl;
                        system(comm.c_str());
                }
        }
        

}
int main (void) {
        cout<<"Welcome to PIC - Plotting made easy!!!\n";
	help["Plot"]="plot X,Y; plots a graph between X and Y.";
	help["Print"]="print Expr; Prints value of expression";
	help["Help"]="help command; tells about the command";
	help["Exit"]="exit; it is the exit command";
	help["SIN"]="sin expr; returns the sin value of the expression";
	help["COS"]="cos expr; returns the cos value of the expression";
	help["TAN"]="tan expr; returns the tan value of the expression";
	help["ABS"]="abs expr; returns the absolute value of the expression";
	help["EXP"]="exp expr; returns the e power value of the expression";
	help["LOG"]="log expr; returns the log value of the expression";
	help["POW"]="pow expr1,expr2; returns the  value of expr1 ^ expr2";

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

