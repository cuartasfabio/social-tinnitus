import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
AudioPlayer song2;
FFT fft;
FFT fft2;

int t1 = 0;
int t2 = 0;

float scoreDecreaseRate = 25;

int nCubes;
Cube[] cubes;


void setup()
{
  fullScreen(P3D);

  minim = new Minim(this);

  song = minim.loadFile("tusa.mp3");

  fft = new FFT(song.bufferSize(), song.sampleRate());

  nCubes = (int)(fft.specSize()*.10);
  cubes = new Cube[nCubes];

  for (int i = 0; i < nCubes; i++) {
    cubes[i] = new Cube();
  }

  background(0);

  song.play(0);
}

void draw()
{
  if (t1 == 0) {
    t1 = millis();
  } else {
    t2 = millis();
    if (t2 - t1 >= 8000) {
      t1 = 0;
      song.pause();
      song.rewind();
      song.play();
    } else {
      fft.forward(song.mix);

      background(0);

      //Cube pour chaque bande de fréquence
      for (int i = 0; i < nCubes; i++)
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
