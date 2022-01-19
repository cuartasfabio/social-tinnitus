
boolean circleOver = false;

public class Boton {

  int circleX, circleY;  // Position of button
  int circleSize, innercircleSize;   // Diameter of circle
  color circleColor1, circleColor2;
  color circleHighlight;
  color currentColor;
  

  public Boton(int posX, int posY, int diameter) {
    this.circleX = posX;
    this.circleY = posY;
    this.circleSize = diameter;
    this.innercircleSize = diameter/2;
    
    this.circleColor1 = color(255);
    this.circleColor2 = color(255,0,0);
    this.circleHighlight = color(204);
    
    ellipseMode(CENTER);
  }

  void display() {
    update();
    
    if (circleOver) {
      fill(circleHighlight);
    } else {
      fill(circleColor1);
    }
    noStroke();
    ellipse(circleX, circleY, circleSize, circleSize);
    fill(circleColor2);
    ellipse(circleX, circleY, innercircleSize, innercircleSize);
  }
  
  void update() {
    if ( overCircle(circleX, circleY, circleSize) ) {
      circleOver = true;
    } else {
      circleOver = false;
    }
  }  
  
  boolean overCircle(int x, int y, int diameter) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
      return true;
    } else {
      return false;
    }
  }
}

void mousePressed() {
  if (circleOver) {
    circleOver = false;
    pararAudios();
    currentState = new CountdownState();
  }
}
