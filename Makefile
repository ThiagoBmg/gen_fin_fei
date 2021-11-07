all: 
	make updateBranch
	make start
start: 
	#!/bin/sh
	echo "Removendo versões anteriores"
	rm -rf app.exe;
	echo "Compilando o projeto..."	
	gcc -o app.exe main.c -w;
	echo "Iniciando o projeto :) \n\n"
	./app.exe  
test:
	#!/bin/sh
	echo "Removendo arquivos de testes antigos..."
	rm -rf ./tests/test.exe;
	echo "Compilando testes ..."
	gcc -o ./tests/test.exe ./tests/string_replace.test.c -w ; 
	echo "Iniciando testes \n"
	./tests/test.exe
build: 
	#!/bin/shð
	docker build -t app_image .;
	docker run -t -d --name gerenciador_financeiro_FEI app_image;
	docker exec -it gerenciador_financeiro_FEI bash;
updateBranch:
	git checkout master;
	git pull origin master;
remove:
	docker stop gerenciador_financeiro_FEI;
	docker rm gerenciador_financeiro_FEI;
# --- tests only ---
dashboard: 
	#!/bin/sh
	echo "Removendo arquivo do serviço de dashboard..."
	rm -rf ./services/dash.exe;
	echo "Compilando serviço ..."
	gcc -o ./services/dash.exe ./services/dashboard.c -w; 
	echo "Iniciando serviço \n"
	./services/dash.exe