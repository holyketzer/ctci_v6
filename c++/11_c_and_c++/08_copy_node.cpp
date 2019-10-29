#include <iostream>

struct Node {
  int value;
  Node *left;
  Node *right;
};

Node *createNode(int value, Node *left = NULL, Node *right = NULL) {
  Node *node = new Node();
  node->value = value;
  node->left = left;
  node->right = right;
  return node;
}

// Time = O(n), Mem = O(log N)
Node *completeCopy(Node *node) {
  if (node) {
    Node *copy = createNode(node->value);
    copy->left = completeCopy(node->left);
    copy->right = completeCopy(node->right);
    return copy;
  } else {
    return node;
  }
}

void printNode(Node *node) {
  std::cout << " (";

  if (node->left) {
    printNode(node->left);
  }

  std::cout << node->value;

  if (node->right) {
    printNode(node->right);
  }

  std::cout << ") ";
}

int main (int argc, char *argv[]) {
  Node *ll = createNode(4);
  Node *lr = createNode(5);

  Node *left = createNode(2, ll, lr);
  Node *right = createNode(3);

  Node *root = createNode(1, left, right);


  Node *res = completeCopy(root);

  printNode(res);
  std::cout << std::endl;
}
