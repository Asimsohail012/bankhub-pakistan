import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _emailSent = false;
  String? _errorMessage;

  void _sendResetEmail() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() => _errorMessage = 'Please enter your email address');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authService.sendPasswordResetEmail(email);
    setState(() => _isLoading = false);

    if (result.isSuccess) {
      setState(() => _emailSent = true);
    } else {
      setState(() => _errorMessage = result.error);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Reset Password'),
      ),
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
                  Icons.lock_open,
                  color: Colors.indigo.shade900,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              if (_emailSent)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Check Your Email',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'We\'ve sent a password reset link to ${_emailController.text}. Please check your inbox and follow the instructions.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green.shade600,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Email sent successfully',
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Didn\'t receive the email? Check your spam folder or try with another email address.',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Back to Sign In', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Reset Your Password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Enter your email address and we\'ll send you a link to reset your password.',
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
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _sendResetEmail,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Send Reset Link', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back to Sign In'),
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
