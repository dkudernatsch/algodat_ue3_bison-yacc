%{
extern int yylval;
extern int sym[];
#include "y.tab.h"
%}

%%

[a-z]   {
	   yylval = *yytext - 'a';
	   return VARIABLE;
        }

[0-9]+  {
           yylval = atoi(yytext);
           return INTEGER;
        }

0x([0-9|A-F|a-f]+) {
            yylval = (int) strtol(yytext, NULL, 16);
            return INTEGER;
        }

":="    return ASSIGN;
"+"     return PLUS;
"*"     return TIMES;
"/"     return DIVIDE;
"%"     return MODULO;
"-"     return MINUS;

"("     return OPEN_PAREN;
")"     return CLOSE_PAREN;

">"     return GREATER;
"<"     return LESSER;
">="    return GREATER_EQ;
"<="    return LESSER_EQ;
"=="    return EQ;
"!="    return NEQ;
","     return COMMA;
"min"   return MIN;
"max"   return MAX;

"\n"    return NEWLINE;
"?"     return QUESTIONMARK;
":"     return COLON;


[ \t]   ;

.       yyerror("Invalid character");

%%

int yywrap() {
 return 1;
}
