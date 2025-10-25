#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# NIGHTSCOUT AUTOMATIC BACKUP
# Runs via cron daily at 3:00 AM
# ═══════════════════════════════════════════════════════════════

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

LOG_FILE="$SCRIPT_DIR/logs/backup.log"
BACKUP_DIR="$SCRIPT_DIR/mongo-backup"
MAX_BACKUPS=30  # Keep backups for the last 30 days

# Create logs directory if it doesn't exist
mkdir -p "$SCRIPT_DIR/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "════════════════════════════════════════════════════"
log "🚀 STARTING AUTOMATIC BACKUP"
log "════════════════════════════════════════════════════"

# Check if Docker is running
if ! docker-compose ps | grep -q "Up"; then
    log "❌ ERROR: Nightscout is not running!"
    exit 1
fi

# Create backup
BACKUP_NAME="nightscout_backup_$(date +%Y%m%d_%H%M%S)"
log "💾 Creating backup: $BACKUP_NAME"

# Execute mongodump
docker-compose exec -T mongo mongodump \
    --authenticationDatabase admin \
    --out "/backup/$BACKUP_NAME" >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    log "✅ Mongodump completed successfully"
else
    log "❌ ERROR: Mongodump failed!"
    exit 1
fi

# Archive
log "📦 Archiving backup..."
cd "$BACKUP_DIR"
tar -czf "${BACKUP_NAME}.tar.gz" "$BACKUP_NAME" >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    rm -rf "$BACKUP_NAME"
    BACKUP_SIZE=$(du -h "${BACKUP_NAME}.tar.gz" | cut -f1)
    log "✅ Backup created: ${BACKUP_NAME}.tar.gz (size: $BACKUP_SIZE)"
else
    log "❌ ERROR: Archiving failed!"
    exit 1
fi

cd "$SCRIPT_DIR"

# Remove old backups
log "🗑️  Removing old backups (older than $MAX_BACKUPS days)..."
DELETED=$(find "$BACKUP_DIR" -name "nightscout_backup_*.tar.gz" -mtime +$MAX_BACKUPS -delete -print | wc -l)
log "Deleted: $DELETED files"

# Check free space
FREE_SPACE=$(df -h "$BACKUP_DIR" | tail -1 | awk '{print $4}')
log "📊 Free space: $FREE_SPACE"

# Statistics
TOTAL_BACKUPS=$(ls -1 "$BACKUP_DIR"/nightscout_backup_*.tar.gz 2>/dev/null | wc -l)
TOTAL_SIZE=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
log "📈 Total backups: $TOTAL_BACKUPS (total size: $TOTAL_SIZE)"

log "════════════════════════════════════════════════════"
log "✅ BACKUP COMPLETED SUCCESSFULLY"
log "════════════════════════════════════════════════════"
log ""

# Optional: Upload backup to cloud (uncomment if needed)
# CLOUD_BACKUP_ENABLED=false
# 
# if [ "$CLOUD_BACKUP_ENABLED" = true ]; then
#     log "☁️  Uploading backup to cloud..."
#     
#     # Example for AWS S3:
#     # aws s3 cp "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" s3://your-bucket/nightscout-backups/
#     
#     # Example for Google Drive (with rclone):
#     # rclone copy "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" gdrive:nightscout-backups/
#     
#     # Example for Dropbox (with rclone):
#     # rclone copy "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" dropbox:nightscout-backups/
#     
#     if [ $? -eq 0 ]; then
#         log "✅ Backup successfully uploaded to cloud"
#     else
#         log "❌ ERROR: Failed to upload backup to cloud"
#     fi
# fi

exit 0
