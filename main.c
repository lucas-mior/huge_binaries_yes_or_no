#include <stdio.h>
#include <stdlib.h>

#include "library.h"

#define LENGTH(X) (int) (sizeof (X) / sizeof (*X)) 

int main(int argc, char **argv) {
    int buffer[1000];
    int x;

    (void) argc;

    for (int i = 0; i < LENGTH(buffer); i += 1) {
        buffer[i] = i;
    }

    x = dummy_function_used(buffer, LENGTH(buffer));
    printf("Result(%s) = %d\n", argv[0], x);

    exit(0);
}
