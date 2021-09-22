FROM jlesage/firefox

# Install dependencies
RUN apk add python3 py3-pip py3-numpy

RUN pip3 install --no-cache-dir websockify

#RUN git clone https://github.com/kanaka/websockify

#RUN apk add websockify --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Run websockify
RUN python3 -m websockify -D 5801 127.0.0.1:5900
#                             |             |
#                             |             --- novnc port 
#                             --- exposed port
