// =====================================================================
// icon_card.dart - Isi kartu gender: ikon besar dengan teks di bawahnya
// =====================================================================

import 'package:flutter/material.dart';
import 'package:bmi/constants.dart';

class IconCard extends StatelessWidget {
  IconCard({this.cardIcon, required this.caption});

  final IconData? cardIcon; // ikon yang ditampilkan
  final String caption; // teks di bawah ikon, contoh: "MALE"

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(cardIcon, size: 70.0),
        const SizedBox(height: 15.0), // jarak antara ikon dan teks
        Text(caption, style: labelTextStyle),
      ],
    );
  }
}
