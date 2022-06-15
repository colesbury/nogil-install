MY_DIR=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIR/build-common.sh

preinstall_file=${preinstall_file:-}

docker run \
    -e package="$package" \
    -e version="$version" \
    -e yum_packages="$yum_packages" \
    -e preinstall_file="$preinstall_file" \
    -e url="$url" \
    -e preinstall_script="$preinstall_script" \
    -e postinstall_script="$postinstall_script" \
    -e pip_packages="$pip_packages" \
    -v `pwd`:/io nogil/manylinux2014_x86_64 \
    /io/build-generic-wheel.sh

filename=$(echo "$package" | tr '-' '_')
wheel="wheelhouse/$filename-$version-$SOABI-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
if [[ ! -f "$wheel" ]]; then
    alt=$(find wheelhouse -name "$filename-$version-*py3-none-any.whl")
    if [[ -f "$alt" ]]; then
        wheel="$alt"
    fi
fi
if [[ ! -f "$wheel" ]]; then
    echo "wheel not found! (expected: $wheel)"
    exit 1
fi
sdist="wheelhouse/$package-$version.tar.gz"
if [[ -f "$sdist" ]]; then
    ./upload_wheel.sh "$wheel" "$sdist"
else
    ./upload_wheel.sh "$wheel"
fi
