import 'package:flutter/material.dart';
import 'screens/app_shell.dart';
import 'utils/app_theme.dart';

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
      theme: AppTheme.lightTheme,
      home: const AppShell(),
    );
  }
}