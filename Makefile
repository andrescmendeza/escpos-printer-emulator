todo: crear_carpeta descargar_repos verificar_docker build_ws run_ws verificar_ws iniciar_emulador
descargar_repos:

# Makefile to automate installation and execution of the ESC/POS emulator

.PHONY: all create_folder download_repos check_docker build_ws run_ws check_ws start_emulator clean_yarn install_npm start_npm

all: create_folder download_repos check_docker build_ws run_ws check_ws start_emulator

create_folder:
	@echo "Creating emulator folder..."
	@mkdir -p emulator

# Download repositories into the emulator folder


	@echo "Cloning repositories..."
	@git clone https://github.com/andrescmendeza/escpos-printer-emulator.git emulator/escpos-printer-emulator || true
	@git clone https://github.com/andrescmendeza/escpos-tools-ws.git emulator/escpos-tools-ws || true

check_docker:
	@echo "Checking if Docker is running..."
	@docker info > /dev/null 2>&1 || (echo "Docker is not running" && exit 1)

build_ws:
	@echo "Building Docker image escpos-tools-ws..."
	@cd emulator/escpos-tools-ws && docker build -t escpos-tools-ws .

run_ws:
	@echo "Running escpos-tools-ws container..."
	@docker run -d --rm --name escpos-tools-ws -p 8080:8080 escpos-tools-ws

check_ws:
	@echo "Checking for HTTP 200 at http://localhost:8080/output.html..."
	@sleep 5
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/output.html | grep 200 || (echo "Web service did not respond with status 200" && exit 1)

start_emulator: clean_yarn install_npm start_npm

clean_yarn:
	@echo "Removing yarn.lock if exists..."
	@rm -f emulator/escpos-printer-emulator/yarn.lock

install_npm:
	@echo "Installing npm dependencies..."
	@cd emulator/escpos-printer-emulator && npm install

start_npm:
	@echo "Starting the emulator..."
	@cd emulator/escpos-printer-emulator && npm start
