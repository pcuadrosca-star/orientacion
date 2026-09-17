import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ElectronicMailboxPage extends StatelessWidget {
  const ElectronicMailboxPage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Casilla Electrónica MTC"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Cabecera con Imagen f1.png y Gradiente
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              'assets/images/f1.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(color: Colors.blue[900]),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.blue[900]!.withOpacity(0.8)
                              ],
                            ),
                          ),
                        ),
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "RECOMENDACIÓN",
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "CASILLA\nELECTRÓNICA",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  height: 0.9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Enlace Principal
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    color: Colors.blue[600],
                    child: Column(
                      children: [
                        const Text(
                          "Crea tu casilla electrónica del MTC para recibir notificaciones oficiales en:",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () => _launchURL("https://casilla.mtc.gob.pe/"),
                          child: const Text(
                            "casilla.mtc.gob.pe",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Pasos del trámite
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildStepCard(
                          number: "1",
                          title: "Acceso al Portal",
                          description: "Ingresa a la página oficial de la casilla electrónica del MTC.",
                          icon: Icons.language,
                          onTap: () => _launchURL("https://casilla.mtc.gob.pe/#/auth/login"),
                        ),
                        _buildStepCard(
                          number: "2",
                          title: "Registro de Cuenta",
                          description: "Haz clic en \"Crear cuenta\" y valida tu identidad con DNIe o Biometría facial.",
                          icon: Icons.person_add_alt_1,
                          onTap: () => _launchURL("https://casilla.mtc.gob.pe/#/registro"),
                        ),
                        _buildStepCard(
                          number: "3",
                          title: "Datos Personales",
                          description: "Completa la información solicitada y registra un correo electrónico activo.",
                          icon: Icons.edit_note,
                        ),
                        _buildStepCard(
                          number: "4",
                          title: "Activación",
                          description: "Revisa tu bandeja de entrada y confirma la activación de tu casilla.",
                          icon: Icons.verified_user,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Inicia tus trámites con nosotros en la Mesa de Partes Virtual:",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: () => _launchURL("https://mesa.mtc.gob.pe/"),
                                child: const Text(
                                  "mesa.mtc.gob.pe",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
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

  Widget _buildStepCard({
    required String number,
    required String title,
    required String description,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
          if (onTap != null)
            IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.open_in_new, color: Colors.blue),
            )
          else
            Icon(icon, color: Colors.grey[400], size: 28),
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
