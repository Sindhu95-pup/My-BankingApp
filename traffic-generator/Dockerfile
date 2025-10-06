FROM curlimages/curl:8.5.0

WORKDIR /app

USER root
COPY traffic.sh .
RUN chmod +x /app/traffic.sh
USER 1000

ENTRYPOINT ["/bin/sh", "/app/traffic.sh"]