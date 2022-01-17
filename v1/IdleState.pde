public class IdleState implements State {

  @Override
  public void display() {

    background(200);
    fill(0);
    text("Presiona una tecla para empezar a grabar.", 20, 20);
    if (t1 == 0) {
      t1 = millis();
    } else {
      t2 = millis();
      if (t2 - t1 >= 8000) {
        t1 = 0;
        pararCanciones();
        empezarCanciones();
      }
    }
  }
}
