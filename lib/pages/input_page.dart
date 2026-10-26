// =====================================================================
// input_page.dart - Halaman input data pengguna
//
// ALUR HALAMAN INI:
// 1. Pengguna memilih gender, menggeser slider tinggi, mengatur berat
//    dan umur dengan tombol -/+, lalu memilih rumus BMR.
// 2. Setiap perubahan memanggil setState() agar tampilan diperbarui.
// 3. Jika rumus Katch-McArdle dipilih, muncul slider Body Fat.
// 4. Tombol CALCULATE BMR: buat objek Calculator, hitung BMR, lalu
//    pindah ke ResultPage sambil membawa hasilnya.
// =====================================================================

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi/components/custom_card.dart';
import 'package:bmi/components/icon_card.dart';
import 'package:bmi/constants.dart';

import 'result_page.dart';

import 'package:bmi/components/bottom_button.dart';
import 'package:bmi/components/round_icon_button.dart';
import 'package:bmi/calculator.dart';

// StatefulWidget karena tampilannya berubah mengikuti input pengguna.
class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // ---------- STATE: data yang diubah pengguna ----------
  Gender selectedGender = Gender.male; // gender terpilih
  BmrFormula formula = BmrFormula.mifflin; // rumus terpilih
  int height = 160; // tinggi (cm)
  int weight = 60; // berat (kg)
  int age = 25; // umur (tahun)
  int bodyFat = 20; // lemak tubuh (%), untuk Katch-McArdle

  // Gaya slider (warna jalur dan tombol geser), dipakai oleh slider
  // tinggi badan dan slider lemak tubuh.
  SliderThemeData sliderStyle() {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: Colors.white,
      inactiveTrackColor: const Color(0xFF8D8E98),
      thumbColor: const Color(0xFFEB1555),
      overlayColor: const Color(0x29EB1555),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMR CALCULATOR')),
      body: SafeArea(
        // SingleChildScrollView: halaman bisa digulir bila layar tidak muat,
        // karena sekarang ada lebih banyak input dibanding versi BMI.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------- 1. Pilihan gender ----------
              // Kartu yang terpilih berwarna activeCardColor, sisanya redup.
              SizedBox(
                height: 180.0,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        color: selectedGender == Gender.male
                            ? activeCardColor
                            : inactiveCardColor,
                        cardChild: IconCard(
                          cardIcon: FontAwesomeIcons.mars.data,
                          caption: 'MALE',
                        ),
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomCard(
                        color: selectedGender == Gender.female
                            ? activeCardColor
                            : inactiveCardColor,
                        cardChild: IconCard(
                          cardIcon: FontAwesomeIcons.venus.data,
                          caption: 'FEMALE',
                        ),
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ---------- 2. Tinggi badan (slider 120-220 cm) ----------
              SizedBox(
                height: 200.0,
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
                        data: sliderStyle(),
                        child: Slider(
                          value: height.toDouble(),
                          min: 120.0,
                          max: 220.0,
                          // Dipanggil setiap slider digeser.
                          onChanged: (double value) {
                            setState(() {
                              height = value.round();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- 3. Berat badan dan umur ----------
              // Berat minimal 30 kg. Umur dibatasi 15-80 tahun,
              // sama seperti calculator.net.
              SizedBox(
                height: 200.0,
                child: Row(
                  children: [
                    // Kartu berat badan
                    Expanded(
                      child: CustomCard(
                        color: activeCardColor,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('WEIGHT (kg)', style: labelTextStyle),
                            Text(weight.toString(), style: numberTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus.data,
                                  onPressed: () {
                                    setState(() {
                                      if (weight > 30) {
                                        weight--;
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus.data,
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Kartu umur (baru, dibutuhkan semua rumus BMR)
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
                                  icon: FontAwesomeIcons.minus.data,
                                  onPressed: () {
                                    setState(() {
                                      if (age > 15) {
                                        age--;
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(width: 10.0),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus.data,
                                  onPressed: () {
                                    setState(() {
                                      if (age < 80) {
                                        age++;
                                      }
                                    });
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

              // ---------- 4. Pilihan rumus BMR (dropdown) ----------
              // Satu item untuk setiap nilai enum BmrFormula.
              CustomCard(
                color: activeCardColor,
                cardChild: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('FORMULA', style: labelTextStyle),
                      DropdownButton<BmrFormula>(
                        isExpanded: true,
                        value: formula,
                        dropdownColor: activeCardColor,
                        underline: const SizedBox(),
                        items: [
                          for (final f in BmrFormula.values)
                            DropdownMenuItem<BmrFormula>(
                              value: f,
                              child: Text(formulaNames[f]!),
                            ),
                        ],
                        onChanged: (BmrFormula? value) {
                          if (value != null) {
                            setState(() {
                              formula = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- 5. Lemak tubuh (khusus Katch-McArdle) ----------
              // "if" di dalam daftar children: kartu hanya muncul jika
              // rumus Katch-McArdle yang dipilih.
              if (formula == BmrFormula.katchMcArdle)
                SizedBox(
                  height: 200.0,
                  child: CustomCard(
                    color: activeCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('BODY FAT', style: labelTextStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(bodyFat.toString(), style: numberTextStyle),
                            const Text('%', style: labelTextStyle),
                          ],
                        ),
                        SliderTheme(
                          data: sliderStyle(),
                          child: Slider(
                            value: bodyFat.toDouble(),
                            min: 5.0,
                            max: 50.0,
                            onChanged: (double value) {
                              setState(() {
                                bodyFat = value.round();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ---------- 6. Tombol hitung ----------
              BottomButton(
                buttonTitle: 'CALCULATE BMR',
                onTap: () {
                  // a. Buat objek Calculator dari data yang diisi pengguna.
                  Calculator cal = Calculator(
                    height: height,
                    weight: weight,
                    age: age,
                    gender: selectedGender,
                    formula: formula,
                    bodyFat: bodyFat,
                  );
                  // b. Hitung BMR (harus dipanggil sebelum getDailyNeeds).
                  String bmr = cal.calculateBMR();

                  // c. Pindah ke ResultPage dan kirim hasilnya lewat
                  //    constructor (cara mengirim data antar halaman).
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        result: cal.getResult(),
                        bmr: bmr,
                        information: cal.getInterpretation(),
                        activities: cal.getDailyNeeds(),
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
