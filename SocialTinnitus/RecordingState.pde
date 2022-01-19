
public class RecordingState implements State {

  String textoCuentaAtrasGrabando = "";
  int segsCuentaAtrasGrabando = 10; 
  int timerCAG = segsCuentaAtrasGrabando;

  @Override
    public void display() {
    background(170, 40, 40);
    textAlign(CENTER);
    text("Recording...", width/2, height/2- 50);
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
      
      recorder.save(); // almacena el archivo
      
      audios.add(new Audio("c"+audios.size()+".wav", LocalDateTime.now()));
      analyzers.add(new SoundAnalyzer(audios.get(audios.size()-1).getPlayer()));
    
      currentState = new IdleState();
    }
  }
}
