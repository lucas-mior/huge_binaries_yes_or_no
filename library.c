int __attribute__ ((noinline)) dummy_function1(int *buffer, int size) {
    int x;
    for (int i = 0; i < size; i += 1) {
        x += buffer[i];
    }
    return x;
}

unsigned int __attribute__ ((noinline)) dummy_function2(int *buffer, int size) {
    unsigned int x = 1;
    for (int i = 0; i < size; i += 1) {
        x *= buffer[i];
    }
    return x;
}
