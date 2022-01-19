public class IdleState implements State {

  int t1 = 0;
  int t2 = 0;
  int t3 = 0;
  int t4 = 0;
  Boton boton = new Boton(width/2,height - 150,80);

  @Override
    public void display() {

    background(0);
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
    if (t3 == 0) {
      t3 = millis();
    } else {
      t4 = millis();
      if (t4 - t3 >= 3600000){
        checkAudios();
        t3 = 0;
      }
    }
    displayAnalyzers();
    boton.display();
  }
}
