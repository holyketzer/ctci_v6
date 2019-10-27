#include <iostream>

void reverse(char *str) {
  char* l = str;
  char* r = str + strlen(str) - 1;

  while (l > r) {
    char tmp = *l;
    *l = *r;
    *r = tmp;

    l++;
    r--;
  }
}

int main (int argc, char *argv[]) {
  char str1[] = "abcdefg";
  reverse(str1);
  std::cout << str1 << std::endl;

  char str2[] = "Mama  Roma";
  reverse(str2);
  std::cout << str2 << std::endl;
}
