FILE_CONTEXT_DIR=../example-web-application

.PHONY: compose-build compose-up compose-up-build compose-down docker-build-all docker-stop docker-remove

compose-build:
	sudo docker compose build

compose-up:
	sudo docker compose up

compose-up-build:
	sudo docker compose up --build

compose-down:
	sudo docker compose down

docker-build-all:
	sudo docker build -t frontend -f ./Dockerfile ${FILE_CONTEXT_DIR}/client-react/
	sudo docker build -t api-node -f ./Dockerfile.2 ${FILE_CONTEXT_DIR}/api-node/

	$(MAKE) docker-stop
	$(MAKE) docker-remove

	sudo docker network create harshit_network || true

	sudo docker run -d \
		--name db \
		--network harshit_network \
		-e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
		-v pgdata:/var/lib/postgresql/data \
		-p 5432:5432 \
		--restart unless-stopped \
		postgres:15.1-alpine

	sudo docker run -d \
		--name frontend \
		--network harshit_network \
		-p 80:80 \
		--restart unless-stopped \
		frontend

	sudo docker run -d \
		--name api-node \
		--network harshit_network \
		-e DATABASE_URL=${DATABASE_URL} \
		-p 3000:3000 \
		--restart unless-stopped \
		api-node

docker-stop:
	-sudo docker stop db
	-sudo docker stop api-node
	-sudo docker stop frontend

docker-remove:
	-sudo docker rm db
	-sudo docker rm api-node
	-sudo docker rm frontend
	-sudo docker network rm harshit_network
