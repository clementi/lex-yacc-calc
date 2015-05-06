%{
#include <math.h>
#include <stdio.h>
#include "symtab.h"
%}

%union {
    double dval;
    struct symtab *symp;
}

%token <symp> NAME
%token <dval> NUMBER
%left '-' '+'
%left '*' '/'
%right '^'
%nonassoc UMINUS
%type <dval> expression
%%
statement_list: statement '\n'
    | statement_list statement '\n'
    ;

statement: NAME '=' expression { $1->value = $3; }
    | expression { printf("= %g\n", $1); }
    ;

expression: expression '+' expression { $$ = $1 + $3; }
    | expression '-' expression { $$ = $1 - $3; }
    | expression '*' expression { $$ = $1 * $3; }
    | expression '/' expression {
        if ($3 == 0.0)
            yyerror("divide by zero");
        else
            $$ = $1 / $3;
    }
    | '-' expression %prec UMINUS { $$ = -$2; }
    | expression '^' expression { $$ = pow($1, $3); }
    | '(' expression ')' { $$ = $2; }
    | NUMBER
    | NAME { $$ = $1->value; }
    ;
%%

