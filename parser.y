%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

extern int yylex();
extern int line_num;
extern FILE *yyin;

void yyerror(const char *s);

/* AST Node Types */
typedef enum {
    NODE_PROGRAM,
    NODE_STMT_LIST,
    NODE_DECL,
    NODE_ASSIGN,
    NODE_COMPOUND_ASSIGN,
    NODE_INC_DEC,
    NODE_INPUT,
    NODE_OUTPUT,
    NODE_IF,
    NODE_WHILE,
    NODE_EXPR,
    NODE_BINARY_OP,
    NODE_UNARY_OP,
    NODE_LITERAL,
    NODE_IDENTIFIER,
    NODE_STRING_CONCAT,
    NODE_OUTPUT_ITEM
} NodeType;

typedef enum {
    OP_ADD, OP_SUB, OP_MUL, OP_DIV,
    OP_LT, OP_GT, OP_LE, OP_GE, OP_EQ, OP_NE,
    OP_AND, OP_OR,
    OP_NEG,
    OP_INC, OP_DEC,
    OP_PLUS_ASSIGN, OP_MINUS_ASSIGN, OP_MULT_ASSIGN, OP_DIV_ASSIGN
} OpType;

/* AST Node Structure */
typedef struct ASTNode {
    NodeType type;
    union {
        struct {
            struct ASTNode *statements;
        } program;
        
        struct {
            struct ASTNode **stmts;
            int count;
            int capacity;
        } stmt_list;
        
        struct {
            int varType; /* 0=int, 1=float, 2=string */
            char **names;
            struct ASTNode **init_values;
            int count;
        } decl;
        
        struct {
            char *name;
            struct ASTNode *value;
        } assign;
        
        struct {
            OpType op;
            char *name;
            struct ASTNode *value;
        } compound_assign;
        
        struct {
            OpType op;
            char *name;
        } inc_dec;
        
        struct {
            char **names;
            int count;
        } input;
        
        struct {
            struct ASTNode **items;
            int count;
        } output;
        
        struct {
            struct ASTNode *condition;
            struct ASTNode *then_branch;
            struct ASTNode *else_branch; /* Can be another IF node for else-if */
        } if_stmt;
        
        struct {
            struct ASTNode *condition;
            struct ASTNode *body;
        } while_stmt;
        
        struct {
            OpType op;
            struct ASTNode *left;
            struct ASTNode *right;
        } binary_op;
        
        struct {
            OpType op;
            struct ASTNode *operand;
        } unary_op;
        
        struct {
            int is_int;
            union {
                int ival;
                double fval;
            } value;
        } literal;
        
        struct {
            char *name;
        } identifier;
        
        struct {
            struct ASTNode **parts;
            int count;
        } string_concat;
        
        struct {
            int is_string;
            union {
                char *str;
                struct ASTNode *expr;
            } value;
        } output_item;
    } data;
} ASTNode;

/* Symbol Table */
#define MAX_VARS 1000

typedef struct VarEntry {
    char *name;
    int type; /* 0=int, 1=float, 2=string */
    union {
        int ival;
        double fval;
        char *sval;
    } value;
    struct VarEntry *next;
} VarEntry;

VarEntry *symbolTable[MAX_VARS];

/* AST Construction Functions */
ASTNode* createProgramNode(ASTNode *stmts);
ASTNode* createStmtListNode();
void addStatement(ASTNode *list, ASTNode *stmt);
ASTNode* createDeclNode(int varType, char **names, ASTNode **values, int count);
ASTNode* createAssignNode(char *name, ASTNode *value);
ASTNode* createCompoundAssignNode(OpType op, char *name, ASTNode *value);
ASTNode* createIncDecNode(OpType op, char *name);
ASTNode* createInputNode(char **names, int count);
ASTNode* createOutputNode(ASTNode **items, int count);
ASTNode* createIfNode(ASTNode *cond, ASTNode *then_br, ASTNode *else_br);
ASTNode* createWhileNode(ASTNode *cond, ASTNode *body);
ASTNode* createBinaryOpNode(OpType op, ASTNode *left, ASTNode *right);
ASTNode* createUnaryOpNode(OpType op, ASTNode *operand);
ASTNode* createIntLiteralNode(int value);
ASTNode* createFloatLiteralNode(double value);
ASTNode* createIdentifierNode(char *name);
ASTNode* createStringConcatNode(ASTNode **parts, int count);
ASTNode* createOutputItemString(char *str);
ASTNode* createOutputItemExpr(ASTNode *expr);

