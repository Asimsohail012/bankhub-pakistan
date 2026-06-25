import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BankHubPakistan());
}

class BankHubPakistan extends StatelessWidget {
  const BankHubPakistan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BankHub Pakistan',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}