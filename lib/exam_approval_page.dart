import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/appointment.dart';

class ExamApprovalPage extends StatefulWidget {
  const ExamApprovalPage({super.key});

  @override
  State<ExamApprovalPage> createState() => _ExamApprovalPageState();
}

class _ExamApprovalPageState extends State<ExamApprovalPage> {
  final ApiService _api = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Appointment> _searchResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;

  void _onSearch() async {
    String query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isSearching = true;
      _hasSearched = true;
    });

    try {
      List<Appointment> results = await _api.searchExamsByDni(query);
      if (results.isEmpty) {
        results = await _api.searchExamsByName(query);
      }

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() => _isSearching = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error en la búsqueda: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aprobación de Exámenes"),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child: _isSearching
                ? const Center(child: CircularProgressIndicator())
                : _hasSearched
                    ? _buildSearchResults()
                    : _buildInitialMessage(),
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
          Text("CONSULTA DE RESULTADOS", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Busca por DNI, C.E. o Nombre completo", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "DNI, C.E. o Nombre",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.search),
              ),
              textCapitalization: TextCapitalization.characters,
              onSubmitted: (_) => _onSearch(),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: _onSearch,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
            child: const Text("Buscar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialMessage() {
    return const Center(child: Text("Ingresa tus datos para consultar", style: TextStyle(color: Colors.grey)));
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(child: Text("No se encontraron resultados."));
    }

    final Map<String, List<Appointment>> grouped = {};
    for (var app in _searchResults) {
      if (!grouped.containsKey(app.dni)) grouped[app.dni] = [];
      grouped[app.dni]!.add(app);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: grouped.entries.map((entry) {
        final exams = entry.value;
        final name = exams.first.name;
        final dni = entry.key;
        final docType = exams.first.documentType;
        final medicalDate = exams.first.medicalExamDate;

        final conocimiento = exams.firstWhere((e) => e.category == 'CONOCIMIENTO', 
          orElse: () => Appointment(dni: dni, name: name, category: 'CONOCIMIENTO', date: DateTime.now()));

        final manejo = exams.firstWhere((e) => e.category == 'MANEJO', 
          orElse: () => Appointment(dni: dni, name: name, category: 'MANEJO', date: DateTime.now()));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPersonHeader(name, dni, docType),
            if (medicalDate != null) _buildMedicalStatus(medicalDate),
            const SizedBox(height: 10),
            _buildResultCard("EXAMEN DE CONOCIMIENTO", conocimiento),
            
            if (conocimiento.isPassed == false)
              _buildOpportunityMessage("Tienen otra oportunidad, pero deberán pagar 50 soles por el re-examen."),

            if (conocimiento.isPassed == true) ...[
              _buildOpportunityMessage("¡Felicidades! Pasaste a la siguiente etapa. El pago para el Examen de Manejo es de 60 soles."),
              _buildResultCard("EXAMEN DE MANEJO", manejo),
            ],
            const Divider(height: 40),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildPersonHeader(String name, String dni, String type) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      color: Colors.grey[200],
      child: Text("$type: $dni\nPOSTULANTE: $name", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
    );
  }

  Widget _buildMedicalStatus(DateTime emissionDate) {
    final expirationDate = DateTime(emissionDate.year, emissionDate.month + 6, emissionDate.day);
    final bool isExpired = DateTime.now().isAfter(expirationDate);

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isExpired ? Colors.red[50] : Colors.green[50],
        border: Border.all(color: isExpired ? Colors.red : Colors.green, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isExpired ? Icons.dangerous : Icons.verified_user, color: isExpired ? Colors.red : Colors.green, size: 20),
              const SizedBox(width: 8),
              Text(
                "EXAMEN MÉDICO: ${isExpired ? 'VENCIDO' : 'VIGENTE'}", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isExpired ? Colors.red[800] : Colors.green[800]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _dateInfo("Emisión:", emissionDate),
              _dateInfo("Vencimiento:", expirationDate, isVenc: true),
            ],
          ),
          if (isExpired) 
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text("⚠️ Debe renovar su examen médico para poder tramitar su licencia.", style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.w500)),
            ),
        ],
      ),
    );
  }

  Widget _dateInfo(String label, DateTime date, {bool isVenc = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold)),
        Text(
          "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isVenc ? Colors.blueGrey[800] : Colors.black87),
        ),
      ],
    );
  }

  Widget _buildOpportunityMessage(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.blue),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildResultCard(String title, Appointment app) {
    bool? isPassed = app.isPassed;
    Color statusColor = isPassed == true ? Colors.green : (isPassed == false ? Colors.red : Colors.orange);
    String statusText = isPassed == true ? "APROBADO" : (isPassed == false ? "DESAPROBADO" : "PENDIENTE");

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(isPassed == true ? Icons.check_circle : Icons.info, color: statusColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        subtitle: app.score != null ? Text("Puntaje: ${app.score}/40") : null,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(12)),
          child: Text(statusText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
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
