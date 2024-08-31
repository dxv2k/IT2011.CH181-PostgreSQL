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

BASE_BACKUP_FILE="$BACKUP_DIR/base_backup_$DATE"
WAL_ARCHIVE_DIR="$BACKUP_DIR/wal_archive"

# Create backup and WAL archive directories if they don't exist
mkdir -p $BACKUP_DIR
mkdir -p $WAL_ARCHIVE_DIR

# Perform the base backup
pg_basebackup -U "$POSTGRES_USER" -D "$BASE_BACKUP_FILE" -F tar -z -X stream

echo "Base backup completed: $BASE_BACKUP_FILE"

# Archive the current WAL files
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT pg_switch_wal();"
rsync -a --remove-source-files /var/lib/postgresql/data/pg_wal/* $WAL_ARCHIVE_DIR

echo "WAL files archived to: $WAL_ARCHIVE_DIR"
