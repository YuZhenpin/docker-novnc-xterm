
NAME?=alpine-novnc

all:
	@echo ""
	@echo ""

build-novnc:
	docker build -t $(NAME) .

start-novnc:
	docker run -it --name $(NAME) -p 8080:8080 $(NAME)

stop-novnc:
	docker ps -aq --filter name=$(NAME) | xargs -r docker stop

destroy-novnc: stop-novnc
	docker ps -aq --filter name=$(NAME) | xargs -r docker rm

.PHONY: clean
clean: destroy-novnc
	docker images -q $(NAME) | xargs -r docker rmi