/* Execution Functions */
void executeProgram(ASTNode *node);
void executeStmtList(ASTNode *node);
void executeStatement(ASTNode *node);
double evaluateExpr(ASTNode *node);
char* evaluateString(ASTNode *node);

/* Symbol Table Functions */
unsigned int hash(const char *str);
VarEntry* findVar(const char *name);
void addVar(const char *name, int type);
int isDeclared(const char *name);
double getNumericValue(const char *name);
void setNumericValue(const char *name, double value);
char* getStringValue(const char *name);
void setStringValue(const char *name, const char *value);
void processEscapeSequences(const char *str);

/* Global root of AST */
ASTNode *astRoot = NULL;

%}

%union {
    int ival;
    double fval;
    char *str;
    struct ASTNode *node;
    struct {
        char **names;
        struct ASTNode **values;
        int count;
    } name_list;
    struct {
        struct ASTNode **items;
        int count;
    } node_list;
}

/* Token declarations */
%token SHURU SHESH PURNO VOGNO SHOBDO JODI NAHOLE JOTOKKHON DEKHAO NAO
%token LBRACE RBRACE LPAREN RPAREN SEMICOLON COMMA
%token INCREMENT DECREMENT PLUS_ASSIGN MINUS_ASSIGN MULT_ASSIGN DIV_ASSIGN
%token EQ NE LE GE LT GT AND OR
%token ASSIGN PLUS MINUS MULT DIV
%token LEFT_SHIFT RIGHT_SHIFT

%token <ival> INT_LITERAL
%token <fval> FLOAT_LITERAL
%token <str> STRING_LITERAL IDENTIFIER

%type <node> program statements statement declaration assignment
%type <node> compound_assignment increment_decrement input_statement output_statement
%type <node> if_statement while_statement
%type <node> expression logical_or logical_and equality relational additive multiplicative primary
%type <node> string_expression output_item
%type <name_list> purno_list vogno_list shobdo_list input_list
%type <node_list> output_list

/* Operator precedence */
%left OR
%left AND
%left EQ NE
%left LT GT LE GE
%left PLUS MINUS
%left MULT DIV
%right UMINUS
%right ASSIGN

%%

program:
    SHURU statements SHESH {
        astRoot = createProgramNode($2);
    }
    ;

statements:
    /* empty */ {
        $$ = createStmtListNode();
    }
    | statements statement {
        addStatement($1, $2);
        $$ = $1;
    }
    ;

statement:
    declaration { $$ = $1; }
    | assignment { $$ = $1; }
    | input_statement { $$ = $1; }
    | output_statement { $$ = $1; }
    | if_statement { $$ = $1; }
    | while_statement { $$ = $1; }
    | compound_assignment { $$ = $1; }
    | increment_decrement { $$ = $1; }
    ;

declaration:
    PURNO purno_list SEMICOLON {
        $$ = createDeclNode(0, $2.names, $2.values, $2.count);
    }
    | VOGNO vogno_list SEMICOLON {
        $$ = createDeclNode(1, $2.names, $2.values, $2.count);
    }
    | SHOBDO shobdo_list SEMICOLON {
        $$ = createDeclNode(2, $2.names, $2.values, $2.count);
    }
    ;

purno_list:
    IDENTIFIER {
        $$.names = malloc(sizeof(char*));
        $$.values = malloc(sizeof(ASTNode*));
        $$.names[0] = $1;
        $$.values[0] = NULL;
        $$.count = 1;
    }
    | IDENTIFIER ASSIGN expression {
        $$.names = malloc(sizeof(char*));
        $$.values = malloc(sizeof(ASTNode*));
        $$.names[0] = $1;
        $$.values[0] = $3;
        $$.count = 1;
    }
    | purno_list COMMA IDENTIFIER {
        $$.names = realloc($1.names, sizeof(char*) * ($1.count + 1));
        $$.values = realloc($1.values, sizeof(ASTNode*) * ($1.count + 1));
        $$.names[$1.count] = $3;
        $$.values[$1.count] = NULL;
        $$.count = $1.count + 1;
    }
    | purno_list COMMA IDENTIFIER ASSIGN expression {
        $$.names = realloc($1.names, sizeof(char*) * ($1.count + 1));
        $$.values = realloc($1.values, sizeof(ASTNode*) * ($1.count + 1));
        $$.names[$1.count] = $3;
        $$.values[$1.count] = $5;
        $$.count = $1.count + 1;
    }
    ;

