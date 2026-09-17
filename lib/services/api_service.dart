import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment.dart';

class ApiService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collection = 'appointments';

  // GUARDAR O ACTUALIZAR: Si ya existe el DNI y la Categoría, lo actualiza.
  Future<void> upsertExamResult(Appointment appointment) async {
    try {
      // Buscamos si ya existe un registro para este DNI y esta categoría exacta
      var query = await _db.collection(_collection)
          .where('dni', isEqualTo: appointment.dni)
          .where('category', isEqualTo: appointment.category)
          .get();

      if (query.docs.isNotEmpty) {
        // Si existe, actualizamos el primer documento encontrado
        await _db.collection(_collection).doc(query.docs.first.id).update(appointment.toMap());
      } else {
        // Si no existe, creamos uno nuevo
        await _db.collection(_collection).add(appointment.toMap());
      }
    } catch (e) {
      print("Error en ApiService (upsert): $e");
      rethrow;
    }
  }

  // BUSCAR: Obtiene todos los exámenes de un DNI
  Future<List<Appointment>> searchExamsByDni(String dni) async {
    try {
      var query = await _db.collection(_collection)
          .where('dni', isEqualTo: dni)
          .get();
      return query.docs.map((doc) => Appointment.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error en búsqueda: $e");
      return [];
    }
  }

  // Búsqueda por nombre
  Future<List<Appointment>> searchExamsByName(String name) async {
    try {
      var query = await _db.collection(_collection)
          .where('name', isGreaterThanOrEqualTo: name.toUpperCase())
          .where('name', isLessThanOrEqualTo: name.toUpperCase() + '\uf8ff')
          .get();
      return query.docs.map((doc) => Appointment.fromFirestore(doc)).toList();
    } catch (e) {
      return [];
    }
  }
}
