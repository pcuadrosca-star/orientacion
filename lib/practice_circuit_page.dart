import 'package:flutter/material.dart';

class PracticeCircuitPage extends StatelessWidget {
  const PracticeCircuitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prácticas en Circuito"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red[600],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    "¡REALIZA TUS PRÁCTICAS EN LA PISTA DEL CIRCUITO OFICIAL!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "CENTRO DE EVALUACIÓN DE HABILIDADES EN LA CONDUCCIÓN",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("PAGO POR USO DE CIRCUITO"),
                  const Text(
                    "Banca Scotiabank a nombre de Transportes La Libertad",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  _buildPriceCard(
                    "ALQUILER DE PISTA PARA AUTO LIGERO - CÓDIGO 223",
                    "Categorías AI - AIIA",
                    "S/. 37.38",
                    Colors.blue[100]!,
                  ),
                  const SizedBox(height: 10),
                  _buildPriceCard(
                    "ALQUILER DE PISTA PARA AUTO PESADO - CÓDIGO 224",
                    "Categorías AIIb - AIIIa - AIIIb - AIIIc",
                    "S/. 49.44",
                    Colors.blue[50]!,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Categorías y horarios de Lunes a Sábado:",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildScheduleItem("AI - AIIa:", "6:30 AM. A 10:00 AM."),
                  _buildScheduleItem("AIIb - AIIIa - AIIIb - AIIIc:", "3:30 PM. A 4:15 PM."),
                  const SizedBox(height: 20),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.location_on, color: Colors.red),
                    title: Text(
                      "Dirección: AV. MIGUEL GRAU 357 - C.P.M. \"El Milagro\"",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: Colors.red[50],
                    child: const Text(
                      "¡Evita a los tramitadores, puedes ser estafado!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildPriceCard(String title, String categories, String price, Color bgColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(categories, style: const TextStyle(fontSize: 12)),
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String cat, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(child: Text(cat, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
