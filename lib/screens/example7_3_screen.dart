import 'dart:math';
import 'package:flutter/material.dart';

class Example7_3Screen extends StatefulWidget {
  @override
  _Example7_3ScreenState createState() => _Example7_3ScreenState();
}

class _Example7_3ScreenState extends State<Example7_3Screen> {
  final TextEditingController inputUxMax = TextEditingController();
  final TextEditingController inputSnomT = TextEditingController();
  final TextEditingController inputRcN = TextEditingController();
  final TextEditingController inputXcN = TextEditingController();
  final TextEditingController inputRcMin = TextEditingController();
  final TextEditingController inputXcMin = TextEditingController();
  final TextEditingController inputUbN = TextEditingController();
  final TextEditingController inputUnn = TextEditingController();

  String result = '';

  double hypot(double a, double b) {
    return sqrt(a * a + b * b);
  }

  void calculate() {
    double Ux_max =
        double.tryParse(inputUxMax.text.replaceAll(',', '.')) ?? 0.0;
    double Snom_t =
        double.tryParse(inputSnomT.text.replaceAll(',', '.')) ?? 0.0;
    double Rc_n = double.tryParse(inputRcN.text.replaceAll(',', '.')) ?? 0.0;
    double Xc_n = double.tryParse(inputXcN.text.replaceAll(',', '.')) ?? 0.0;
    double Rc_min =
        double.tryParse(inputRcMin.text.replaceAll(',', '.')) ?? 0.0;
    double Xc_min =
        double.tryParse(inputXcMin.text.replaceAll(',', '.')) ?? 0.0;
    double Ub_n = double.tryParse(inputUbN.text.replaceAll(',', '.')) ?? 0.0;
    double Unn = double.tryParse(inputUnn.text.replaceAll(',', '.')) ?? 0.0;

    if (Ux_max > 0 &&
        Snom_t > 0 &&
        Rc_n > 0 &&
        Xc_n > 0 &&
        Rc_min > 0 &&
        Xc_min > 0 &&
        Ub_n > 0 &&
        Unn > 0) {
      double Xt = (Ux_max * Ub_n * Ub_n) / (100 * Snom_t);
      double Xsh_n = Xc_n + Xt;
      double Zsh_n = hypot(Rc_n, Xsh_n);
      double Ip3_n = (Ub_n * 1000) / (sqrt(3.0) * Zsh_n);
      double Ip2_n = Ip3_n * sqrt(3.0) / 2;

      double Xsh_min = Xc_min + Xt;
      double Zsh_min = hypot(Rc_min, Xsh_min);
      double Ip3_min = (Ub_n * 1000) / (sqrt(3.0) * Zsh_min);
      double Ip2_min = Ip3_min * sqrt(3.0) / 2;

      double kpr = (Unn * Unn) / (Ub_n * Ub_n);
      double Rsh_n_adj = Rc_n * kpr;
      double Xsh_n_adj = Xsh_n * kpr;
      double Zsh_n_adj = hypot(Rsh_n_adj, Xsh_n_adj);
      double Rsh_min_adj = Rc_min * kpr;
      double Xsh_min_adj = Xsh_min * kpr;
      double Zsh_min_adj = hypot(Rsh_min_adj, Xsh_min_adj);

      double I3_sh_n = (Unn * 1000) / (sqrt(3.0) * Zsh_n_adj);
      double I2_sh_n = I3_sh_n * sqrt(3.0) / 2;
      double I3_sh_min = (Unn * 1000) / (sqrt(3.0) * Zsh_min_adj);
      double I2_sh_min = I3_sh_min * sqrt(3.0) / 2;

      double Ln = 0.2 + 0.35 + 0.2 + 0.6 + 2 + 2.55 + 3.37 + 3.1;
      double R0 = 0.64;
      double X0 = 0.363;
      double Rn = Ln * R0;
      double Xn = Ln * X0;

      double Rx_n = Rn + Rsh_n_adj;
      double Xx_n = Xn + Xsh_n_adj;
      double Zx_n = hypot(Rx_n, Xx_n);
      double Rx_min = Rn + Rsh_min_adj;
      double Xx_min = Xn + Xsh_min_adj;
      double Zx_min = hypot(Rx_min, Xx_min);

      double I3_t10_n = (Unn * 1000) / (sqrt(3.0) * Zx_n);
      double I2_t10_n = I3_t10_n * sqrt(3.0) / 2;
      double I3_t10_min = (Unn * 1000) / (sqrt(3.0) * Zx_min);
      double I2_t10_min = I3_t10_min * sqrt(3.0) / 2;

      setState(() {
        result = """
Розрахунок для нормального режиму:
Xt: ${Xt.toStringAsFixed(2)} Ом
Xш (нормальний): ${Xsh_n.toStringAsFixed(2)} Ом
Zш (нормальний): ${Zsh_n.toStringAsFixed(2)} Ом
Струм трифазного КЗ (Ip3, нормальний): ${Ip3_n.toStringAsFixed(2)} А
Струм двофазного КЗ (Ip2, нормальний): ${Ip2_n.toStringAsFixed(2)} А

Розрахунок для мінімального режиму:
Xш (мінімальний): ${Xsh_min.toStringAsFixed(2)} Ом
Zш (мінімальний): ${Zsh_min.toStringAsFixed(2)} Ом
Струм трифазного КЗ (Ip3, мінімальний): ${Ip3_min.toStringAsFixed(2)} А
Струм двофазного КЗ (Ip2, мінімальний): ${Ip2_min.toStringAsFixed(2)} А
Коефіцієнт приведення (kpr): ${kpr.toStringAsFixed(3)}
Rш в нормальному режимі, приведений: ${Rsh_n_adj.toStringAsFixed(2)} Ом
Xш в нормальному режимі, приведений: ${Xsh_n_adj.toStringAsFixed(2)} Ом
Zш в нормальному режимі, приведений: ${Zsh_n_adj.toStringAsFixed(2)} Ом
Rш в мінімальному режимі, приведений: ${Rsh_min_adj.toStringAsFixed(2)} Ом
Xш в мінімальному режимі, приведений: ${Xsh_min_adj.toStringAsFixed(2)} Ом
Zш в мінімальному режимі, приведений: ${Zsh_min_adj.toStringAsFixed(2)} Ом
Дійсний струм трифазного КЗ (I3) в нормальному режимі: ${I3_sh_n.toStringAsFixed(2)} А
Дійсний струм двофазного КЗ (I2) в нормальному режимі: ${I2_sh_n.toStringAsFixed(2)} А
Дійсний струм трифазного КЗ (I3) в мінімальному режимі: ${I3_sh_min.toStringAsFixed(2)} А
Дійсний струм двофазного КЗ (I2) в мінімальному режимі: ${I2_sh_min.toStringAsFixed(2)} А
Довжина проводу (Ln): ${Ln.toStringAsFixed(2)} км
Резистивний опір (Rn): ${Rn.toStringAsFixed(2)} Ом
Реактивний опір (Xn): ${Xn.toStringAsFixed(2)} Ом
Rx в нормальному режимі: ${Rx_n.toStringAsFixed(2)} Ом
Xx в нормальному режимі: ${Xx_n.toStringAsFixed(2)} Ом
Zx в нормальному режимі: ${Zx_n.toStringAsFixed(2)} Ом
Rx в мінімальному режимі: ${Rx_min.toStringAsFixed(2)} Ом
Xx в мінімальному режимі: ${Xx_min.toStringAsFixed(2)} Ом
Zx в мінімальному режимі: ${Zx_min.toStringAsFixed(2)} Ом
Струм трифазного КЗ в точці 10 (I3) в нормальному режимі: ${I3_t10_n.toStringAsFixed(2)} А
Струм двофазного КЗ в точці 10 (I2) в нормальному режимі: ${I2_t10_n.toStringAsFixed(2)} А
Струм трифазного КЗ в точці 10 (I3) в мінімальному режимі: ${I3_t10_min.toStringAsFixed(2)} А
Струм двофазного КЗ в точці 10 (I2) в мінімальному режимі: ${I2_t10_min.toStringAsFixed(2)} А
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
      appBar: AppBar(title: Text('Example 7.3')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Введіть вхідні параметри:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(
                  controller: inputUxMax,
                  decoration: InputDecoration(
                      labelText: 'Ux max (Максимальне значення напруги)')),
              TextField(
                  controller: inputSnomT,
                  decoration: InputDecoration(
                      labelText:
                          'Snom T (Номінальна потужність трансформатора)')),
              TextField(
                  controller: inputRcN,
                  decoration: InputDecoration(
                      labelText:
                          'Rc N (Опір короткого замикання, нормальний режим)')),
              TextField(
                  controller: inputXcN,
                  decoration: InputDecoration(
                      labelText: 'Xc N (Реактивний опір, нормальний режим)')),
              TextField(
                  controller: inputRcMin,
                  decoration: InputDecoration(
                      labelText:
                          'Rc Min (Опір короткого замикання, мінімальний режим)')),
              TextField(
                  controller: inputXcMin,
                  decoration: InputDecoration(
                      labelText:
                          'Xc Min (Реактивний опір, мінімальний режим)')),
              TextField(
                  controller: inputUbN,
                  decoration:
                      InputDecoration(labelText: 'Ub N (Номінальна напруга)')),
              TextField(
                  controller: inputUnn,
                  decoration:
                      InputDecoration(labelText: 'Unn (Розрахункова напруга)')),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    onPressed: calculate, child: Text('Розрахувати')),
              ),
              SizedBox(height: 20),
              Text(result, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
