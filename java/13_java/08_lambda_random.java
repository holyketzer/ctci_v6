import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

class Program {
  static List<Integer> getRandomSubset(List<Integer> list) {
    List<Integer> result = new ArrayList<>();
    Random rand = new Random();

    for (Integer value : list) {
      // Each item with 50% probability will be in the result set
      if (rand.nextDouble() < 0.5) {
        result.add(value);
      }
    }

    return result;
  }

  public static void main(String[] args) {
    List<Integer> list = Arrays.asList(1, 2, 3, 4, 5);

    System.out.println(getRandomSubset(list));
  }
}