vogno_list:
    IDENTIFIER {
        $$.names = malloc(sizeof(char*));
        $$.values = malloc(sizeof(ASTNode*));
        $$.names[0] = $1;
        $$.values[0] = NULL;
        $$.count = 1;
    }
    | IDENTIFIER ASSIGN expression {
        $$.names = malloc(sizeof(char*));
        $$.values = malloc(sizeof(ASTNode*));
        $$.names[0] = $1;
        $$.values[0] = $3;
        $$.count = 1;
    }
    | vogno_list COMMA IDENTIFIER {
        $$.names = realloc($1.names, sizeof(char*) * ($1.count + 1));
        $$.values = realloc($1.values, sizeof(ASTNode*) * ($1.count + 1));
        $$.names[$1.count] = $3;
        $$.values[$1.count] = NULL;
        $$.count = $1.count + 1;
    }
    | vogno_list COMMA IDENTIFIER ASSIGN expression {
        $$.names = realloc($1.names, sizeof(char*) * ($1.count + 1));
        $$.values = realloc($1.values, sizeof(ASTNode*) * ($1.count + 1));
        $$.names[$1.count] = $3;
        $$.values[$1.count] = $5;
        $$.count = $1.count + 1;
    }
    ;

shobdo_list:
    IDENTIFIER {
        $$.names = malloc(sizeof(char*));
        $$.values = malloc(sizeof(ASTNode*));
        $$.names[0] = $1;
        $$.values[0] = NULL;
        $$.count = 1;
    }
    | IDENTIFIER ASSIGN string_expression {
        $$.names = malloc(sizeof(char*));
        $$.values = malloc(sizeof(ASTNode*));
        $$.names[0] = $1;
        $$.values[0] = $3;
        $$.count = 1;
    }
    | shobdo_list COMMA IDENTIFIER {
        $$.names = realloc($1.names, sizeof(char*) * ($1.count + 1));
        $$.values = realloc($1.values, sizeof(ASTNode*) * ($1.count + 1));
        $$.names[$1.count] = $3;
        $$.values[$1.count] = NULL;
        $$.count = $1.count + 1;
    }
    | shobdo_list COMMA IDENTIFIER ASSIGN string_expression {
        $$.names = realloc($1.names, sizeof(char*) * ($1.count + 1));
        $$.values = realloc($1.values, sizeof(ASTNode*) * ($1.count + 1));
        $$.names[$1.count] = $3;
        $$.values[$1.count] = $5;
        $$.count = $1.count + 1;
    }
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON {
        $$ = createAssignNode($1, $3);
    }
    | IDENTIFIER ASSIGN string_expression SEMICOLON {
        $$ = createAssignNode($1, $3);
    }
    ;

compound_assignment:
    IDENTIFIER PLUS_ASSIGN expression SEMICOLON {
        $$ = createCompoundAssignNode(OP_PLUS_ASSIGN, $1, $3);
    }
    | IDENTIFIER MINUS_ASSIGN expression SEMICOLON {
        $$ = createCompoundAssignNode(OP_MINUS_ASSIGN, $1, $3);
    }
    | IDENTIFIER MULT_ASSIGN expression SEMICOLON {
        $$ = createCompoundAssignNode(OP_MULT_ASSIGN, $1, $3);
    }
    | IDENTIFIER DIV_ASSIGN expression SEMICOLON {
        $$ = createCompoundAssignNode(OP_DIV_ASSIGN, $1, $3);
    }
    | IDENTIFIER PLUS_ASSIGN string_expression SEMICOLON {
        $$ = createCompoundAssignNode(OP_PLUS_ASSIGN, $1, $3);
    }
    ;

increment_decrement:
    IDENTIFIER INCREMENT SEMICOLON {
        $$ = createIncDecNode(OP_INC, $1);
    }
    | IDENTIFIER DECREMENT SEMICOLON {
        $$ = createIncDecNode(OP_DEC, $1);
    }
    ;

input_statement:
    NAO input_list SEMICOLON {
        $$ = createInputNode($2.names, $2.count);
    }
    ;

input_list:
    RIGHT_SHIFT IDENTIFIER {
        $$.names = malloc(sizeof(char*));
        $$.names[0] = $2;
        $$.count = 1;
    }
    | input_list RIGHT_SHIFT IDENTIFIER {
        $$.names = realloc($1.names, sizeof(char*) * ($1.count + 1));
        $$.names[$1.count] = $3;
        $$.count = $1.count + 1;
    }
    ;

output_statement:
    DEKHAO output_list SEMICOLON {
        $$ = createOutputNode($2.items, $2.count);
    }
    ;

