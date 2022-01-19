
import java.time.LocalDateTime;

import ddf.minim.AudioPlayer;
import ddf.minim.Minim;

public class Audio {

  private String ruta;
  private LocalDateTime fecha;
  private AudioPlayer player;

  public Audio(String ruta, LocalDateTime fecha) {
    this.ruta = ruta;
    this.fecha = fecha;
    this.player = minim.loadFile(ruta);
  }

  public AudioPlayer getPlayer() {
    return player;
  }

  public LocalDateTime getFecha() {
    return fecha;
  }

  public String getRuta() {
    return ruta;
  }

  public void play() {
    player.rewind();
    player.play();
  }

  public void pause() {
    player.pause();
  }

  public boolean isValid() {
    LocalDateTime now = LocalDateTime.now();
    if (now.getYear() - fecha.getYear() > 0) {
      return false;
    }
    if (now.getDayOfYear() - fecha.getDayOfYear() == 0) {
      return true;
    }
    if (fecha.getHour() - now.getHour() > 0 && 
      now.getDayOfYear() - fecha.getDayOfYear() == 1) {
      return true;
    }
    if (fecha.getMinute() - now.getMinute() > 0 &&
      now.getDayOfYear() - fecha.getDayOfYear() == 1 && fecha.getHour() - now.getHour() == 0) {
      return true;
    }
    return false;
  }

  public String toString() {
    return ruta + ";" + fecha.toLocalDate() + " " + fecha.toLocalTime();
  }
}
