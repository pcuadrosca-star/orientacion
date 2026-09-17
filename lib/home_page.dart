import 'package:flutter/material.dart';
import 'payments_page.dart';
import 'appointments_page.dart';
import 'schedules_page.dart';
import 'practice_circuit_page.dart';
import 'electronic_mailbox_page.dart';
import 'exam_approval_page.dart';
import 'medical_exam_page.dart';
import 'senior_license_page.dart';
import 'admin_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.account_circle, size: 35, color: Colors.white),
              tooltip: "Panel Administrador",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[900]!,
              Colors.blue[600]!,
              Colors.blue[400]!,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/f1.png',
                        height: 100,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car, size: 80, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Portal de Orientación",
                        style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Trámites y Licencias de Conducir",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    child: Column(
                      children: <Widget>[
                        _buildMenuButton(context, "Costos de Servicios (TUPA)", Icons.payments_outlined, const PaymentsPage()),
                        const SizedBox(height: 12),
                        _buildMenuButton(context, "Reserva de Citas", Icons.calendar_month_outlined, const AppointmentsPage()),
                        const SizedBox(height: 12),
                        _buildMenuButton(context, "Aprobación de Exámenes", Icons.verified_outlined, const ExamApprovalPage()),
                        const SizedBox(height: 12),
                        _buildMenuButton(context, "Vigencia de Examen Médico", Icons.medical_services_outlined, const MedicalExamPage()),
                        const SizedBox(height: 12),
                        _buildMenuButton(context, "Trámite para Adulto Mayor", Icons.elderly_outlined, const SeniorLicensePage()),
                        const SizedBox(height: 12),
                        _buildMenuButton(context, "Horarios de Evaluación", Icons.access_time, const SchedulesPage()),
                        const SizedBox(height: 12),
                        _buildMenuButton(context, "Prácticas en el Circuito", Icons.drive_eta_outlined, const PracticeCircuitPage()),
                        const SizedBox(height: 12),
                        _buildMenuButton(context, "Crear Casilla Electrónica", Icons.mail_outline, const ElectronicMailboxPage()),
                        
                        const SizedBox(height: 30),
                        Image.asset(
                          'assets/images/images2.png',
                          height: 60,
                          errorBuilder: (context, error, stackTrace) => const Text(
                            "Gobierno Regional La Libertad",
                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData icon, Widget targetPage) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.blue[900]!.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue[900], size: 22),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 12, color: Colors.blue[900]),
            ],
          ),
        ),
      ),
    );
  }
}
