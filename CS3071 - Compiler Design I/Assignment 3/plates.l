%{
	
	#include <string.h>
	
	const int MFW_ITS_THE_CURRENT_YEAR = 2019;
	const int CEN_20 = 1900;
	const int CEN_21 = 2000;
	const int IN_20 = 87;
	
	int getYearDiff(char* yytext) {
	
		char yearText[2];
		strncpy(yearText, yytext, 2);
		
		int year = atoi(yearText);
		year += (year >= IN_20) ? CEN_20 : CEN_21;
		
		return MFW_ITS_THE_CURRENT_YEAR - year;
		
	}
	
%}

YEAR1		(8[7-9])|(9[0-9])|(0[0-9])|(1[0-2])
YEAR2		13[1-2]
YEAR3		1[4-9][1-2]
COUNTY1		C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LK|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW
COUNTY2		C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
NUMBER		[1-9][0-9]{0,5}[ \n\t\r]+

%%

{YEAR1}-{COUNTY1}-{NUMBER}		{ printf("%d\n", getYearDiff(yytext)); }
{YEAR2}-{COUNTY1}-{NUMBER}		{ printf("%d\n", getYearDiff(yytext)); }
{YEAR3}-{COUNTY2}-{NUMBER} 		{ printf("%d\n", getYearDiff(yytext)); }
[ \n\t\r]+						{ }
[^ \n\t\r]+						{ printf("INVALID\n"); }

%%

int main()
{
	yylex();
	return 0;
}
