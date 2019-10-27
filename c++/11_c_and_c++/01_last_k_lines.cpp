#include <iostream>
#include <fstream>
#include <stdlib.h> // atoi
#include <queue>

void tail(char* fileName, int n) {
  std::ifstream f(fileName);
  std::queue<std::streampos> lastLineOffsets;

  if (f.is_open()) {
    for (std::string line; getline(f, line); ) {
      lastLineOffsets.push(f.tellg());

      if (lastLineOffsets.size() > n) {
        lastLineOffsets.pop();
      }
    }

    if (lastLineOffsets.size() > 0) {
      f.clear();
      f.seekg(lastLineOffsets.front(), f.beg);

      for (std::string line; getline(f, line); ) {
        std::cout << line << std::endl;
      }
    }

    f.close();
  } else {
    std::cout << "Unable to open file: " << fileName << std::endl;
  }
}

int main (int argc, char *argv[]) {
  tail(argv[1], atoi(argv[2]));
}
