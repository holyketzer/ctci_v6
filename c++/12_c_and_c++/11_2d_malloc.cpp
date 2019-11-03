#include <iostream>

int** my2DMalloc(uint rows_count, uint columns_count) {
  int** arr = (int**)malloc(rows_count * columns_count * sizeof(int) + rows_count * sizeof(int*));
  int** p = arr;
  int* data_offset = (int*)(arr + rows_count);

  // std::cout << "arr = " << (uintptr_t)arr << " int size=" << sizeof(int) << " int* size=" << sizeof(int*) << std::endl;

  for (uint i = 0; i < rows_count; i++) {
    *p = data_offset + (i * columns_count);
    // std::cout << "i = " << i << " offset: " << (uintptr_t)p << " pointer: " << (uintptr_t)(*p) << std::endl;
    p++;
  }

  return arr;
}

int main (int argc, char *argv[]) {
  uint rows_count = 10;
  uint cols_count = 5;

  int** arr = my2DMalloc(rows_count, cols_count);

  for (uint row = 0; row < rows_count; row++) {
    for (uint col = 0; col < cols_count; col++) {
      // std::cout << "row: " << row << " addr " << (uintptr_t)arr[row] << "  " << arr[row][col] << std::endl;
      arr[row][col] = (cols_count * row) + col + 1;
    }
  }

  for (uint row = 0; row < rows_count; row++) {
    for (uint col = 0; col < cols_count; col++) {
      std::cout << arr[row][col] << " ";
    }
    std::cout << std::endl;
  }

  free(arr);
}
