#!/bin/bash
set -exou pipefail

MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

wheel="$1"
filename=$(basename $wheel)
IFS=- read package the_rest <<< "$filename"

BUCKET=pypi.sam-gross.com
DISTRIBUTION_ID=E24KCXAB5NQNKG

aws s3 cp "$wheel" "s3://$BUCKET/$filename"

packages=$(aws s3 ls $BUCKET | awk '{$1=$2=$3=""; print $0}' | sed 's/^[ \t]*//' | grep $package)

index=`mktemp index.XXXXX.html`
echo "package=$package"


cat <<EOF >>$index
<!DOCTYPE html>
<html>
  <body>
EOF

for filename in $packages; do
cat <<EOF >>$index
    <a href="/$filename">$filename</a>
EOF
done

cat <<EOF >>$index
  </body>
</html>
EOF


aws s3 cp "$index" "s3://$BUCKET/$package/index.html"
rm $index

aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/$package/" "/$filename"
