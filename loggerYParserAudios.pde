import java.io.*;

/**
 * Simple logger.
 * @author Philippe Lhoste
 */
 
class Logger {
  String m_fileName;
  
  BufferedReader reader;
  ArrayList<String> lineas;

  Logger(String fileName) {
    m_fileName = fileName;
  }
  
  ArrayList<String> leerLineas() {
    lineas = new ArrayList<String>();
    String linea;
    
    reader = createReader("sound_data.txt");
    
    try {
      while ((linea = reader.readLine()) != null) {
        println("Leida la linea: "+linea);
        lineas.add(linea);
      }
    } catch (IOException e) {
      e.printStackTrace();
      println("Error al leer del fichero");
    }
    
    return lineas;
  }

  void log(String line) {
    PrintWriter pw = null;
    try
    {
      pw = GetWriter();
      pw.println(line);
      println(line);
    }
    catch (IOException e)
    {
      e.printStackTrace();
      println("Error al escribir en el fichero");
    }
    finally
    {
      if (pw != null)
      {
        pw.close();
      }
    }
  }

  private PrintWriter GetWriter() throws IOException {
    return new PrintWriter(new BufferedWriter(new FileWriter(m_fileName, true)));
  }
  
}

// =================================================

/**
 * Parser de pistas de audio para social-tinnitus.
 * Y funciones auxiliares
 * @author cuartasfabio
 */
 
class ParserAudios {
  
  Logger loggerObject;
  
  void ParserAudios() {
    loggerObject = new Logger(sketchPath("") + "\\sound_data.txt");
  } 
   
  // Metodo para formatear los objetos Audio a String y guardarlos en sound_data.txt
  void guardarAudios(ArrayList<Audio> nuevosAudios) {
    for (Audio audio : nuevosAudios) {
      loggerObject.log("c" + audio.getRuta() + ".wav" + " " + audio.getHoraGrabacion());
    }
  }
  
  // Metodo para leer sound_data.txt y parsear el texto a objetos Audio
  ArrayList<Audio> cargarAudios() {
    ArrayList<Audio> audios = new ArrayList<Audio>();
    ArrayList<String> lineas = loggerObject.leerLineas();
    
    for (String linea : lineas) {  
      String[] datosAudio = split(linea, ' ');
      audios.add(new Audio(datosAudio[0], datosAudio[1]));
    }
    
    return audios;
  }
  
  // Metodo auxiliar que devuelve la hora en formato "HH:mm:ss"
  String getHoraActual() {
    String fecha = "";
    fecha += String.valueOf(hour());
    fecha += ":";
    fecha += String.valueOf(minute());
    fecha += ":";
    fecha += String.valueOf(second());
    return fecha;
  }
  
  // Metodo auxiliar para comprobar si ha pasado suficiente tiempo como para "desvanecer" el audio
  boolean elAudioEsViejo(String horaAudioAComprobar, String tiempoDeVidaDelAudio) { // En numero de horas
    String horaActual[] = split(getHoraActual(), ':');
    String horaAudio[] = split(horaAudioAComprobar, ':');
 
    // Si horaActual - horaAudioAComprobar > tiempoDeVidaDelAudio -----> audio para de reproducirse
    if ( Integer.valueOf(horaActual[0]) -  Integer.valueOf(horaAudio[0]) > Integer.valueOf(tiempoDeVidaDelAudio)) {
      return false;
    }
    return true;
  }
  
}
