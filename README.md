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

