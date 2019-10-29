// Hash table:
// add - O(1)
// delete - O(1)
// find - O(1)
// Implementation: hash table
// initial size can be relaively big to store several items, grows by big steps
// Rebuilding is expensive

// STL map
// add - O(log n)
// delete - O(log n)
// find - O(log n)
// Implementation: tree
// Initial size small, grows proportionally n
// No rebuilding

// If count of items is small or data structure will be under heavy modifying STL map preferable
