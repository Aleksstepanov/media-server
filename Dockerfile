FROM alpine:latest

RUN apk add --no-cache curl bash fuse3 su-exec ffmpeg ca-certificates \
    && curl -L https://github.com/rclone/rclone/releases/latest/download/rclone-v1.66.0-linux-amd64.zip -o rclone.zip \
    && unzip rclone.zip \
    && mv rclone-*-linux-amd64/rclone /usr/bin/ \
    && chmod +x /usr/bin/rclone \
    && curl -L https://github.com/navidrome/navidrome/releases/latest/download/navidrome_linux_amd64.tar.gz -o navidrome.tar.gz \
    && tar -xzf navidrome.tar.gz \
    && mv navidrome /opt/navidrome \
    && rm -rf /rclone* /navidrome*.tar.gz /navidrome-*

# Пользователь для запуска
RUN addgroup -S navidrome && adduser -S navidrome -G navidrome

COPY start.sh /start.sh
COPY navidrome.toml /etc/navidrome.toml
COPY rclone.conf.template /config/rclone.conf.template

RUN chmod +x /start.sh

VOLUME /data
VOLUME /config
VOLUME /mnt/music

EXPOSE 4533

CMD ["/start.sh"]
