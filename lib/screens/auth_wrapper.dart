import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_shell.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.account_balance,
                      color: Colors.indigo.shade900,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  const Text('Loading BankHub...'),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          return const AppShell();
        }

        return const LoginScreen();
      },
    );
  }
}
