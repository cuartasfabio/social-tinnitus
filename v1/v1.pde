import processing.sound.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

// Ejemplo original:
//         https://p5js.org/es/examples/sound-record-save-audio.html

// Funcionamiento: 
//   1) Se presiona cualquier tecla para a grabar
//   2) Hay una cuenta atrás de segsCuentaAtrasEmpezarGrabacion segundos
//   3) Empieza la grabación del audio y se para tras segsCuentaAtrasGrabando-1 segundos
//   4) Queda a la espera de pulsar cualquier tecla para reproducir y descargar el audio
//   5) Vuelve al estado inicial (se puede volver a grabar)


Minim minim;

// Audios
ArrayList<Audio> audios;

// Player
int t1 = 0;
int t2 = 0;

// Recorder
AudioInput   in;
AudioRecorder recorder;

// Cargado y guardado de audios
ParserAudios parser;

String textoCuentaAtrasEmpezarGrabacion = "";
int segsCuentaAtrasEmpezarGrabacion = 3;  // Cuenta atrás para grabar
int timerCAEG = segsCuentaAtrasEmpezarGrabacion;

String textoCuentaAtrasGrabando = "";
int segsCuentaAtrasGrabando = 10;  // Duración de la grabación (8 segundos + 1 (empieza a grabar tarde)) Si quieres que grabe 10 segs, pon 11.
int timerCAG = segsCuentaAtrasGrabando;

int state = -1; // -1: a la espera de grabar    0: cuenta atrás para grabar    1: grabando    2: grabación terminada

int numAudios = 0; // cuenta de cuantos audios han sido grabados

SoundFile metronomoSonido; // archivo de audio para marcar el pulso

void setup() {
  size(400, 400);
  
  minim = new Minim(this);

  in = minim.getLineIn(Minim.STEREO);
  
  textFont(createFont("Arial", 12));
  
  // sonido del metrónomo
  //metronomoSonido = new SoundFile(this, "beatSound.mp3");
  
  parser = new ParserAudios();
  audios = parser.cargarAudios();
  checkAudios();
  
}

void draw() {
  
  if(state == -1) {
    
    background(200);
    fill(0);
    text("Presiona una tecla para empezar a grabar.", 20, 20);
    if (t1 == 0) {
      t1 = millis();
    } 
    else {
      t2 = millis();
      if (t2 - t1 >= 8000) {
        t1 = 0;
        pararCanciones();
        empezarCanciones();
      }
    }
  }
  
  if(state == 0) { 
    background(200);
    text(textoCuentaAtrasEmpezarGrabacion, width/2, height/2);
    cuentaAtrasEmpezarGrabacion(); 
  }
  
  if(state == 1) { 
    background(255, 0, 0);
    text("¡Grabando!", 20, 20);
    text(textoCuentaAtrasGrabando, width/2, height/2);
    cuentaAtrasGrabando(); 
  }
}

void checkAudios() {
  if (audios.size() == 0){
    return;
  }
  if (!audios.get(0).isValid()) {
    audios.remove(0);
    checkAudios();
  }
}

// Player 
void pararCanciones(){
  for (Audio a : audios){
    a.pause();
  }
}

void empezarCanciones(){
  for (Audio a : audios){
    a.play();
  }
}

// Recorder

void cuentaAtrasEmpezarGrabacion() {
  
  textoCuentaAtrasEmpezarGrabacion = str(timerCAEG);
  if (frameCount % 60 == 0 && timerCAEG > 0) { // si el framecount es divisible por 60, ha pasado un seg
    timerCAEG --;
  }
  if (timerCAEG == 0) {
    println("Empeisa grabar.");
    timerCAEG = segsCuentaAtrasEmpezarGrabacion;
    state = 1; // empieza grabación
    
    recorder = minim.createRecorder(in, "c"+ numAudios +".wav"); // crea el nuevo archivo para el audio
    numAudios++;  // incrementa contador de audios
    recorder.beginRecord();  // empieza a grabar
   
  }
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
    state = 2; // termina grabación
  }
}

void keyPressed() {
  if (state == -1) {
    state = 0; // Empieza la cuenta atrás para grabar
    pararCanciones();
  } else if (state == 2) {
    
    recorder.save(); // almacena el archivo
    canciones = new AudioPlayer[numAudios];
    cargarCanciones();
    
    state = -1; // vuelve al estado inicial
  }
}

public void dispose() {
    println("Cerrando programa...");
    
    // Guardar audios grabados en sound_data.txt
    parser.guardarAudios(audios);
}
