%{
	int evens = 0;
%}

%%

[0-9]*[02468]+[ \t\r\v\f\n]	{ evens++; }
\n	{}
.	{}

%%

int main()
{
	yylex();
	printf("%d\n", evens);
	return 0;
}