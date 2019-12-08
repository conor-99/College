%{
    typedef enum { false, true } bool;
    bool singleComment = false;
    bool multiComment = false;
%}

%%

\".*\"  { if (!singleComment && !multiComment) { printf("%s", yytext); } }
"{"     { if (!singleComment) { multiComment = true; } }
"}"     { if (multiComment) { multiComment = false; } else { printf("syntax error\n"); return 0; } }
"**"    { if (!multiComment) { singleComment = true; } }
\n      { if (singleComment) { singleComment = false; } if (!multiComment) { printf("\n"); } }
.       { if (!singleComment && 0 == multiComment) { printf("%s", yytext); } }

%%

int main()
{
    yylex();
    if (multiComment) printf("syntax error\n");
    return 0;
}