output_list:
    LEFT_SHIFT output_item {
        $$.items = malloc(sizeof(ASTNode*));
        $$.items[0] = $2;
        $$.count = 1;
    }
    | output_list LEFT_SHIFT output_item {
        $$.items = realloc($1.items, sizeof(ASTNode*) * ($1.count + 1));
        $$.items[$1.count] = $3;
        $$.count = $1.count + 1;
    }
    ;

output_item:
    STRING_LITERAL {
        $$ = createOutputItemString($1);
    }
    | IDENTIFIER {
        $$ = createOutputItemExpr(createIdentifierNode($1));
    }
    | expression {
        $$ = createOutputItemExpr($1);
    }
    ;

if_statement:
    JODI LPAREN expression RPAREN LBRACE statements RBRACE {
        $$ = createIfNode($3, $6, NULL);
    }
    | JODI LPAREN expression RPAREN LBRACE statements RBRACE NAHOLE LBRACE statements RBRACE {
        $$ = createIfNode($3, $6, $10);
    }
    | JODI LPAREN expression RPAREN LBRACE statements RBRACE NAHOLE if_statement {
        $$ = createIfNode($3, $6, $9);
    }
    ;

while_statement:
    JOTOKKHON LPAREN expression RPAREN LBRACE statements RBRACE {
        $$ = createWhileNode($3, $6);
    }
    ;

expression:
    logical_or { $$ = $1; }
    ;

logical_or:
    logical_and { $$ = $1; }
    | logical_or OR logical_and {
        $$ = createBinaryOpNode(OP_OR, $1, $3);
    }
    ;

logical_and:
    equality { $$ = $1; }
    | logical_and AND equality {
        $$ = createBinaryOpNode(OP_AND, $1, $3);
    }
    ;

equality:
    relational { $$ = $1; }
    | equality EQ relational {
        $$ = createBinaryOpNode(OP_EQ, $1, $3);
    }
    | equality NE relational {
        $$ = createBinaryOpNode(OP_NE, $1, $3);
    }
    ;

relational:
    additive { $$ = $1; }
    | relational LT additive {
        $$ = createBinaryOpNode(OP_LT, $1, $3);
    }
    | relational GT additive {
        $$ = createBinaryOpNode(OP_GT, $1, $3);
    }
    | relational LE additive {
        $$ = createBinaryOpNode(OP_LE, $1, $3);
    }
    | relational GE additive {
        $$ = createBinaryOpNode(OP_GE, $1, $3);
    }
    ;

additive:
    multiplicative { $$ = $1; }
    | additive PLUS multiplicative {
        $$ = createBinaryOpNode(OP_ADD, $1, $3);
    }
    | additive MINUS multiplicative {
        $$ = createBinaryOpNode(OP_SUB, $1, $3);
    }
    ;

multiplicative:
    primary { $$ = $1; }
    | multiplicative MULT primary {
        $$ = createBinaryOpNode(OP_MUL, $1, $3);
    }
    | multiplicative DIV primary {
        $$ = createBinaryOpNode(OP_DIV, $1, $3);
    }
    ;

primary:
    INT_LITERAL {
        $$ = createIntLiteralNode($1);
    }
    | FLOAT_LITERAL {
        $$ = createFloatLiteralNode($1);
    }
    | IDENTIFIER {
        $$ = createIdentifierNode($1);
    }
    | LPAREN expression RPAREN {
        $$ = $2;
    }
    | MINUS primary %prec UMINUS {
        $$ = createUnaryOpNode(OP_NEG, $2);
    }
    ;

string_expression:
    STRING_LITERAL {
        ASTNode **parts = malloc(sizeof(ASTNode*));
        parts[0] = createOutputItemString($1);
        $$ = createStringConcatNode(parts, 1);
    }
    | IDENTIFIER {
        ASTNode **parts = malloc(sizeof(ASTNode*));
        parts[0] = createIdentifierNode($1);
        $$ = createStringConcatNode(parts, 1);
    }
    | string_expression PLUS STRING_LITERAL {
        ASTNode *str_node = createOutputItemString($3);
        int newCount = $1->data.string_concat.count + 1;
        $1->data.string_concat.parts = realloc($1->data.string_concat.parts, sizeof(ASTNode*) * newCount);
        $1->data.string_concat.parts[newCount - 1] = str_node;
        $1->data.string_concat.count = newCount;
        $$ = $1;
    }
    | string_expression PLUS IDENTIFIER {
        ASTNode *id_node = createIdentifierNode($3);
        int newCount = $1->data.string_concat.count + 1;
        $1->data.string_concat.parts = realloc($1->data.string_concat.parts, sizeof(ASTNode*) * newCount);
        $1->data.string_concat.parts[newCount - 1] = id_node;
        $1->data.string_concat.count = newCount;
        $$ = $1;
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error: %s at line %d\n", s, line_num);
}

