#!/bin/bash

function write_file {
  TARGET_FILENAME=$1
  EXISTING_FILENAME=$2
  DATA=$3

  if [ -z "$EXISTING_FILENAME" ]; then
    if [ -z "$DATA" ]; then
      echo "Error: No filename or data provided"
      exit 1
    fi
    echo "$DATA" > $TARGET_FILENAME
  elif [ -e "$EXISTING_FILENAME" ]; then
    cp $EXISTING_FILENAME $TARGET_FILENAME
  else
    echo "Error: File $EXISTING_FILENAME missing"
    exit 1
  fi
}

TARGET_CERT_FILE="/opt/etcd/server.crt"
TARGET_KEY_FILE="/opt/etcd/server.key.insecure"
ETCD_BIN="/opt/etcd/bin/etcd"

echo "Writing cert file"
write_file "$TARGET_CERT_FILE" "$CERT_FILE" "$CERT_FILE_DATA"
echo "Done"
echo "Writing key file"
write_file "$TARGET_KEY_FILE" "$KEY_FILE" "$KEY_FILE_DATA"

DISCOVERY_ARGS=""
if [ -n "$DISCOVERY_URL" ]; then
  DISCOVERY_ARGS="--discovery $DISCOVERY_URL"
fi

$ETCD_BIN -f -name $HOSTNAME $DISCOVERY_ARGS -cert-file=$TARGET_CERT_FILE -key-file=$TARGET_KEY_FILE

