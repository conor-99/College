%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror();
char* convert(int n);

%}

%token I V X L C D M Z
%token ADD SUB MUL DIV OPEN CLOSE
%token EOL

%%


line:
 | line expr EOL	{ printf("%s\n", convert($2)); }
 ;

expr: factor		{ $$ = $1; }
 | expr ADD factor	{ $$ = $1 + $3; }
 | expr SUB factor	{ $$ = $1 - $3; }
 ;

factor: pexpr		{ $$ = $1; }
 | factor MUL pexpr	{ $$ = $1 * $3; }
 | factor DIV pexpr	{ $$ = $1 / $3; }
 ;

pexpr: num		{ $$ = $1; }
 | OPEN expr CLOSE	{ $$ = $2; }
 ;

num:
 | SUB num		{ $$ = -$2; }
 | Z			{ $$ = 0; }
 | thos huns tens ones	{ $$ = $1 + $2 + $3 + $4; }
 ;

thos:			{ $$ = 0; }
 | thos M		{ $$ = 1000 * $2; }
 ;

huns:			{ $$ = 0; }
 | C M			{ $$ = 900; }
 | D C C C		{ $$ = 800; }
 | D C C		{ $$ = 700; }
 | D C			{ $$ = 600; }
 | D			{ $$ = 500; }
 | C D			{ $$ = 400; }
 | C C C		{ $$ = 300; }
 | C C			{ $$ = 200; }
 | C			{ $$ = 100; }
 ;

tens:			{ $$ = 0; }
 | X C			{ $$ = 90; }
 | L X X X		{ $$ = 80; }
 | L X X		{ $$ = 70; }
 | L X			{ $$ = 60; }
 | L			{ $$ = 50; }
 | X L			{ $$ = 40; }
 | X X X		{ $$ = 30; }
 | X X			{ $$ = 20; }
 | X			{ $$ = 10; }
 ;

ones:			{ $$ = 0; }
 | I X			{ $$ = 9; }
 | V I I I		{ $$ = 8; }
 | V I I		{ $$ = 7; }
 | V I			{ $$ = 6; }
 | V			{ $$ = 5; }
 | I V			{ $$ = 4; }
 | I I I		{ $$ = 3; }
 | I I			{ $$ = 2; }
 | I			{ $$ = 1; }
 ;

%%

int main() {
	yyparse();
	return 0;
}

void yyerror() {
	printf("syntax error\n");
	exit(0);
}

char* convert(int n) {

	char* res = (char*) malloc(sizeof(char) * 50);

	if (n == 0) return "Z";

	if (n < 0) {
		strcat(res, "-");
		n *= -1;
	}

	int vals[] = { 0, 0, 0, 0 };
	int powTen  = 1000;

	int i;
	for (i = 0; i < 4; i++) {
		while (powTen <= n) {
			vals[i]++;
			n -= powTen;
		}
		powTen /= 10;
	}

	char* huns[] = { "", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM" };
	char* tens[] = { "", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC" };
	char* ones[] = { "", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" };

	for (i = 0; i < vals[0]; i++) strcat(res, "M");
	strcat(res, huns[vals[1]]);
	strcat(res, tens[vals[2]]);
	strcat(res, ones[vals[3]]);
	
	return res;
	
}
