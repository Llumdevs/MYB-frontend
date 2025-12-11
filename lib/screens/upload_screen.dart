import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Herramienta para abrir carpetas
import '../services/api_service.dart'; // cable con el backend
import 'results_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

// Esta clase es donde vive la lógica y la memoria
class _UploadScreenState extends State<UploadScreen>{

  //memoria: esta variable recuerda si estamos trabajando o no
  bool _isloading = false;

  //funcion inteligente para subir el archivo
  Future<void> _pickandUpload() async {
    //abrimos ventana de archivos
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      //El usuario ha elegido un archivo
      PlatformFile file = result.files.first;

      //setState avisa a la pantalla para que se redibuje
      setState(() {
        _isloading = true; //cambia a cargando
      });

      //llamamos al backend
      print("Subiendo archivo: ${file.name}");
      var response = await ApiService.analyzePayroll(file);

      //ya tenemos la respuesta, quitamos caargando
      setState(() {
        _isloading = false; 
      });

      //ver resultado
      if (response != null && mounted){
        Navigator.push(
        context,
        MaterialPageRoute(
          // Aquí es donde "creamos" la nueva pantalla y le pasamos datos
          builder: (context) => ResultsScreen(analysisData: response),
        ),
      );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al conectar con el cerebro (Backend)."), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Mind your Business'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        // 🎓 LOGICA VISUAL: 
        // Si _isLoading es true -> Muestra el círculo.
        // Si _isLoading es false -> Muestra el botón.
        child: _isloading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(), // El spinner
                  SizedBox(height: 20),
                  Text("La IA está leyendo..."),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cloud_upload_outlined, size: 100, color: Colors.purple),
                  const SizedBox(height: 20),
                  const Text(
                    "Sube tu nómina",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _pickandUpload, // Conectamos la función aquí
                    icon: const Icon(Icons.search),
                    label: const Text("Analizar mi Nómina"), // Tu texto personalizado
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    ),
                  )
                ],
              ),
      ),
    );
  }

}