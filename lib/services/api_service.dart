import 'dart:convert'; // Herramienta para traducir de Texto a JSON
import 'package:http/http.dart' as http; // Herramienta para enviar cartas por internet
import 'package:file_picker/file_picker.dart'; // El tipo de dato "Archivo"

class ApiService {
  // 1. STATIC: Significa que no necesito "construir" (instanciar) esta clase para usarla.
  // Puedo usarla directamente como una herramienta.
  // OJO: En Web usamos 127.0.0.1, en Emulador Android sería 10.0.2.2
  static const String baseUrl = 'http://127.0.0.1:8000';

  // 2. FUTURE: Concepto CLAVE en Dart.
  // Como internet es lento (tarda milisegundos o segundos), esta función no devuelve
  // el dato "ya", sino que devuelve una "Promesa" (Future) de que en el futuro traerá un dato.
  // El "?" al final de Map? significa que puede devolver un Mapa... O puede devolver NULL (si falla).
  static Future<Map<String, dynamic>?> analyzePayroll(PlatformFile file) async {
    try {
      // Preparamos la dirección: http://127.0.0.1:8000/analyze
      var uri = Uri.parse('$baseUrl/analyze');

      // Preparamos el sobre (MultipartRequest es para enviar archivos)
      var request = http.MultipartRequest('POST', uri);

      // Metemos el archivo en el sobre.
      // file.bytes!: Los datos binarios del PDF.
      request.files.add(http.MultipartFile.fromBytes(
        'file', 
        file.bytes!,
        filename: file.name,
      ));

      // 3. AWAIT: Aquí le decimos al programa: "PÁRATE AQUÍ y espera".
      // No sigas a la siguiente línea hasta que el servidor responda.
      var streamedResponse = await request.send();

      // Leemos la respuesta
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Si el servidor dice "OK" (200), traducimos el texto a JSON (Map)
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print("Error del servidor: ${response.statusCode}");
        return null; // Devolvemos "nada" (null) porque falló
      }
    } catch (e) {
      print("Error de conexión: $e");
      return null;
    }
  }
}