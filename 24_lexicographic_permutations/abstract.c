#include <stdio.h>
#include <stdbool.h>

#define N 10

// Function to swap two elements
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Function to reverse the elements of an array from index start to end
void reverse(int arr[], int start, int end) {
    while (start < end) {
        swap(&arr[start], &arr[end]);
        start++;
        end--;
    }
}

// Function to find the next lexicographical permutation
bool next_permutation(int arr[], int n) {
    // Step 1: Find the largest index k such that arr[k] < arr[k + 1]
    int k = n - 2;
    while (k >= 0 && arr[k] >= arr[k + 1]) {
        k--;
    }
    
    // If no such index exists, the permutation is the last one
    // if (k < 0) {
    //     return false; // No next permutation
    // }

    // Step 2: Find the largest index l greater than k such that arr[k] < arr[l]
    int l = n - 1;
    while (arr[k] >= arr[l]) {
        l--;
    }

    // Step 3: Swap arr[k] with arr[l]
    swap(&arr[k], &arr[l]);

    // Step 4: Reverse the sequence from arr[k + 1] to the end
    reverse(arr, k + 1, n - 1);

    // return true; // Next permutation exists
}

int main() {
    // Initialize the array with the first permutation
    int arr[N] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

    // Print the first 10 lexicographical permutations
    for (int i = 0; i < 1000000; i++) {
        // Print the current permutation
        for (int j = 0; j < N; j++) {
            printf("%d", arr[j]);
        }
        printf("\n");

        // Generate the next permutation
        if (!next_permutation(arr, N)) {
            break; // No more permutations
        }
    }

    return 0;
}