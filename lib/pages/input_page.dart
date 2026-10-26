import 'package:flutter/material.dart';
import 'package:bmi/bottom_button.dart';
import 'package:bmi/calculator.dart';
import 'package:bmi/constants.dart';
import 'package:bmi/custom_card.dart';
import 'package:bmi/icon.dart';
import 'package:bmi/round_icon_button.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // Inisialisasi nilai default untuk Gender, Height, Weight, dan Age
  Gender selectedGender = Gender.male;
  int height = 160;
  int weight = 60;
  int age = 20; // Mengaktifkan variabel age untuk BMR

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMR CALCULATOR')), // Mengubah judul aplikasi
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Bagian Pemilihan Gender (Male / Female)
              SizedBox(
                height: 180.0,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        color: selectedGender == Gender.male
                            ? activeCardColor
                            : inactiveCardColor,
                        cardChild: const IconCard(
                          cardIcon: Icons.male,
                          caption: 'MALE',
                        ),
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.male; // Update state gender ke laki-laki
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomCard(
                        color: selectedGender == Gender.female
                            ? activeCardColor
                            : inactiveCardColor,
                        cardChild: const IconCard(
                          cardIcon: Icons.female,
                          caption: 'FEMALE',
                        ),
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.female; // Update state gender ke perempuan
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // 2. Bagian Slider Tinggi Badan (Height)
              SizedBox(
                height: 220.0,
                child: CustomCard(
                  color: activeCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('HEIGHT', style: labelTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(height.toString(), style: numberTextStyle),
                          const Text('cm', style: labelTextStyle),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: const Color(0xFF8D8E98),
                          thumbColor: const Color(0xFFEB1555),
                          overlayColor: const Color(0x29EB1555),
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: height.toDouble(),
                          min: 120.0,
                          max: 220.0,
                          onChanged: (double value) {
                            setState(() {
                              height = value.round(); // Update nilai tinggi badan
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 3. Bagian Input Berat Badan (Weight) & Umur (Age)
              SizedBox(
                height: 220.0,
                child: Row(
                  children: [
                    // Kolom Berat Badan
                    Expanded(
                      child: CustomCard(
                        color: activeCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('WEIGHT', style: labelTextStyle),
                            Text(weight.toString(), style: numberTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    setState(() { if (weight >= 30) weight--; }); // Kurangi berat
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                RoundIconButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    setState(() { weight++; }); // Tambah berat
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Kolom Umur
                    Expanded(
                      child: CustomCard(
                        color: activeCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('AGE', style: labelTextStyle),
                            Text(age.toString(), style: numberTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: Icons.remove,
                                  onPressed: () {
                                    setState(() { if (age > 0) age--; }); // Kurangi umur
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                RoundIconButton(
                                  icon: Icons.add,
                                  onPressed: () {
                                    setState(() { age++; }); // Tambah umur
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 4. Tombol Hitung BMR
              BottomButton(
                buttonTitle: 'CALCULATE BMR',
                onTap: () {
                  // Inisialisasi object Calculator dengan data yang diinput user
                  Calculator cal = Calculator(
                    height: height,
                    weight: weight,
                    age: age,
                    gender: selectedGender,
                  );
                  // Eksekusi fungsi kalkulasi
                  String bmr = cal.calculateBMR();
                  String result = cal.getResult();
                  String information = cal.getInterpretation();
                  
                  // Pindah ke halaman hasil dengan membawa data hasil perhitungan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        result: result,
                        bmr: bmr, // Menggunakan variabel bmr menggantikan bmi
                        information: information,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
