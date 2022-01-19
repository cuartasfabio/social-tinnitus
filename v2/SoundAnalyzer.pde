import ddf.minim.analysis.FFT;

public class SoundAnalyzer {

  FFT fft;
  int nCubes;
  Cube[] cubes;

  AudioPlayer song;

  float specLow = 0.03;
  float specMid = 0.125;
  float specHi = 0.20;

  float scoreLow = 0;
  float scoreMid = 0;
  float scoreHi = 0;

  float oldScoreLow = scoreLow;
  float oldScoreMid = scoreMid;
  float oldScoreHi = scoreHi;

  float scoreDecreaseRate = 25;

  public SoundAnalyzer(AudioPlayer song) {

    this.song = song;

    fft = new FFT(song.bufferSize(), song.sampleRate());

    nCubes = 5;
    cubes = new Cube[nCubes];

    for (int i = 0; i < nCubes; i++) {
      cubes[i] = new Cube(); 

      background(0);
    }
  }

  public void display()
  {
    fft.forward(song.mix);

    oldScoreLow = scoreLow;
    oldScoreMid = scoreMid;
    oldScoreHi = scoreHi;

    scoreLow = 0;
    scoreMid = 0;
    scoreHi = 0;

    for (int i = 0; i < fft.specSize()*specLow; i++)
    {
      scoreLow += fft.getBand(i);
    }

    for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
    {
      scoreMid += fft.getBand(i);
    }

    for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
    {
      scoreHi += fft.getBand(i);
    }

    if (oldScoreLow > scoreLow) {
      scoreLow = oldScoreLow - scoreDecreaseRate;
    }

    if (oldScoreMid > scoreMid) {
      scoreMid = oldScoreMid - scoreDecreaseRate;
    }

    if (oldScoreHi > scoreHi) {
      scoreHi = oldScoreHi - scoreDecreaseRate;
    }

    float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;

    for (int i = 0; i < nCubes; i++)
    {
      float bandValue = fft.getBand(i);

      cubes[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
    }
  }
}
