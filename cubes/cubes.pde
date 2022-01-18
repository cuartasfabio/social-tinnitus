import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

int t1 = 0;
int t2 = 0;

// Valeur d'adoucissement
float scoreDecreaseRate = 25;

// Cubes qui apparaissent dans l'espace
int nbCubes;
Cube[] cubes;


void setup()
{
  //Faire afficher en 3D sur tout l'écran
  fullScreen(P3D);

  //Charger la librairie minim
  minim = new Minim(this);

  //Charger la chanson
  song = minim.loadFile("song.mp3");

  //Créer l'objet FFT pour analyser la chanson
  fft = new FFT(song.bufferSize(), song.sampleRate());

  //Un cube par bande de fréquence
  nbCubes = (int)(10);
  cubes = new Cube[nbCubes];

  //Autant de murs qu'on veux

  //Créer tous les objets
  //Créer les objets cubes
  for (int i = 0; i < nbCubes; i++) {
    cubes[i] = new Cube();
  }

  //Fond noir
  background(0);

  //Commencer la chanson
  song.play(0);
}

void draw()
{
  if (t1 == 0) {
    t1 = millis();
  } else {
    t2 = millis();
    if (t2 - t1 >= 60000) {
      t1 = 0;
      song.pause();
      song.rewind();
      song.play();
    } else {
      //Faire avancer la chanson. On draw() pour chaque "frame" de la chanson...
      fft.forward(song.mix);

      //Volume pour toutes les fréquences à ce moment, avec les sons plus haut plus importants.
      //Cela permet à l'animation d'aller plus vite pour les sons plus aigus, qu'on remarque plus
      //float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;

      background(0);

      //Cube pour chaque bande de fréquence
      for (int i = 0; i < nbCubes; i++)
      {
        //Valeur de la bande de fréquence
        float bandValue = fft.getBand(i);

        //La couleur est représentée ainsi: rouge pour les basses, vert pour les sons moyens et bleu pour les hautes. 
        //L'opacité est déterminée par le volume de la bande et le volume global.
        cubes[i].display(bandValue);
      }
    }
  }
}
