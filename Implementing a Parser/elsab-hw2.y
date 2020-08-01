%{
#include <stdio.h>
void yyerror (const char *s) /* Called by yyparse on error */
  {
  //printf ("%s\n", s);
  }
%}

%token tINTTYPE tINTVECTORTYPE tINTMATRIXTYPE tREALTYPE tREALVECTORTYPE tREALMATRIXTYPE tIF tENDIF tTRANSPOSE tEQ tLT tGT tAND tDOTPROD tNE tLTE tGTE tOR tIDENT tINTNUM tREALNUM

%left '+' '-'
%left '/' '*'
%left tDOTPROD

%left tTRANSPOSE
%left tOR
%left tAND

%left tNE tEQ
%left tLT tGT tGTE tLTE

%left '[' ']' '(' ')'

%% 
/* Grammar rules and actions follow */

prog: stmtlst
;

stmtlst: stmt
| stmtlst stmt
;

stmt: decl
| asgn
| if
;

decl: type vars '=' expr ';'
;

type: tINTTYPE | tINTVECTORTYPE | tINTMATRIXTYPE | tREALTYPE | tREALVECTORTYPE | tREALMATRIXTYPE
;

vars: tIDENT
| tIDENT ',' vars
;

asgn: tIDENT '=' expr ';'
;

if: tIF '(' bool ')' stmtlst tENDIF
;

expr: tIDENT | tREALNUM | tINTNUM | vectorLit | matrixLit 
| expr '+' expr
| expr '-' expr
| expr '*' expr
| expr '/' expr
| expr tDOTPROD expr 
| transpose
;

transpose: tTRANSPOSE '(' expr ')' 
;

vectorLit: '[' row ']'
;

matrixLit: '[' rows ']' 
;

rows: row ';' row 
| row ';'rows
;

row: value 
| value ',' row
;

value: tREALNUM
			|tINTNUM
			|tIDENT
;

bool: comp
      |bool tAND bool
      |bool tOR bool
;

comp: tIDENT relation tIDENT
;

relation: tGT | tLT | tGTE | tLTE | tNE | tEQ
;

%%

int main ()
{
  if (yyparse()) {
    printf("ERROR\n");
    return 1;
  }

else {
  printf("OK\n");
  return 0;
  }
}

