class BinaryHeap(object):
  def __init__(self, data = []):
    # Avoid source data modifying
    self.data = list(data)
    self.heap_size = len(data)
    self.build_heap()

  def add(self, v):
    self.data.append(v)
    self.heap_size += 1
    self.heap_increase_key(self.heap_size - 1, v)

  def build_heap(self):
    for i in range(self.heap_size / 2, -1, -1):
      self.heapify(i)

  # Order from top to down
  def heapify(self, i):
    l = 2 * i
    r = 2 * i + 1

    largest = i

    if l < len(self.data) and self.data[l] > self.data[largest]:
      largest = l

    if r < len(self.data) and self.data[r] > self.data[largest]:
      largest = r

    if i != largest:
      self.swap(i, largest)
      self.heapify(largest)

  def swap(self, i, j):
    tmp = self.data[i]
    self.data[i] = self.data[j]
    self.data[j] = tmp

  def __str__(self):
    return '(' + ' '.join((str(v) for v in self.data[0:self.heap_size])) + ')'

  # Order from down to top
  def heap_increase_key(self, i, key):
    self.data[i] = key

    while i > 0:
      parent = (i + 1) / 2 - 1

      if self.data[i] > self.data[parent]:
        self.swap(i, parent)
        i = parent
      else:
        break

  def pop_max(self):
    if self.heap_size == 0:
      return None

    top = self.data[0]

    self.data[0] = self.data[self.heap_size - 1]
    self.heap_size -= 1
    self.heapify(0)

    return top

print BinaryHeap()

h = BinaryHeap([1, 2, 3, 4, 5, 6, 7, 8])

h.add(5.5)
print h

print h.pop_max()
print h
