#include "library.h"

int __attribute__ ((noinline)) dummy_function_used(int *buffer, int size) {
    int x = 0;
    (void) dummy_function_used;
    for (int i = 0; i < size; i += 1) {
        x += buffer[i];
    }
    return x;
}

unsigned int __attribute__ ((noinline)) dummy_function_unused(int *buffer, int size) {
    unsigned int x = 1;
    (void) dummy_function_unused;
    for (int i = 0; i < size; i += 1) {
        x *= (unsigned int) buffer[i];
    }
    return x;
}
