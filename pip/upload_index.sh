#!/bin/bash
set -e
BUCKET=pypi.sam-gross.com

dirs=$(aws s3 ls $BUCKET | grep PRE | awk -F'PRE ' '{print $2}')

index=`mktemp index.XXXXX.html`
cat <<EOF >>$index
<!DOCTYPE html>
<html>
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