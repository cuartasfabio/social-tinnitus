
public class StartState implements State {

  int t1 = 0;
  int t2 = 0;

  boolean start = true;

  @Override 
    public void display() {
    background(0);
    fill(255);
    
    if (t1 == 0) {
      t1 = millis();
    }else {
      t2 = millis();
      
      if (t2 - t1 >= 5000 && start) {
        empezarAudios();  
        start = false;
      } else if (t2 - t1 >= 13000) {
        pararAudios();
        currentState = new IdleState();
      } else if (t2 - t1 < 5000) {
        textFont(font, 128);
        textAlign(CENTER);
        text("Social Tinnitus",width/2,height/2);
        textSize(32);
        text("By Luis Lomba Martínez",width/2,height/2+64);
        text("and Fabio Cuartas Puente",width/2,height/2+110);
      }
    }
    if (!start) {
      displayAnalyzers();
    }
  }
}