/* AST Construction Functions */

ASTNode* createProgramNode(ASTNode *stmts) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_PROGRAM;
    node->data.program.statements = stmts;
    return node;
}

ASTNode* createStmtListNode() {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_STMT_LIST;
    node->data.stmt_list.stmts = NULL;
    node->data.stmt_list.count = 0;
    node->data.stmt_list.capacity = 0;
    return node;
}

void addStatement(ASTNode *list, ASTNode *stmt) {
    if (list->data.stmt_list.count >= list->data.stmt_list.capacity) {
        list->data.stmt_list.capacity = list->data.stmt_list.capacity == 0 ? 8 : list->data.stmt_list.capacity * 2;
        list->data.stmt_list.stmts = realloc(list->data.stmt_list.stmts, 
                                             sizeof(ASTNode*) * list->data.stmt_list.capacity);
    }
    list->data.stmt_list.stmts[list->data.stmt_list.count++] = stmt;
}

ASTNode* createDeclNode(int varType, char **names, ASTNode **values, int count) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_DECL;
    node->data.decl.varType = varType;
    node->data.decl.names = names;
    node->data.decl.init_values = values;
    node->data.decl.count = count;
    return node;
}

ASTNode* createAssignNode(char *name, ASTNode *value) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_ASSIGN;
    node->data.assign.name = name;
    node->data.assign.value = value;
    return node;
}

ASTNode* createCompoundAssignNode(OpType op, char *name, ASTNode *value) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_COMPOUND_ASSIGN;
    node->data.compound_assign.op = op;
    node->data.compound_assign.name = name;
    node->data.compound_assign.value = value;
    return node;
}

ASTNode* createIncDecNode(OpType op, char *name) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_INC_DEC;
    node->data.inc_dec.op = op;
    node->data.inc_dec.name = name;
    return node;
}

ASTNode* createInputNode(char **names, int count) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_INPUT;
    node->data.input.names = names;
    node->data.input.count = count;
    return node;
}

ASTNode* createOutputNode(ASTNode **items, int count) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_OUTPUT;
    node->data.output.items = items;
    node->data.output.count = count;
    return node;
}

ASTNode* createIfNode(ASTNode *cond, ASTNode *then_br, ASTNode *else_br) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_IF;
    node->data.if_stmt.condition = cond;
    node->data.if_stmt.then_branch = then_br;
    node->data.if_stmt.else_branch = else_br;
    return node;
}

ASTNode* createWhileNode(ASTNode *cond, ASTNode *body) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_WHILE;
    node->data.while_stmt.condition = cond;
    node->data.while_stmt.body = body;
    return node;
}

ASTNode* createBinaryOpNode(OpType op, ASTNode *left, ASTNode *right) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_BINARY_OP;
    node->data.binary_op.op = op;
    node->data.binary_op.left = left;
    node->data.binary_op.right = right;
    return node;
}

ASTNode* createUnaryOpNode(OpType op, ASTNode *operand) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_UNARY_OP;
    node->data.unary_op.op = op;
    node->data.unary_op.operand = operand;
    return node;
}

ASTNode* createIntLiteralNode(int value) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_LITERAL;
    node->data.literal.is_int = 1;
    node->data.literal.value.ival = value;
    return node;
}

ASTNode* createFloatLiteralNode(double value) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_LITERAL;
    node->data.literal.is_int = 0;
    node->data.literal.value.fval = value;
    return node;
}

ASTNode* createIdentifierNode(char *name) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_IDENTIFIER;
    node->data.identifier.name = name;
    return node;
}

ASTNode* createStringConcatNode(ASTNode **parts, int count) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_STRING_CONCAT;
    node->data.string_concat.parts = parts;
    node->data.string_concat.count = count;
    return node;
}

ASTNode* createOutputItemString(char *str) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_OUTPUT_ITEM;
    node->data.output_item.is_string = 1;
    node->data.output_item.value.str = str;
    return node;
}

ASTNode* createOutputItemExpr(ASTNode *expr) {
    ASTNode *node = malloc(sizeof(ASTNode));
    node->type = NODE_OUTPUT_ITEM;
    node->data.output_item.is_string = 0;
    node->data.output_item.value.expr = expr;
    return node;
}

