FROM jlesage/firefox

# Switch Alpine to Edge repository and update all packages
RUN sed -i '/edge/ s/^#//g' /etc/apk/repositories && \
    apk update && \
    apk upgrade --available

# Update Firefox to latest release
RUN latest=$(apk list firefox | tail -n 1 | cut -d " " -f 1 | sed 's/firefox-//') && \
    add-pkg firefox=$latest --force

# Install dependencies
RUN apk add websockify

# Run websockify
RUN websockify -D --web=/usr/share/novnc/ 5801 localhost:5800
#                                           |             |
#                                           |             --- novnc port 
#                                           --- exposed port


#ENTRYPOINT ["/opt/websockify/run"]
