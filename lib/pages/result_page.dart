// =====================================================================
// result_page.dart - Halaman hasil perhitungan BMR
//
// ALUR HALAMAN INI:
// 1. Menerima data dari InputPage lewat constructor
//    (nama rumus, nilai BMR, catatan, dan daftar kebutuhan kalori).
// 2. Menampilkan nama rumus, angka BMR, lalu tabel kebutuhan kalori
//    harian untuk 6 tingkat aktivitas.
// 3. Tombol RE-CALCULATE memanggil Navigator.pop() untuk kembali
//    ke InputPage.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:bmi/components/custom_card.dart';
import 'package:bmi/constants.dart';
import 'package:bmi/components/bottom_button.dart';
import 'package:bmi/calculator.dart';

// StatelessWidget karena halaman ini hanya menampilkan data, tanpa state.
class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.result,
    required this.bmr,
    required this.information,
    required this.activities,
  });

  final String result; // nama rumus yang dipakai
  final String bmr; // nilai BMR (kkal/hari)
  final String information; // catatan di bagian bawah
  final List<ActivityNeed> activities; // isi tabel aktivitas

  // Memberi pemisah ribuan pada angka. Contoh: 2060 menjadi 2.060.
  String formatNumber(int n) {
    return n.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (m) => '.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMR CALCULATOR')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Judul halaman
          const Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            child: Text(
              'Your Result',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ),

          // Kartu hasil memenuhi sisa tinggi layar (Expanded).
          Expanded(
            child: CustomCard(
              color: activeCardColor,
              cardChild: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(result, style: resultTextStyle), // nama rumus
                    Text(bmr, style: bmrTextStyle), // angka BMR
                    const Text('kkal / hari', style: labelTextStyle),
                    const Divider(height: 28.0),
                    const Text(
                      'Kebutuhan kalori harian berdasarkan aktivitas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Tabel aktivitas: satu baris untuk setiap ActivityNeed.
                    // ListView membuat tabel bisa digulir bila tidak muat.
                    Expanded(
                      child: ListView(
                        children: [
                          for (final a in activities)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      a.label,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Text(
                                    formatNumber(a.calories),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      information,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF8D8E98),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Kembali ke halaman input (menghapus halaman ini dari tumpukan).
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
