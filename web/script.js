// DOM Elements
const codeEditor = document.getElementById('codeEditor');
const inputArea = document.getElementById('inputArea');
const outputArea = document.getElementById('outputArea');
const runBtn = document.getElementById('runBtn');
const examplesBtn = document.getElementById('examplesBtn');
const clearBtn = document.getElementById('clearBtn');
const clearInputBtn = document.getElementById('clearInputBtn');
const clearOutputBtn = document.getElementById('clearOutputBtn');
const examplesModal = document.getElementById('examplesModal');
const closeModal = document.getElementById('closeModal');
const loadingOverlay = document.getElementById('loadingOverlay');
const resizeHandle = document.getElementById('resizeHandle');
const resizeHandleVertical = document.getElementById('resizeHandleVertical');
const editorPanel = document.getElementById('editorPanel');
const inputSection = document.getElementById('inputSection');

// Example Programs
const examples = {
    hello: `শুরু
    শব্দ message = "হ্যালো, বাংলা কম্পাইলার!";
    দেখাও << message << "\\n";
শেষ`,
    
    calculator: `শুরু
    পূর্ণ a, b;
    দেখাও << "Enter two numbers: ";
    নাও >> a >> b;
    
    দেখাও << "Sum: " << (a + b) << "\\n";
    দেখাও << "Difference: " << (a - b) << "\\n";
    দেখাও << "Product: " << (a * b) << "\\n";
    দেখাও << "Division: " << (a / b) << "\\n";
শেষ`,
    
    factorial: `শুরু
    পূর্ণ n, fact = 1, i = 1;
    দেখাও << "Enter a number: ";
    নাও >> n;
    
    যতক্ষণ (i <= n) {
        fact = fact * i;
        i++;
    }
    
    দেখাও << "Factorial of " << n << " is " << fact << "\\n";
শেষ`,
    
    ifelse: `শুরু
    পূর্ণ x, y = 50;
    দেখাও << "Enter a number: ";
    নাও >> x;
    
    যদি (x < y && x != 0) {
        দেখাও << "x is less than y and not zero\\n";
    } নাহলে যদি (x == y) {
        দেখাও << "x equals y\\n";
    } নাহলে {
        দেখাও << "x is greater than y\\n";
    }
    
    দেখাও << "You entered: " << x << "\\n";
শেষ`
};

// Horizontal Resize (Editor Panel)
let isResizing = false;
let startX = 0;
let startWidth = 0;

resizeHandle.addEventListener('mousedown', (e) => {
    isResizing = true;
    startX = e.clientX;
    startWidth = editorPanel.offsetWidth;
    resizeHandle.classList.add('resizing');
    document.body.style.cursor = 'col-resize';
    document.body.style.userSelect = 'none';
});

document.addEventListener('mousemove', (e) => {
    if (!isResizing) return;
    
    const delta = e.clientX - startX;
    const newWidth = startWidth + delta;
    
    if (newWidth >= 300 && newWidth <= window.innerWidth - 300) {
        editorPanel.style.flex = 'none';
        editorPanel.style.width = newWidth + 'px';
    }
});

document.addEventListener('mouseup', () => {
    if (isResizing) {
        isResizing = false;
        resizeHandle.classList.remove('resizing');
        document.body.style.cursor = '';
        document.body.style.userSelect = '';
    }
});

// Vertical Resize (Input/Output Sections)
let isResizingVertical = false;
let startY = 0;
let startHeight = 0;

resizeHandleVertical.addEventListener('mousedown', (e) => {
    isResizingVertical = true;
    startY = e.clientY;
    startHeight = inputSection.offsetHeight;
    resizeHandleVertical.classList.add('resizing');
    document.body.style.cursor = 'row-resize';
    document.body.style.userSelect = 'none';
});

document.addEventListener('mousemove', (e) => {
    if (!isResizingVertical) return;
    
    const delta = e.clientY - startY;
    const newHeight = startHeight + delta;
    
    if (newHeight >= 100 && newHeight <= window.innerHeight - 200) {
        inputSection.style.flex = 'none';
        inputSection.style.height = newHeight + 'px';
    }
});

document.addEventListener('mouseup', () => {
    if (isResizingVertical) {
        isResizingVertical = false;
        resizeHandleVertical.classList.remove('resizing');
        document.body.style.cursor = '';
        document.body.style.userSelect = '';
    }
});

// Run Code
runBtn.addEventListener('click', async () => {
    const code = codeEditor.value;
    const input = inputArea.value;
    
    if (!code.trim()) {
        outputArea.textContent = 'Error: No code to run!';
        outputArea.className = 'output-error';
        return;
    }
    
    loadingOverlay.classList.add('active');
    outputArea.textContent = '';
    
    try {
        const response = await fetch('/api/run', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ code, input })
        });
        
        const result = await response.json();
        
        if (result.success) {
            outputArea.textContent = result.output || '(No output)';
            outputArea.className = '';
        } else {
            outputArea.textContent = result.error || 'Unknown error occurred';
            outputArea.className = 'output-error';
        }
    } catch (error) {
        outputArea.textContent = 'Error: Failed to connect to server\n' + error.message;
        outputArea.className = 'output-error';
    } finally {
        loadingOverlay.classList.remove('active');
    }
});

// Clear Buttons
clearBtn.addEventListener('click', () => {
    codeEditor.value = '';
});

clearInputBtn.addEventListener('click', () => {
    inputArea.value = '';
});

clearOutputBtn.addEventListener('click', () => {
    outputArea.textContent = '';
    outputArea.className = '';
});

// Examples Modal
examplesBtn.addEventListener('click', () => {
    examplesModal.classList.add('active');
});

closeModal.addEventListener('click', () => {
    examplesModal.classList.remove('active');
});

examplesModal.addEventListener('click', (e) => {
    if (e.target === examplesModal) {
        examplesModal.classList.remove('active');
    }
});

// Load Example
document.querySelectorAll('.example-item').forEach(item => {
    item.addEventListener('click', () => {
        const exampleName = item.dataset.example;
        if (examples[exampleName]) {
            codeEditor.value = examples[exampleName];
            examplesModal.classList.remove('active');
        }
    });
});

// Tab key support in editor
codeEditor.addEventListener('keydown', (e) => {
    if (e.key === 'Tab') {
        e.preventDefault();
        const start = codeEditor.selectionStart;
        const end = codeEditor.selectionEnd;
        const value = codeEditor.value;
        
        codeEditor.value = value.substring(0, start) + '    ' + value.substring(end);
        codeEditor.selectionStart = codeEditor.selectionEnd = start + 4;
    }
});

// Keyboard shortcuts
document.addEventListener('keydown', (e) => {
    // Ctrl/Cmd + Enter to run
    if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
        e.preventDefault();
        runBtn.click();
    }
    
    // Escape to close modal
    if (e.key === 'Escape' && examplesModal.classList.contains('active')) {
        examplesModal.classList.remove('active');
    }
});
