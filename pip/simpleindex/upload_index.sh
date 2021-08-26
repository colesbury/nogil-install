#!/bin/bash
set -e
BUCKET=pypi.sam-gross.com

for filename in `find * -name '*.html'`; do
  aws s3 cp "$filename" s3://$BUCKET/$filename
done
