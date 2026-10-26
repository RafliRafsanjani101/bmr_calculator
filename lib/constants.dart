// =====================================================================
// constants.dart - Kumpulan konstanta yang dipakai di seluruh aplikasi
//
// Warna, ukuran, gaya teks, dan enum dikumpulkan di satu file supaya
// tidak ditulis berulang dan mudah diubah dari satu tempat.
// =====================================================================

import 'package:flutter/material.dart';

// ---------- Warna & ukuran ----------
const activeCardColor = Color(0xFF1D1E33); // kartu yang aktif / terpilih
const inactiveCardColor = Color(0xFF111328); // kartu yang tidak terpilih
const bottomContainerHeight = 80.0; // tinggi tombol merah di bawah
const bottomContainerColor = Color(0xFFEB1555); // warna tombol merah

// ---------- Enum ----------
// Enum = tipe data buatan sendiri yang nilainya terbatas.

// Gender hanya bisa bernilai male atau female.
enum Gender { male, female }

// Tiga rumus BMR yang tersedia (sama seperti calculator.net).
enum BmrFormula { mifflin, harrisBenedict, katchMcArdle }

// Nama rumus yang ditampilkan ke pengguna.
// Dipakai pada pilihan rumus di InputPage dan judul hasil di ResultPage.
const formulaNames = {
  BmrFormula.mifflin: 'Mifflin St Jeor',
  BmrFormula.harrisBenedict: 'Revised Harris-Benedict',
  BmrFormula.katchMcArdle: 'Katch-McArdle',
};

// ---------- Gaya teks ----------
const labelTextStyle = TextStyle(fontSize: 18.0, color: Color(0xFF8D8E98));

const numberTextStyle = TextStyle(fontSize: 45.0, fontWeight: FontWeight.w900);

const buttonTextStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

const resultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

// Angka BMR pada halaman hasil (sebelumnya bmiTextStyle berukuran 100).
const bmrTextStyle = TextStyle(fontSize: 70, fontWeight: FontWeight.bold);
