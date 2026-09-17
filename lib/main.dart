import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      // Estos son los datos de la aplicación en Firebase para la plataforma
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyDG1a0BbqP_Rb0q04n0izq8q0kDFW_t_FU",
          authDomain: "orientacion-ae87b.firebaseapp.com",
          projectId: "orientacion-ae87b",
          storageBucket: "orientacion-ae87b.firebasestorage.app",
          messagingSenderId: "833426703342",
          appId: "1:833426703342:web:9ab9c8eead3fd04b40c4ff",
          measurementId: "G-4YS92RQB25",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    print("Firebase conectado con éxito en Chrome");
  } catch (e) {
    print("Error conectando Firebase: $e");
  }

  runApp(const OrientacionApp());
}

class OrientacionApp extends StatelessWidget {
  const OrientacionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orientación para Licencia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
