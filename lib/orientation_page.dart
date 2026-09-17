import 'package:flutter/material.dart';

class OrientationPage extends StatelessWidget {
  const OrientationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orientación Post-Examen"),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "¡Felicidades, Aprobaste!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            const Text(
              "Ahora que has pasado el examen, estos son tus siguientes pasos para completar tu ingreso:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            _buildStepCard(
              context,
              "1. Entrega de Documentos",
              "Debes presentar tu DNI, certificado de estudios y el recibo de pago de matrícula en la oficina de admisión.",
              Icons.description,
            ),
            _buildStepCard(
              context,
              "2. Charla de Bienvenida",
              "Asiste a la charla virtual el próximo lunes a las 10:00 AM para conocer a tus coordinadores.",
              Icons.group,
            ),
            _buildStepCard(
              context,
              "3. Registro de Cursos",
              "Desde el portal del estudiante, podrás seleccionar tus horarios y cursos para este ciclo.",
              Icons.app_registration,
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción para descargar guía o similar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "Descargar Guía del Estudiante",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(BuildContext context, String title, String description, IconData icon) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.blue[800]),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
