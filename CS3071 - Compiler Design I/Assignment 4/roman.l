%{
#include <string.h>
#include "roman.tab.h"
void yyerror();
%}

%%

I{4,}       { yyerror(); }
IVI{1,}     { yyerror(); }
IXI{1,}     { yyerror(); }
X{4,}       { yyerror(); }
XLX{1,}     { yyerror(); }
XCX{1,}     { yyerror(); }
C{4,}       { yyerror(); }
CDC{1,}     { yyerror(); }
CMC{1,}     { yyerror(); }
I           { return I; }
V           { return V; }
X           { return X; }
L           { return L; }
C           { return C; }
D           { return D; }
M+          { yylval = strlen(yytext); return M; }
\n          { return EOL; }
.           { yyerror(); }

%%
