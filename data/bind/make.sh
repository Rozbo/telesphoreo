pkg:extract
cd *
pkg:configure --with-randomdev=/dev/random BUILD_CC=gcc
make
pkg:install
