#include <stdio.h>
#include <stdbool.h>

#define N 10

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void reverse(int arr[], int start, int end) {
    while (start < end) {
        swap(&arr[start], &arr[end]);
        ++start;
        --end;
    }
}

void next_permutation(int arr[], int n) {
    int k = n - 2;
    while (arr[k] >= arr[k + 1]) {
        --k;
    }

    int l = n - 1;
    while (arr[k] >= arr[l]) {
        --l;
    }

    swap(&arr[k], &arr[l]);
    reverse(arr, k + 1, n - 1);
}

int main() {
    int arr[N] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

    for (int i = 0; i < 1000000; ++i) {
        next_permutation(arr, N);
    }

    for (int i = 0; i < 10; ++i) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    return 0;
}
