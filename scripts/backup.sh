#!/bin/bash

TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
BACKUP_DIR="backups/$TIMESTAMP"

echo "[INFO] Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

cp deployment.yaml "$BACKUP_DIR/deployment.yaml"
cp service.yaml "$BACKUP_DIR/service.yaml"
cp trigger.txt "$BACKUP_DIR/trigger.txt" 2>/dev/null || echo "[WARN] Geen trigger.txt gevonden"

echo "[INFO] Backup completed at $TIMESTAMP" >> "$BACKUP_DIR/backup.log"

echo "[DONE] Backup opgeslagen in $BACKUP_DIR"
