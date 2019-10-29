// Virtual table: function name to function implementation
// Pointer points to object, objects contains vptr pointing to vtable
// Resolving in runtime (overhead)
// destructor can be virtual
// constructor can't be because there is no vptr at a constructing step
// to call constructor we need exact type there is no need in virtuality, and it calls base class constructor by design
