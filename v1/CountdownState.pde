
public class CountdownState implements State {

  @Override
  public void display() {
    background(200);
      text(textoCuentaAtrasEmpezarGrabacion, width/2, height/2);
      cuentaAtrasEmpezarGrabacion(); 

  }

}
