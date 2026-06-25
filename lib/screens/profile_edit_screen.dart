import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ProfileEditScreen extends StatefulWidget {
  final User? user;

  const ProfileEditScreen({super.key, required this.user});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final AuthService _authService = AuthService();
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool _isEditing = false;
  String? _successMessage;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.displayName ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _phoneController = TextEditingController(text: widget.user?.phoneNumber ?? '');
  }

  void _updateProfile() async {
    final displayName = _nameController.text.trim();

    if (displayName.isEmpty) {
      setState(() => _errorMessage = 'Please enter a name');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    final result = await _authService.updateProfile(displayName, null);
    setState(() => _isLoading = false);

    if (result.isSuccess) {
      setState(() {
        _successMessage = 'Profile updated successfully';
        _isEditing = false;
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _successMessage = null);
        }
      });
    } else {
      setState(() => _errorMessage = result.error);
    }
  }

  void _signOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sign Out')),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      await _authService.signOut();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  void _deleteAccount() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('This action cannot be undone. Are you sure you want to delete your account?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirm == true && widget.user != null) {
      setState(() => _isLoading = true);
      await _authRepository.deleteUserAccount(widget.user!.uid);
      await widget.user!.delete();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 0,
        actions: [
          if (_isEditing)
            TextButton(
              onPressed: _isLoading ? null : () => setState(() => _isEditing = false),
              child: const Text('Cancel'),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.indigo.shade50,
                  child: Icon(
                    Icons.person,
                    color: Colors.indigo.shade900,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.user?.displayName ?? 'User',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.user?.email ?? '',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (_successMessage != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade300),
              ),
              child: Text(
                _successMessage!,
                style: TextStyle(color: Colors.green.shade900),
              ),
            ),
          const SizedBox(height: 16),
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
          if (!_isEditing)
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () => setState(() => _isEditing = true),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _signOut,
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _deleteAccount,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete Account'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Display Name', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Email cannot be changed',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Link phone number in settings',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _updateProfile,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save Changes', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