/* Execution Functions */

void executeProgram(ASTNode *node) {
    if (node && node->type == NODE_PROGRAM) {
        executeStmtList(node->data.program.statements);
    }
}

void executeStmtList(ASTNode *node) {
    if (node && node->type == NODE_STMT_LIST) {
        int i;
        for (i = 0; i < node->data.stmt_list.count; i++) {
            executeStatement(node->data.stmt_list.stmts[i]);
        }
    }
}

void executeStatement(ASTNode *node) {
    int i;
    double val;
    char *strval;
    VarEntry *var;
    
    if (!node) return;
    
    switch (node->type) {
        case NODE_DECL:
            for (i = 0; i < node->data.decl.count; i++) {
                if (isDeclared(node->data.decl.names[i])) {
                    fprintf(stderr, "Error: Redeclaration of variable '%s'\n", node->data.decl.names[i]);
                } else {
                    addVar(node->data.decl.names[i], node->data.decl.varType);
                    if (node->data.decl.init_values[i]) {
                        if (node->data.decl.varType == 2) {
                            /* String type */
                            strval = evaluateString(node->data.decl.init_values[i]);
                            setStringValue(node->data.decl.names[i], strval);
                            free(strval);
                        } else {
                            /* Numeric type */
                            val = evaluateExpr(node->data.decl.init_values[i]);
                            setNumericValue(node->data.decl.names[i], val);
                        }
                    }
                }
            }
            break;
            
        case NODE_ASSIGN:
            if (!isDeclared(node->data.assign.name)) {
                fprintf(stderr, "Error: Undeclared variable '%s'\n", node->data.assign.name);
            } else {
                var = findVar(node->data.assign.name);
                if (var->type == 2) {
                    strval = evaluateString(node->data.assign.value);
                    setStringValue(node->data.assign.name, strval);
                    free(strval);
                } else {
                    val = evaluateExpr(node->data.assign.value);
                    setNumericValue(node->data.assign.name, val);
                }
            }
            break;
            
        case NODE_COMPOUND_ASSIGN:
            if (!isDeclared(node->data.compound_assign.name)) {
                fprintf(stderr, "Error: Undeclared variable '%s'\n", node->data.compound_assign.name);
            } else {
                var = findVar(node->data.compound_assign.name);
                if (var->type == 2 && node->data.compound_assign.op == OP_PLUS_ASSIGN) {
                    strval = evaluateString(node->data.compound_assign.value);
                    char *current = getStringValue(node->data.compound_assign.name);
                    char *newval = malloc(strlen(current) + strlen(strval) + 1);
                    strcpy(newval, current);
                    strcat(newval, strval);
                    setStringValue(node->data.compound_assign.name, newval);
                    free(newval);
                    free(strval);
                } else if (var->type != 2) {
                    double current = getNumericValue(node->data.compound_assign.name);
                    val = evaluateExpr(node->data.compound_assign.value);
                    switch (node->data.compound_assign.op) {
                        case OP_PLUS_ASSIGN: setNumericValue(node->data.compound_assign.name, current + val); break;
                        case OP_MINUS_ASSIGN: setNumericValue(node->data.compound_assign.name, current - val); break;
                        case OP_MULT_ASSIGN: setNumericValue(node->data.compound_assign.name, current * val); break;
                        case OP_DIV_ASSIGN:
                            if (val == 0) fprintf(stderr, "Error: Division by zero\n");
                            else setNumericValue(node->data.compound_assign.name, current / val);
                            break;
                        default: break;
                    }
                }
            }
            break;
            
        case NODE_INC_DEC:
            if (!isDeclared(node->data.inc_dec.name)) {
                fprintf(stderr, "Error: Undeclared variable '%s'\n", node->data.inc_dec.name);
            } else {
                double current = getNumericValue(node->data.inc_dec.name);
                if (node->data.inc_dec.op == OP_INC) {
                    setNumericValue(node->data.inc_dec.name, current + 1);
                } else {
                    setNumericValue(node->data.inc_dec.name, current - 1);
                }
            }
            break;
            
        case NODE_INPUT:
            for (i = 0; i < node->data.input.count; i++) {
                if (!isDeclared(node->data.input.names[i])) {
                    fprintf(stderr, "Error: Undeclared variable '%s'\n", node->data.input.names[i]);
                } else {
                    var = findVar(node->data.input.names[i]);
                    if (var->type == 0) {
                        int ival;
                        scanf("%d", &ival);
                        var->value.ival = ival;
                    } else if (var->type == 1) {
                        double fval;
                        scanf("%lf", &fval);
                        var->value.fval = fval;
                    } else {
                        char buffer[1000];
                        scanf("%s", buffer);
                        free(var->value.sval);
                        var->value.sval = strdup(buffer);
                    }
                }
            }
            break;
            
        case NODE_OUTPUT:
            for (i = 0; i < node->data.output.count; i++) {
                ASTNode *item = node->data.output.items[i];
                if (item->type == NODE_OUTPUT_ITEM) {
                    if (item->data.output_item.is_string) {
                        char *str = item->data.output_item.value.str;
                        size_t len = strlen(str);
                        if (len >= 2) {
                            str[len-1] = '\0';
                            processEscapeSequences(str + 1);
                        }
                    } else {
                        ASTNode *expr = item->data.output_item.value.expr;
                        if (expr->type == NODE_IDENTIFIER) {
                            char *name = expr->data.identifier.name;
                            if (!isDeclared(name)) {
                                fprintf(stderr, "Error: Undeclared variable '%s'\n", name);
                            } else {
                                var = findVar(name);
                                if (var->type == 0) {
                                    printf("%d", var->value.ival);
                                } else if (var->type == 1) {
                                    printf("%g", var->value.fval);
                                } else {
                                    printf("%s", var->value.sval);
                                }
                            }
                        } else {
                            printf("%g", evaluateExpr(expr));
                        }
                    }
                }
            }
            break;
            
        case NODE_IF:
            val = evaluateExpr(node->data.if_stmt.condition);
            if (val) {
                executeStmtList(node->data.if_stmt.then_branch);
            } else if (node->data.if_stmt.else_branch) {
                if (node->data.if_stmt.else_branch->type == NODE_IF) {
                    /* else-if */
                    executeStatement(node->data.if_stmt.else_branch);
                } else {
                    /* else */
                    executeStmtList(node->data.if_stmt.else_branch);
                }
            }
            break;
            
        case NODE_WHILE:
            while (evaluateExpr(node->data.while_stmt.condition)) {
                executeStmtList(node->data.while_stmt.body);
            }
            break;
            
        default:
            break;
    }
}

