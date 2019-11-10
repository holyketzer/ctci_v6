import java.lang.Thread;

class Program {
  public static class FooThread extends Thread {
    private int step;
    private Foo foo;

    public FooThread(Foo foo, int step) {
      this.step = step;
      this.foo = foo;
    }

    public void run() {
      if (step == 1) {
        foo.first();
      } else if (step == 2) {
        foo.second();
      } else if (step == 3) {
        foo.third();
      } else {
        System.out.println("Unexpexted step " + step);
      }
    }
  }

  static class Foo {
    private int step = 1;

    public Foo() {
    }

    public void first() {
      waitStep(1);
      doSomeJob(1);
    }

    public void second() {
      waitStep(2);
      doSomeJob(2);
    }

    public void third() {
      waitStep(3);
      doSomeJob(3);
    }

    private void waitStep(int n) {
      try {
        while (true) {
          synchronized(this) {
            if (step == n) {
              return;
            }
          }
          Thread.sleep(1);
        }
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }

    private void doSomeJob(int step) {
      try {
        Thread.sleep(1000);

        synchronized(this) {
          this.step = step + 1;
        }

        System.out.println("Step " + step + " done");
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }
  }

  public static void main(String[] args) {
    Foo foo = new Foo();
    FooThread thread1 = new FooThread(foo, 1);
    FooThread thread2 = new FooThread(foo, 2);
    FooThread thread3 = new FooThread(foo, 3);

    thread1.start();
    thread2.start();
    thread3.start();
  }
}
