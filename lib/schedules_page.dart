import 'package:flutter/material.dart';

class SchedulesPage extends StatelessWidget {
  const SchedulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Horarios de Evaluación"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[900]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              width: double.infinity,
              child: const Column(
                children: [
                  Text(
                    "CENTRO DE EVALUACIÓN DE HABILIDADES EN LA CONDUCCIÓN",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Nuevos horarios de EVALUACIÓN",
                    style: TextStyle(color: Colors.yellow, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        "LUNES A VIERNES",
                        style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      _buildScheduleRow("Categoría AI - AIIa", "10:15 am. a 13:00 pm."),
                      const Divider(),
                      _buildScheduleRow("AIIb - AIIb - AIIc", "14:00 pm. a 15:30 pm."),
                    ],
                  ),
                ),
              ),
            ),
            _buildInfoSection(
              "Informes y orientación: mensaje de WhatsApp",
              "969730223",
              Icons.message,
              Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Prohibido en la evaluación:",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: const [
                        _ForbiddenItem(text: "Gorro y lentes"),
                        _ForbiddenItem(text: "Casco y lapicero"),
                        _ForbiddenItem(text: "Mochila o bolso"),
                        _ForbiddenItem(text: "Celular y audífonos"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _buildPaymentSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleRow(String category, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(category, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(time, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(title, style: const TextStyle(fontSize: 13)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Pago: por Scotiabank", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          Text("(Panam. Norte Km. 572 - El Milagro)"),
          SizedBox(height: 5),
          Text("Nombre: TRANSPORTES LA LIBERTAD", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Código 132", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          Text("S/. 60.00 - 1 oportunidad", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16)),
        ],
      ),
    );
  }
}

class _ForbiddenItem extends StatelessWidget {
  final String text;
  const _ForbiddenItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.cancel, color: Colors.red, size: 16),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
