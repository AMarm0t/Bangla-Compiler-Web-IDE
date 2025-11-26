%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

int line_num = 1;
%}

%option noyywrap

/* Regular expressions */
DIGIT       [0-9]
LETTER      [a-zA-Z_]
ALPHANUM    [a-zA-Z0-9_]

%%

    /* Comments */
"//".*                  { /* single-line comment */ }
"/*"([^*]|\*+[^*/])*"*/"  { /* multi-line comment */ }

    /* Bangla Keywords */
"শুরু"                  { return SHURU; }
"শেষ"                   { return SHESH; }
"পূর্ণ"                 { return PURNO; }
"ভগ্ন"                  { return VOGNO; }
"শব্দ"                  { return SHOBDO; }
"যদি"                   { return JODI; }
"নাহলে"                 { return NAHOLE; }
"যতক্ষণ"                { return JOTOKKHON; }
"দেখাও"                 { return DEKHAO; }
"নাও"                   { return NAO; }

    /* Operators */
"++"                    { return INCREMENT; }
"--"                    { return DECREMENT; }
"+="                    { return PLUS_ASSIGN; }
"-="                    { return MINUS_ASSIGN; }
"*="                    { return MULT_ASSIGN; }
"/="                    { return DIV_ASSIGN; }
"=="                    { return EQ; }
"!="                    { return NE; }
"<="                    { return LE; }
">="                    { return GE; }
"&&"                    { return AND; }
"||"                    { return OR; }
"<<"                    { return LEFT_SHIFT; }
">>"                    { return RIGHT_SHIFT; }
"<"                     { return LT; }
">"                     { return GT; }
"="                     { return ASSIGN; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MULT; }
"/"                     { return DIV; }

    /* Delimiters */
"{"                     { return LBRACE; }
"}"                     { return RBRACE; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
";"                     { return SEMICOLON; }
","                     { return COMMA; }

    /* String literals */
\"([^\\\"]|\\.)*\"      { 
                          yylval.str = strdup(yytext);
                          return STRING_LITERAL; 
                        }

    /* Numbers */
{DIGIT}+"."{DIGIT}+     { 
                          yylval.fval = atof(yytext); 
                          return FLOAT_LITERAL; 
                        }
{DIGIT}+                { 
                          yylval.ival = atoi(yytext); 
                          return INT_LITERAL; 
                        }

    /* Identifiers */
{LETTER}{ALPHANUM}*     { 
                          yylval.str = strdup(yytext); 
                          return IDENTIFIER; 
                        }

    /* Whitespace */
[ \t]+                  { /* ignore spaces and tabs */ }
\n                      { line_num++; }

    /* Unknown characters */
.                       { 
                          fprintf(stderr, "Lexical error: Unknown character '%s' at line %d\n", yytext, line_num);
                        }

%%
