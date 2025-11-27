const express = require('express');
const { exec } = require('child_process');
const fs = require('fs').promises;
const path = require('path');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.static('web'));

// Ensure temp directory exists
const TEMP_DIR = path.join(__dirname, 'temp');
fs.mkdir(TEMP_DIR, { recursive: true }).catch(console.error);

// API endpoint to run code
app.post('/api/run', async (req, res) => {
    const { code, input } = req.body;
    
    if (!code) {
        return res.json({ success: false, error: 'No code provided' });
    }
    
    // Generate unique filename
    const id = uuidv4();
    const codeFile = path.join(TEMP_DIR, `${id}.txt`);
    const inputFile = path.join(TEMP_DIR, `${id}_input.txt`);
    
    try {
        // Write code to file
        await fs.writeFile(codeFile, code, 'utf8');
        
        // Prepare command - use 'app' on Linux, 'app.exe' on Windows
        const appName = process.platform === 'win32' ? 'app.exe' : 'app';
        const appPath = path.join(__dirname, appName);
        const command = `"${appPath}" "${codeFile}"`;
        
        // Execute compiler with input via stdin
        const childProcess = exec(command, { 
            timeout: 5000,
            windowsHide: true
        }, async (error, stdout, stderr) => {
            // Cleanup temp files
            try {
                await fs.unlink(codeFile);
            } catch (cleanupError) {
                console.error('Cleanup error:', cleanupError);
            }
            
            if (error) {
                // Check if it's a timeout
                if (error.killed) {
                    return res.json({ 
                        success: false, 
                        error: 'Execution timeout (5 seconds exceeded)' 
                    });
                }
                
                // Return compilation/runtime errors
                return res.json({ 
                    success: false, 
                    error: stderr || stdout || error.message 
                });
            }
            
            // Success
            res.json({ 
                success: true, 
                output: stdout 
            });
        });
        
        // Send input to stdin if provided
        if (input && childProcess.stdin) {
            childProcess.stdin.write(input);
            childProcess.stdin.end();
        }
        
    } catch (err) {
        console.error('Server error:', err);
        res.json({ 
            success: false, 
            error: 'Server error: ' + err.message 
        });
    }
});

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.json({ status: 'ok', message: 'Bangla Compiler Server is running' });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
    console.log(`
╔════════════════════════════════════════════╗
║   Bangla Compiler - Web IDE Server        ║
╚════════════════════════════════════════════╝

🚀 Server running at: http://localhost:${PORT}
📱 Mobile access: http://192.168.0.104:${PORT}
📝 Open your browser and navigate to the URL above

Press Ctrl+C to stop the server
    `);
});
