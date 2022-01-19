public class IdleState implements State {

  int t1 = 0;
  int t2 = 0;
  Boton boton = new Boton(width/2,height/2,30);

  @Override
    public void display() {

    background(200);
    fill(0);
    text("Presiona una tecla para empezar a grabar.", 20, 20);
    if (t1 == 0) {
      t1 = millis();
      empezarAudios();
    } else {
      t2 = millis();
      if (t2 - t1 >= 8000) {
        t1 = 0;
        pararAudios();
        empezarAudios();
      }
    }
    boton.display();
  }
}
