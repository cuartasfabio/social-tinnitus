
public class StartState implements State {

  int t1 = 0;
  int t2 = 0;
  
  boolean start = true;

  @Override
    public void display() {
    // TODO Auto-generated method stub
    background(200);
    fill(0);
    text("Estado de inicio", 20, 20);
    if (t1 == 0) {
      t1 = millis();
    }
    else {
      t2 = millis();
      if (t2 - t1 >= 7000 && start){
        empezarAudios();  
        start = false;
      }
      else if (t2 - t1 >= 15000) {
        pararAudios();
        currentState = new IdleState();
      }
    }
  }
}
