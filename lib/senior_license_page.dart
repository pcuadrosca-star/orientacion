import 'package:flutter/material.dart';

class SeniorLicensePage extends StatelessWidget {
  const SeniorLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trámite Adulto Mayor"),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.blue[600],
                    width: double.infinity,
                    child: const Column(
                      children: [
                        Text(
                          "ORIENTACIÓN PARA ADULTO MAYOR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Información especial para conductores mayores de 70 años:",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildInfoCard(
                          "Vigencia de la Licencia",
                          "• De 70 a 75 años: Vigencia por 1 año.\n• De 75 a 80 años: Vigencia por 6 meses.\n• Mayores de 80 años: Vigencia por 3 meses.",
                          Icons.history,
                        ),
                        const SizedBox(height: 15),
                        _buildInfoCard(
                          "Requisitos Principales",
                          "1. Examen médico aprobado (especial para su edad).\n2. Examen de conocimientos aprobado.\n3. Pago de tasas correspondientes.",
                          Icons.assignment,
                        ),
                        const SizedBox(height: 15),
                        _buildInfoCard(
                          "Atención Preferencial",
                          "Usted cuenta con atención prioritaria en todas nuestras sedes de la Gerencia Regional de Transportes.",
                          Icons.volunteer_activism,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue[800], size: 30),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.blue[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/f1.png',
            height: 40,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("GERENCIA REGIONAL DE TRANSPORTES Y COMUNICACIONES", 
                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                Text("GOBIERNO REGIONAL LA LIBERTAD", 
                  style: TextStyle(color: Colors.white, fontSize: 8)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
