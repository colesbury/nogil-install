set -e

OPENSSL_VERSION="1.1.1k"

curl -O https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
tar xvf openssl-${OPENSSL_VERSION}.tar.gz
cd openssl-${OPENSSL_VERSION}
./config no-shared no-ssl2 no-ssl3 -fPIC --prefix=/openssl
make -j && make install
cd ..
export CFLAGS="-I/openssl/include"
export LDFLAGS="-L/openssl/lib"
