# 🇧🇩 Bangla Programming Language - Web IDE

A complete programming language with **native Bengali keywords**. Write code entirely in Bangla with full UTF-8 support. Features a modern web-based IDE for instant compilation and execution.

[![Language](https://img.shields.io/badge/Language-Bangla-green.svg)](https://en.wikipedia.org/wiki/Bengali_language)
[![Built With](https://img.shields.io/badge/Built%20With-Flex%20%26%20Bison-blue.svg)](https://www.gnu.org/software/bison/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Live Demo](https://img.shields.io/badge/Demo-Live-success.svg)](https://bangla-compiler-web-ide.onrender.com)

---

## ✨ Features

### Language Capabilities
- **Native Bangla Keywords** - Complete syntax in Bengali
- **Full UTF-8 Support** - Bangla variable names (ন, সংখ্যা, গণনা)
- **Data Types** - পূর্ণ (int), ভগ্ন (float), শব্দ (string)
- **Arrays** - পূর্ণ[], ভগ্ন[], শব্দ[] with dynamic input support
- **Control Flow** - যদি/নাহলে (if/else), যতক্ষণ (while), ফোর (for)
- **Operators** - Arithmetic, comparison, logical, compound (++, --, +=, etc.)
- **Advanced** - Negative numbers, array input (`নাও >> arr[i]`), Bangla output (০-৯)

### Web IDE
- **Modern Interface** - VS Code-style dark theme
- **Real-time Compilation** - Instant code execution
- **Mobile Responsive** - Works on all devices
- **Interactive I/O** - Separate input/output panels
- **Example Programs** - Built-in templates to get started

---

## 📖 Language Reference

### Keywords

| Bangla | English | Example |
|--------|---------|---------|
| শুরু | start | Program begins |
| শেষ | end | Program ends |
| পূর্ণ | int | `পূর্ণ x = 10;` |
| ভগ্ন | float | `ভগ্ন y = 3.14;` |
| শব্দ | string | `শব্দ নাম = "বাংলা";` |
| যদি | if | `যদি (x > 0) { }` |
| নাহলে | else | `নাহলে { }` |
| যতক্ষণ | while | `যতক্ষণ (i < 10) { }` |
| ফোর | for | `ফোর (i = 0; i < 5; i++;) { }` |
| দেখাও | print | `দেখাও << "text";` |
| নাও | input | `নাও >> x;` |

### Operators
- **Arithmetic:** `+` `-` `*` `/`
- **Comparison:** `==` `!=` `<` `>` `<=` `>=`
- **Logical:** `&&` `||`
- **Assignment:** `=` `+=` `-=` `*=` `/=`
- **Inc/Dec:** `++` `--`

---

## 🚀 Quick Start

### Online (Easiest)
Visit **[Live Demo](https://bangla-compiler-web-ide.onrender.com)** - No installation needed!

### Local Setup

**Requirements:** Node.js 14+, GCC, Flex 2.5+, Bison 3.0+

```bash
# Clone repository
git clone https://github.com/AMarm0t/Bangla-Compiler-Web-IDE.git
cd Bangla-Compiler-Web-IDE

# Install dependencies
npm install

# Build compiler
flex scanner.l
bison -d parser.y
gcc -o app lex.yy.c parser.tab.c -lm

# Start server
npm start
```

Open http://localhost:3000

---

## 📝 Code Examples

### Hello World
```bangla
শুরু
    দেখাও << "হ্যালো বাংলা!" << নতুনলাইন;
শেষ
```

### Variables
```bangla
শুরু
    পূর্ণ সংখ্যা = 42;
    ভগ্ন দশমিক = 3.14;
    শব্দ নাম = "বাংলাদেশ";
    
    দেখাও << "সংখ্যা: " << সংখ্যা << নতুনলাইন;
শেষ
```

### Input & Conditions
```bangla
শুরু
    পূর্ণ বয়স;
    দেখাও << "বয়স দিন: ";
    নাও >> বয়স;
    
    যদি (বয়স >= 18) {
        দেখাও << "প্রাপ্তবয়স্ক" << নতুনলাইন;
    } নাহলে {
        দেখাও << "অপ্রাপ্তবয়স্ক" << নতুনলাইন;
    }
শেষ
```

### Loops
```bangla
শুরু
    // While loop
    পূর্ণ গণনা = 1;
    যতক্ষণ (গণনা <= 5) {
        দেখাও << গণনা << " ";
        গণনা++;
    }
    
    দেখাও << নতুনলাইন;
    
    // For loop
    পূর্ণ ই;
    ফোর (ই = 1; ই <= 5; ই++;) {
        দেখাও << ই << " ";
    }
শেষ
```

### Arrays
```bangla
শুরু
    পূর্ণ সংখ্যা[৫];
    পূর্ণ ই;
    
    // Input array
    দেখাও << "৫ টি সংখ্যা দিন:" << নতুনলাইন;
    ফোর (ই = 0; ই < 5; ই++;) {
        নাও >> সংখ্যা[ই];
    }
    
    // Display array
    দেখাও << "আপনার সংখ্যা:" << নতুনলাইন;
    ফোর (ই = 0; ই < 5; ই++;) {
        দেখাও << সংখ্যা[ই] << " ";
    }
শেষ
```

### String Arrays
```bangla
শুরু
    শব্দ শহর[৩];
    শহর[০] = "ঢাকা";
    শহর[১] = "চট্টগ্রাম";
    শহর[২] = "খুলনা";
    
    পূর্ণ ই;
    ফোর (ই = 0; ই < 3; ই++;) {
        দেখাও << শহর[ই] << নতুনলাইন;
    }
শেষ
```

---

## 🏗️ Project Structure

```
├── scanner.l       # Lexer (tokenization, UTF-8 support)
├── parser.y        # Parser (grammar, AST generation)
├── server.js       # Express web server
├── web/            # Frontend (HTML/CSS/JS)
│   ├── index.html
│   ├── style.css
│   └── script.js
├── Dockerfile      # Docker config
├── render.yaml     # Render deployment
└── package.json    # Node.js dependencies
```

---

## 🌐 Deployment

### Deploy to Render (Free)

1. Fork this repository
2. Go to [render.com](https://render.com) → Sign up
3. Click "New +" → "Web Service"
4. Connect your forked repository
5. Render auto-detects `render.yaml` → Click "Create Web Service"
6. Live in 2-3 minutes at `https://your-app.onrender.com`

**Free Tier:** 750 hours/month, sleeps after 15min inactivity

**Keep Alive:** Use [UptimeRobot](https://uptimerobot.com) (free) to ping every 5 minutes

### Docker Deployment

```bash
docker build -t bangla-compiler .
docker run -p 3000:3000 bangla-compiler
```

---

## 🔧 Technical Details

### Compiler Pipeline
1. **Lexer (Flex)** - Tokenizes Bangla keywords and UTF-8 identifiers
2. **Parser (Bison)** - Builds Abstract Syntax Tree (AST)
3. **Executor** - Interprets AST, manages variables and I/O

### UTF-8 Implementation
```c
// scanner.l - Bangla character recognition
UTF8_2BYTE    [\xC0-\xDF][\x80-\xBF]
UTF8_3BYTE    \xE0[\x80-\xBF][\x80-\xBF]|...
BENGALI_CHAR  \xE0[\xA6-\xA7][\x80-\xBF]
BANGLA_DIGIT  \xE0\xA7[\xA6-\xAF]

IDENT_START   {ASCII_LETTER}|{UTF8_CHAR}
IDENT_CONT    {ASCII_LETTER}|{ASCII_DIGIT}|{UTF8_CHAR}|{BANGLA_DIGIT}
```

### Type System
- **Type 0:** পূর্ণ (int) - 32-bit signed
- **Type 1:** ভগ্ন (float) - double precision
- **Type 2:** শব্দ (string) - UTF-8 encoded
- **Arrays:** Homogeneous typed arrays

---

## 💡 Language Syntax Guide

### Variable Declaration
```bangla
পূর্ণ x;              // Declare
পূর্ণ y = 10;         // Declare and initialize
ভগ্ন pi = 3.14;       // Float
শব্দ name = "বাংলা";  // String
```

### Arrays
```bangla
পূর্ণ arr[10];        // Declare array
arr[0] = 5;            // Assign
দেখাও << arr[0];      // Access
নাও >> arr[i];        // Input to array element
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

// While
যতক্ষণ (i < 10) {
    i++;
}

// For (note: semicolon after increment)
ফোর (i = 0; i < 10; i++;) {
    // code
}
```

### Input/Output
```bangla
নাও >> x;               // Input single value
নাও >> x >> y >> z;     // Multiple inputs
নাও >> arr[i];          // Array element input

দেখাও << "text";        // Output text
দেখাও << x << " " << y; // Multiple outputs
দেখাও << নতুনলাইন;      // Newline
```

### Comments
```bangla
// Single line comment

/* Multi-line
   comment */
```

---

## ⚠️ Known Limitations

- Array initialization lists `{1,2,3}` not supported (use manual assignment)
- Variable declaration in for loop init not supported (declare before loop)
- No function definitions (single main program only)
- No include/import system

---

## 🤝 Contributing

Contributions welcome! To contribute:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing`)
3. Commit changes (`git commit -m 'Add feature'`)
4. Push to branch (`git push origin feature/amazing`)
5. Open Pull Request

---

## 📄 License

MIT License - Copyright (c) 2025 AMarm0t

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
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

---

## 👨‍💻 Author

**AMarm0t**  
GitHub: [@AMarm0t](https://github.com/AMarm0t)  
Repository: [Bangla-Compiler-Web-IDE](https://github.com/AMarm0t/Bangla-Compiler-Web-IDE)

---

## 🙏 Acknowledgments

- Built for programming education in native Bangla
- Powered by Flex and Bison
- Thanks to the open-source community

---

**⭐ Star this project if you find it helpful!**  
**🐛 Found a bug? [Open an issue](https://github.com/AMarm0t/Bangla-Compiler-Web-IDE/issues)**  
**💡 Have an idea? Submit a pull request!**

Made with ❤️ for the Bangla programming community
