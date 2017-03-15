FROM alpine:3.5

# Setup demo environment variables
ENV HOME=/root \
	DEBIAN_FRONTEND=noninteractive \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=en_US.UTF-8 \
	DISPLAY=:0.0 \
	DISPLAY_WIDTH=1024 \
	DISPLAY_HEIGHT=768

# x11vnc apk
ADD /apk /apk
RUN cp /apk/.abuild/-58b7ee0c.rsa.pub /etc/apk/keys
RUN apk --update add /apk/ossp-uuid-1.6.2-r0.apk
RUN apk add /apk/ossp-uuid-dev-1.6.2-r0.apk
RUN apk add /apk/x11vnc-0.9.13-r0.apk

# Install git, supervisor, VNC, & X11 packages
RUN apk --update --upgrade add \
	bash \
	fluxbox \
	git \
	socat \
	supervisor \
        xterm \
	xfce4-terminal \
	xvfb \
	x11vnc \
        vim

# Clone noVNC from github
RUN git clone https://github.com/YuZhenpin/noVNC.git /root/noVNC \
	&& git clone https://github.com/kanaka/websockify /root/noVNC/utils/websockify \
	&& rm -rf /root/noVNC/.git \
	&& rm -rf /root/noVNC/utils/websockify/.git \
	&& apk del git

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Modify the launch script 'ps -p'
RUN sed -i -- "s/ps -p/ps -o pid | grep/g" /root/noVNC/utils/launch.sh

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
