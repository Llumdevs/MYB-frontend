import 'package:flutter/material.dart';
import 'screens/upload_screen.dart';

// 1. La función main() es el punto de partida. Igual que en Python.
void main() {
  runApp(const MyApp());
}

// 2. MyApp es el "Marco" de la pintura. Configura colores, fuentes y rutas.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MYB - Mind Your Business',
      debugShowCheckedModeBanner: false, // Quita la etiqueta "Debug" fea de la esquina
      // TEMA GLOBAL DE LA APP
      theme: ThemeData(
        useMaterial3: true,
        
        // 1. Definimos los colores corporativos
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E), 
          secondary: const Color(0xFF00BFA5), 
          background: const Color(0xFFF5F7FA), 
        ),
        
        // 2. Fondo general de las pantallas
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),


        // 4. Estilo de la Barra Superior (AppBar)
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent, 
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF1A237E), 
            fontSize: 22, 
            fontWeight: FontWeight.bold
          ),
          iconTheme: IconThemeData(color: Color(0xFF1A237E)),
        ),

        // 5. Estilo de los Botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A237E), 
            foregroundColor: Colors.white, 
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), 
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      
      // Aqui es donde se define la pantalla inicial
      home: const UploadScreen(),
    );
  }
}