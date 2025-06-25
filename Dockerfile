FROM alpine:latest

# Устанавливаем зависимости
RUN apk add --no-cache bash fuse rclone ffmpeg curl

# Добавляем Navidrome
RUN curl -L https://github.com/navidrome/navidrome/releases/latest/download/navidrome_linux_amd64.tar.gz \
    | tar xz -C /app
RUN mv /app/navidrome /app/navidrome-bin

# Создаём рабочую структуру
WORKDIR /app
COPY start.sh .
COPY navidrome.toml .
COPY rclone.conf.template .

RUN chmod +x /app/start.sh

VOLUME ["/app/data"]

EXPOSE 4533

CMD ["./start.sh"]
