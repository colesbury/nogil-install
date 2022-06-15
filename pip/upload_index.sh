#!/bin/bash
set -e

BUCKET=pypi.sam-gross.com
DISTRIBUTION_ID=E24KCXAB5NQNKG

dirs=$(aws s3 ls $BUCKET | grep PRE | awk -F'PRE ' '{print $2}')

index=`mktemp index.XXXXX.html`
cat <<EOF >>$index
<!DOCTYPE html>
<html lang="en">
  <body>
EOF

for dir in $dirs; do
    if [[ $dir == .* ]]; then
        continue
    fi
cat <<EOF >>$index
    <a href="/$dir">$(basename $dir)</a>
EOF
done

cat <<EOF >>$index
  </body>
</html>
EOF

aws s3 cp "$index" "s3://$BUCKET/index.html"
rm $index

aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/"
