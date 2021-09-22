FROM jlesage/firefox

# Switch Alpine to Edge repository and update all packages
RUN sed -i '/edge/ s/^#//g' /etc/apk/repositories

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    apk update && \
    apk upgrade --available

# Update Firefox to latest release
RUN latest=$(apk list firefox | tail -n 1 | cut -d " " -f 1 | sed 's/firefox-//') && \
    add-pkg firefox=$latest --force

# Install dependencies
RUN apk add python3 py3-pip py3-numpy

RUN pip3 install --no-cache-dir websockify

#RUN git clone https://github.com/kanaka/websockify

#RUN apk add websockify --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Run websockify
RUN python3 -m websockify -D 5801 127.0.0.1:5800
#                             |             |
#                             |             --- novnc port 
#                             --- exposed port


#ENTRYPOINT ["/opt/websockify/run"]
