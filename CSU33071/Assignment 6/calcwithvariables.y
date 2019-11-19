%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int NONE = 1000000000;

int yylex();
void yyerror();

int vals[26];
void set(int, int);
void out(int);
int get(int);

%}

%token VAL VAR
%token ADD SUB MUL DIV
%token PRINT ASSIGN END

%%

line:
 | line instruction END
 ;

instruction:
 | VAR ASSIGN expr			{ set($1, $3); }
 | PRINT expr				{ out($2); }
 ;

expr: factor				{ $$ = $1; }
 | expr ADD factor			{ $$ = $1 + $3; }
 | expr SUB factor			{ $$ = $1 - $3; }
 ;

factor: term				{ $$ = $1; }
 | factor MUL term 			{ $$ = $1 * $3; }
 | factor DIV term			{ $$ = $1 / $3; }
 ;

term: VAL					{ $$ = $1; }
 | SUB term					{ $$ = -$2; }
 | VAR						{ $$ = get($1); }
 ;

%%

int main() {
	
	int i = 0;
	while (i < 26) {
		vals[i] = NONE;
		i++;
	}
	
	yyparse();
	return 0;
	
}

void yyerror() {
	printf("syntax error\n");
	exit(0);
}

void out(int i) {
	printf("%d\n", i);
}

void set(int i, int val) {
	vals[i] = val;
}

int get(int i) {
	if (vals[i] == NONE) yyerror();
	else return vals[i];
}
