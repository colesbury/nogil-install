preinstall_file=${preinstall_file:-}

docker run \
    -e package="$package" \
    -e version="$version" \
    -e yum_packages="$yum_packages" \
    -e preinstall_file="$preinstall_file" \
    -e url="$url" \
    -e preinstall_script="$preinstall_script" \
    -e postinstall_script="$postinstall_script" \
    -v `pwd`:/io nogil/manylinux2014_x86_64 \
    /io/build-generic-wheel.sh

filename=$(echo "$package" | tr '-' '_')
wheel="wheelhouse/$filename-$version-nogil39-nogil_39b_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
if [[ ! -f "$wheel" ]]; then
    wheel="wheelhouse/$filename-$version-py2.py3-none-any.whl"
fi
if [[ ! -f "$wheel" ]]; then
    echo "wheel not found!"
    exit 1
fi
./upload_wheel.sh "$wheel"
