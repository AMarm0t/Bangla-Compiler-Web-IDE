# Bangla Compiler - Web IDE 🇧🇩

A complete programming language compiler with **native Bangla keywords**, built with Flex, Bison, and Node.js. Write code entirely in Bengali with full UTF-8 support for variable names, strings, and all language constructs.

![Bangla Compiler](https://img.shields.io/badge/Language-Bangla-green.svg)
![Built With](https://img.shields.io/badge/Built%20With-Flex%20%26%20Bison-blue.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Status](https://img.shields.io/badge/Status-Production%20Ready-success.svg)

## ✨ Features

### Language Features
- **🔤 Native Bangla Keywords**: Complete programming syntax in Bengali (শুরু, শেষ, যদি, যতক্ষণ, ফোর, etc.)
- **🌐 Full UTF-8 Support**: Use Bangla variable names - single character (ন, ক, ই) or multi-character (সংখ্যা, গণনা, যোগফল)
- **📊 Data Types**: Integers (পূর্ণ), Floats (ভগ্ন), Strings (শব্দ) with full Bangla text support
- **📚 Arrays**: First-class array support for all types (পূর্ণ[], ভগ্ন[], শব্দ[])
- **🔄 Control Flow**: If-else conditionals, while loops (যতক্ষণ), for loops (ফোর)
- **🧮 Operators**: Arithmetic (+, -, *, /), Comparison (==, !=, <, >, <=, >=), Logical (&&, ||)
- **⚡ Compound Operations**: +=, -=, *=, /=, ++, --
- **🔢 Negative Numbers**: Full support for negative integers and floats
- **📥 Array Input**: Dynamic array input with `নাও >> arr[i]` syntax in loops
- **📤 Bangla Output**: All output displays in Bengali numerals (০-৯)

### Web IDE Features
- **🎨 Modern Interface**: VS Code-style dark theme with syntax highlighting
- **⚡ Real-time Compilation**: Compile and run code instantly in your browser
- **🔄 Interactive I/O**: Separate input and output panels with full UTF-8 support
- **📐 Resizable Layout**: Drag-and-drop panel resizing for custom workspace
- **📚 Example Programs**: Built-in examples (Hello World, Calculator, Factorial, Loops, Arrays, Conditionals)
- **🌍 Cross-Platform**: Works on any modern browser - desktop, tablet, or mobile
- **☁️ Cloud Deployment**: Deployed on Render with automatic builds from GitHub

## 📖 Language Reference

### Keywords

| Bangla | English | Purpose | Example |
|--------|---------|---------|---------|
| শুরু | start | Program start | `শুরু` |
| শেষ | end | Program end | `শেষ` |
| পূর্ণ | int | Integer type | `পূর্ণ সংখ্যা = 10;` |
| ভগ্ন | float | Float type | `ভগ্ন দশমিক = 3.14;` |
| শব্দ | string | String type | `শব্দ নাম = "বাংলা";` |
| পূর্ণ[] | int[] | Integer array | `পূর্ণ তালিকা[৫];` |
| ভগ্ন[] | float[] | Float array | `ভগ্ন মূল্য[১০];` |
| শব্দ[] | string[] | String array | `শব্দ নাম[৩];` |
| যদি | if | Conditional | `যদি (x > 0) { }` |
| নাহলে | else | Else clause | `নাহলে { }` |
| যতক্ষণ | while | While loop | `যতক্ষণ (i < 10) { }` |
| ফোর | for | For loop | `ফোর (i = 0; i < 5; i++;) { }` |
| দেখাও | print | Output | `দেখাও << "হ্যালো";` |
| নাও | input | Input | `নাও >> x;` |
| নতুনলাইন | newline | Line break | `দেখাও << নতুনলাইন;` |

### Operators

**Arithmetic**: `+`, `-`, `*`, `/`  
**Comparison**: `==`, `!=`, `<`, `>`, `<=`, `>=`  
**Logical**: `&&` (AND), `||` (OR)  
**Compound Assignment**: `+=`, `-=`, `*=`, `/=`  
**Increment/Decrement**: `++`, `--`  
**Unary**: `-` (negative numbers)

## 🚀 Quick Start

### Prerequisites
- Node.js (v14+)
- GCC compiler
- Flex (2.5+)
- Bison (3.0+)

### Installation

```bash
# Clone the repository
git clone https://github.com/AMarm0t/Bangla-Compiler-Web-IDE.git
cd Bangla-Compiler-Web-IDE

# Install Node.js dependencies
npm install

# Build the compiler
flex scanner.l
bison -d parser.y
gcc -o app lex.yy.c parser.tab.c -lm

# Start the web server
npm start
```

Visit **http://localhost:3000** in your browser.

### Windows Users

For proper Bangla display in terminal:
```powershell
chcp 65001  # Set UTF-8 code page
.\app.exe your_code.txt
```

## 📝 Code Examples

### Hello World
```bangla
শুরু
    দেখাও << "হ্যালো বাংলা!" << নতুনলাইন;
শেষ
```

### Variables with Bangla Names
```bangla
শুরু
    পূর্ণ সংখ্যা = 42;
    ভগ্ন দশমিক = 3.14159;
    শব্দ নাম = "বাংলাদেশ";
    
    দেখাও << "সংখ্যা: " << সংখ্যা << নতুনলাইন;
    দেখাও << "দশমিক: " << দশমিক << নতুনলাইন;
    দেখাও << "নাম: " << নাম << নতুনলাইন;
শেষ
```

### Input and Arithmetic
```bangla
শুরু
    পূর্ণ ক, খ, যোগফল;
    
    দেখাও << "প্রথম সংখ্যা: ";
    নাও >> ক;
    
    দেখাও << "দ্বিতীয় সংখ্যা: ";
    নাও >> খ;
    
    যোগফল = ক + খ;
    দেখাও << "যোগফল = " << যোগফল << নতুনলাইন;
শেষ
```

### Conditionals
```bangla
শুরু
    পূর্ণ বয়স = 20;
    
    যদি (বয়স >= 18) {
        দেখাও << "প্রাপ্তবয়স্ক" << নতুনলাইন;
    } নাহলে {
        দেখাও << "অপ্রাপ্তবয়স্ক" << নতুনলাইন;
    }
শেষ
```

### While Loop
```bangla
শুরু
    পূর্ণ গণনা = 1;
    
    যতক্ষণ (গণনা <= 5) {
        দেখাও << "সংখ্যা: " << গণনা << নতুনলাইন;
        গণনা++;
    }
শেষ
```

### For Loop
```bangla
শুরু
    পূর্ণ ই;
    
    ফোর (ই = 1; ই <= 10; ই++;) {
        দেখাও << ই << " ";
    }
    
    দেখাও << নতুনলাইন;
শেষ
```

### Arrays with Bangla Variables
```bangla
শুরু
    পূর্ণ সংখ্যা[৫];
    পূর্ণ ই;
    
    // Initialize array
    সংখ্যা[০] = 10;
    সংখ্যা[১] = 20;
    সংখ্যা[২] = 30;
    সংখ্যা[৩] = 40;
    সংখ্যা[৪] = 50;
    
    // Display array
    ফোর (ই = 0; ই < 5; ই++;) {
        দেখাও << "সংখ্যা[" << ই << "] = " << সংখ্যা[ই] << নতুনলাইন;
    }
শেষ
```

### Dynamic Array Input
```bangla
শুরু
    পূর্ণ আকার, ই;
    
    দেখাও << "অ্যারে আকার: ";
    নাও >> আকার;
    
    পূর্ণ তালিকা[১০];
    
    দেখাও << আকার << " টি সংখ্যা দিন:" << নতুনলাইন;
    ফোর (ই = 0; ই < আকার; ই++;) {
        দেখাও << "উপাদান [" << ই << "]: ";
        নাও >> তালিকা[ই];
    }
    
    // Display entered values
    দেখাও << "আপনার তালিকা:" << নতুনলাইন;
    ফোর (ই = 0; ই < আকার; ই++;) {
        দেখাও << তালিকা[ই] << " ";
    }
    দেখাও << নতুনলাইন;
শেষ
```

### String Arrays with Bangla Text
```bangla
শুরু
    শব্দ শহর[৫];
    পূর্ণ ই;
    
    শহর[০] = "ঢাকা";
    শহর[১] = "চট্টগ্রাম";
    শহর[২] = "খুলনা";
    শহর[৩] = "রাজশাহী";
    শহর[৪] = "সিলেট";
    
    দেখাও << "বাংলাদেশের শহর:" << নতুনলাইন;
    ফোর (ই = 0; ই < 5; ই++;) {
        দেখাও << (ই + 1) << ". " << শহর[ই] << নতুনলাইন;
    }
শেষ
```

### Complex Algorithm - Binary Search
```bangla
শুরু
    পূর্ণ তালিকা[১০];
    পূর্ণ ই;
    
    // Initialize sorted array
    তালিকা[০] = 5;
    তালিকা[১] = 10;
    তালিকা[২] = 15;
    তালিকা[৩] = 20;
    তালিকা[৪] = 25;
    তালিকা[৫] = 30;
    তালিকা[৬] = 35;
    তালিকা[৭] = 40;
    তালিকা[৮] = 45;
    তালিকা[৯] = 50;
    
    পূর্ণ লক্ষ্য = 25;
    পূর্ণ বাম = 0;
    পূর্ণ ডান = 9;
    পূর্ণ মধ্য;
    পূর্ণ ফলাফল = -1;
    
    যতক্ষণ (বাম <= ডান) {
        মধ্য = বাম + (ডান - বাম) / 2;
        
        যদি (তালিকা[মধ্য] == লক্ষ্য) {
            ফলাফল = মধ্য;
            বাম = ডান + 1;
        } নাহলে {
            যদি (তালিকা[মধ্য] < লক্ষ্য) {
                বাম = মধ্য + 1;
            } নাহলে {
                ডান = মধ্য - 1;
            }
        }
    }
    
    যদি (ফলাফল != -1) {
        দেখাও << "পাওয়া গেছে: " << ফলাফল << নতুনলাইন;
    } নাহলে {
        দেখাও << "পাওয়া যায়নি" << নতুনলাইন;
    }
শেষ
```

## 🏗️ Project Structure

```
Bangla-Compiler-Web-IDE/
├── scanner.l              # Flex lexer - tokenization with UTF-8 support
├── parser.y               # Bison parser - grammar and AST generation
├── compiler.h             # Compiler header - AST structures and function declarations
├── compiler.cpp           # Compiler implementation - AST execution engine
├── server.js              # Node.js Express server for web IDE
├── web/                   # Frontend web interface
│   ├── index.html         # Main IDE interface
│   ├── style.css          # Dark theme styling
│   └── script.js          # Client-side logic and API calls
├── tests/                 # Comprehensive test suite (13 test files)
│   ├── test_01_variables.txt
│   ├── test_02_conditions.txt
│   ├── test_03_while_loop.txt
│   ├── test_04_for_loop.txt
│   ├── test_05_int_arrays.txt
│   ├── test_06_float_arrays.txt
│   ├── test_07_string_arrays.txt
│   ├── test_08_compound_ops.txt
│   ├── test_09_nested.txt
│   ├── test_10_multiple_arrays.txt
│   ├── test_11_complex_expr.txt
│   ├── test_12_edge_cases.txt
│   └── test_13_binary_search.txt
├── Dockerfile             # Docker containerization
├── render.yaml            # Render deployment configuration
├── package.json           # Node.js dependencies
├── TEST_RESULTS.md        # Comprehensive test documentation
└── README.md              # This file
```

## 🔧 Technical Implementation

### Compiler Architecture

**Lexical Analysis (scanner.l)**
- UTF-8 byte sequence matching for Bangla characters
- Support for 2-byte, 3-byte, and 4-byte UTF-8 sequences
- Bengali-specific character ranges (০xE0[০xA6-০xA7][০x80-০xBF])
- Bangla digit recognition (০-৯)
- Token generation for keywords, identifiers, literals, and operators

**Syntax Analysis (parser.y)**
- Context-free grammar for Bangla programming constructs
- Abstract Syntax Tree (AST) generation
- Type checking and validation
- Symbol table management
- Support for nested scopes

**Semantic Analysis & Execution (compiler.cpp)**
- AST traversal and interpretation
- Variable storage and retrieval
- Type coercion (int ↔ float)
- Array bounds checking
- Expression evaluation with proper precedence
- Bangla number output conversion (০-৯)

### Key Technical Features

**UTF-8 Support**
```c
// scanner.l patterns
UTF8_2BYTE      [\xC0-\xDF][\x80-\xBF]
UTF8_3BYTE      \xE0[\x80-\xBF][\x80-\xBF]|...
BENGALI_CHAR    \xE0[\xA6-\xA7][\x80-\xBF]
BANGLA_DIGIT    \xE0\xA7[\xA6-\xAF]

IDENT_START     {ASCII_LETTER}|{UTF8_CHAR}
IDENT_CONT      {ASCII_LETTER}|{ASCII_DIGIT}|{UTF8_CHAR}|{BANGLA_DIGIT}
```

**Array Input Support**
```c
// Grammar support for dynamic array input
input_list:
    RIGHT_SHIFT IDENTIFIER
    | RIGHT_SHIFT IDENTIFIER LBRACKET expression RBRACKET
```

**Type System**
- Type 0: পূর্ণ (int) - 32-bit signed integers
- Type 1: ভগ্ন (float) - double precision floating point
- Type 2: শব্দ (string) - UTF-8 encoded strings
- Arrays: Homogeneous typed arrays for all base types

## 🧪 Testing

The project includes **13 comprehensive test suites** covering:

✅ Variable declaration and arithmetic  
✅ Conditional statements (if/else)  
✅ While loops  
✅ For loops  
✅ Integer arrays  
✅ Float arrays  
✅ String arrays with Bangla text  
✅ Compound operations (++, --, +=, etc.)  
✅ Nested control structures  
✅ Multiple array operations  
✅ Complex expressions and operator precedence  
✅ Edge cases (negatives, zero, empty strings)  
✅ Algorithmic implementation (binary search)  

**Run all tests:**
```powershell
chcp 65001
.\app.exe tests\test_01_variables.txt
.\app.exe tests\test_02_conditions.txt
# ... (run all 13 tests)
```

See [TEST_RESULTS.md](TEST_RESULTS.md) for detailed test documentation.

## 🌐 Deployment

### Deploy to Render (Free Hosting)

1. **Fork/Clone this repository**
2. **Push to your GitHub account**
3. **Go to [render.com](https://render.com) and sign up**
4. **Create new Web Service**
   - Connect your GitHub repository
   - Render auto-detects `render.yaml`
   - Click "Create Web Service"
5. **Your app will be live** at `https://your-app-name.onrender.com`

**Render Free Tier:**
- ✅ 750 hours/month (enough for 24/7 uptime)
- ✅ Automatic deployments from GitHub
- ✅ Free SSL certificate
- ⚠️ Sleeps after 15 min inactivity (30s wake time)

### Docker Deployment

```bash
# Build Docker image
docker build -t bangla-compiler .

# Run container
docker run -p 3000:3000 bangla-compiler
```

## 📚 Language Syntax Guide

### Variable Declaration
```bangla
পূর্ণ x;           // Declare integer
পূর্ণ y = 10;      // Declare and initialize
ভগ্ন pi = 3.14;    // Float variable
শব্দ name = "বাংলা"; // String variable
```

### Arrays
```bangla
পূর্ণ arr[10];     // Integer array
arr[0] = 5;         // Array assignment
দেখাও << arr[0];   // Array access
```

### Control Flow
```bangla
// If-else
যদি (condition) {
    // code
} নাহলে যদি (condition2) {
    // code
} নাহলে {
    // code
}

// While loop
যতক্ষণ (i < 10) {
    i++;
}

// For loop (note: semicolon after increment)
ফোর (i = 0; i < 10; i++;) {
    // code
}
```

### Input/Output
```bangla
নাও >> variable;           // Input single value
নাও >> x >> y >> z;        // Multiple inputs
নাও >> arr[i];             // Array element input

দেখাও << "text";           // Output text
দেখাও << variable;         // Output variable
দেখাও << x << " " << y;   // Multiple outputs
দেখাও << নতুনলাইন;         // Newline
```

### Operators
```bangla
x = a + b;      // Addition
x = a - b;      // Subtraction
x = a * b;      // Multiplication
x = a / b;      // Division

x += 5;         // Compound addition
x -= 3;         // Compound subtraction
x *= 2;         // Compound multiplication
x /= 4;         // Compound division

x++;            // Increment
x--;            // Decrement

যদি (a == b)   // Equality
যদি (a != b)   // Inequality
যদি (a < b)    // Less than
যদি (a > b)    // Greater than
যদি (a <= b)   // Less than or equal
যদি (a >= b)   // Greater than or equal

যদি (a && b)   // Logical AND
যদি (a || b)   // Logical OR
```

### Comments
```bangla
// Single line comment

/* Multi-line
   comment */
```

## ⚠️ Known Limitations

- Array initialization lists `{1, 2, 3}` not supported (use manual assignment)
- Variable declaration in for loop init not supported (declare before loop)
- No function definitions (single main program only)
- No include/import system
- No pointers or references

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow existing code style
- Add tests for new features
- Update documentation
- Test UTF-8 handling thoroughly
- Ensure backwards compatibility

## 📄 License

MIT License

Copyright (c) 2025 AMarm0t

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## 👨‍💻 Author

**AMarm0t**  
GitHub: [@AMarm0t](https://github.com/AMarm0t)  
Repository: [Bangla-Compiler-Web-IDE](https://github.com/AMarm0t/Bangla-Compiler-Web-IDE)

## 🙏 Acknowledgments

- Inspired by the need for programming education in native Bangla
- Built with Flex and Bison - powerful tools for language implementation
- Thanks to the open-source community for tools and libraries

## 🔗 Links

- **Live Demo**: [Your Render URL]
- **GitHub Repository**: https://github.com/AMarm0t/Bangla-Compiler-Web-IDE
- **Issue Tracker**: https://github.com/AMarm0t/Bangla-Compiler-Web-IDE/issues
- **Test Results**: [TEST_RESULTS.md](TEST_RESULTS.md)

---

⭐ **If you find this project helpful, please give it a star!**  
🐛 **Found a bug? Open an issue!**  
💡 **Have an idea? Submit a pull request!**

Made with ❤️ for the Bangla programming community```cpp
purno x = 10;                    // Declaration with initialization
purno a = 5, b = 15, c;         // Multiple declarations
x = a + b * 2;                  // Arithmetic operations
x += 10;                        // Compound assignment
x++;                            // Increment
```

#### Float (`vogno`)
```cpp
vogno pi = 3.14159;             // Float declaration
vogno area = pi * radius * radius;
area /= 2.0;                    // Division assignment
```

#### String (`shobdo`)
```cpp
shobdo greeting = "Hello";       // String declaration
shobdo name = "World";
shobdo message = greeting + " " + name;  // Concatenation
```

## 🛠️ Installation Guide

### Prerequisites

#### For Linux/Unix Systems
- **Operating System**: Linux/Unix (Ubuntu 18.04+ recommended)
- **Tools**: Flex 2.5+, Bison 3.0+, GCC 7.0+ with C++11 support, Make
- **Memory**: Minimum 512MB RAM
- **Storage**: 100MB free space

#### For Windows Systems
- **Operating System**: Windows 10/11 (recommended)
- **Tools**: One of the following:
  - **MSYS2** (recommended) - includes Flex, Bison, GCC, Make
  - **Cygwin** - with Flex, Bison, GCC packages
  - **WSL2** (Windows Subsystem for Linux)
- **Memory**: Minimum 1GB RAM
- **Storage**: 200MB free space

### Step-by-Step Installation

#### 🐧 Linux/Unix Installation

##### Ubuntu/Debian
```bash
# Update package list
sudo apt-get update

# Install Flex, Bison, GCC, and Make
sudo apt-get install flex bison g++ make git

# Clone the repository
git clone https://github.com/Hamza-28/Compiler-Design-Project.git
cd Compiler-Design-Project

# Build the compiler
make

# Run the compiler
./bangla_compiler
```

##### Fedora/RHEL
```bash
# Install dependencies
sudo dnf install flex bison gcc-c++ make git

# Clone and build
git clone https://github.com/Hamza-28/Compiler-Design-Project.git
cd Compiler-Design-Project
make

# Run
./bangla_compiler
```

##### Arch Linux
```bash
# Install dependencies
sudo pacman -S flex bison gcc make git

# Clone and build
git clone https://github.com/Hamza-28/Compiler-Design-Project.git
cd Compiler-Design-Project
make

# Run
./bangla_compiler
```

#### 🪟 Windows Installation

##### Option 1: Using MSYS2 (Recommended)

**Step 1: Install MSYS2**
1. Download MSYS2 from: https://www.msys2.org/
2. Run the installer and follow the installation wizard
3. Open "MSYS2 MinGW 64-bit" from Start Menu

**Step 2: Install Dependencies**
```bash
# Update package database
pacman -Syu

# Install development tools
pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-flex mingw-w64-x86_64-bison make git
```

**Step 3: Build the Compiler**
```bash
# Clone repository
git clone https://github.com/Hamza-28/Compiler-Design-Project.git
cd Compiler-Design-Project

# Build
make

# Run
./bangla_compiler.exe
```

##### Option 2: Using WSL2 (Windows Subsystem for Linux)

**Step 1: Enable WSL2**
```powershell
# Run in PowerShell as Administrator
wsl --install
# Restart computer
```

**Step 2: Install Ubuntu from Microsoft Store**

**Step 3: Follow Linux Instructions**
```bash
# Inside WSL2 Ubuntu terminal
sudo apt-get update
sudo apt-get install flex bison g++ make git
git clone https://github.com/Hamza-28/Compiler-Design-Project.git
cd Compiler-Design-Project
make
./bangla_compiler
```

##### Option 3: Using Cygwin

**Step 1: Download and Install Cygwin**
- Download from: https://www.cygwin.com/
- During installation, select these packages:
  - `flex`
  - `bison`
  - `gcc-g++`
  - `make`
  - `git`

**Step 2: Build**
```bash
# In Cygwin terminal
git clone https://github.com/Hamza-28/Compiler-Design-Project.git
cd Compiler-Design-Project
make
./bangla_compiler.exe
```

### Troubleshooting Installation

#### Linux/Unix Issues

**Issue**: `flex: command not found`
```bash
# Ubuntu/Debian
sudo apt-get install flex

# Fedora
sudo dnf install flex

# Arch
sudo pacman -S flex
```

**Issue**: `bison: command not found`
```bash
# Ubuntu/Debian
sudo apt-get install bison

# Fedora
sudo dnf install bison

# Arch
sudo pacman -S bison
```

#### Windows Issues

**Issue**: Commands not recognized in PowerShell/CMD
```powershell
# Solution: Use MSYS2 MinGW terminal instead of Windows CMD/PowerShell
# Or add MSYS2 bin directory to PATH:
# C:\msys64\mingw64\bin
```

**Issue**: UTF-8 encoding problems
```powershell
# Ensure your text editor saves files in UTF-8 encoding
# VS Code: Set "files.encoding": "utf8" in settings
# Notepad++: Encoding → UTF-8
```

**Issue**: Compilation errors
```bash
# Make sure you have the correct GCC version
g++ --version  # Should be 7.0 or higher

# Try clean build
make clean
make
```

## 📖 Usage Instructions

### 🚀 How to Use the Compiler

The compiler reads source code from a file (default: `code.txt`) and executes it.

#### Basic Usage

**Linux/Unix:**
```bash
# Run with default file (code.txt)
./bangla_compiler

# Run with specific file
./bangla_compiler myprogram.txt
./bangla_compiler examples/hello_world_bangla.txt
```

**Windows:**
```powershell
# Run with default file
bangla_compiler.exe

# Run with specific file
bangla_compiler.exe myprogram.txt
bangla_compiler.exe examples\hello_world_bangla.txt
```

#### Using Makefile

```bash
# Build the compiler
make

# Build and run with code.txt
make run

# Build and run with specific file
make run-file FILE=examples/calculator_bangla.txt

# Clean build artifacts
make clean

# Show help
make help
```

### 📋 Complete Workflow Examples

#### Example 1: Hello World Program

**Step 1: Create a file `hello.txt`**
```
শুরু
    শব্দ message = "হ্যালো, বাংলা কম্পাইলার!";
    দেখাও << message << "\n";
শেষ
```

**Step 2: Run the program**
```bash
./bangla_compiler hello.txt
```

**Expected Output:**
```
হ্যালো, বাংলা কম্পাইলার!
```

#### Example 2: Interactive Calculator

**Step 1: Create `calculator.txt`**
```
শুরু
    পূর্ণ num1, num2;
    দেখাও << "প্রথম সংখ্যা লিখুন: ";
    নাও >> num1;
    দেখাও << "দ্বিতীয় সংখ্যা লিখুন: ";
    নাও >> num2;
    
    পূর্ণ sum = num1 + num2;
    দেখাও << "যোগফল: " << sum << "\n";
শেষ
```

**Step 2: Run and interact**
```bash
./bangla_compiler calculator.txt
```

**Example Interaction:**
```
প্রথম সংখ্যা লিখুন: 15
দ্বিতীয় সংখ্যা লিখুন: 25
যোগফল: 40
```

### 🔧 Build Instructions

For detailed build instructions, see [BUILD.md](BUILD.md).

**Quick Build:**
```bash
# Using Makefile
make

# Manual build
bison -d parser.y
flex scanner.l
g++ -std=c++11 -o bangla_compiler main.cpp parser.tab.c lex.yy.c
```

### 🔧 Development Workflow

#### Method 1: Edit and Recompile Each Time
```bash
# 1. Edit your program
nano code.txt

# 2. Run the compiler (no need to recompile if compiler source hasn't changed)
./compiler
```

#### Method 2: Using Different File Names
If you want to work with multiple programs:

**Step 1: Create multiple program files**
```bash
# Create different programs
nano program1.txt
nano program2.txt
nano program3.txt
```

**Step 2: Copy to code.txt when you want to run**
```bash
# Run program1
cp program1.txt code.txt
./compiler

# Run program2  
cp program2.txt code.txt
./compiler
```

#### Method 3: Batch Script for Convenience

**Linux/Unix (create run_program.sh):**
```bash
#!/bin/bash
if [ "$1" ]; then
    cp "$1" code.txt
fi
g++ -std=c++11 -o compiler compiler.cpp tokenizer.cpp parser.cpp && ./compiler
```

**Usage:**
```bash
chmod +x run_program.sh
./run_program.sh myprogram.txt
```

**Windows (create run_program.bat):**
```batch
@echo off
if "%1" neq "" (
    copy "%1" code.txt
)
g++ -std=c++11 -o compiler.exe compiler.cpp tokenizer.cpp parser.cpp
if %errorlevel% equ 0 (
    compiler.exe
)
```

**Usage:**
```powershell
run_program.bat myprogram.txt
```

### 🐛 Debugging Your Programs

#### Common Issues and Solutions

**Issue**: Program doesn't compile
```bash
# Check for syntax errors in your .txt file
# Make sure you have shuru and shesh
# Check for proper semicolons and braces
```

**Issue**: Program runs but gives unexpected output
```bash
# Add debug output to trace execution
dekhao << "Debug: x = " << x << "\n";
```

**Issue**: Input not working
```bash
# Make sure you're using 'nao >>' for input
# Example: nao >> variable_name;
```

### 📝 Important Notes

1. **File Name**: The compiler reads from `code.txt` by default or any file you specify
2. **Compilation**: Recompile when you modify `scanner.l`, `parser.y`, or `main.cpp` using `make`
3. **Program Changes**: When you modify your program in `code.txt`, just run `./bangla_compiler` again
4. **File Encoding**: Use UTF-8 encoding for files with Bangla keywords
5. **Line Endings**: Both Unix (LF) and Windows (CRLF) line endings are supported

## 📚 Complete Language Reference

### 1. Program Structure
Every program must start with `শুরু` and end with `শেষ`:

```
শুরু
    // Your program code here
শেষ
```

### 2. Variable Declaration and Initialization

#### Single Variable Declaration
```
পূর্ণ age;                      // Declaration only
পূর্ণ score = 85;               // Declaration with initialization
ভগ্ন temperature = 98.6;        // Float with decimal
শব্দ message = "হ্যালো";       // String with quotes
```

#### Multiple Variable Declaration
```
পূর্ণ x = 10, y = 20, z;        // Mixed declaration
ভগ্ন a = 1.5, b = 2.7, c = 0.0;
শব্দ first = "আহমেদ", last = "রহমান";
```

### 3. Operators and Expressions

#### Arithmetic Operators
```
পূর্ণ result;
result = a + b;                  // Addition
result = a - b;                  // Subtraction
result = a * b;                  // Multiplication
result = a / b;                  // Division
result = (a + b) * (c - d);      // Complex expressions
```

#### Assignment Operators
```
x = 10;                          // Basic assignment
x += 5;                          // Add and assign (x = x + 5)
x -= 3;                          // Subtract and assign
x *= 2;                          // Multiply and assign
x /= 4;                          // Divide and assign
x++;                             // Increment by 1
x--;                             // Decrement by 1
```

#### Comparison Operators
```
যদি (a < b) { /* code */ }      // Less than
যদি (a > b) { /* code */ }      // Greater than
যদি (a <= b) { /* code */ }     // Less than or equal
যদি (a >= b) { /* code */ }     // Greater than or equal
যদি (a == b) { /* code */ }     // Equal to
যদি (a != b) { /* code */ }     // Not equal to
```

#### Logical Operators
```
যদি (a > 0 && b > 0) {          // Logical AND
    দেখাও << "উভয়ই ধনাত্মক\n";
}

যদি (a == 0 || b == 0) {        // Logical OR
    দেখাও << "অন্তত একটি শূন্য\n";
}

// Complex logical expressions
যদি ((a > 0 && b > 0) || (a < 0 && b < 0)) {
    দেখাও << "একই চিহ্ন\n";
}
```

### 4. Control Flow Statements

#### If-Else Statements
```
// Simple if
যদি (condition) {
    // code block
}

// If-else
যদি (condition) {
    // if block
} নাহলে {
    // else block
}

// If-else-if chain
যদি (score >= 90) {
    দেখাও << "গ্রেড: A\n";
} নাহলে যদি (score >= 80) {
    দেখাও << "গ্রেড: B\n";
} নাহলে যদি (score >= 70) {
    দেখাও << "গ্রেড: C\n";
} নাহলে {
    দেখাও << "গ্রেড: F\n";
}
```

#### While Loops
```
// Basic while loop
পূর্ণ i = 1;
যতক্ষণ (i <= 10) {
    দেখাও << i << " ";
    i++;
}

// While loop with complex condition
যতক্ষণ (i < 100 && sum < 1000) {
    sum += i;
    i++;
}

// Nested while loops
পূর্ণ row = 1;
যতক্ষণ (row <= 5) {
    পূর্ণ col = 1;
    যতক্ষণ (col <= row) {
        দেখাও << "* ";
        col++;
    }
    দেখাও << "\n";
    row++;
}
```

### 5. Input and Output Operations

#### Output (`দেখাও`)
```
// Basic output
দেখাও << "হ্যালো ওয়ার্ল্ড\n";

// Variable output
দেখাও << "মান: " << x << "\n";

// Multiple values
দেখাও << "x = " << x << ", y = " << y << "\n";

// Escape sequences
দেখাও << "লাইন 1\nলাইন 2\tট্যাবড\n";
```

#### Input (`নাও`)
```
// Single variable input
পূর্ণ age;
দেখাও << "আপনার বয়স লিখুন: ";
নাও >> age;

// Multiple inputs
পূর্ণ x, y;
দেখাও << "দুটি সংখ্যা লিখুন: ";
নাও >> x >> y;

// String input
শব্দ name;
দেখাও << "আপনার নাম লিখুন: ";
নাও >> name;
```

### 6. String Operations
```
শব্দ firstName = "আহমেদ";
শব্দ lastName = "রহমান";
শব্দ fullName = firstName + " " + lastName;

// String with variables
শব্দ result = "হ্যালো " + name + "!";

// String concatenation with assignment
message += " স্বাগতম!";
```

### 7. Comments
```
// এটি একক লাইন কমেন্ট

/*
   এটি
   মাল্টি-লাইন
   কমেন্ট
*/

পূর্ণ x = 10;  // ইনলাইন কমেন্ট
```

## 💡 Code Examples

### Example 1: Hello World
```
শুরু
    শব্দ message = "হ্যালো, বাংলা কম্পাইলার!";
    দেখাও << message << "\n";
শেষ
```

### Example 2: Calculator Program
```
শুরু
    পূর্ণ num1, num2, choice;
    ভগ্ন result;
    
    দেখাও << "সাধারণ ক্যালকুলেটর\n";
    দেখাও << "প্রথম সংখ্যা লিখুন: ";
    নাও >> num1;
    দেখাও << "দ্বিতীয় সংখ্যা লিখুন: ";
    নাও >> num2;
    
    দেখাও << "অপারেশন নির্বাচন করুন:\n";
    দেখাও << "1. যোগ\n2. বিয়োগ\n3. গুণ\n4. ভাগ\n";
    নাও >> choice;
    
    যদি (choice == 1) {
        result = num1 + num2;
        দেখাও << "ফলাফল: " << result << "\n";
    } নাহলে যদি (choice == 2) {
        result = num1 - num2;
        দেখাও << "ফলাফল: " << result << "\n";
    } নাহলে যদি (choice == 3) {
        result = num1 * num2;
        দেখাও << "ফলাফল: " << result << "\n";
    } নাহলে যদি (choice == 4) {
        যদি (num2 != 0) {
            result = num1 / num2;
            দেখাও << "ফলাফল: " << result << "\n";
        } নাহলে {
            দেখাও << "ত্রুটি: শূন্য দিয়ে ভাগ করা যায় না!\n";
        }
    } নাহলে {
        দেখাও << "ভুল পছন্দ!\n";
    }
শেষ
```

### Example 3: Factorial Calculator
```
শুরু
    পূর্ণ n, factorial = 1, i = 1;
    
    দেখাও << "একটি সংখ্যা লিখুন: ";
    নাও >> n;
    
    যদি (n < 0) {
        দেখাও << "ঋণাত্মক সংখ্যার ফ্যাক্টোরিয়াল সংজ্ঞায়িত নয়\n";
    } নাহলে যদি (n == 0 || n == 1) {
        দেখাও << n << " এর ফ্যাক্টোরিয়াল হল 1\n";
    } নাহলে {
        যতক্ষণ (i <= n) {
            factorial *= i;
            i++;
        }
        দেখাও << n << " এর ফ্যাক্টোরিয়াল হল " << factorial << "\n";
    }
শেষ
```

### Example 4: Grade Calculator
```
শুরু
    পূর্ণ numSubjects, i = 1;
    ভগ্ন totalMarks = 0.0, average;
    পূর্ণ currentMark;
    
    দেখাও << "গ্রেড ক্যালকুলেটর\n";
    দেখাও << "বিষয়ের সংখ্যা লিখুন: ";
    নাও >> numSubjects;
    
    যতক্ষণ (i <= numSubjects) {
        দেখাও << "বিষয় " << i << " এর নম্বর লিখুন: ";
        নাও >> currentMark;
        totalMarks += currentMark;
        i++;
    }
    
    average = totalMarks / numSubjects;
    
    দেখাও << "মোট নম্বর: " << totalMarks << "\n";
    দেখাও << "গড়: " << average << "\n";
    
    যদি (average >= 90) {
        দেখাও << "গ্রেড: A+ (চমৎকার)\n";
    } নাহলে যদি (average >= 80) {
        দেখাও << "গ্রেড: A (অতি উত্তম)\n";
    } নাহলে যদি (average >= 70) {
        দেখাও << "গ্রেড: B (ভালো)\n";
    } নাহলে যদি (average >= 60) {
        দেখাও << "গ্রেড: C (গড়)\n";
    } নাহলে {
        দেখাও << "গ্রেড: F (অকৃতকার্য)\n";
    }
শেষ
```

### Example 5: Pattern Printing
```
শুরু
    পূর্ণ rows, i = 1, j;
    
    দেখাও << "সারির সংখ্যা লিখুন: ";
    নাও >> rows;
    
    যতক্ষণ (i <= rows) {
        j = 1;
        যতক্ষণ (j <= i) {
            দেখাও << "* ";
            j++;
        }
        দেখাও << "\n";
        i++;
    }
শেষ
```

## 🔧 Technical Implementation

### Flex and Bison Architecture

This compiler is built using industry-standard tools:

**Flex (Fast Lexical Analyzer)**:
- Generates the lexical analyzer (scanner)
- Handles tokenization of Bangla keywords and UTF-8 characters
- Processes comments, strings, numbers, and operators
- File: `scanner.l`

**Bison (Parser Generator)**:
- Generates the syntax analyzer (parser)
- Implements grammar rules and semantic actions
- Manages symbol table and type checking
- Executes programs directly (interpreter mode)
- File: `parser.y`

### Compiler Pipeline

```
┌─────────────────────────────────────────────────────────────┐
│                   Bangla Compiler Pipeline                  │
├─────────────────────────────────────────────────────────────┤
│  Input: Source Code (.txt file with Bangla keywords)       │
│                           │                                 │
│                           ▼                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │            Flex Lexical Analyzer                    │   │
│  │            (Generated from scanner.l)               │   │
│  │  • UTF-8 Bangla character processing                │   │
│  │  • Keyword recognition (শুরু, শেষ, পূর্ণ, etc.)      │   │
│  │  • Tokenization (keywords, identifiers, literals)   │   │
│  │  • Comment removal (// and /* */)                   │   │
│  │  • String literal handling                          │   │
│  │  • Operator recognition (++, --, +=, etc.)          │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                 │
│                           ▼ (Token Stream)                  │
│  ┌─────────────────────────────────────────────────────┐   │
│  │            Bison Parser                             │   │
│  │            (Generated from parser.y)                │   │
│  │  • Syntax analysis using context-free grammar       │   │
│  │  • Symbol table management (3 separate tables)      │   │
│  │  • Expression evaluation with precedence            │   │
│  │  • Type checking (পূর্ণ, ভগ্ন, শব্দ)                 │   │
│  │  • Semantic error detection                         │   │
│  │  • Abstract Syntax Tree (implicit)                  │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                 │
│                           ▼                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │            Interpreter                              │   │
│  │            (Integrated in parser actions)           │   │
│  │  • Direct execution of statements                   │   │
│  │  • Variable storage and retrieval                   │   │
│  │  • Control flow execution (যদি, যতক্ষণ)             │   │
│  │  • I/O operations (দেখাও, নাও)                      │   │
│  │  • Runtime error detection                          │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                 │
│                           ▼                                 │
│  Output: Program Execution Results                          │
└─────────────────────────────────────────────────────────────┘
```

### Symbol Table Implementation

The compiler uses three separate symbol tables for type safety:

```cpp
map<string, int> purnoTable;      // Integer variables (পূর্ণ)
map<string, double> vognoTable;   // Float variables (ভগ্ন)
map<string, string> shobdoTable;  // String variables (শব্দ)
```

### Token Types

```c
/* Bangla Keywords */
SHURU      শুরু       (program start)
SHESH      শেষ        (program end)
PURNO      পূর্ণ       (integer type)
VOGNO      ভগ্ন        (float type)
SHOBDO     শব্দ        (string type)
JODI       যদি        (if)
NAHOLE     নাহলে       (else)
JOTOKKHON  যতক্ষণ      (while)
DEKHAO     দেখাও       (output)
NAO        নাও        (input)

/* Operators */
Arithmetic:  +, -, *, /
Assignment:  =, +=, -=, *=, /=
Increment:   ++, --
Comparison:  <, >, <=, >=, ==, !=
Logical:     && (AND), || (OR)
I/O:         << (output), >> (input)

/* Literals */
INT_LITERAL:    123, 456
FLOAT_LITERAL:  3.14, 2.718
STRING_LITERAL: "হ্যালো", "Hello"
IDENTIFIER:     variable_name, x, count
```

### Grammar Rules (Simplified)

```yacc
program: SHURU statements SHESH

statements: statement
          | statements statement

statement: declaration
         | assignment
         | if_statement
         | while_statement
         | input_statement
         | output_statement

expression: logical_or

logical_or: logical_and
          | logical_or OR logical_and

logical_and: equality
           | logical_and AND equality

equality: relational
        | equality EQ relational
        | equality NE relational

relational: additive
          | relational LT additive
          | relational GT additive
          | relational LE additive
          | relational GE additive

additive: multiplicative
        | additive PLUS multiplicative
        | additive MINUS multiplicative

multiplicative: primary
              | multiplicative MULT primary
              | multiplicative DIV primary

primary: INT_LITERAL
       | FLOAT_LITERAL
       | IDENTIFIER
       | LPAREN expression RPAREN
```

## 🏗️ Project Architecture

### Directory Structure
```
Compiler-Design-Project/
├── scanner.l                  # Flex lexical analyzer specification
├── parser.y                   # Bison parser grammar
├── main.cpp                   # Main driver program
├── Makefile                   # Build automation
├── code.txt                   # Default test program (Bangla)
├── code_bangla.txt           # Example Bangla program
├── examples/                  # Example programs
│   ├── hello_world_bangla.txt
│   ├── calculator_bangla.txt
│   └── factorial_bangla.txt
├── README.md                  # English documentation
├── README_BANGLA.md          # Bangla documentation
├── BUILD.md                   # Build instructions
├── QUICK_REFERENCE.md        # Quick reference
├── CONVERSION_SUMMARY.md     # Conversion summary
└── .gitignore                # Git ignore rules
```

### Component Architecture (Flex & Bison)

This compiler uses professional tools - **Flex** for lexical analysis and **Bison** for parsing.

```
┌─────────────────────────────────────────────────────────────┐
│               Bangla Compiler Architecture                  │
│                  (Flex & Bison Based)                       │
├─────────────────────────────────────────────────────────────┤
│  Input: Source Code (.txt file with Bangla keywords)       │
│                           │                                 │
│                           ▼                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Flex Lexical Analyzer                  │   │
│  │              (Generated from scanner.l)             │   │
│  │  • UTF-8 Bangla keyword recognition                 │   │
│  │  • Tokenization (শুরু, শেষ, পূর্ণ, etc.)            │   │
│  │  • Comment removal (// and /* */)                   │   │
│  │  • String literal handling                          │   │
│  │  • Operator recognition (++, &&, etc.)              │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                 │
│                           ▼                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Bison Parser                           │   │
│  │              (Generated from parser.y)              │   │
│  │  • Grammar-based parsing                            │   │
│  │  • Expression evaluation                            │   │
│  │  • Symbol table management                          │   │
│  │  • Type checking                                    │   │
│  │  • Error reporting                                  │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                 │
│                           ▼                                 │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                Interpreter                          │   │
│  │              (integrated in parser)                 │   │
│  │  • Direct execution                                 │   │
│  │  • Variable storage                                 │   │
│  │  • Control flow handling                            │   │
│  │  • I/O operations                                   │   │
│  │  • Runtime error detection                          │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                                 │
│                           ▼                                 │
│  Output: Program Execution Results                          │
└─────────────────────────────────────────────────────────────┘
```

## 🛡️ Error Handling

### Error Categories

#### 1. Lexical Errors
- **Invalid Characters**: Unrecognized symbols
- **Malformed Numbers**: Invalid numeric formats
- **Unterminated Strings**: Missing closing quotes
- **Invalid Identifiers**: Reserved keywords as variable names

```cpp
// Example lexical errors
purno 123invalid;        // Error: Invalid identifier
shobdo message = "Hello; // Error: Unterminated string
purno x@ = 5;           // Error: Invalid character '@'
```

#### 2. Syntax Errors
- **Missing Tokens**: Expected operators, braces, semicolons
- **Unexpected Tokens**: Tokens in wrong context
- **Malformed Expressions**: Invalid expression structure
- **Unmatched Braces**: Missing opening or closing braces

```cpp
// Example syntax errors
jodi (x > 0 {            // Error: Missing ')'
    dekhao << x;
}

purno x = 5 +;           // Error: Incomplete expression
```

#### 3. Semantic Errors
- **Undeclared Variables**: Using variables before declaration
- **Type Mismatches**: Incompatible type operations
- **Redeclaration**: Declaring same variable twice
- **Division by Zero**: Runtime division by zero

```cpp
// Example semantic errors
dekhao << undeclaredVar;  // Error: Undeclared variable
purno x = 3.14;          // Error: Type mismatch (float to int)
purno x = 5;
purno x = 10;            // Error: Redeclaration
```

#### 4. Runtime Errors
- **Division by Zero**: Mathematical errors
- **Input/Output Errors**: Failed I/O operations
- **Memory Errors**: Stack overflow (in complex expressions)

### Error Reporting System

#### Detailed Error Messages
```cpp
Error: Undeclared variable 'count' used in expression.
Error: Type mismatch. Cannot assign a non-integer value to an integer variable 'x'.
Error: Expected ')' after jodi condition, but got ';'.
Error: Redeclaration of variable 'sum'.
```

#### Error Recovery Strategies
- **Skip to Next Statement**: Continue parsing after error
- **Synchronization Points**: Recover at statement boundaries
- **Partial Execution**: Execute valid parts of program

## 🚀 Advanced Features

### 1. Complex Expression Support
- **Nested Parentheses**: Unlimited nesting depth
- **Mixed Data Types**: Automatic type promotion
- **Operator Chaining**: Multiple operators in single expression

```cpp
// Complex expression examples
result = ((a + b) * (c - d)) / ((e + f) * (g - h));
jodi ((x > 0 && y > 0) || (x < 0 && y < 0)) { /* same sign */ }
average = (math + physics + chemistry + biology) / 4.0;
```

### 2. String Processing
- **Concatenation**: Multiple string concatenation
- **Escape Sequences**: `\n`, `\t`, `\\`, `\"`
- **Variable Interpolation**: Mixing strings with variables

```cpp
shobdo message = "Hello" + " " + name + "!";
dekhao << "Line 1\nLine 2\tTabbed text\n";
dekhao << "Value of x is: " << x << "\n";
```

### 3. Advanced Control Flow
- **Nested Structures**: Unlimited nesting depth
- **Complex Conditions**: Multi-part logical expressions
- **Short-circuit Evaluation**: Efficient boolean evaluation

```cpp
// Deeply nested structures
jodi (condition1) {
    jotokkhon (condition2) {
        jodi (condition3) {
            // Nested logic
        }
    }
}

// Short-circuit evaluation
jodi (x != 0 && (y / x) > 5) {  // Safe division
    // y/x only evaluated if x != 0
}
```

### 4. Robust Type System
- **Implicit Conversions**: Safe type conversions
- **Type Checking**: Compile-time and runtime checking
- **Error Prevention**: Type mismatch detection

```cpp
vogno result = 10;        // int to float conversion
purno count = 3.0;        // Error: float to int requires explicit cast
shobdo text = 123;        // Error: number to string conversion
```

## 🧪 Testing

### Test Categories

#### 1. Unit Tests
```bash
# Basic functionality tests
./test_basic_arithmetic.sh
./test_variable_operations.sh
./test_string_operations.sh
./test_control_flow.sh
```

#### 2. Integration Tests
```bash
# End-to-end program tests
./test_calculator_program.sh
./test_loop_programs.sh
./test_complex_logic.sh
```

#### 3. Error Handling Tests
```bash
# Error detection and recovery
./test_syntax_errors.sh
./test_semantic_errors.sh
./test_runtime_errors.sh
```

#### 4. Performance Tests
```bash
# Performance and stress testing
./test_large_programs.sh
./test_deep_nesting.sh
./test_complex_expressions.sh
```

### Sample Test Cases

#### Test 1: Basic Arithmetic
```cpp
// test_arithmetic.txt
shuru
    purno a = 10, b = 5;
    purno sum = a + b;
    purno diff = a - b;
    purno prod = a * b;
    purno quot = a / b;
    
    dekhao << "Sum: " << sum << "\n";      // Expected: 15
    dekhao << "Diff: " << diff << "\n";    // Expected: 5
    dekhao << "Prod: " << prod << "\n";    // Expected: 50
    dekhao << "Quot: " << quot << "\n";    // Expected: 2
shesh
```

#### Test 2: Logical Operators
```cpp
// test_logical.txt
shuru
    purno x = 5, y = 10, z = 0;
    
    jodi (x > 0 && y > 0) {
        dekhao << "Both positive\n";       // Should execute
    }
    
    jodi (x > 0 || z > 0) {
        dekhao << "At least one positive\n"; // Should execute
    }
    
    jodi (x > 10 && y > 5) {
        dekhao << "Should not print\n";    // Should not execute
    }
shesh
```

#### Test 3: Error Handling
```cpp
// test_errors.txt
shuru
    purno declared = 5;
    dekhao << undeclared;     // Error: Undeclared variable
    
    purno x = 5;
    purno x = 10;             // Error: Redeclaration
    
    purno y = 3.14;           // Error: Type mismatch
shesh
```

### Running Tests
```bash
# Automated testing script
#!/bin/bash
echo "Running Compiler Tests..."

for test_file in tests/*.txt; do
    echo "Testing: $test_file"
    ./compiler "$test_file" > output.txt 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✓ PASS: $test_file"
    else
        echo "✗ FAIL: $test_file"
        cat output.txt
    fi
done

echo "Testing complete."
```

## ⚡ Performance

### Benchmarks

#### Time Complexity
- **Tokenization**: O(n) where n is source code length
- **Parsing**: O(n) where n is number of tokens
- **Expression Evaluation**: O(m) where m is expression complexity
- **Symbol Table Lookup**: O(1) average case (hash table)

#### Space Complexity
- **Token Storage**: O(n) for token vector
- **Symbol Tables**: O(v) where v is number of variables
- **Call Stack**: O(d) where d is nesting depth

#### Performance Characteristics
```cpp
// Performance test results (approximate)
Source Code Size    | Compilation Time | Memory Usage
--------------------|------------------|-------------
< 1KB              | < 1ms           | < 1MB
1KB - 10KB         | < 10ms          | 1-5MB
10KB - 100KB       | < 100ms         | 5-20MB
> 100KB            | Variable        | 20MB+
```

### Optimization Opportunities
1. **Token Caching**: Reduce re-parsing overhead
2. **Symbol Table Optimization**: More efficient data structures
3. **Expression Tree Caching**: Cache complex expression results
4. **Memory Pool**: Reduce allocation overhead

## 🤝 Contributing

### Development Setup
```bash
# Fork the repository
git fork https://github.com/Hamza-28/Compiler-Design-Project.git

# Clone your fork
git clone https://github.com/YOUR_USERNAME/Compiler-Design-Project.git
cd Compiler-Design-Project

# Create development branch
git checkout -b feature/your-feature-name

# Set up development environment
make dev-setup  # If available
```

### Coding Standards

#### C++ Style Guidelines
- **Naming**: camelCase for functions, PascalCase for classes
- **Indentation**: 2 spaces (no tabs)
- **Braces**: Opening brace on same line
- **Comments**: Descriptive comments for complex logic

```cpp
// Good example
class Parser {
private:
  int currentPosition;
  
public:
  bool parseExpression() {
    if (condition) {
      // Process tokens
      return true;
    }
    return false;
  }
};
```

#### Commit Message Format
```
type(scope): brief description

Detailed explanation of changes made.

- Added feature X
- Fixed bug Y
- Updated documentation Z
```

### Contribution Types

#### 1. Bug Fixes
- **Error Reporting**: Improve error messages
- **Edge Cases**: Handle corner cases
- **Memory Leaks**: Fix memory issues

#### 2. Feature Additions
- **New Keywords**: Add language constructs
- **Data Types**: Support for arrays, structures
- **Built-in Functions**: Math, string functions

#### 3. Performance Improvements
- **Optimization**: Faster parsing algorithms
- **Memory**: Reduce memory footprint
- **Caching**: Implement smart caching

#### 4. Documentation
- **Examples**: More code examples
- **Tutorials**: Step-by-step guides
- **API Docs**: Internal documentation

### Pull Request Process
1. **Create Issue**: Describe proposed changes
2. **Develop Feature**: Implement with tests
3. **Test Thoroughly**: Ensure no regressions
4. **Update Docs**: Document new features
5. **Submit PR**: Clear description and examples

## 🗺️ Roadmap

### Version 1.0 (Current)
- ✅ Basic language constructs
- ✅ Arithmetic and logical operators
- ✅ Control flow (if-else, while)
- ✅ Input/output operations
- ✅ Error handling

### Version 1.1 (Planned)
- 🔄 Functions and procedures
- 🔄 Local variable scoping
- 🔄 Parameter passing
- 🔄 Return values

### Version 1.2 (Future)
- 📋 Arrays and data structures
- 📋 For loops
- 📋 Break and continue statements
- 📋 Switch-case statements

### Version 2.0 (Long-term)
- 📋 Object-oriented features
- 📋 File I/O operations
- 📋 Standard library
- 📋 Module system

### Version 2.1 (Advanced)
- 📋 Error recovery and debugging
- 📋 IDE integration
- 📋 Code optimization
- 📋 JIT compilation

## ❓ FAQ

### General Questions

**Q: What inspired the Bengali keywords?**
A: The Bengali-inspired keywords make programming more accessible to Bengali speakers and demonstrate how programming languages can be localized for different cultures.

**Q: Is this a compiled or interpreted language?**
A: Currently, it's an interpreted language. The "compiler" directly executes the source code without generating intermediate machine code.

**Q: Can I use this for production applications?**
A: This is primarily an educational project. While functional, it lacks many features needed for production use.

### Technical Questions

**Q: How do I add new keywords?**
A: Add the keyword to the `keywords` set in `tokenizer.cpp` and implement the parsing logic in `parser.cpp`.

**Q: Can I extend the type system?**
A: Yes, you can add new data types by creating additional symbol tables and extending the parsing logic.

**Q: How do I implement new operators?**
A: Add operator recognition in `tokenizer.cpp`, update precedence in `parser.cpp`, and implement evaluation logic.

### Troubleshooting

**Q: Compilation fails with "undefined reference" errors**
A: Ensure all source files are included in compilation: `g++ -o compiler compiler.cpp tokenizer.cpp parser.cpp`

**Q: Program hangs during execution**
A: Check for infinite loops in your source code, especially while loops with conditions that never become false.

**Q: Getting "Invalid identifier" errors**
A: Ensure variable names start with a letter and contain only alphanumeric characters and underscores.

### Performance Questions

**Q: How large programs can this handle?**
A: The compiler can handle moderately sized programs (up to several hundred lines) efficiently. Very large programs may experience performance degradation.

**Q: Can I optimize compilation speed?**
A: Yes, compile with `-O2` flag for optimized binary: `g++ -O2 -o compiler *.cpp`

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Hamza

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 📞 Contact & Support

### Author
**Hamza** - Compiler Design Enthusiast
- **GitHub**: [@Hamza-28](https://github.com/Hamza-28)
- **Email**: [Contact via GitHub](https://github.com/Hamza-28)

### Project Links
- **Repository**: [https://github.com/Hamza-28/Compiler-Design-Project](https://github.com/Hamza-28/Compiler-Design-Project)
- **Issues**: [Report bugs and request features](https://github.com/Hamza-28/Compiler-Design-Project/issues)
- **Discussions**: [Community discussions](https://github.com/Hamza-28/Compiler-Design-Project/discussions)

### Getting Help
1. **Check FAQ**: Review common questions above
2. **Search Issues**: Look for existing solutions
3. **Create Issue**: Report bugs with detailed information
4. **Start Discussion**: Ask questions or propose ideas

### Acknowledgments
- Inspiration from traditional compiler design principles
- Bengali language and culture for keyword inspiration
- Open source community for tools and resources
- Computer Science education community

---

<div align="center">

**⭐ If you found this project helpful, please give it a star! ⭐**

*Built with ❤️ for the compiler design and programming language community*

[🚀 Get Started](#-installation-guide) | [📖 Learn More](#-language-specification) | [🤝 Contribute](#-contributing) | [❓ Get Help](#-faq)

</div>
