import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicalExamPage extends StatelessWidget {
  const MedicalExamPage({super.key});

  Future<void> _launchURL() async {
    const String url = "https://licencias-tramite.mtc.gob.pe/frmConsultaEvaluaciones.aspx";
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Examen Médico"),
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
                          "CONSULTA MÉDICA",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Verifica la vigencia de tu examen médico directamente en el portal oficial del MTC:",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            const Icon(Icons.medical_services_outlined, size: 80, color: Colors.red),
                            const SizedBox(height: 20),
                            const Text(
                              "Vigencia del Examen Médico",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Presiona el botón inferior para ingresar al sistema de evaluaciones del MTC y consultar si tu certificado médico está registrado.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton.icon(
                              onPressed: _launchURL,
                              icon: const Icon(Icons.open_in_new, color: Colors.white),
                              label: const Text("Consultar en MTC", style: TextStyle(color: Colors.white, fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                minimumSize: const Size(double.infinity, 55),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                      ),
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
