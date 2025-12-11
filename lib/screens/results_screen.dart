import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultsScreen extends StatelessWidget{
  //aqui guardamos el JSON que nos manda la pantalla anterior
  final Map<String, dynamic> analysisData;
  //obligamos a quien llame a esta pantalla a que nos de los datos.
  //required this.analysisData es rollo "no me crees si no me das el dato"
  const ResultsScreen({super.key, required this.analysisData});

  @override
  Widget build(BuildContext context) {
    // Sacamos los datos del mapa para usarlos fácil
    final double bruto = (analysisData['salario_bruto'] ?? 0.0).toDouble();
    final double neto = (analysisData['salario_neto'] ?? 0.0).toDouble();
    final String resumen = analysisData['resumen'] ?? "Sin resumen";
    final List<dynamic> consejos = analysisData['consejos'] ?? [];

    // Calculamos el tajazo del estado (Impuestos y deducciones)
    // Si el neto es mayor que el bruto por error, ponemos impuestos a 0 para que no explote.
    double impuestos = (bruto > neto) ? (bruto - neto) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Dinero Explicado'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView( //para que vaya expandiendo segun entren elementos
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECCIÓN 1: EL GRÁFICO ---
            const Text(
              "¿Dónde va tu dinero?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Contenedor del gráfico (le damos altura fija para que se vea bien)
            SizedBox(
              height: 200, 
              child: PieChart(
                PieChartData(
                  sections: [
                    // SECCIÓN A: Lo que te llevas (NETO)
                    PieChartSectionData(
                      value: neto,
                      color: Colors.green,
                      title: 'Tú\n${neto.toStringAsFixed(0)}€',
                      radius: 60,
                      titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    // SECCIÓN B: Lo que pagas (IMPUESTOS)
                    PieChartSectionData(
                      value: impuestos,
                      color: Colors.redAccent,
                      title: 'Impuestos\n${impuestos.toStringAsFixed(0)}€',
                      radius: 50, // Un poco más pequeño para efecto estético
                      titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                  sectionsSpace: 2, // Espacio entre quesitos
                  centerSpaceRadius: 40, // Agujero del donut
                ),
              ),
            ),
            
            const SizedBox(height: 30),

            // --- SECCIÓN 2: detalle salario ---
            Row(
              children: [
                Expanded(child: _MoneyCard(title: "Salario Bruto", amount: bruto, color: Colors.grey)),
                const SizedBox(width: 10),
                Expanded(child: _MoneyCard(title: "Salario Neto", amount: neto, color: Colors.green)),
              ],
            ),

            const SizedBox(height: 30),

            // --- SECCIÓN 3: Consejos ---
            const Text("Análisis Legal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Text(resumen, style: const TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 20),
            const Text("Consejos Detectados", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            
            ...consejos.map((consejo) => Card(
              margin: const EdgeInsets.only(top: 10),
              child: ListTile(
                leading: const Icon(Icons.lightbulb_outline, color: Colors.orange),
                title: Text(consejo),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// Widget para no repetir código en las tarjetas de dinero
class _MoneyCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;

  const _MoneyCard({required this.title, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text("${amount.toStringAsFixed(2)}€", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}