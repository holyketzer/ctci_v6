import java.lang.Thread;
import java.util.ArrayDeque;

// With Go channels it should be much more pretty
class Program {
  public static class FirstThread extends Thread {
    private FizzBuzzData data;

    public FirstThread(FizzBuzzData data) {
      this.data = data;
    }

    public void run() {
      while (true) {
        Integer number = data.pullNumberForFizzCheck();

        if (number == null) {
          break;
        }

        if (number % 3 == 0) {
          System.out.println("Fizz: " + number);
        } else {
          data.pushCheckedNumber(number);
        }
      }

      data.setFizzDone();
    }
  }

  public static class SecondThread extends Thread {
    private FizzBuzzData data;

    public SecondThread(FizzBuzzData data) {
      this.data = data;
    }

    public void run() {
      while (true) {
        Integer number = data.pullNumberForBuzzCheck();

        if (number == null) {
          break;
        }

        if (number % 5 == 0) {
          System.out.println("Buzz: " + number);
        } else {
          data.pushNumberForFizzCheck(number);
        }
      }

      data.setBuzzDone();
    }
  }

  public static class ThirdThread extends Thread {
    private FizzBuzzData data;

    public ThirdThread(FizzBuzzData data) {
      this.data = data;
    }

    public void run() {
      while (true) {
        Integer number = data.pullNumberForFizzBuzzCheck();

        if (number == null) {
          break;
        }

        if (number % 5 == 0 && number % 3 == 0) {
          System.out.println("FizzBuzz: " + number);
        } else {
          data.pushNumberForBuzzCheck(number);
        }
      }

      data.setFizzBuzzDone();
    }
  }

  public static class FourthThread extends Thread {
    private FizzBuzzData data;

    public FourthThread(FizzBuzzData data) {
      this.data = data;
    }

    public void run() {
      while (true) {
        Integer number = data.pullCheckedNumber();

        if (number == null) {
          break;
        }

        System.out.println(number);
      }
    }
  }

  public static class FizzBuzzData {
    private ArrayDeque<Integer> numbersForFizzBuzzCheck = new ArrayDeque<Integer>();
    private ArrayDeque<Integer> numbersForBuzzCheck = new ArrayDeque<Integer>();
    private ArrayDeque<Integer> numbersForFizzCheck = new ArrayDeque<Integer>();
    private ArrayDeque<Integer> checkedNumbers = new ArrayDeque<Integer>();

    private boolean fizzBuzzDone = false;
    private boolean buzzDone = false;
    private boolean fizzDone = false;

    public FizzBuzzData(int n) {
      synchronized(numbersForFizzBuzzCheck) {
        for (int i = 1; i <= n; i++) {
          numbersForFizzBuzzCheck.addLast(i);
        }

        System.out.println(n + " numbers in the queue");
      }
    }

    public void setFizzBuzzDone() {
      synchronized(this) {
        this.fizzBuzzDone = true;
      }
    }

    public boolean getFizzBuzzDone() {
      synchronized(this) {
        return this.fizzBuzzDone;
      }
    }

    public void setFizzDone() {
      synchronized(this) {
        this.fizzDone = true;
      }
    }

    public boolean getFizzDone() {
      synchronized(this) {
        return this.fizzDone;
      }
    }

    public void setBuzzDone() {
      synchronized(this) {
        this.buzzDone = true;
      }
    }

    public boolean getBuzzDone() {
      synchronized(this) {
        return this.buzzDone;
      }
    }

    public int numbersForFizzBuzzCheckSize() {
      synchronized(numbersForFizzBuzzCheck) {
        return numbersForFizzBuzzCheck.size();
      }
    }

    public Integer pullNumberForFizzBuzzCheck() {
      while (numbersForFizzBuzzCheckSize() > 0) {
        synchronized(numbersForFizzBuzzCheck) {
          Integer res = numbersForFizzBuzzCheck.pollFirst();

          if (res != null) {
            return res;
          }
        }
      }

      return null;
    }

    public void pushNumberForBuzzCheck(int n) {
      synchronized(numbersForBuzzCheck) {
        numbersForBuzzCheck.addLast(n);
      }
    }

    public int numbersForBuzzCheckSize() {
      synchronized(numbersForBuzzCheck) {
        return numbersForBuzzCheck.size();
      }
    }

    public Integer pullNumberForBuzzCheck() {
      while (getFizzBuzzDone() == false || numbersForBuzzCheckSize() > 0) {
        synchronized(numbersForBuzzCheck) {
          Integer res = numbersForBuzzCheck.pollFirst();

          if (res != null) {
            return res;
          }
        }
      }

      return null;
    }

    public void pushNumberForFizzCheck(int n) {
      synchronized(numbersForFizzCheck) {
        numbersForFizzCheck.addLast(n);
      }
    }

    public int numbersForFizzCheckSize() {
      synchronized(numbersForFizzCheck) {
        return numbersForFizzCheck.size();
      }
    }

    public Integer pullNumberForFizzCheck() {
      while (getBuzzDone() == false || numbersForFizzCheckSize() > 0) {
        synchronized(numbersForFizzCheck) {
          Integer res = numbersForFizzCheck.pollFirst();

          if (res != null) {
            return res;
          }
        }
      }

      return null;
    }

    public void pushCheckedNumber(int n) {
      synchronized(checkedNumbers) {
        checkedNumbers.addLast(n);
      }
    }

    public int checkedNumbersSize() {
      synchronized(checkedNumbers) {
        return checkedNumbers.size();
      }
    }

    public Integer pullCheckedNumber() {
      while (getFizzDone() == false || checkedNumbersSize() > 0) {
        synchronized(checkedNumbers) {
          Integer res = checkedNumbers.pollFirst();

          if (res != null) {
            return res;
          }
        }
      }

      return null;
    }
  }

  public static void main(String[] args) {
    try {
      FizzBuzzData data = new FizzBuzzData(1000);

      FirstThread thread1 = new FirstThread(data);
      SecondThread thread2 = new SecondThread(data);
      ThirdThread thread3 = new ThirdThread(data);
      FourthThread thread4 = new FourthThread(data);

      thread1.start();
      thread2.start();
      thread3.start();
      thread4.start();

      thread1.join();
      thread2.join();
      thread3.join();
      thread4.join();
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
  }
}
