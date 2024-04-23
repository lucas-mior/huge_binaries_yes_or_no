#!/bin/sh

echo "Does your compiler produce huge binaries with static linking?"

CFLAGS="$CFLAGS -flto -O2 -Wall -Wextra"
CC=clang
if [ $CC = "clang" ]; then
    CFLAGS="$CFLAGS -Weverything -Wno-unsafe-buffer-usage"
fi
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

echo "Compare the executable sizes:"
set -x
du -ba --apparent-size *.exe
objdump -D main_static.exe > main_static.asm

if grep -q "dummy_function_unused" main_static.asm; then
    set +x
    printf "$RED"
    echo "Unused function is in final binary. Static linking is bad!"
    printf "$RESET"
else
    set +x
    printf "$RED"
    echo "Unused function is gone. Static linking rocks!"
    printf "$RESET"
fi
