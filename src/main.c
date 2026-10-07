#include <stdio.h>
#include <stdlib.h>

#include "example.h"

int main(int argc, char const* argv[]) {
    (void)argc;
    (void)argv;

    echo("Hello World");

    char* ptr = malloc(1);
    (void)ptr;

    return EXIT_SUCCESS;
}
