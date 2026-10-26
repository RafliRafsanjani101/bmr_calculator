// =====================================================================
// main.dart - Titik masuk (entry point) aplikasi BMR Calculator
//
// ALUR PROGRAM SECARA KESELURUHAN:
// 1. main()               -> menjalankan aplikasi lewat runApp()
// 2. MyApp                -> mengatur tema gelap, lalu membuka InputPage
// 3. InputPage            -> pengguna mengisi gender, tinggi, berat, umur,
//                            dan memilih rumus BMR
// 4. Tombol CALCULATE     -> membuat objek Calculator dan menghitung BMR
// 5. ResultPage           -> menampilkan BMR dan tabel kebutuhan kalori harian
// 6. Tombol RE-CALCULATE  -> kembali ke InputPage (Navigator.pop)
// =====================================================================

import 'package:flutter/material.dart';
import 'package:bmi/pages/input_page.dart';

// Fungsi pertama yang dijalankan Dart saat aplikasi dibuka.
void main() {
  runApp(const MyApp());
}

// Widget akar (root) aplikasi. Tidak punya state, jadi StatelessWidget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tema gelap: dasar ThemeData.dark(), lalu warna disesuaikan.
      // Pengaturan tema ditulis sekali di sini dan berlaku di semua halaman.
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),
          centerTitle: true,
          elevation: 0.0,
        ),
      ),
      // Halaman pertama yang tampil adalah halaman input data.
      home: InputPage(),
    );
  }
}
