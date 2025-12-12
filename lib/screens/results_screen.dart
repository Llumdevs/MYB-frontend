import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Asegúrate de tener esta librería

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> analysisData;

  const ResultsScreen({super.key, required this.analysisData});

  @override
  Widget build(BuildContext context) {
    // 1. Extracción y Limpieza de Datos
    final double bruto = (analysisData['salario_bruto'] ?? 0.0).toDouble();
    final double neto = (analysisData['salario_neto'] ?? 0.0).toDouble();
    final String resumen = analysisData['resumen'] ?? "Sin resumen disponible.";
    final List<dynamic> consejos = analysisData['consejos'] ?? [];

    // Cálculo de impuestos para la gráfica (evitamos negativos)
    double impuestos = (bruto > neto) ? (bruto - neto) : 0.0;

    // Colores del tema (los sacamos del contexto para ser consistentes)
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tu Dinero Explicado"),
        // No ponemos color aquí, dejamos que el tema global (main.dart) se encargue
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // --- SECCIÓN SUPERIOR: TARJETAS (IZQ) + GRÁFICO (DER) ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. COLUMNA IZQUIERDA: Las Tarjetas Flotantes
                Expanded(
                  flex: 3, // Ocupa un poco menos de espacio que el gráfico
                  child: Column(
                    children: [
                      _SummaryCard(
                        title: "Salario Neto",
                        amount: neto,
                        color: colorScheme.secondary, // Verde/Esmeralda
                        icon: Icons.wallet,
                        isMain: true, // Esta será más grande/destacada
                      ),
                      const SizedBox(height: 12), // Aire entre tarjetas
                      _SummaryCard(
                        title: "Salario Bruto",
                        amount: bruto,
                        color: Colors.grey.shade700,
                        icon: Icons.attach_money,
                        isMain: false,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20), // Aire horizontal

                // 2. COLUMNA DERECHA: El Gráfico Donut
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 200, // Altura fija para el gráfico
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 0, // Sin huecos para look moderno
                        centerSpaceRadius: 40,
                        sections: [
                          // Sección NETO (Verde)
                          PieChartSectionData(
                            value: neto,
                            color: colorScheme.secondary,
                            radius: 50,
                            showTitle: false, // Minimalista: sin texto encima
                          ),
                          // Sección IMPUESTOS (Rojo suave)
                          PieChartSectionData(
                            value: impuestos,
                            color: const Color(0xFFEF5350), // Rojo suave
                            radius: 40, // Un poco más fino para efecto visual
                            showTitle: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Leyenda pequeña debajo del gráfico (opcional, por claridad)
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _LegendItem(color: colorScheme.secondary, text: "Tú"),
                const SizedBox(width: 15),
                const _LegendItem(color: Color(0xFFEF5350), text: "Impuestos"),
                const SizedBox(width: 20), // Margen derecho para alinear con gráfico
              ],
            ),

            const SizedBox(height: 30),

            // --- SECCIÓN DESCRIPCIÓN ---
            Text(
              "Análisis Legal", 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: colorScheme.primary
              )
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Text(
                resumen, 
                style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87)
              ),
            ),

            const SizedBox(height: 30),

            // --- SECCIÓN CONSEJOS ---
            Text(
              "Consejos Inteligentes", 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: colorScheme.primary
              )
            ),
            const SizedBox(height: 10),
            
            ...consejos.map((consejo) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Card(
                elevation: 0, // Diseño plano (Flat)
                color: const Color(0xFFE8EAF6), // Azul muy muy clarito
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.lightbulb_outline_rounded, color: Colors.orange),
                  title: Text(consejo, style: const TextStyle(fontSize: 14)),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// 🧱 Widget Auxiliar: Tarjeta de Resumen (Bruto/Neto)
class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final IconData icon;
  final bool isMain;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
    required this.isMain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMain ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: isMain ? Border.all(color: color.withOpacity(0.3), width: 1) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey),
              const SizedBox(width: 5),
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "${amount.toStringAsFixed(0)}€",
            style: TextStyle(
              fontSize: isMain ? 24 : 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// 🧱 Widget Auxiliar: Item de Leyenda (Bolita de color + texto)
class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10, height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}