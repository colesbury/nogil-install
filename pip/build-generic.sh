preinstall_file=${preinstall_file:-}

docker run \
    -e package="$package" \
    -e version="$version" \
    -e yum_packages="$yum_packages" \
    -e preinstall_file="$preinstall_file" \
    -e github_branch="$github_branch" \
    -v `pwd`:/io nogil/manylinux2014_x86_64 \
    /io/build-generic-wheel.sh

filename=$(echo "$package" | tr '-' '_')
./upload_wheel.sh wheelhouse/$filename-$version-nogil39-nogil_39*_x86_64_linux_gnu-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
