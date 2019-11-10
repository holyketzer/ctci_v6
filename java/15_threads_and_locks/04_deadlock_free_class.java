import java.util.concurrent.locks.ReentrantLock;

class Program {
  static class DeadlockFreeLock {
    private ReentrantLock lock;
    private Object lockedBy;

    public DeadlockFreeLock() {
      this.lock = new ReentrantLock();
      this.lockedBy = null;
    }

    public boolean lock(Object user) {
      synchronized(this) {
        if (this.lockedBy == null) {
          this.lockedBy = user;
          lock.lock();
          return true;
        } else {
          return false;
        }
      }
    }

    public boolean unlock(Object user) {
      synchronized(this) {
        if (this.lockedBy == user) {
          lock.unlock();
          this.lockedBy = null;
          return true;
        } else {
          return false;
        }
      }
    }
  }

  static class Client {
    private DeadlockFreeLock lock;

    public Client(DeadlockFreeLock lock) {
      this.lock = lock;
    }

    public boolean lock() {
      return lock.lock(this);
    }

    public boolean unlock() {
      return lock.unlock(this);
    }
  }

  public static void main(String[] args) {
    DeadlockFreeLock lock = new DeadlockFreeLock();

    Client client1 = new Client(lock);
    Client client2 = new Client(lock);

    System.out.println("client1.lock = " + client1.lock());
    System.out.println("client2.lock = " + client2.lock());

    System.out.println("client2.unlock = " + client2.unlock());
    System.out.println("client1.unlock = " + client1.unlock());

    System.out.println("client2.lock = " + client2.lock());
    System.out.println("client2.unlock = " + client2.unlock());
  }
}
