// =====================================================================
// round_icon_button.dart - Tombol bulat untuk "-" dan "+"
// Dipakai pada kartu berat badan dan umur.
// =====================================================================

import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed});

  final IconData icon; // ikon di tengah tombol
  final Function() onPressed; // fungsi yang dijalankan saat ditekan

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      constraints: const BoxConstraints.tightFor(width: 40.0, height: 40.0),
      shape: const CircleBorder(), // bentuk lingkaran
      fillColor: const Color(0xFF4C4F5E),
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
