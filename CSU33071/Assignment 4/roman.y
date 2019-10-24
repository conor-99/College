%{
#include <stdio.h>
int yylex();
void yyerror();
%}

%token I V X L C D M
%token EOL

%%


line:
 | line numeral EOL { printf("%d\n", $2);}
 ;

numeral:
 | thos huns tens ones { $$ = $1 + $2 + $3 + $4; }
 ;

thos: { $$ = 0; }
 | thos M { $$ = 1000 * $2; }
 ;

huns: { $$ = 0; }
 | C M { $$ = 900; }
 | D C C C { $$ = 800; }
 | D C C { $$ = 700; }
 | D C { $$ = 600; }
 | D { $$ = 500; }
 | C D { $$ = 400; }
 | C C C { $$ = 300; }
 | C C { $$ = 200; }
 | C { $$ = 100; }
 ;

tens: { $$ = 0; }
 | X C { $$ = 90; }
 | L X X X { $$ = 80; }
 | L X X { $$ = 70; }
 | L X { $$ = 60; }
 | L { $$ = 50; }
 | X L { $$ = 40; }
 | X X X { $$ = 30; }
 | X X { $$ = 20; }
 | X { $$ = 10; }
 ;

ones: {$$ = 0; }
 | I X { $$ = 9; }
 | V I I I { $$ = 8; }
 | V I I { $$ = 7; }
 | V I { $$ = 6; }
 | V { $$ = 5; }
 | I V { $$ = 4; }
 | I I I { $$ = 3; }
 | I I { $$ = 2; }
 | I { $$ = 1; }
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
