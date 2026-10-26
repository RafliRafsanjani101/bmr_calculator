// =====================================================================
// calculator.dart - Logika perhitungan BMR (tidak berisi tampilan)
//
// Memisahkan logika dari tampilan membuat kode lebih rapi (konsep OOP).
//
// ALUR:
// 1. InputPage membuat objek Calculator dengan data dari pengguna.
// 2. calculateBMR()  -> menghitung BMR sesuai rumus yang dipilih.
// 3. getDailyNeeds() -> mengalikan BMR dengan faktor aktivitas.
// 4. Hasilnya dikirim ke ResultPage untuk ditampilkan.
//
// Referensi rumus: https://www.calculator.net/bmr-calculator.html
// =====================================================================

import 'package:bmi/constants.dart';

// Model data untuk satu baris pada tabel kebutuhan kalori harian.
class ActivityNeed {
  const ActivityNeed(this.label, this.calories);

  final String label; // contoh: "Olahraga 1-3 kali/minggu"
  final int calories; // kebutuhan kalori per hari
}

class Calculator {
  // Semua data wajib (required) diisi saat objek dibuat.
  // formula dan bodyFat punya nilai bawaan karena tidak selalu dipakai.
  Calculator({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    this.formula = BmrFormula.mifflin,
    this.bodyFat = 20,
  });

  final int height; // tinggi badan (cm)
  final int weight; // berat badan (kg)
  final int age; // umur (tahun)
  final Gender gender; // male / female
  final BmrFormula formula; // rumus yang dipilih pengguna
  final int bodyFat; // lemak tubuh (%), hanya untuk Katch-McArdle

  // Hasil BMR disimpan agar bisa dipakai lagi oleh getDailyNeeds().
  double _bmr = 0.0;

  // Menghitung BMR sesuai rumus yang dipilih, mengembalikan String bulat.
  String calculateBMR() {
    switch (formula) {
      // Rumus 1: Mifflin St Jeor
      //   Pria   : 10W + 6.25H - 5A + 5
      //   Wanita : 10W + 6.25H - 5A - 161
      case BmrFormula.mifflin:
        _bmr = (10 * weight) + (6.25 * height) - (5 * age);
        _bmr += gender == Gender.male ? 5 : -161;
        break;

      // Rumus 2: Revised Harris-Benedict (koefisien pria dan wanita berbeda)
      case BmrFormula.harrisBenedict:
        if (gender == Gender.male) {
          _bmr = 13.397 * weight + 4.799 * height - 5.677 * age + 88.362;
        } else {
          _bmr = 9.247 * weight + 3.098 * height - 4.330 * age + 447.593;
        }
        break;

      // Rumus 3: Katch-McArdle
      //   370 + 21.6 x (1 - F) x W, F = lemak tubuh dalam bentuk pecahan.
      //   Persentase dibagi 100 dulu (20% menjadi 0.2).
      case BmrFormula.katchMcArdle:
        _bmr = 370 + 21.6 * (1 - bodyFat / 100) * weight;
        break;
    }
    // round() membulatkan ke bilangan bulat terdekat.
    return _bmr.round().toString();
  }

  // Nama rumus yang dipakai, ditampilkan sebagai judul di ResultPage.
  String getResult() {
    return formulaNames[formula]!;
  }

  // Kebutuhan kalori harian = BMR x faktor aktivitas.
  // Pemanggilan ini harus SETELAH calculateBMR(), karena memakai _bmr.
  List<ActivityNeed> getDailyNeeds() {
    return [
      ActivityNeed('Sedentari: sedikit atau tanpa olahraga', (_bmr * 1.2).round()),
      ActivityNeed('Olahraga 1-3 kali/minggu', (_bmr * 1.375).round()),
      ActivityNeed('Olahraga 4-5 kali/minggu', (_bmr * 1.465).round()),
      ActivityNeed('Olahraga harian, atau intens 3-4 kali/minggu', (_bmr * 1.55).round()),
      ActivityNeed('Olahraga intens 6-7 kali/minggu', (_bmr * 1.725).round()),
      ActivityNeed('Sangat intens setiap hari, atau pekerjaan fisik', (_bmr * 1.9).round()),
    ];
  }

  // Catatan singkat di bagian bawah halaman hasil.
  String getInterpretation() {
    return 'BMR adalah energi yang dibutuhkan tubuh saat istirahat total. '
        'Hasil ini hanya estimasi dari rumus, bukan pengukuran medis.';
  }
}
