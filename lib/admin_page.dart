import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/appointment.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ApiService _api = ApiService();
  final _formKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  
  final _dniController = TextEditingController();
  final _nameController = TextEditingController();
  final _scoreController = TextEditingController();
  final _medicalDateController = TextEditingController();
  
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  String _documentType = 'DNI';
  String _selectedCategory = 'CONOCIMIENTO';
  String _licenseCategory = 'A-I';
  bool _isPassed = true;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  DateTime? _selectedMedicalDate;

  final List<String> _licenseCategories = [
    'A-I', 'A-IIa', 'A-IIb', 'A-IIIa', 'A-IIIb', 'A-IIIc', 
    'B-I', 'B-IIa', 'B-IIb', 'B-IIc'
  ];

  void _login() {
    if (_userController.text == 'ADMIN' && _passwordController.text == '123456') {
      setState(() {
        _isLoggedIn = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario o contraseña incorrectos")),
      );
    }
  }

  void _buscarNombrePorDocumento(String doc) async {
    if (doc.length >= 8) {
      try {
        final resultados = await _api.searchExamsByDni(doc);
        if (resultados.isNotEmpty) {
          setState(() {
            _nameController.text = resultados.first.name;
            _documentType = resultados.first.documentType;
            _licenseCategory = resultados.first.licenseCategory;
            if (resultados.first.medicalExamDate != null) {
              _selectedMedicalDate = resultados.first.medicalExamDate;
              _medicalDateController.text = "${_selectedMedicalDate!.day}/${_selectedMedicalDate!.month}/${_selectedMedicalDate!.year}";
            }
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Postulante encontrado en la base de datos"),
                duration: Duration(seconds: 1),
              ),
            );
          }
        }
      } catch (e) {
        debugPrint("Error al buscar documento: $e");
      }
    }
  }

  Future<void> _selectMedicalDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedMedicalDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedMedicalDate) {
      setState(() {
        _selectedMedicalDate = picked;
        _medicalDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _saveResult() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _api.upsertExamResult(
        Appointment(
          dni: _dniController.text.trim(),
          documentType: _documentType,
          name: _nameController.text.trim().toUpperCase(),
          category: _selectedCategory,
          licenseCategory: _licenseCategory,
          date: DateTime.now(),
          status: 'completado',
          isPassed: _isPassed,
          score: int.tryParse(_scoreController.text),
          medicalExamDate: _selectedMedicalDate,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Resultado actualizado con éxito")),
      );

      _scoreController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoggedIn ? "Panel de Administrador" : "Acceso Administrativo"),
        backgroundColor: Colors.red[900],
        foregroundColor: Colors.white,
        actions: _isLoggedIn ? [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => setState(() => _isLoggedIn = false),
          )
        ] : null,
      ),
      body: _isLoggedIn ? _buildAdminForm() : _buildLoginForm(),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_person, size: 80, color: Colors.red[900]),
              const SizedBox(height: 20),
              const Text(
                "INGRESO RESTRINGIDO",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: "Usuario",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.key),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("INGRESAR"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ACTUALIZAR CALIFICACIÓN",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: _documentType,
                    decoration: const InputDecoration(
                      labelText: "Tipo",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'DNI', child: Text("DNI")),
                      DropdownMenuItem(value: 'CE', child: Text("C.E.")),
                    ],
                    onChanged: (val) => setState(() => _documentType = val!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: _dniController,
                    onChanged: _buscarNombrePorDocumento,
                    decoration: InputDecoration(
                      labelText: _documentType == 'DNI' ? "Número de DNI" : "Número de C.E.",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.badge),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) => value!.isEmpty ? "Ingresa el número" : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nombre Completo",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              textCapitalization: TextCapitalization.characters,
              validator: (value) => value!.isEmpty ? "Ingresa el nombre" : null,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _licenseCategory,
              decoration: const InputDecoration(
                labelText: "Categoría de Licencia",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.directions_car),
              ),
              items: _licenseCategories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (val) => setState(() => _licenseCategory = val!),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _medicalDateController,
              readOnly: true,
              onTap: () => _selectMedicalDate(context),
              decoration: const InputDecoration(
                labelText: "Fecha Examen Médico",
                hintText: "Presiona para seleccionar fecha",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_services_outlined),
              ),
              validator: (value) => value!.isEmpty ? "Ingresa la fecha" : null,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: "Tipo de Examen",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'CONOCIMIENTO', child: Text("Examen de Conocimiento")),
                DropdownMenuItem(value: 'MANEJO', child: Text("Examen de Manejo")),
              ],
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _scoreController,
              decoration: const InputDecoration(
                labelText: "Puntaje (Opcional)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.score),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            SwitchListTile(
              title: const Text("¿Aprobó el examen?"),
              subtitle: Text(_isPassed ? "SÍ (APROBADO)" : "NO (DESAPROBADO)"),
              value: _isPassed,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
              onChanged: (val) => setState(() => _isPassed = val),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveResult,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("GUARDAR / ACTUALIZAR", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
