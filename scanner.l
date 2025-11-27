%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

int line_num = 1;

// Function to convert Bangla digits to English
char* bangla_to_english_digits(const char* str) {
    char* result = strdup(str);
    for (int i = 0; result[i] != '\0'; i++) {
        unsigned char c = (unsigned char)result[i];
        // Bangla digits: ০১২৩৪৫৬৭৮৯ (UTF-8: E0 A7 A6 to E0 A7 AF)
        if ((unsigned char)result[i] == 0xE0 && 
            (unsigned char)result[i+1] == 0xA7 && 
            (unsigned char)result[i+2] >= 0xA6 && 
            (unsigned char)result[i+2] <= 0xAF) {
            // Convert Bangla digit to English
            char digit = '0' + ((unsigned char)result[i+2] - 0xA6);
            result[i] = digit;
            // Shift remaining characters
            memmove(&result[i+1], &result[i+3], strlen(&result[i+3]) + 1);
        }
    }
    return result;
}
%}

%option noyywrap

/* Regular expressions - Using actual Bangla characters */
BANGLA_DIGIT    [০-৯]
DIGIT           [0-9]
ALL_DIGIT       [0-9০-৯]
LETTER          [a-zA-Z_\x80-\xFF]
ALPHANUM        [a-zA-Z0-9_\x80-\xFF০-৯]

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
"নতুনলাইন"             { yylval.str = strdup("\"\n\""); return STRING_LITERAL; }

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
{ALL_DIGIT}+"."{ALL_DIGIT}+     { 
                          char* converted = bangla_to_english_digits(yytext);
                          yylval.fval = atof(converted);
                          free(converted);
                          return FLOAT_LITERAL; 
                        }
{ALL_DIGIT}+                { 
                          char* converted = bangla_to_english_digits(yytext);
                          yylval.ival = atoi(converted);
                          free(converted);
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
