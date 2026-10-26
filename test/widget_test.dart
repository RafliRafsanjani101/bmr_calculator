// Tes sederhana: memastikan halaman input tampil saat aplikasi dibuka.
// Jalankan dengan: flutter test

import 'package:flutter_test/flutter_test.dart';
import 'package:bmi/main.dart';

void main() {
  testWidgets('Halaman input BMR tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('BMR CALCULATOR'), findsOneWidget);
    expect(find.text('CALCULATE BMR'), findsOneWidget);
  });
}
