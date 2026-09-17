import 'package:flutter_test/flutter_test.dart';
import 'package:orientacion/main.dart';

void main() {
  testWidgets('Verificación de página de inicio', (WidgetTester tester) async {
    // Carga la aplicación
    await tester.pumpWidget(const OrientacionApp());

    // Verifica que el texto de bienvenida esté presente
    expect(find.text('¡Felicidades!'), findsOneWidget);
    
    // Verifica que los botones principales existan
    expect(find.text('Ver Pasos de Orientación'), findsOneWidget);
    expect(find.text('Tasas de Pago (Scotiabank)'), findsOneWidget);
  });
}
