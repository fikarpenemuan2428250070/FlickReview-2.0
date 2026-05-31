import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flickreview/l10n/app_localizations.dart';
import 'sign_in_screen.dart';

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

  Map<String, dynamic>? currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  // CEK LOGIN
  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUserJson = prefs.getString("currentUser");

    if (currentUserJson == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
      return;
    }

    setState(() {
      currentUser = jsonDecode(currentUserJson);
    });
  }

  /// 🔄 GANTI PASSWORD (REAL FIX)
  Future<void> _changePassword() async {
    final prefs = await SharedPreferences.getInstance();
    final l10n = AppLocalizations.of(context)!;

    final oldPass = _oldController.text.trim();
    final newPass = _newController.text.trim();
    final confirmPass = _confirmController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      _showMessage(l10n.allFieldsRequired);
      return;
    }

    if (oldPass != currentUser!['password']) {
      _showMessage(l10n.wrongPassword);
      return;
    }

    if (newPass != confirmPass) {
      _showMessage(l10n.passwordMismatch);
      return;
    }

    // 🔁 UPDATE USERS LIST
    List<String> users = prefs.getStringList("users") ?? [];

    for (int i = 0; i < users.length; i++) {
      final user = jsonDecode(users[i]);
      if (user['username'] == currentUser!['username']) {
        user['password'] = newPass;
        users[i] = jsonEncode(user);
        currentUser = user;
        break;
      }
    }

    await prefs.setStringList("users", users);
    await prefs.setString("currentUser", jsonEncode(currentUser));

    _showMessage(l10n.profileUpdated);

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.changePassword), centerTitle: true),
      body: Padding(
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
                onPressed: _changePassword,
                child: Text(l10n.saveChanges),
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
      ),
    );
  }
}
