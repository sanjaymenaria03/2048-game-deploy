FROM ubuntu:latest as builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl -o master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master \
    && unzip master.zip \
    && mv 2048-master/* . \
    && rm -rf 2048-master master.zip

FROM cgr.dev/chainguard/nginx:latest

COPY --from=builder /app /usr/share/nginx/html

EXPOSE 8080

CMD ["-c", "/etc/nginx/nginx.conf", "-e", "/dev/stderr", "-g", "daemon off;"]