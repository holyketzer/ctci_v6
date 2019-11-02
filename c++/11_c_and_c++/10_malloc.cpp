#include <iostream>

void* align_malloc(uint size, uint alignment) {
  uint pointer_size = sizeof(void*);
  uint pointer_offset = 0;

  if (pointer_size > alignment) {
    pointer_offset = pointer_size;
  }

  void* p = malloc(size + alignment + pointer_offset);

  uintptr_t addr = (uintptr_t)p;
  uintptr_t data_offset = (((addr + pointer_size) / alignment) + 1) * alignment;

  void* data_start = (void*)data_offset;

  std::size_t* p_ptr = (std::size_t*)data_start;
  p_ptr--;
  *p_ptr = addr;

  std::cout << "Alignment: " << alignment << " Allocated: " << p << std::endl;
  // std::cout << "Data addr: " << (uintptr_t)data_start << " p pointer: " << (uintptr_t)p_ptr << " p addr: " << (void*)*p_ptr << std::endl;

  return data_start;
}

void aligned_free(void* p) {
  std::size_t* p_ptr = (std::size_t*)p;
  p_ptr--;
  void* offset = (void*)*p_ptr;
  std::cout << "free: " << offset << std::endl;
  free(offset);
}

int main (int argc, char *argv[]) {
  for (uint i = 1; i <= 10; i++) {
    uint alignment = 1 << i;
    void *p = align_malloc(1000, alignment);
    assert((uintptr_t)p % alignment == 0);
    aligned_free(p);
  }
}
