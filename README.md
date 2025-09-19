# EscPrinter Emulator (Fork)

This project is a fork of the original [ZplEscPrinter](https://github.com/erikn69/ZplEscPrinter) by ErikN. It is a printer emulator for ZPL and ESC/POS rendering, based on the [labelary](http://labelary.com/service.html) web service and [receipt-print-hq/escpos-tools](https://github.com/receipt-print-hq/escpos-tools).

## About this Fork

This fork is maintained independently and may include changes, improvements, or adaptations not present in the original repository. All original credits and copyrights remain with their respective authors.

- Original author: ErikN
- Original repository: https://github.com/erikn69/ZplEscPrinter
- License: ISC (see LICENSE)

## Features
- Emulates ZPL and ESC/POS printers
- Renders labels using web services
- Configurable print density, label size, and TCP server
- Cross-platform: Windows, Linux, Mac

## Installation & Usage
**Note:** If you are using npm and there is a `yarn.lock` file in the project, it is recommended to delete it before running `npm install` to avoid dependency conflicts.

1. Clone this repository.
2. Open a terminal in the project folder.
3. Run `npm install` to install dependencies.
4. Run `npm start` to launch the application in development mode.
5. (Optional) Run `npm run make` to generate binaries for your operating system.

## References
- [ZPL Command Support](http://labelary.com/docs.html)
- [ZPL Web Service](http://labelary.com/service.html)
- [Esc/Pos Commands](https://escpos.readthedocs.io/en/latest/commands.html)
- [Esc/Pos receipt print tools](https://github.com/receipt-print-hq/escpos-tools)
- [Electron](https://www.electronjs.org)
- [Electron Forge](https://www.electronforge.io)


## License
This project is distributed under the ISC License. For full details, see the [LICENSE](./LICENSE) file.

## Acknowledgements
This fork respects and credits all original authors and contributors. If you use or redistribute this code, please retain all original notices and links to the source.
* **Fix** Save labels

# Recommended Desktop Configuration

For best results, use the following settings in the Desktop application:

- **Unit Size:** Inches
- **Width:** 4
- **Height:** 8
- **Network Host:** 127.0.0.1
- **Buffer Size:** 4096 B
- **Check** the **Keep TCP Socket Alive** option
- Save changes after updating these settings.

# TCP configuration and testing

## How to configure the service to listen via TCP

1. Make sure the port and host are set correctly in the graphical interface or configuration:
	- Host: `0.0.0.0` (or `127.0.0.1` for local only)
	- Port: `9100` (default)
2. Turn on the emulator, ensuring the "On" option is active.
3. Check that the console shows a message like:
	```
	Printer started on Host: <b>0.0.0.0</b> Port: <b>9100</b>
	```

## How to test if the service is listening via TCP

You can use `netstat` to verify that the port is open:

```
netstat -an | findstr 9100
```

You should see a line like:

```
  TCP    0.0.0.0:9100           0.0.0.0:0              LISTENING
```

## Test command to send a RAW file via TCP (PowerShell)


### How to send a RAW file to the emulator via TCP

#### Windows (PowerShell)
Run the following script in PowerShell:
```powershell
$client = New-Object System.Net.Sockets.TcpClient("127.0.0.1", 9100)
$stream = $client.GetStream()
[byte[]]$bytes = [System.IO.File]::ReadAllBytes("c:\GitHub\escpos-print-emulator\emulator_test.raw")
$stream.Write($bytes, 0, $bytes.Length)
$stream.Flush()
$stream.Close()
$client.Close()
```
Replace the file path with your test file location if needed.

#### Linux (Command Line)
You can use `nc` (netcat) to send a file:
```bash
nc 127.0.0.1 9100 < /path/to/emulator_test.raw
```
Replace `/path/to/emulator_test.raw` with your test file location.

#### Mac (Terminal)
On macOS, you can also use `nc` (netcat):
```bash
nc 127.0.0.1 9100 < /path/to/emulator_test.raw
```
Replace `/path/to/emulator_test.raw` with your test file location.

> **Note:**
> The TCP server accumulates all received data in memory and only processes the file once the client closes the connection. This ensures the entire file is received before converting it to base64 and sending it to the ESC/POS or ZPL handler, matching the Desktop flow. If you send a file in multiple chunks, make sure to close the connection after sending to trigger processing.

> **Note:**
> The TCP server accumulates all received data in memory and only processes the file once the client closes the connection. This ensures the entire file is received before converting it to base64 and sending it to the ESC/POS or ZPL handler, matching the Desktop flow. If you send a file in multiple chunks, make sure to close the connection after sending to trigger processing.