import 'dart:math';

enum Gender { male, female }

class Calculator {
  // Menambahkan parameter 'age' yang wajib diisi saat inisialisasi object
  Calculator({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
  });

  final int height;
  final int weight;
  final int age;
  final Gender gender;

  double _bmr = 0.0;

  // Fungsi untuk menghitung BMR menggunakan rumus Mifflin-St Jeor
  String calculateBMR() {
    if (gender == Gender.male) {
      // Rumus BMR untuk Pria
      _bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      // Rumus BMR untuk Wanita
      _bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
    // Mengembalikan nilai dalam bentuk string tanpa angka desimal
    return _bmr.toStringAsFixed(0);
  }

  // Menentukan label hasil kalkulasi
  String getResult() {
    return 'Kalori / Hari';
  }

  // Memberikan deskripsi atau penjelasan mengenai angka BMR
  String getInterpretation() {
    return 'Ini adalah estimasi jumlah kalori basal (BMR) yang dibutuhkan tubuh Anda untuk berfungsi saat istirahat total.';
  }
}
