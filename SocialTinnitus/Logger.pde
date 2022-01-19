import java.io.*;
import java.util.ArrayList;

public class Logger {
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
    } 
    catch (IOException e) {
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
    return new PrintWriter(new BufferedWriter(new FileWriter(m_fileName, false)));
  }
}
