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
      theme: ThemeData(
        // Aquí definimos la "Personalidad" de tu marca
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)), // Un morado profesional
        useMaterial3: true,
      ),
      // 3. Le decimos: "Tu pantalla de inicio es esta":
      home: const UploadScreen(),
    );
  }
}