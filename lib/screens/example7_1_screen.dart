import 'dart:math';
import 'package:flutter/material.dart';

class Example7_1Screen extends StatefulWidget {
  @override
  _Example7_1ScreenState createState() => _Example7_1ScreenState();
}

class _Example7_1ScreenState extends State<Example7_1Screen> {
  final TextEditingController inputSm = TextEditingController();
  final TextEditingController inputIk = TextEditingController();
  final TextEditingController inputTf = TextEditingController();
  final TextEditingController inputUnom = TextEditingController();
  final TextEditingController inputTm = TextEditingController();

  String result = '';

  void calculate() {
    double Sm = double.tryParse(inputSm.text.replaceAll(',', '.')) ?? 0.0;
    double Ik = double.tryParse(inputIk.text.replaceAll(',', '.')) ?? 0.0;
    double tf = double.tryParse(inputTf.text.replaceAll(',', '.')) ?? 0.0;
    double Unom = double.tryParse(inputUnom.text.replaceAll(',', '.')) ?? 0.0;
    double Tm = double.tryParse(inputTm.text.replaceAll(',', '.')) ?? 0.0;

    double Jek = 1.4; // Густина струму
    double Ct = 92.0; // Константа для термічної стійкості

    if (Sm > 0 && Ik > 0 && tf > 0 && Unom > 0 && Tm > 0) {
      double Im = Sm / (2 * sqrt(3.0) * Unom);
      double ImPa = 2 * Im;
      double Sek = Im / Jek;
      double Smin = (Ik * sqrt(tf)) / Ct;

      setState(() {
        result = """
Розрахунковий струм для нормального режиму: ${Im.toStringAsFixed(2)} A
Розрахунковий струм для післяаварійного режиму: ${ImPa.toStringAsFixed(2)} A
Економічний переріз: ${Sek.toStringAsFixed(2)} мм²
Мінімальний переріз для термічної стійкості: ${Smin.toStringAsFixed(2)} мм²
""";
      });
    } else {
      setState(() {
        result = "Будь ласка, введіть коректні значення";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example 7.1')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                  controller: inputSm,
                  decoration: InputDecoration(
                      labelText: 'Розрахункове навантаження (кВА)')),
              TextField(
                  controller: inputIk,
                  decoration: InputDecoration(labelText: 'Струм КЗ (А)')),
              TextField(
                  controller: inputTf,
                  decoration: InputDecoration(labelText: 'Час дії КЗ (с)')),
              TextField(
                  controller: inputUnom,
                  decoration:
                      InputDecoration(labelText: 'Номінальна напруга (кВ)')),
              TextField(
                  controller: inputTm,
                  decoration: InputDecoration(
                      labelText: 'Розрахункова тривалість (год)')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: calculate, child: Text('Розрахувати')),
              SizedBox(height: 20),
              Text(result, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
