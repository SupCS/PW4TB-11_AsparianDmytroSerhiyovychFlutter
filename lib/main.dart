import 'package:flutter/material.dart';
import 'screens/example7_1_screen.dart';
import 'screens/example7_2_screen.dart';
import 'screens/example7_3_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electrical Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Головний екран')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Example7_1Screen()),
              ),
              child: Text('Example 7.1'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Example7_2Screen()),
              ),
              child: Text('Example 7.2'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Example7_3Screen()),
              ),
              child: Text('Example 7.3'),
            ),
          ],
        ),
      ),
    );
  }
}
