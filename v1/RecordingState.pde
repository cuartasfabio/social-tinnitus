
public class RecordingState implements State {

  @Override
  public void display() {
    background(255, 0, 0);
      text("¡Grabando!", 20, 20);
      text(textoCuentaAtrasGrabando, width/2, height/2);
      cuentaAtrasGrabando(); 

  }

}
