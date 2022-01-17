import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class ParserAudios {

  Logger loggerObject;

  void ParserAudios() {
    loggerObject = new Logger(sketchPath("") + "\\sound_data.txt");
  }

  // Metodo para formatear los objetos Audio a String y guardarlos en
  // sound_data.txt
  void guardarAudios(ArrayList<Audio> nuevosAudios) {
    for (Audio audio : nuevosAudios) {
      loggerObject.log(audio.getRuta() + "\t" + audio.getFecha());
    }
  }

  // Metodo para leer sound_data.txt y parsear el texto a objetos Audio
  ArrayList<Audio> cargarAudios() {
    ArrayList<Audio> audios = new ArrayList<Audio>();
    ArrayList<String> lineas = loggerObject.leerLineas();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    
    for (String linea : lineas) {
      String[] datosAudio = linea.split("\t");
      audios.add(new Audio(datosAudio[0], LocalDateTime.parse(datosAudio[1], formatter)));
    }

    return audios;
  }

}
