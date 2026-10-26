// =====================================================================
// custom_card.dart - Widget kotak berwarna yang bisa ditekan
//
// Dipakai di banyak tempat (gender, tinggi, berat, umur, hasil).
// Dibuat sebagai widget sendiri agar kode tidak ditulis berulang.
// =====================================================================

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({required this.color, this.cardChild, this.onPress});

  final Color color; // warna latar kartu
  final Widget? cardChild; // isi kartu (boleh kosong)
  final Function()? onPress; // fungsi yang dijalankan saat kartu ditekan

  @override
  Widget build(BuildContext context) {
    // GestureDetector mendeteksi ketukan (tap) pada kartu.
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.only(left: 1.0, right: 1.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}