double evaluateExpr(ASTNode *node) {
    double left, right;
    
    if (!node) return 0.0;
    
    switch (node->type) {
        case NODE_LITERAL:
            return node->data.literal.is_int ? 
                   (double)node->data.literal.value.ival : 
                   node->data.literal.value.fval;
                   
        case NODE_IDENTIFIER:
            if (!isDeclared(node->data.identifier.name)) {
                fprintf(stderr, "Error: Undeclared variable '%s'\n", node->data.identifier.name);
                return 0.0;
            }
            return getNumericValue(node->data.identifier.name);
            
        case NODE_BINARY_OP:
            left = evaluateExpr(node->data.binary_op.left);
            right = evaluateExpr(node->data.binary_op.right);
            switch (node->data.binary_op.op) {
                case OP_ADD: return left + right;
                case OP_SUB: return left - right;
                case OP_MUL: return left * right;
                case OP_DIV:
                    if (right == 0) {
                        fprintf(stderr, "Error: Division by zero\n");
                        return 0.0;
                    }
                    return left / right;
                case OP_LT: return left < right;
                case OP_GT: return left > right;
                case OP_LE: return left <= right;
                case OP_GE: return left >= right;
                case OP_EQ: return left == right;
                case OP_NE: return left != right;
                case OP_AND: return left && right;
                case OP_OR: return left || right;
                default: return 0.0;
            }
            
        case NODE_UNARY_OP:
            if (node->data.unary_op.op == OP_NEG) {
                return -evaluateExpr(node->data.unary_op.operand);
            }
            return 0.0;
            
        default:
            return 0.0;
    }
}

