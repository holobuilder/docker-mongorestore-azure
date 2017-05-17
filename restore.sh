#!/bin/sh
set -e

BACKUP_NAME="${BACKUP_NAME}"

MONGO_HOST=${MONGODB_HOST:=$MONGODB_PORT_27017_TCP_ADDR}
MONGO_DB=${MONGODB_DB}


BACKUP_FILE="/tmp/$BACKUP_NAME.tgz"
BACKUP_FOLDER="/tmp/$BACKUP_NAME/"

restore_backup() {

  tar -zxvf $BACKUP_FILE -C /tmp/

  /mongorestore -h $MONGO_HOST $BACKUP_FOLDER

}

AZURE_CONTAINER=${AZURE_CONTAINER}
AZURE_STORAGE_ACCOUNT=${AZURE_STORAGE_ACCOUNT}
AZURE_STORAGE_KEY=${AZURE_STORAGE_KEY}

download_backup() {

  # Download from cloud storage
  azure telemetry --disable
  azure storage blob download -q -c "DefaultEndpointsProtocol=https;BlobEndpoint=https://$AZURE_STORAGE_ACCOUNT.blob.core.windows.net/;AccountName=$AZURE_STORAGE_ACCOUNT;AccountKey=$AZURE_STORAGE_KEY" $AZURE_CONTAINER $BACKUP_NAME.tgz /tmp/

}

download_backup
restore_backup
