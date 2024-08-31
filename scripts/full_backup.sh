#!/bin/bash
set -e

# Variables
DEFAULT_BACKUP_DIR="./scripts/backup"
DATE=$(date +'%Y%m%d_%H%M%S')

# Check if a backup directory is provided as an argument
if [ -z "$1" ]; then
  BACKUP_DIR=$DEFAULT_BACKUP_DIR
else
  BACKUP_DIR=$1
fi

BACKUP_FILE="$BACKUP_DIR/full_backup_$DATE.sql"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Perform the backup
pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" -F c -b -v -f "$BACKUP_FILE"

echo "Backup completed: $BACKUP_FILE"

