
NAME?=alpine-novnc

all:
	@echo "Makefile targets:"
	@echo "\nbuild-novnc\t: build image."
	@echo "\nstart-novnc\t: run novnc docker instance."
	@echo "\nstop-novnc\t: stop novnc docker instance."
	@echo "\tdestroy-novnc\t: remove novnc docker instance."
	@echo "\nclean\t: remove novnc docker image."

build-novnc:
	docker build -t $(NAME) .

start-novnc: destroy-novnc
	docker run -it --name $(NAME) -p 8080:8080 $(NAME)

stop-novnc:
	docker ps -aq --filter name=$(NAME) | xargs -r docker stop

destroy-novnc: stop-novnc
	docker ps -aq --filter name=$(NAME) | xargs -r docker rm

.PHONY: clean
clean: destroy-novnc
	docker images -q $(NAME) | xargs -r docker rmi

