// =====================================================================
// bottom_button.dart - Tombol merah lebar di bagian bawah halaman
// Dipakai sebagai "CALCULATE BMR" dan "RE-CALCULATE".
// =====================================================================

import 'package:flutter/material.dart';
import 'package:bmi/constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.buttonTitle, required this.onTap});

  final String buttonTitle; // tulisan pada tombol
  final Function() onTap; // fungsi yang dijalankan saat tombol ditekan

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        height: bottomContainerHeight,
        color: bottomContainerColor,
        child: Center(child: Text(buttonTitle, style: buttonTextStyle)),
      ),
    );
  }
}
