import java.util.Arrays;
import java.util.List;

class Program {
  static class Country {
    String name;
    String continent;
    long population;

    public Country(String name, String continent, long population) {
      this.name = name;
      this.continent = continent;
      this.population = population;
    }

    public String getName() {
      return name;
    }

    public String getContinent() {
      return continent;
    }

    public long getPopulation() {
      return population;
    }

    public String toString() {
      return name + " [" + continent + "] = " + population;
    }
  }

  static long getPopulation(List<Country> countries, String continent) {
    return countries.stream()
      .filter(c -> c.getContinent() == continent)
      .map(c -> c.getPopulation())
      .reduce((long)0, Long::sum);
  }

  public static void main(String[] args) {
    List<Country> countries = Arrays.asList(
      new Country("China", "Eurasia", 1399840000),
      new Country("India", "Eurasia", 1354350000),
      new Country("United States", "Noth America", 330178000),
      new Country("Indonesia", "Eurasia", 266911900),
      new Country("Brazil", "South America", 210669000),
      new Country("Pakistan", "Eurasia", 206558000),
      new Country("Nigeria", "Africa", 200963599),
      new Country("Bangladesh", "Eurasia", 167522000),
      new Country("Russia", "Eurasia", 146793744),
      new Country("Mexico", "South America", 126577691),
      new Country("Japan", "Eurasia", 126140000),
      new Country("Philippines", "Eurasia", 108471000),
      new Country("Egypt", "Africa", 99528400),
      new Country("Ethiopia", "Africa", 98665000),
      new Country("Vietnam", "Eurasia", 96208984),
      new Country("Democratic Republic of the Congo", "Africa", 86790567),
      new Country("Germany", "Eurasia", 83073100),
      new Country("Iran", "Eurasia", 82919100),
      new Country("Turkey", "Eurasia", 82003882),
      new Country("France", "Eurasia", 67069000)
    );

    System.out.println("Eurasia population:       " + getPopulation(countries, "Eurasia"));
    System.out.println("Africa population:         " + getPopulation(countries, "Africa"));
    System.out.println("South America population:  " + getPopulation(countries, "South America"));
  }
}
