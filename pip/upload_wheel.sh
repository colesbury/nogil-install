#!/bin/bash
set -exou pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

wheel="$1"
filename=$(basename $wheel)
BUCKET=pypi.sam-gross.com

aws s3 cp "$wheel" "s3://$BUCKET/$filename"
