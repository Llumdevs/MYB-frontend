import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget{
  //aqui guardamos el JSON que nos manda la pantalla anterior
  final Map<String, dynamic> analysisData;
  //obligamos a quien llame a esta pantalla a que nos de los datos.
  //required this.analysisData es rollo "no me crees si no me das el dato"
  const ResultsScreen({super.key, required this.analysisData});

  @override
  Widget build(BuildContext context) {
    // Sacamos los datos del mapa para usarlos fácil
    final double neto = analysisData['salario_neto'] ?? 0.0;
    final String resumen = analysisData['resumen'] ?? "Sin resumen";
    final List<dynamic> consejos = analysisData['consejos'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Análisis completado"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView( // Por si la lista es muy larga, que se pueda hacer scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TARJETA DEL DINERO
            Card(
              elevation: 4,
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text("Líquido a Percibir (Neto)", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(
                      "$neto €", // Mostramos el dato
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
    // 2. SECCIÓN RESUMEN
            const Text("Resumen Legal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(resumen, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // 3. SECCIÓN CONSEJOS (Lista dinámica)
            const Text("Consejos para ti", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // Recorremos la lista de consejos y creamos un Widget por cada uno
            ...consejos.map((consejo) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.lightbulb, color: Colors.orange),
                title: Text(consejo),
              ),
            )),
          ],
        ),
      ),
    );
  }
}