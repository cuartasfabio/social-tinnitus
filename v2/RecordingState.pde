
public class RecordingState implements State {

  String textoCuentaAtrasGrabando = "";
  int segsCuentaAtrasGrabando = 10; 
  int timerCAG = segsCuentaAtrasGrabando;

  @Override
    public void display() {
    background(255, 0, 0);
    text("¡Grabando!", 20, 20);
    text(textoCuentaAtrasGrabando, width/2, height/2);
    cuentaAtrasGrabando(); 
  }
  
  void cuentaAtrasGrabando() {
    textoCuentaAtrasGrabando = str(timerCAG);
    if (frameCount % 60 == 0 && timerCAG > 0) { // si el framecount es divisible por 60, ha pasado un seg
      timerCAG --;
      //metronomoSonido.play(); // reproduce el sonido del metrónomo
    }
    if (timerCAG == 0) {
      timerCAG = segsCuentaAtrasGrabando;
      
      recorder.endRecord();  // para la grabación
      
      background(0, 255, 0);
      text("Grabación terminada. Presiona una tecla para reproducir y guardar.", 20, 20);
      
      recorder.save(); // almacena el archivo
      
      audios.add(new Audio("c"+audios.size()+".wav", LocalDateTime.now()));
    
      currentState = new IdleState();
    }
  }
}
