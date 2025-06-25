#!/bin/bash

set -e

# Подставляем ключи в шаблон конфигурации
envsubst < /app/rclone.conf.template > /app/rclone.conf

# Монтируем S3 через rclone (в фоне)
rclone mount timeweb_s3:${S3_BUCKET} /mnt/music \
  --allow-other \
  --vfs-cache-mode writes \
  --config /app/rclone.conf &

# Небольшая задержка, чтобы примонтировалось
sleep 3

# Запуск Navidrome
/app/navidrome --configfile /app/navidrome.toml
