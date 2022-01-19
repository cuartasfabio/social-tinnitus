import ddf.minim.AudioSample;
public class CountdownState implements State {

  String textoCuentaAtrasEmpezarGrabacion = "";
  int segsCuentaAtrasEmpezarGrabacion = 3;  // Cuenta atrás para grabar
  int timerCAEG = segsCuentaAtrasEmpezarGrabacion;
  AudioSample beep = minim.loadSample("beep.mp3");
  
  @Override
    public void display() {
    background(50);
    displayAnalyzers();
    fill(255);
    text(textoCuentaAtrasEmpezarGrabacion, width/2, height/2);
    cuentaAtrasEmpezarGrabacion();
  }
  
  void cuentaAtrasEmpezarGrabacion() {
    textoCuentaAtrasEmpezarGrabacion = str(timerCAEG);
    if (frameCount % 60 == 0 && timerCAEG > 0) {
      timerCAEG --;
    }
    if (timerCAEG == 0) {
      println("Empeisa grabar.");
      timerCAEG = segsCuentaAtrasEmpezarGrabacion;
      
      recorder = minim.createRecorder(in, "c"+ audios.size() +".wav"); // crea el nuevo archivo para el audio
      recorder.beginRecord();  // empieza a grabar
      
      beep.trigger();
      currentState = new RecordingState();
    }
  }
}
