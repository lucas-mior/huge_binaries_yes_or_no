#!/bin/sh

echo "Does gcc produce huge binaries with static linking?"

CFLAGS="-flto -O2 "
CC=clang
set -x

$CC library.c -shared -fPIC $CFLAGS -o libdynamic.so
$CC library.c -c            $CFLAGS -o object.o
ar rcs libstatic.a object.o

$CC main.c -o main_dynamic.exe $CFLAGS -L. -ldynamic
$CC main.c -o main_static.exe  $CFLAGS -L. -lstatic
$CC main.c -o main_object.exe  $CFLAGS      object.o

export LD_LIBRARY_PATH=.
set +x
./main_dynamic.exe
./main_object.exe
./main_static.exe
