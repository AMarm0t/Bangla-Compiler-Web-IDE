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
%option 8bit

/* 
 * UTF-8 aware patterns for Bangla/Bengali text
 * 
 * Bengali Unicode block: U+0980–U+09FF
 * In UTF-8 encoding: 0xE0 0xA6 0x80 to 0xE0 0xA7 0xBF
 * 
 * Bengali characters are 3-byte UTF-8 sequences:
 * - First byte:  0xE0
 * - Second byte: 0xA6 or 0xA7
 * - Third byte:  0x80-0xBF
 */

/* Match any 2-byte UTF-8 sequence (for completeness) */
UTF8_2BYTE      [\xC0-\xDF][\x80-\xBF]

/* Match Bengali/Bangla UTF-8 characters specifically */
BENGALI_CHAR    \xE0[\xA6-\xA7][\x80-\xBF]

/* Match any 3-byte UTF-8 sequence (broader, includes Bengali) */
UTF8_3BYTE      \xE0[\x80-\xBF][\x80-\xBF]|\xE1[\x80-\xBF][\x80-\xBF]|\xE2[\x80-\xBF][\x80-\xBF]|\xE3[\x80-\xBF][\x80-\xBF]|\xE4[\x80-\xBF][\x80-\xBF]|\xE5[\x80-\xBF][\x80-\xBF]|\xE6[\x80-\xBF][\x80-\xBF]|\xE7[\x80-\xBF][\x80-\xBF]|\xE8[\x80-\xBF][\x80-\xBF]|\xE9[\x80-\xBF][\x80-\xBF]|\xEA[\x80-\xBF][\x80-\xBF]|\xEB[\x80-\xBF][\x80-\xBF]|\xEC[\x80-\xBF][\x80-\xBF]|\xED[\x80-\xBF][\x80-\xBF]|\xEE[\x80-\xBF][\x80-\xBF]|\xEF[\x80-\xBF][\x80-\xBF]

/* Match any 4-byte UTF-8 sequence (emoji, etc.) */
UTF8_4BYTE      [\xF0-\xF7][\x80-\xBF][\x80-\xBF][\x80-\xBF]

/* Any UTF-8 multibyte character */
UTF8_CHAR       {UTF8_2BYTE}|{UTF8_3BYTE}|{UTF8_4BYTE}

/* Bangla digits ০-৯ are in the Bengali block */
BANGLA_DIGIT    \xE0\xA7[\xA6-\xAF]

/* ASCII components */
ASCII_LETTER    [a-zA-Z_]
ASCII_DIGIT     [0-9]

/* Identifier components: ASCII or UTF-8 (Bengali) letters/digits */
IDENT_START     {ASCII_LETTER}|{UTF8_CHAR}
IDENT_CONT      {ASCII_LETTER}|{ASCII_DIGIT}|{UTF8_CHAR}|{BANGLA_DIGIT}

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
"ফোর"                   { return FOR; }
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
"["                     { return LBRACKET; }
"]"                     { return RBRACKET; }
";"                     { return SEMICOLON; }
","                     { return COMMA; }

    /* String literals */
\"([^\\\"]|\\.)*\"      { 
                          yylval.str = strdup(yytext);
                          return STRING_LITERAL; 
                        }

    /* Numbers - supporting both ASCII and Bangla digits */
({ASCII_DIGIT}|{BANGLA_DIGIT})+"."({ASCII_DIGIT}|{BANGLA_DIGIT})+     { 
                          char* converted = bangla_to_english_digits(yytext);
                          yylval.fval = atof(converted);
                          free(converted);
                          return FLOAT_LITERAL; 
                        }
({ASCII_DIGIT}|{BANGLA_DIGIT})+    { 
                          char* converted = bangla_to_english_digits(yytext);
                          yylval.ival = atoi(converted);
                          free(converted);
                          return INT_LITERAL; 
                        }

    /* Identifiers - UTF-8 aware, supports Bengali variable names */
{IDENT_START}{IDENT_CONT}* { 
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
