import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../utils/app_colors.dart';

Future<void> showPremiumUnlockSheet(BuildContext context) async {
  if (FirebaseAuth.instance.currentUser != null) {
    return;
  }

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          20 + MediaQuery.of(sheetContext).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 54,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: AppColors.premiumGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.workspace_premium, color: Colors.white, size: 30),
                  SizedBox(height: 18),
                  Text(
                    'Unlock Premium Features',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Create a free BankHub Pakistan account to synchronize your banking experience across devices.',
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _AuthActionButton(
              icon: Icons.g_mobiledata,
              label: 'Continue with Google',
              onTap: () => _openLogin(context, sheetContext),
            ),
            const SizedBox(height: 10),
            _AuthActionButton(
              icon: Icons.apple,
              label: 'Continue with Apple',
              onTap: () => _openLogin(context, sheetContext),
            ),
            const SizedBox(height: 10),
            _AuthActionButton(
              icon: Icons.email_outlined,
              label: 'Continue with Email',
              onTap: () => _openLogin(context, sheetContext),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.pop(sheetContext),
              child: const Text('Continue as Guest'),
            ),
          ],
        ),
      );
    },
  );
}

void _openLogin(BuildContext context, BuildContext sheetContext) {
  Navigator.pop(sheetContext);
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
  );
}

class _AuthActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AuthActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}