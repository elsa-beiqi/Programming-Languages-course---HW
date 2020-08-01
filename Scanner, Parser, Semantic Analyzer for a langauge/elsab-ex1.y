%{
#include <stdio.h>
#include <stdlib.h>
#include "elsab-ex1.h"
void yyerror (const char *s) 
{
	printf ("%s\n", s); 
}
extern int lineNumber;

myNode * globalvars;
myNode * localvars;

%}

%locations

%union{
char * varname;
}

%type <varname> declaration bodystmt assignment printstmt expr value
%token <varname> tINT tSTRING tRETURN tPRINT tLPAR tRPAR tCOMMA tMOD tASSIGNM tMINUS tPLUS tDIV tSTAR tSEMI tLBRAC tRBRAC tIDENT tINTVAL tSTRINGVAL
%left tPLUS tMINUS
%left tDIV tSTAR tMOD
%start prog

%%

prog: stmtlst;

stmtlst: stmtlst stmt| stmt
;

stmt: FuncDefinition
    | declaration{searchdecl(globalvars,$1,lineNumber);
push(globalvars,$1 );//search if it exists before pushing
}
    | assignment{searchundef(globalvars,$1,lineNumber);}
    | printstmt
;

FuncDefinition: type tIDENT tLPAR rowformal tRPAR tLBRAC body returnstmt tRBRAC{//search in localvars before deleting
//always search in global vars	      

deleteList(localvars);
}
;

body: body bodystmt
    | bodystmt
    |
;

bodystmt: declaration{
	searchdecl(globalvars,$1,lineNumber);
	searchdecl(localvars,$1, lineNumber);
	push(localvars,$1);
	
}
	| assignment{
	int check1 = searchundef(globalvars,$1,lineNumber);
    int check2 = searchundef(localvars,$1,lineNumber);
    int check3 = check1+ check2;
    if(check3 ==1)
    {;
    }
    else
    {
    	printf("ERROR: %d undeclared variable\n", lineNumber);
	exit(1);
	}
}
	| printstmt
;

returnstmt: tRETURN expr tSEMI
;

rowformal: formalParameter
	 | rowformal tCOMMA formalParameter
         |
;

formalParameter: type tIDENT{searchdecl(globalvars,$2,lineNumber);
	       			push(localvars,$2);}
;

rowActuals: expr
	  | rowActuals tCOMMA expr
          | 
;

printstmt: tPRINT tLPAR expr tRPAR tSEMI{$$ = $3;}
;

declaration: type tIDENT tASSIGNM expr tSEMI{$$ = $2;}
;


expr: value{$$ = $1;}| FunctionCall{}| expr Operators expr{}
;

FunctionCall: tIDENT tLPAR rowActuals tRPAR 
;

assignment: tIDENT tASSIGNM expr tSEMI{$$ = $1;}
;

value: tINTVAL{} | tSTRINGVAL{} | tIDENT{int check1 = searchundef(globalvars,$1,lineNumber);
    int check2 = searchundef(localvars,$1,lineNumber);
    int check3 = check1+ check2;
    if(check3 ==1)
    {;
    }
    else
    {
    	printf("ERROR: %d undeclared variable\n", lineNumber);
	exit(1);
	}
}
;

Operators: tPLUS | tMINUS | tSTAR | tMOD | tDIV
;


type: tINT
    | tSTRING
;



%%
int main ()
{
   globalvars = emptyList();
   localvars = emptyList();
   if (yyparse()) {
   // parse error
       printf("ERROR\n");
       return 1;
   }
   else {
   // successful parsing
      printf("OK\n");
      
      return 0;
   }
}
