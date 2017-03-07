
NAME?=alpine-novnc

build:
	docker build -t $(NAME) .

run:
	docker run -it --name $(NAME) -p 8080:8080 $(NAME)

stop:
	docker stop --name $(NAME)
