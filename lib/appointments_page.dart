import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/api_service.dart';
import 'models/appointment.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  // Instancia de nuestro "API" interno
  static final ApiService _api = ApiService();

  Future<void> _handleReserva(BuildContext context, String categoria, String url) async {
    final user = FirebaseAuth.instance.currentUser;
    
    // Intentar guardar en la base de datos para el historial (opcional si no hay DNI)
    try {
      if (user != null) {
        await _api.upsertExamResult(
          Appointment(
            userId: user.uid,
            dni: "", // Se deja vacío para que se llene luego en admin o se use el buscador por nombre si se asocia
            name: user.displayName ?? "Usuario", 
            category: categoria,
            date: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error al registrar interés: $e");
    }

    // Abrir el enlace externo
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reserva de Citas"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildCitaCard(
                            context,
                            title: "PRACTICAS",
                            subtitle: "Programación de Practicas",
                            info: "Turnos para el circuito el Milagro",
                            color: Colors.pink[400]!,
                            icon: Icons.timer_outlined,
                            onTap: () => _handleReserva(context, "PRACTICAS", "http://www.grtclalibertad.gob.pe/citas/entrega#step-1"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildCitaCard(
                            context,
                            title: "EVALUACIÓN",
                            subtitle: "Examen de Manejo",
                            info: "Programación de examen práctico",
                            color: Colors.orange[400]!,
                            icon: Icons.directions_car_filled,
                            onTap: () => _handleReserva(context, "EVALUACION", "http://www.grtclalibertad.gob.pe/citas/examenpractico#step-1"),
                          ),
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue[600],
      width: double.infinity,
      child: const Column(
        children: [
          Text("COMUNICADO", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            "Reserva cita para tu evaluación en habilidades para la conducción",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCitaCard(BuildContext context, {
    required String title,
    required String subtitle,
    required String info,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Chip(label: Text(title, style: const TextStyle(color: Colors.white, fontSize: 10)), backgroundColor: color),
          const SizedBox(height: 10),
          Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 15),
          Icon(icon, size: 50, color: Colors.grey[400]),
          const SizedBox(height: 15),
          Text(info, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text("Reservar Cita", style: TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ],
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
