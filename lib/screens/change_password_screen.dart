import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flickreview/l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    final l10n = AppLocalizations.of(context)!;

    final user = currentUser;
    final oldPass = _oldController.text.trim();
    final newPass = _newController.text.trim();
    final confirmPass = _confirmController.text.trim();

    if (user == null) {
      _showMessage('Please sign in again');
      return;
    }

    if (user.email == null) {
      _showMessage('Email account not found');
      return;
    }

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      _showMessage(l10n.allFieldsRequired);
      return;
    }

    if (newPass.length < 6) {
      _showMessage('New password must be at least 6 characters');
      return;
    }

    if (newPass != confirmPass) {
      _showMessage(l10n.passwordMismatch);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPass,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPass);

      if (!mounted) return;

      _showMessage('Password changed successfully');

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = 'Failed to change password';

      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = l10n.wrongPassword;
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      } else if (e.code == 'requires-recent-login') {
        message = 'Please sign in again before changing password';
      } else if (e.code == 'network-request-failed') {
        message = 'No internet connection';
      }

      _showMessage(message);
    } catch (e) {
      if (!mounted) return;
      _showMessage('Something went wrong');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.changePassword), centerTitle: true),
        body: const Center(child: Text('Please sign in first')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.changePassword), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _passwordField(
              controller: _oldController,
              label: l10n.oldPassword,
              obscure: _obscureOld,
              toggle: () => setState(() => _obscureOld = !_obscureOld),
            ),

            const SizedBox(height: 16),

            _passwordField(
              controller: _newController,
              label: l10n.newPassword,
              obscure: _obscureNew,
              toggle: () => setState(() => _obscureNew = !_obscureNew),
            ),

            const SizedBox(height: 16),

            _passwordField(
              controller: _confirmController,
              label: l10n.confirmPassword,
              obscure: _obscureConfirm,
              toggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _changePassword,
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.saveChanges),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
