import 'dart:math';
import 'package:flutter/material.dart';

class Example7_2Screen extends StatefulWidget {
  @override
  _Example7_2ScreenState createState() => _Example7_2ScreenState();
}

class _Example7_2ScreenState extends State<Example7_2Screen> {
  final TextEditingController inputUsn =
      TextEditingController(); // Номінальна напруга (кВ)
  final TextEditingController inputSk =
      TextEditingController(); // Потужність КЗ (МВА)

  String result = '';

  void calculate() {
    double Usn = double.tryParse(inputUsn.text.replaceAll(',', '.')) ?? 0.0;
    double Sk = double.tryParse(inputSk.text.replaceAll(',', '.')) ?? 0.0;

    double UkPercentage = 10.5; // Відсоток напруги КЗ
    double Sn = 6.3; // Стандартна потужність

    if (Usn > 0 && Sk > 0) {
      double Xc = (Usn * Usn) / Sk;
      double Xt = (UkPercentage / 100) * ((Usn * Usn) / Sn);
      double Xsum = Xc + Xt;
      double Ip0 = (Usn * 1000) / (sqrt(3.0) * Xsum);

      setState(() {
        result = """
Опір Xc: ${Xc.toStringAsFixed(2)} Ом
Опір Xt: ${Xt.toStringAsFixed(2)} Ом
Сумарний опір Xсум: ${Xsum.toStringAsFixed(2)} Ом
Початкове діюче значення струму трифазного КЗ (Ip0): ${Ip0.toStringAsFixed(2)} А
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
      appBar: AppBar(title: Text('Example 7.2')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                  controller: inputUsn,
                  decoration:
                      InputDecoration(labelText: 'Номінальна напруга (кВ)')),
              TextField(
                  controller: inputSk,
                  decoration:
                      InputDecoration(labelText: 'Потужність КЗ (МВА)')),
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
