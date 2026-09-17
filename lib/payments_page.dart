import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredServices = [];

  final List<Map<String, String>> _allServices = const [
    {'code': '101', 'name': 'JORNADA DE CAPACITACION EXTRAORDINARIA', 'price': '18.60'},
    {'code': '102', 'name': 'CURSO EXTRAORDINARIO DE EDUCACION EN TRANSITO Y SEGURIDAD VIAL', 'price': '25.50'},
    {'code': '103', 'name': 'PERMISO TUR ACUATICO REGIONAL', 'price': '339.30'},
    {'code': '104', 'name': 'RENUEVA TUR ACUATICO REGIONAL', 'price': '411.50'},
    {'code': '105', 'name': 'HABILITA NAVES TUR ACUATICO', 'price': '339.30'},
    {'code': '106', 'name': 'AUTORIZACION TRANSPORTE MERCANCIAS (GRAL)', 'price': '38.40'},
    {'code': '107', 'name': 'AUTORIZACION TRANSPORTE MERCANCIAS (PROPIA)', 'price': '37.80'},
    {'code': '108', 'name': 'AGENCIA DE TRANSPORTE MERCANCIAS', 'price': '432.30'},
    {'code': '109', 'name': 'BAJA VEHICULAR / CONCLUSION HABILITACION', 'price': '100.00'},
    {'code': '110', 'name': 'CANJE/DUPLICADO TUC (TODOS)', 'price': '30.50'},
    {'code': '111', 'name': 'CONSTANCIA TRANSPORTISTA HABIL', 'price': '64.60'},
    {'code': '112', 'name': 'HABILITACION DE CONDUCTORES', 'price': '57.50'},
    {'code': '113', 'name': 'CERTIF. HABILITACION TECNICA (TERMINAL/RUTA)', 'price': '146.90'},
    {'code': '114', 'name': 'HABILITACION VEHICULAR MERCANCIAS (INCR/SUST)', 'price': '53.40'},
    {'code': '115', 'name': 'HABILITACION VEHICULAR PERSONAS (INCR/SUST)', 'price': '117.00'},
    {'code': '116', 'name': 'MODIF. AUTORIZACION TRANSP. MERCANCIAS', 'price': '435.40'},
    {'code': '117', 'name': 'RENOVACION AUTORIZACION TRANSP. MERCANCIAS', 'price': '38.40'},
    {'code': '118', 'name': 'RENUNCIA AUTORIZACION TRANSP. MERCANCIAS', 'price': '178.40'},
    {'code': '120', 'name': 'AUTORIZACION IPRESS - RECSAL', 'price': '712.90'},
    {'code': '121', 'name': 'AUTORIZACION EVENTUAL TRANSP. PERSONAS', 'price': '87.60'},
    {'code': '122', 'name': 'AUTORIZACION TRANSP. PRIVADO PERSONAS', 'price': '424.00'},
    {'code': '123', 'name': 'AUTORIZACION TRANSP. REGULAR PERSONAS', 'price': '195.10'},
    {'code': '124', 'name': 'AUTORIZACION TALLERES GLP', 'price': '235.50'},
    {'code': '125', 'name': 'MODIF. AUTORIZACION TRANSP. PERSONAS', 'price': '435.40'},
    {'code': '126', 'name': 'RENOVACION AUTORIZACION TRANSP. PERSONAS', 'price': '227.35'},
    {'code': '127', 'name': 'RENUNCIA AUTORIZACION TRANSP. PERSONAS', 'price': '25.50'},
    {'code': '128', 'name': 'AUTORIZACION SERV. TRANSP. TURISTICO', 'price': '395.10'},
    {'code': '129', 'name': 'AUTORIZACION SERV. TRANSP. TRABAJADORES', 'price': '124.10'},
    {'code': '130', 'name': 'AUTORIZACION SERV. TRANSP. AUTO COLECTIVO', 'price': '394.90'},
    {'code': '131', 'name': 'EXAMEN CONOCIMIENTOS LICENCIA CLASE A', 'price': '50.00'},
    {'code': '132', 'name': 'EXAMEN HABILIDADES CONDUCCION CLASE A', 'price': '60.00'},
    {'code': '133', 'name': 'RENUNCIA A LICENCIA DE CONDUCIR', 'price': '49.00'},
    {'code': '134', 'name': 'CANJE LICENCIA POR MODIFICACION', 'price': '38.30'},
    {'code': '135', 'name': 'DUPLICADO LICENCIA (PERDIDA/ROBO)', 'price': '33.50'},
    {'code': '136', 'name': 'CANJE LICENCIA OTRO PAIS', 'price': '38.30'},
    {'code': '137', 'name': 'LICENCIA DE CONDUCIR (DIRECTO)', 'price': '33.50'},
    {'code': '138', 'name': 'RECATEGORIZACION LICENCIA', 'price': '33.50'},
    {'code': '139', 'name': 'REVALIDACION LICENCIA', 'price': '33.50'},
    {'code': '140', 'name': 'REVALIDACION LICENCIA ESPECIAL (MAT. PELIG)', 'price': '33.50'},
    {'code': '141', 'name': 'LICENCIA ESPECIAL (MAT. PELIGROSOS)', 'price': '33.50'},
    {'code': '200', 'name': 'LEVANTAMIENTO ORDEN DEPÓSITO VEHICULAR', 'price': 'LIBRE'},
    {'code': '204', 'name': 'MULTAS INFRACCIONES RNAT', 'price': 'LIBRE'},
    {'code': '205', 'name': 'OTROS INGRESOS DIVERSOS', 'price': 'LIBRE'},
    {'code': '206', 'name': 'CONSTANCIA DE LICENCIA DE CONDUCIR', 'price': '26.20'},
    {'code': '207', 'name': 'OTROS INGRESOS DIVERSOS (LABORATORIO)', 'price': 'LIBRE'},
    {'code': '208', 'name': 'RENOVACION CON CAMBIOS TALLER GLP', 'price': '235.50'},
    {'code': '209', 'name': 'RENOVACION SIN CAMBIOS TALLER GLP', 'price': '211.50'},
    {'code': '210', 'name': 'LICENCIA ELECTRONICA CLASE A', 'price': '6.00'},
    {'code': '211', 'name': 'LICENCIA PROVISIONAL EXTRANJEROS', 'price': '18.30'},
    {'code': '212', 'name': 'LICENCIA SERV. DIPLOMATICO', 'price': '38.30'},
    {'code': '213', 'name': 'REVALIDACION LICENCIA ELECTRONICA', 'price': '6.00'},
    {'code': '214', 'name': 'REVALIDACION PROVISIONAL EXTRANJEROS', 'price': '18.10'},
    {'code': '215', 'name': 'CANJE LICENCIA MILITAR O POLICIAL', 'price': '62.40'},
    {'code': '216', 'name': 'CANJE PROVISIONAL EXTRANJEROS', 'price': '38.30'},
    {'code': '217', 'name': 'CANJE LIC. SOLICITADO SERV. DIPLOMATICO', 'price': '38.30'},
    {'code': '218', 'name': 'CANJE LICENCIA ELECTRONICA (MODIF)', 'price': '6.00'},
    {'code': '219', 'name': 'DUPLICADO LICENCIA ELECTRONICA', 'price': '6.00'},
    {'code': '220', 'name': 'REGISTRO RAD. NO IONIZANTES', 'price': '214.40'},
    {'code': '221', 'name': 'REGISTRO VALOR AÑADIDO', 'price': '214.40'},
    {'code': '222', 'name': 'REGISTRO COMERCIALIZADORES', 'price': '192.00'},
    {'code': '223', 'name': 'ALQUILER DE PISTA (LIGERO)', 'price': '37.38'},
    {'code': '224', 'name': 'ALQUILER DE PISTA (PESADO)', 'price': '49.44'},
  ];

  @override
  void initState() {
    super.initState();
    _filteredServices = _allServices;
  }

  void _filterServices(String query) {
    setState(() {
      _filteredServices = _allServices
          .where((service) =>
              service['name']!.toLowerCase().contains(query.toLowerCase()) ||
              service['code']!.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Costos de Servicios - TUPA 2024"),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue[800],
            child: TextField(
              controller: _searchController,
              onChanged: _filterServices,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Buscar por nombre o código...",
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredServices.length,
              itemBuilder: (context, index) {
                final service = _filteredServices[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[900],
                      child: Text(service['code']!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    title: Text(service['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    trailing: Text(
                      service['price'] == 'LIBRE' ? 'LIBRE' : "S/. ${service['price']}",
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
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
