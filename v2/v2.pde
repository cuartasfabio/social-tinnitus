import processing.sound.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
State currentState;

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
  fullScreen(P3D);

  minim = new Minim(this);

  in = minim.getLineIn(Minim.STEREO);

  textFont(createFont("Arial", 12));

  // sonido del metrónomo
  //metronomoSonido = new SoundFile(this, "beatSound.mp3");

  currentState = new StartState();

  //parser = new ParserAudios();          ----------------------------------
  //audios = parser.cargarAudios();       ----------------------------------

  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");         // -------------------------    

  Audio a0 = new Audio("c0.mp3", LocalDateTime.parse("2020-07-01 17:45", formatter));    // -------------------------    
  Audio a1 = new Audio("c1.mp3", LocalDateTime.now());                                   // -------------------------    
  Audio a2 = new Audio("c2.mp3", LocalDateTime.now());                                   // -------------------------    
  Audio a3 = new Audio("c3.mp3", LocalDateTime.now());                                   // -------------------------    
  Audio a4 = new Audio("c4.mp3", LocalDateTime.now());                                   // -------------------------    
  audios = new ArrayList<Audio>();                                                       // -------------------------    

  audios.add(a0);                                                                       // -------------------------    
  audios.add(a1);                                                                       // -------------------------    
  audios.add(a2);                                                                       // -------------------------    
  audios.add(a3);                                                                       // -------------------------    
  audios.add(a4);                                                                       // -------------------------    

  checkAudios();
  cargarAnalyzers();                                                                     // -----------------------------------
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
