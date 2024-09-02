#include <stdio.h>
#include "test_h.h"

int
test2(int a, int b){
    return 2;
}

int
test3(void) {
    return 0;
}

int main() {
    int a = test2(2, 3);
    printf("Test2 %d", test2(1, 2));
    printf("Test %d", test3());
    printf("Test %d", test_f());
}
