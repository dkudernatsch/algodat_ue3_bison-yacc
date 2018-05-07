%{
#include <stdio.h>
int sym[26];
%}

%token VARIABLE ASSIGN INTEGER NEWLINE

%left COMMA

%right QUESTIONMARK
%right COLON

%left EQ
%left NEQ

%left GREATER
%left LESSER
%left GREATER_EQ
%left LESSER_EQ

%left PLUS
%left MINUS

%left TIMES
%left DIVIDE
%left MODULO


%left OPEN_PAREN
%left CLOSE_PAREN

%left MIN
%left MAX

%%

program: program statement
       |
       ;

statement: expr NEWLINE
	     { printf("%d\n", $1); }
         | VARIABLE ASSIGN expr NEWLINE
             { sym[$1] = $3; }
         ;

expr: INTEGER                { $$ = $1;        }
      | VARIABLE             { $$ = sym[$1];   }
      | MINUS           expr { $$ = -1 * $2;   }
      | PLUS            expr { $$ =  1 * $2;   }
      | expr PLUS       expr { $$ = $1 + $3;   }
      | expr TIMES      expr { $$ = $1 * $3;   }
      | expr MINUS      expr { $$ = $1 - $3;   }
      | expr DIVIDE     expr { $$ = $1 / $3;   }
      | expr MODULO     expr { $$ = $1 % $3;   }
      | expr GREATER    expr { $$ = $1 > $3;   }
      | expr LESSER     expr { $$ = $1 < $3;   }
      | expr GREATER_EQ expr { $$ = $1 >= $3;  }
      | expr LESSER_EQ  expr { $$ = $1 <= $3;  }
      | expr EQ         expr { $$ = $1 == $3;  }
      | expr NEQ        expr { $$ = $1 != $3;  }
      | OPEN_PAREN expr CLOSE_PAREN { $$ = $2; }
      | MIN OPEN_PAREN min_list CLOSE_PAREN { $$ = $3; }
      | MAX OPEN_PAREN max_list CLOSE_PAREN { $$ = $3; }
      | expr QUESTIONMARK expr COLON expr { $$ = $1 ? $3 : $5; }
      ;

min_list
    : expr { $$ = $1; }
    | expr COMMA min_list { $$ = $1 < $3 ? $1 : $3; }
    ;

max_list
    : expr { $$ = $1; }
    | expr COMMA max_list { $$ = $1 > $3 ? $1 : $3; }
    ;

%%

int yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
  return 0;
}

int main() {
  yyparse();
  return 0;
}
