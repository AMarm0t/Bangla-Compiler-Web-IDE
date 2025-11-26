# Makefile for Bangla Compiler (Flex & Bison)

# Compiler settings
CXX = g++
FLEX = flex
BISON = bison

# Compiler flags
CXXFLAGS = -std=c++11 -Wall -Wno-unused-function
LDFLAGS = 

# Target executable
TARGET = bangla_compiler

# Source files
FLEX_SRC = scanner.l
BISON_SRC = parser.y

# Generated files
LEX_OUTPUT = lex.yy.c
BISON_OUTPUT = parser.tab.c
BISON_HEADER = parser.tab.h

# Default target
all: $(TARGET)

# Build the executable
$(TARGET): $(BISON_OUTPUT) $(LEX_OUTPUT)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(BISON_OUTPUT) $(LEX_OUTPUT) $(LDFLAGS)

# Generate parser from Bison grammar
$(BISON_OUTPUT) $(BISON_HEADER): $(BISON_SRC)
	$(BISON) -d $(BISON_SRC)

# Generate lexer from Flex specification
$(LEX_OUTPUT): $(FLEX_SRC) $(BISON_HEADER)
	$(FLEX) $(FLEX_SRC)

# Run the compiler with default input file
run: $(TARGET)
	./$(TARGET)

# Run with a specific file
run-file: $(TARGET)
	./$(TARGET) $(FILE)

# Clean build artifacts
clean:
	rm -f $(TARGET) $(LEX_OUTPUT) $(BISON_OUTPUT) $(BISON_HEADER) *.o

# Clean everything including backup files
distclean: clean
	rm -f *~ *.bak

# Help message
help:
	@echo "Bangla Compiler Makefile"
	@echo "========================"
	@echo "Available targets:"
	@echo "  make          - Build the compiler"
	@echo "  make all      - Same as 'make'"
	@echo "  make run      - Build and run with code.txt"
	@echo "  make run-file FILE=<file> - Build and run with specific file"
	@echo "  make clean    - Remove build artifacts"
	@echo "  make distclean - Remove all generated files"
	@echo "  make help     - Show this help message"
	@echo ""
	@echo "Example usage:"
	@echo "  make"
	@echo "  make run"
	@echo "  make run-file FILE=myprogram.txt"

.PHONY: all run run-file clean distclean help