char* evaluateString(ASTNode *node) {
    int i;
    char *result, *temp;
    size_t total_len;
    
    if (!node) return strdup("");
    
    if (node->type == NODE_STRING_CONCAT) {
        total_len = 0;
        for (i = 0; i < node->data.string_concat.count; i++) {
            ASTNode *part = node->data.string_concat.parts[i];
            if (part->type == NODE_OUTPUT_ITEM && part->data.output_item.is_string) {
                char *str = part->data.output_item.value.str;
                size_t len = strlen(str);
                if (len >= 2) {
                    total_len += len - 2; /* Exclude quotes */
                }
            } else if (part->type == NODE_IDENTIFIER) {
                char *val = getStringValue(part->data.identifier.name);
                if (val) total_len += strlen(val);
            }
        }
        
        result = malloc(total_len + 1);
        result[0] = '\0';
        
        for (i = 0; i < node->data.string_concat.count; i++) {
            ASTNode *part = node->data.string_concat.parts[i];
            if (part->type == NODE_OUTPUT_ITEM && part->data.output_item.is_string) {
                char *str = part->data.output_item.value.str;
                size_t len = strlen(str);
                if (len >= 2) {
                    temp = malloc(len - 1);
                    strncpy(temp, str + 1, len - 2);
                    temp[len - 2] = '\0';
                    strcat(result, temp);
                    free(temp);
                }
            } else if (part->type == NODE_IDENTIFIER) {
                char *val = getStringValue(part->data.identifier.name);
                if (val) strcat(result, val);
            }
        }
        
        return result;
    } else if (node->type == NODE_OUTPUT_ITEM && node->data.output_item.is_string) {
        char *str = node->data.output_item.value.str;
        size_t len = strlen(str);
        if (len >= 2) {
            result = malloc(len - 1);
            strncpy(result, str + 1, len - 2);
            result[len - 2] = '\0';
            return result;
        }
    } else if (node->type == NODE_IDENTIFIER) {
        char *val = getStringValue(node->data.identifier.name);
        return val ? strdup(val) : strdup("");
    }
    
    return strdup("");
}

/* Symbol Table Functions */

unsigned int hash(const char *str) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;
    return hash % MAX_VARS;
}

VarEntry* findVar(const char *name) {
    unsigned int idx = hash(name);
    VarEntry *entry = symbolTable[idx];
    while (entry != NULL) {
        if (strcmp(entry->name, name) == 0) {
            return entry;
        }
        entry = entry->next;
    }
    return NULL;
}

void addVar(const char *name, int type) {
    unsigned int idx = hash(name);
    VarEntry *entry = (VarEntry*)malloc(sizeof(VarEntry));
    entry->name = strdup(name);
    entry->type = type;
    
    if (type == 0) {
        entry->value.ival = 0;
    } else if (type == 1) {
        entry->value.fval = 0.0;
    } else {
        entry->value.sval = strdup("");
    }
    
    entry->next = symbolTable[idx];
    symbolTable[idx] = entry;
}

int isDeclared(const char *name) {
    return findVar(name) != NULL;
}

double getNumericValue(const char *name) {
    VarEntry *var = findVar(name);
    if (var == NULL) return 0.0;
    
    if (var->type == 0) {
        return (double)var->value.ival;
    } else if (var->type == 1) {
        return var->value.fval;
    }
    return 0.0;
}

void setNumericValue(const char *name, double value) {
    VarEntry *var = findVar(name);
    if (var == NULL) return;
    
    if (var->type == 0) {
        var->value.ival = (int)value;
    } else if (var->type == 1) {
        var->value.fval = value;
    }
}

char* getStringValue(const char *name) {
    VarEntry *var = findVar(name);
    if (var == NULL || var->type != 2) return NULL;
    return var->value.sval;
}

void setStringValue(const char *name, const char *value) {
    VarEntry *var = findVar(name);
    if (var == NULL || var->type != 2) return;
    
    if (var->value.sval) {
        free(var->value.sval);
    }
    var->value.sval = strdup(value);
}

void processEscapeSequences(const char *str) {
    size_t i;
    for (i = 0; i < strlen(str); i++) {
        if (str[i] == '\\' && i + 1 < strlen(str)) {
            switch (str[i + 1]) {
                case 'n': printf("\n"); i++; break;
                case 't': printf("\t"); i++; break;
                case '\\': printf("\\"); i++; break;
                case '"': printf("\""); i++; break;
                default: printf("%c", str[i]); break;
            }
        } else {
            printf("%c", str[i]);
        }
    }
}

int main(int argc, char **argv) {
    int i;
    
    /* Initialize symbol table */
    for (i = 0; i < MAX_VARS; i++) {
        symbolTable[i] = NULL;
    }
    
    const char *filename = (argc > 1) ? argv[1] : "code.txt";
    FILE *file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Error: Cannot open file '%s'\n", filename);
        return 1;
    }
    yyin = file;
    
    /* Parse the program and build AST */
    yyparse();
    
    fclose(yyin);
    
    /* Execute the AST */
    if (astRoot) {
        executeProgram(astRoot);
    }
    
    return 0;
}
