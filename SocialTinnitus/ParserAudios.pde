import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class ParserAudios {

  Logger loggerObject;

  public ParserAudios() {
    loggerObject = new Logger(sketchPath("") + "\\sound_data.txt");
  }

  // Metodo para formatear los objetos Audio a String y guardarlos en
  // sound_data.txt
  void guardarAudios(ArrayList<Audio> nuevosAudios) {
    
    StringBuilder sb = new StringBuilder();
    for (Audio audio : nuevosAudios) {
      sb.append(audio.toString() + "\n");
    }
    loggerObject.log(sb.toString());
  }

  // Metodo para leer sound_data.txt y parsear el texto a objetos Audio
  ArrayList<Audio> cargarAudios() {
    ArrayList<Audio> audios = new ArrayList<Audio>();
    ArrayList<String> lineas = loggerObject.leerLineas();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    if (lineas.size() >=1){
      lineas.remove(lineas.size()-1);
    }

    for (String linea: lineas) {
      String[] datosAudio = linea.split(";");
      println(datosAudio[0]);
      println(datosAudio[1]);
      audios.add(new Audio(datosAudio[0], LocalDateTime.parse(datosAudio[1], formatter)));
    }

    return audios;
  }
}
