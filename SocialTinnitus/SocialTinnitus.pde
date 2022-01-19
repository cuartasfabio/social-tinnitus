import processing.sound.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
State currentState;
PFont font;  

// Audios
ArrayList<Audio> audios;
ArrayList<SoundAnalyzer> analyzers;

// Recorder
AudioInput   in;
AudioRecorder recorder;

// Cargado y guardado de audios
ParserAudios parser;

SoundFile metronomoSonido; // archivo de audio para marcar el pulso

void setup() {
  font = createFont("OverpassMono-Medium.ttf", 128);
  fullScreen(P3D);

  minim = new Minim(this);

  in = minim.getLineIn(Minim.STEREO);

  textFont(createFont("Arial", 12));

  // sonido del metrónomo
  //metronomoSonido = new SoundFile(this, "beatSound.mp3");

  currentState = new StartState();

  parser = new ParserAudios();          
  audios = parser.cargarAudios();

  checkAudios();
  cargarAnalyzers();
}

void draw() {
  currentState.display();
}

void checkAudios() {
  if (audios.size() == 0) {
    return;
  }
  if (!audios.get(0).isValid()) {
    audios.remove(0);
    checkAudios();
  }
}

public void dispose() {
  println("Cerrando programa...");
  pararAudios();
  parser.guardarAudios(audios);
  // Guardar audios grabados en sound_data.txt
}

void pararAudios() {
  for (Audio a : audios) {
    a.pause();
  }
}

void empezarAudios() {
  for (Audio a : audios) {
    a.play();
  }
}

void cargarAnalyzers() {
  analyzers = new ArrayList<SoundAnalyzer>();
  for (Audio a : audios) {
    analyzers.add(new SoundAnalyzer(a.getPlayer()));
  }
}

void displayAnalyzers(){
  for (SoundAnalyzer s : analyzers){
    s.display();
  }
}
