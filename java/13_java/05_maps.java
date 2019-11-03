import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.TreeMap;

class Program {
  public static void main(String[] args) {
    // Red-black tree inside, O(log n) for all operations
    // there is no ability to store insertion order
    // all items are sorted in natural order
    // Use when:
    // * natural order of keys matters
    // * data will be under intensive write/delete load
    TreeMap<String, Double> tmItems = new TreeMap<>();
    tmItems.put("Potato", 5.0);
    tmItems.put("Carrot", 1.0);
    tmItems.put("Onion", 1.0);

    System.out.println(tmItems.get("Onion"));
    System.out.println(tmItems.get("Tomatos"));

    // Hash table inside, amortized O(1) for all operations
    // resize costs grow with size of iternal array
    // there is no ability to store insertion order
    // Use when:
    // * loaded once in memory and make many reads
    // * order doesn't matter
    HashMap<String, Double> hItems = new HashMap<>();
    hItems.put("Potato", 5.0);
    hItems.put("Carrot", 1.0);
    hItems.put("Onion", 1.0);

    System.out.println(hItems.get("Onion"));
    System.out.println(hItems.get("Tomatos"));

    // Similar to hash table, but stores the order od key insertion
    // with double linked list inside
    // Can store insertion order
    // Use when:
    // * insertion order matters (also can be ordered by last access time)
    LinkedHashMap<String, Double> lhItems = new LinkedHashMap<>();
    lhItems.put("Potato", 5.0);
    lhItems.put("Carrot", 1.0);
    lhItems.put("Onion", 1.0);

    System.out.println(lhItems.get("Onion"));
    System.out.println(lhItems.get("Tomatos"));
  }
}
