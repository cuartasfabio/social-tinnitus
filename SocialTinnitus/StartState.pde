
public class StartState implements State {

  int t1 = 0;
  int t2 = 0;
  int alphaText = 0;
  int alphaBackground = 100;
  
  
  boolean start = true;

  @Override 
    public void display() {
    background(0);
    fill(255);
    
    if (t1 == 0) {
      t1 = millis();
    }else {
      t2 = millis();
      
      if (t2 - t1 >= 8000 && start) {
        empezarAudios();  
        start = false;
      } else if (t2 - t1 >= 16000) {
        pararAudios();
        currentState = new IdleState();
      } else if (t2 - t1 < 4000) {
        textFont(font, 128);
        textAlign(CENTER);
        fill(255, alphaText);
        alphaText += 2;
        text("Social Tinnitus",width/2,height/2);
        textSize(32);
        text("By Luis Lomba Martínez",width/2,height/2+64);
        text("and Fabio Cuartas Puente",width/2,height/2+110);
      }else if (t2 - t1 < 8000) {
        textFont(font, 128);
        textAlign(CENTER);
        fill(255, alphaText);
        alphaText -= 2;
        text("Social Tinnitus",width/2,height/2);
        textSize(32);
        text("By Luis Lomba Martínez",width/2,height/2+64);
        text("and Fabio Cuartas Puente",width/2,height/2+110);
      }
      
    }
    if (!start) {
      displayAnalyzers();
      noStroke();
      fill(0, alphaBackground);
      rect(-10, -10, width, height);
      alphaBackground -= 2;
    }
  }
  
  
}
