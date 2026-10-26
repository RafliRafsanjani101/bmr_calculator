import 'package:flutter/material.dart';
import 'package:bmi/bottom_button.dart';
import 'package:bmi/constants.dart';
import 'package:bmi/custom_card.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.result,
    required this.bmr, // Menangkap data bmr
    required this.information,
  });

  final String result;
  final String bmr;
  final String information;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMR CALCULATOR')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Your Result',
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Kartu yang menampilkan Angka BMR dan interpretasinya
          Expanded(
            flex: 5,
            child: CustomCard(
              color: activeCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(result, style: resultTextStyle),
                  Text(bmr, style: bmiTextStyle), // Menampilkan hasil BMR
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      information,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Tombol Hitung Ulang untuk kembali ke halaman input
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
