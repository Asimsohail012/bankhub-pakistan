import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/auth_wrapper.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const AuthWrapper(),
    );
  }
}