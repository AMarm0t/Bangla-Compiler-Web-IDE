// Wait for DOM to be ready
document.addEventListener('DOMContentLoaded', () => {

// DOM Elements
const codeEditor = document.getElementById('codeEditor');
const inputArea = document.getElementById('inputArea');
const outputArea = document.getElementById('outputArea');
const runBtn = document.getElementById('runBtn');
const runBtnMobile = document.getElementById('runBtnMobile');
const runBtnBottom = document.getElementById('runBtnBottom');
const runBtnTop = document.getElementById('runBtnTop');
const examplesBtn = document.getElementById('examplesBtn');
const examplesBtnBottom = document.getElementById('examplesBtnBottom');
const examplesBtnTop = document.getElementById('examplesBtnTop');
const clearBtn = document.getElementById('clearBtn');
const clearBtnBottom = document.getElementById('clearBtnBottom');
const clearBtnTop = document.getElementById('clearBtnTop');
const clearInputBtn = document.getElementById('clearInputBtn');
const clearOutputBtn = document.getElementById('clearOutputBtn');
const examplesModal = document.getElementById('examplesModal');
const closeModal = document.getElementById('closeModal');
const loadingOverlay = document.getElementById('loadingOverlay');
const resizeHandle = document.getElementById('resizeHandle');
const resizeHandleVertical = document.getElementById('resizeHandleVertical');
const editorPanel = document.getElementById('editorPanel');
const inputSection = document.getElementById('inputSection');
const outputPanel = document.querySelector('.output-panel');

// Mobile tab elements
const tabButtons = document.querySelectorAll('.tab-btn');

// Mobile Tab Switching
tabButtons.forEach(btn => {
    btn.addEventListener('click', () => {
        const tab = btn.dataset.tab;
        
        // Update active tab button
        tabButtons.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        
        // Show corresponding panel
        if (tab === 'code') {
            editorPanel.classList.add('active');
            outputPanel.classList.remove('active');
        } else {
            editorPanel.classList.remove('active');
            outputPanel.classList.add('active');
        }
    });
});

// Example Programs
const examples = {
    hello: `শুরু
    শব্দ বার্তা = "হ্যালো, বাংলা কম্পাইলার!";
    দেখাও << বার্তা << নতুনলাইন;
শেষ`,
    
    calculator: `শুরু
    পূর্ণ ক, খ;
    দেখাও << "দুটি সংখ্যা লিখুন: ";
    নাও >> ক >> খ;
    
    দেখাও << "যোগফল: " << (ক + খ) << নতুনলাইন;
    দেখাও << "বিয়োগফল: " << (ক - খ) << নতুনলাইন;
    দেখাও << "গুণফল: " << (ক * খ) << নতুনলাইন;
    দেখাও << "ভাগফল: " << (ক / খ) << নতুনলাইন;
শেষ`,
    
    factorial: `শুরু
    পূর্ণ সংখ্যা, ফ্যাক্ট = 1, আই = 1;
    দেখাও << "একটি সংখ্যা লিখুন: ";
    নাও >> সংখ্যা;
    
    যতক্ষণ (আই <= সংখ্যা) {
        ফ্যাক্ট = ফ্যাক্ট * আই;
        আই++;
    }
    
    দেখাও << সংখ্যা << " এর ফ্যাক্টরিয়াল হল " << ফ্যাক্ট << নতুনলাইন;
শেষ`,
    
    ifelse: `শুরু
    পূর্ণ ক, খ = 50;
    দেখাও << "একটি সংখ্যা লিখুন: ";
    নাও >> ক;
    
    যদি (ক < খ && ক != 0) {
        দেখাও << "ক এর মান খ থেকে ছোট এবং শূন্য নয়" << নতুনলাইন;
    } নাহলে যদি (ক == খ) {
        দেখাও << "ক সমান খ" << নতুনলাইন;
    } নাহলে {
        দেখাও << "ক এর মান খ থেকে বড়" << নতুনলাইন;
    }
    
    দেখাও << "আপনি লিখেছেন: " << ক << নতুনলাইন;
শেষ`,
    
    loops: `শুরু
    দেখাও << "=== While Loop (যতক্ষণ) ===" << নতুনলাইন;
    পূর্ণ গণনা = 1;
    পূর্ণ যোগফল = 0;
    
    যতক্ষণ (গণনা <= 5) {
        দেখাও << "গণনা: " << গণনা << নতুনলাইন;
        যোগফল = যোগফল + গণনা;
        গণনা++;
    }
    দেখাও << "যোগফল = " << যোগফল << নতুনলাইন;
    
    দেখাও << নতুনলাইন << "=== For Loop (ফোর) ===" << নতুনলাইন;
    পূর্ণ সংখ্যা[৫];
    সংখ্যা[0] = 10;
    সংখ্যা[1] = 20;
    সংখ্যা[2] = 30;
    সংখ্যা[3] = 40;
    সংখ্যা[4] = 50;
    
    পূর্ণ সূচক;
    ফোর (সূচক = 0; সূচক < 5; সূচক = সূচক + 1;) {
        দেখাও << "সংখ্যা[" << সূচক << "] = " << সংখ্যা[সূচক] << নতুনলাইন;
    }
    
    দেখাও << নতুনলাইন << "=== For Loop with Sum ===" << নতুনলাইন;
    পূর্ণ মোট = 0;
    পূর্ণ ই;
    ফোর (ই = 1; ই <= 10; ই = ই + 1;) {
        মোট = মোট + ই;
    }
    দেখাও << "১ থেকে ১০ পর্যন্ত যোগফল = " << মোট << নতুনলাইন;
শেষ`,

    arrays: `শুরু
    দেখাও << "=== Array Input/Output Example ===" << নতুনলাইন;
    
    // Get array size from user
    পূর্ণ আকার;
    দেখাও << "Enter array size: ";
    নাও >> আকার;
    
    // Declare array
    পূর্ণ সংখ্যা[১০];
    
    // Input array elements
    দেখাও << "Enter " << আকার << " numbers:" << নতুনলাইন;
    পূর্ণ ই = ০;
    যতক্ষণ (ই < আকার) {
        দেখাও << "Element [" << ই << "]: ";
        নাও >> সংখ্যা[ই];
        ই++;
    }
    
    // Output array elements
    দেখাও << নতুনলাইন << "Your array:" << নতুনলাইন;
    পূর্ণ জ = ০;
    যতক্ষণ (জ < আকার) {
        দেখাও << "সংখ্যা[" << জ << "] = " << সংখ্যা[জ] << নতুনলাইন;
        জ++;
    }
    
    // Calculate sum
    দেখাও << নতুনলাইন << "Calculating sum..." << নতুনলাইন;
    পূর্ণ যোগফল = ০;
    পূর্ণ ক = ০;
    যতক্ষণ (ক < আকার) {
        যোগফল = যোগফল + সংখ্যা[ক];
        ক++;
    }
    দেখাও << "Sum = " << যোগফল << নতুনলাইন;
    
    // String array example
    দেখাও << নতুনলাইন << "=== String Array Example ===" << নতুনলাইন;
    শব্দ নাম[৩];
    নাম[০] = "বাংলা";
    নাম[১] = "ভাষা";
    নাম[২] = "সুন্দর";
    
    দেখাও << "String array with while loop:" << নতুনলাইন;
    পূর্ণ খ = ০;
    যতক্ষণ (খ < ৩) {
        দেখাও << "নাম[" << খ << "] = " << নাম[খ] << নতুনলাইন;
        খ++;
    }
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

// Run Code (shared)
async function runCode() {
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
            outputArea.className = 'output-success';
        } else {
            outputArea.textContent = result.error || 'Unknown error occurred';
            outputArea.className = 'output-error';
        }
    } catch (error) {
        outputArea.textContent = `Error: ${error.message}`;
        outputArea.className = 'output-error';
    } finally {
        loadingOverlay.classList.remove('active');
    }
}

// Hook buttons
runBtn.addEventListener('click', runCode);
if (runBtnMobile) runBtnMobile.addEventListener('click', runCode);
if (runBtnBottom) runBtnBottom.addEventListener('click', runCode);
if (runBtnTop) runBtnTop.addEventListener('click', runCode);

// Clear Buttons
function clearCode() {
    codeEditor.value = '';
}
clearBtn.addEventListener('click', clearCode);
if (clearBtnBottom) clearBtnBottom.addEventListener('click', clearCode);
if (clearBtnTop) clearBtnTop.addEventListener('click', clearCode);

clearInputBtn.addEventListener('click', () => {
    inputArea.value = '';
});

clearOutputBtn.addEventListener('click', () => {
    outputArea.textContent = '';
    outputArea.className = '';
});

// Examples Modal
function openExamples() {
    examplesModal.classList.add('active');
}
examplesBtn.addEventListener('click', openExamples);
if (examplesBtnBottom) examplesBtnBottom.addEventListener('click', openExamples);
if (examplesBtnTop) examplesBtnTop.addEventListener('click', openExamples);

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

}); // End DOMContentLoaded
