# ESC/POS & ZPL Printer Emulator - Technical Overview

## Architecture Diagram

```
+-------------------+         +-------------------+         +----------------------+
|                   |         |                   |         |                      |
|   Desktop (UI)    | <-----> |   Electron Main   | <-----> |   ZplEscPrinter JS   |
| (Electron/HTML)   |         |   Process         |         |   Logic (main.js)    |
|                   |         |                   |         |                      |
+-------------------+         +-------------------+         +----------------------+
        |                                                         |
        |                                                         |
        |                 +-------------------+                   |
        +---------------->|   TCP Server      |<------------------+
                          |   (net module)    |
                          +-------------------+
                                   |
                                   v
                          +-------------------+
                          |  Web Service API  |
                          | (Labelary, esc2html)|
                          +-------------------+
```

## Brief Code Explanation

- **Language & Stack:**  
  - Written in JavaScript (Node.js) using Electron for the desktop GUI.
  - Uses HTML/CSS/JS for the renderer process (UI).
  - Uses Node.js `net` module for TCP server.
  - Calls external web services (Labelary for ZPL, esc2html for ESC/POS).
  - Compiled and packaged with Electron Forge.

- **Key Files:**  
  - `ZplEscPrinter/js/main.js`: Main logic for both Desktop and TCP flows.
  - `main.html`, `style.css`: UI.
  - `package.json`: Project config.

## Desktop Flow (Electron)

1. **User selects a file** via the UI.
2. Electron's renderer process sends the file path to the main process.
3. The file is read from disk and converted to base64.
4. The base64 data is sent to the main logic (`escpos` or `zpl` function).
5. The main logic decodes/processes the data and, if needed, sends it to a web service for rendering (Labelary for ZPL, esc2html for ESC/POS).
6. The result (image or HTML) is displayed in the UI.

## TCP Flow

1. The app starts a TCP server (default port 9100).
2. A client (e.g., POS system, test script) connects and sends raw binary data.
3. The server accumulates all data in a buffer until the client closes the connection.
4. Once closed, the buffer is converted to base64 and processed identically to the Desktop flow.
5. The data is decoded and, if needed, sent to the web service for rendering.
6. The result is displayed in the UI.

## Web Service Call

- **ZPL:**  
  - Calls the Labelary API (`http://labelary.com/service.html`) to render ZPL to an image/PDF.
- **ESC/POS:**  
  - Calls a local or remote `esc2html_service.php` to render ESC/POS commands to HTML.

## Repository

- **GitHub:**  
  - https://github.com/andrescmendeza/escpos-print-emulator

## Language & Compilers

- **Language:** JavaScript (Node.js, Electron)
- **Compilers/Tools:**  
  - Node.js (v14+ recommended)
  - Electron Forge (for packaging)
  - npm (for dependencies)

## Recommendations, Limitations, and Possible Improvements

**Recommendations:**
- Use the recommended Desktop configuration (see README).
- Always close the TCP connection after sending data to ensure full file processing.

**Limitations:**
- High cognitive complexity in some functions (should be refactored for maintainability).
- Uses prototype extension (`String.prototype`), which is discouraged in modern JS.
- Exception handling is minimal; error reporting could be improved.
- Only supports ZPL and ESC/POS; other printer languages are not supported.
- Relies on external web services (Labelary, esc2html), so requires internet or local service availability.

**Possible Improvements:**
- Refactor complex functions for readability and maintainability.
- Replace prototype extensions with utility functions.
- Improve error handling and user feedback.
- Add support for more printer languages or models.
- Implement a more robust TCP protocol (e.g., with delimiters or size headers).
- Add unit and integration tests.

**ESC/POS Support:**
- The emulator covers most common ESC/POS commands, but advanced features (graphics, custom fonts, etc.) may not be fully supported.
- Web service rendering may not match all real printer behaviors.

## Similarities with Epson L90 and Bixolon SP300

- **Epson L90:**  
  - Supports ESC/POS commands, similar to the emulator.
  - Handles label and receipt printing; the emulator mimics this by rendering ESC/POS to HTML/images.
  - TCP/IP printing is supported in both.

- **Bixolon SP300:**  
  - Also uses ESC/POS command set.
  - Supports TCP/IP and serial communication, like the emulator's TCP server.
  - Basic command compatibility is high, but hardware-specific features (cutters, sensors) are only emulated visually.

**Note:**  
While the emulator processes ESC/POS commands like these printers, it does not physically print or emulate hardware-level features (e.g., sensors, real cutter actions). It is ideal for software testing, development, and label previewing.
