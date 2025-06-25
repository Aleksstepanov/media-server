#!/bin/bash
set -e

echo "[INFO] Generating rclone.conf from template"
envsubst < /config/rclone.conf.template > /config/rclone.conf

echo "[INFO] Mounting rclone..."
mkdir -p /mnt/music

rclone mount timeweb_s3:cb4f3c27-b7b96197-61cf-4ffe-9dbe-ec7a7d596aad \
  /mnt/music \
  --config /config/rclone.conf \
  --allow-other \
  --vfs-cache-mode writes \
  --daemon

sleep 2

echo "[INFO] Starting Navidrome..."
exec su-exec navidrome /opt/navidrome --configfile /etc/navidrome.toml
