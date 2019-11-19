%{
#include <string.h>
#include "calcwithvariables.tab.h"
void yyerror();
%}

%%

[0-9]+      { yylval = atoi(yytext); return VAL; }
[a-z]       { yylval = yytext[0] - 'a'; return VAR; }
"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV; }
"print"     { return PRINT; }
":="        { return ASSIGN; }
";"         { return END; }
[ \t\n]     { }
.           { yyerror(); }

%%
