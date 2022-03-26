#!/bin/sh

echo "Dumping database ...\n"
pg_dump -f people-dump -h localhost -U postgres people
echo "Compressing data file ...\n"
gzip people-dump
