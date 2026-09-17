import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? id;
  final String? userId;
  final String dni; 
  final String documentType; 
  final String name;
  final String category; // Tipo de Examen: CONOCIMIENTO o MANEJO
  final String licenseCategory; // Categoría: A-I, A-IIa, etc.
  final DateTime date;
  final String status;
  final bool? isPassed;
  final int? score;
  final DateTime? medicalExamDate; 

  Appointment({
    this.id,
    this.userId,
    required this.dni,
    this.documentType = 'DNI',
    required this.name,
    required this.category,
    this.licenseCategory = 'A-I',
    required this.date,
    this.status = 'pendiente',
    this.isPassed,
    this.score,
    this.medicalExamDate,
  });

  factory Appointment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Appointment(
      id: doc.id,
      userId: data['userId'],
      dni: data['dni'] ?? '',
      documentType: data['documentType'] ?? 'DNI',
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      licenseCategory: data['licenseCategory'] ?? 'A-I',
      date: (data['date'] as Timestamp).toDate(),
      status: data['status'] ?? 'pendiente',
      isPassed: data['isPassed'],
      score: data['score'],
      medicalExamDate: data['medicalExamDate'] != null 
          ? (data['medicalExamDate'] as Timestamp).toDate() 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'dni': dni,
      'documentType': documentType,
      'name': name,
      'category': category,
      'licenseCategory': licenseCategory,
      'date': date,
      'status': status,
      'isPassed': isPassed,
      'score': score,
      'medicalExamDate': medicalExamDate,
    };
  }
}
