import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../repositories/auth_repository.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  void _signInWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please fill in all fields');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authService.signInWithEmail(email, password);
    setState(() => _isLoading = false);

    if (result.isSuccess && result.data != null) {
      if (mounted) Navigator.pop(context);
    } else {
      setState(() => _errorMessage = result.error);
    }
  }

  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authService.signInWithGoogle();
    setState(() => _isLoading = false);

    if (result.isSuccess && result.data != null) {
      final user = result.data!;
      await _authRepository.createUserProfile(user.uid, user.email ?? '', user.displayName ?? 'User');
      if (mounted) Navigator.pop(context);
    } else {
      setState(() => _errorMessage = result.error);
    }
  }

  void _signInWithApple() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authService.signInWithApple();
    setState(() => _isLoading = false);

    if (result.isSuccess && result.data != null) {
      final user = result.data!;
      await _authRepository.createUserProfile(user.uid, user.email ?? '', user.displayName ?? 'User');
      if (mounted) Navigator.pop(context);
    } else {
      setState(() => _errorMessage = result.error);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
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
              const SizedBox(height: 24),
              const Text(
                'Welcome to BankHub',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Pakistan's Smart Banking Platform",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade900),
                  ),
                ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email address',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text('Forgot password?'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _signInWithEmail,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Sign In', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Or continue with'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : _signInWithGoogle,
                      icon: const Icon(Icons.g_mobiledata),
                      label: const Text('Google'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : _signInWithApple,
                      icon: const Icon(Icons.apple),
                      label: const Text('Apple'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
