FROM alpine:latest

RUN apk --no-cache add ffmpeg

WORKDIR /app

VOLUME ["/app/input", "/app/output"]

COPY script.sh /script.sh
RUN chmod +x /script.sh

ENTRYPOINT ["/bin/sh","/script.sh"]
