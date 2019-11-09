import java.lang.Thread;
import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;
import java.util.Random;

class Program {
  // These philosophers got a thread lock
  public static class DummyPhilosopherThread extends Thread {
    protected int number;
    protected int[] sticks;
    protected boolean left = false;
    protected boolean right = false;
    protected boolean wantToEat = false;
    protected int leftStick;
    protected int rightStick;
    protected Random rand = new Random();

    public DummyPhilosopherThread(int number, int[] sticks) {
      this.number = number;
      this.sticks = sticks;
      this.leftStick = number == 0 ? sticks.length - 1 : number - 1;
      this.rightStick = (number + 1) % sticks.length;
      // System.out.println(number + " left stick " + leftStick + " right stick " + rightStick);
    }

    public int totalIterations() {
      return 5000;
    }

    public void run() {
      try {
        for (int i = 0; i < totalIterations(); i++) {
          if (wantToEat == true) {
            if (right) {
              eat();
              releaseRight();
              releaseLeft();
              this.wantToEat = false;
            } else if (left) {
              acquireRight();
            } else {
              acquireLeft();
            }
          }

          if (rand.nextBoolean()) {
            this.wantToEat = true;
          }

          // synchronized(this.sticks) {
          //   System.out.println("Sticks: " + Arrays.toString(this.sticks));
          // }

          Thread.sleep(1);
        }

        System.out.println(number + " done!");
      } catch (InterruptedException exc) {
        System.out.println(number + ": interrupted.");
        System.out.println(exc);
      }
    }

    public void eat() throws InterruptedException {
      Thread.sleep(1);
      System.out.println(number + " had a meal");
    }

    public void acquireLeft() {
      synchronized(this.sticks) {
        if (this.sticks[leftStick] == -1) {
          this.sticks[leftStick] = number;
          this.left = true;
        }
      }
    }

    public void acquireRight() {
      synchronized(this.sticks) {
        if (this.sticks[rightStick] == -1) {
          this.sticks[rightStick] = number;
          this.right = true;
        }
      }
    }

    public void releaseLeft() {
      synchronized(this.sticks) {
        this.sticks[leftStick] = -1;
        this.left = false;
      }
    }

    public void releaseRight() {
      synchronized(this.sticks) {
        this.sticks[rightStick] = -1;
        this.right = false;
      }
    }
  }

  public static class SmartPhilosopherThread extends DummyPhilosopherThread {
    private int leftNeighborLeftStick;

    public SmartPhilosopherThread(int number, int[] sticks) {
      super(number, sticks);
      this.leftNeighborLeftStick = leftStick == 0 ? sticks.length - 1 : leftStick - 1;
      // System.out.println(number + " leftNeighborLeftStick " + leftNeighborLeftStick);
    }

    public void acquireLeft() {
      // System.out.println("Overriden acquireLeft");
      synchronized(this.sticks) {
        if (this.sticks[leftNeighborLeftStick] == -1) {
          if (this.sticks[leftStick] == -1) {
            this.sticks[leftStick] = number;
            this.left = true;
          }
        }
      }
    }

    public void acquireRight() {
      synchronized(this.sticks) {
        if (this.sticks[rightStick] == -1) {
          this.sticks[rightStick] = number;
          this.right = true;
        } else {
          releaseLeft();
        }
      }
    }
  }

  public static <T> void test(Class<T> className) {
    try {
      // Order of men and sticks: [stick4] man1 stick1 man2 stick2 man3 stick3 man4 stick4
      int[] sticks = new int[] { -1, -1, -1, -1 };

      System.out.println(className + " strategy");

      Thread[] threads = new Thread[sticks.length];
      for (int i = 0; i < sticks.length; i++) {
        Thread thread = (Thread)className.getDeclaredConstructor(int.class, int[].class).newInstance(i, sticks);
        thread.start();
        threads[i] = thread;
      }

      for (Thread thread : threads) {
        thread.join();
      }
    } catch (InterruptedException e) {
      e.printStackTrace();
    } catch (InvocationTargetException e) {
      e.printStackTrace();
    } catch (IllegalAccessException e) {
      e.printStackTrace();
    } catch (InstantiationException e) {
      e.printStackTrace();
    } catch (NoSuchMethodException e) {
      e.printStackTrace();
    }
  }

  public static void main(String[] args) {
    test(DummyPhilosopherThread.class);
    test(SmartPhilosopherThread.class);

    // int[] sticks = new int[] { -1, -1, -1, -1 };

    // // Order of men and sticks: [stick4] man1 stick1 man2 stick2 man3 stick3 man4 stick4

    // for (int i = 0; i < sticks.length; i++) {
    //   DummyPhilosopherThread thread = new DummyPhilosopherThread(i, sticks);
    //   thread.start();
    // }
  }
}
