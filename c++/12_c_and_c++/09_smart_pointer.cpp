// TODO: actually it's stupid pointer
#include <iostream>

class Node {
  int value;
  Node *left;
  Node *right;

  public:

  Node(int v) {
    value = v;
    left = NULL;
    right = NULL;
  }
};

template<class T> class SmartPointer {
  T* p;
  int counter;

  public:

  SmartPointer(T* tp) {
    p = tp;
  }

  T* get() {
    if (p) {
      counter++;
      return p;
    } else {
      return NULL;
    }
  }

  void release() {
    if (counter > 0) {
      counter--;
    }

    if (counter == 0) {
      delete p;
      p = NULL;
    }
  }

  void inspect() {
    std::cout << "Pointer: " << p << " Reference count: " << counter << std::endl;
  }
};

int main (int argc, char *argv[]) {
  SmartPointer<Node> pointer(new Node(1));
  pointer.inspect();

  pointer.get();
  pointer.get();
  pointer.inspect();

  pointer.release();
  pointer.release();
  pointer.inspect();
}
