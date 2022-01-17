
public class StartState implements State {

  int t1 = 0;
  int t2 = 0;

  @Override
  public void display() {
    // TODO Auto-generated method stub

    if (t1 == 0) {
      t1 = millis();
    } else {
      t2 = millis();
      if (t2 - t1 >= 15000) {
        currentState = new IdleState();
      }
    }

  }

}
