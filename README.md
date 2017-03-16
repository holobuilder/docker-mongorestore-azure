# docker-mongorestore-azure
A docker image performing a restore operation via mongorestore from an Azure Storage Account

# Usage
Single-Shot-Run:
```
  docker run --rm \
    --link <mongodb container>:mongodb \
    -e "BACKUP_NAME=<backup name>" \
    -e "AZURE_CONTAINER=<storage container name>" \
    -e "AZURE_STORAGE_ACCOUNT=<storage account name" \
    -e "AZURE_STORAGE_KEY=<storage account key>" \
    phimar/mongorestore-azure`
```