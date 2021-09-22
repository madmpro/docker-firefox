FROM jlesage/firefox

# Switch Alpine to Edge repository and update all packages
RUN sed -i -e 's/v[[:digit:]]\..*\//edge\//g' /etc/apk/repositories && \
    apk update && \
    apk upgrade --available

# Update Firefox to latest release
RUN latest=$(apk list firefox | tail -n 1 | cut -d " " -f 1 | sed 's/firefox-//') && \
    add-pkg firefox=$latest --force

# Install dependencies
RUN apk add --update-cache python3 websockify

# Run websockify
RUN websockify -D --web=/usr/share/novnc/ 5801 localhost:5800
#                                           |             |
#                                           |             --- novnc port 
#                                           --- exposed port


#ENTRYPOINT ["/opt/websockify/run"]
