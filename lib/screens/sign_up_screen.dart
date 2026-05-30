import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _errorText = '';
  bool _obsecurePassword = true;
  bool isLoading = false;

  String normalizeUsername(String username) {
    return username.trim().toLowerCase();
  }

  Future<void> _signUp() async {
    final String fullname = _nameController.text.trim();
    final String username = normalizeUsername(_usernameController.text);
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (fullname.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _errorText = 'All fields are required.';
      });
      return;
    }

    if (!RegExp(r'^[a-z0-9_\.]+$').hasMatch(username)) {
      setState(() {
        _errorText =
            'Username hanya boleh huruf kecil, angka, underscore, dan titik.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorText = 'Password confirmation is not the same.';
      });
      return;
    }

    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        _errorText =
            'Minimum 8 characters, combination of A-Z, a-z, numbers, and symbols.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      _errorText = '';
    });

    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user == null) {
        setState(() {
          _errorText = 'Registration failed.';
          isLoading = false;
        });
        return;
      }

      final usernameRef = FirebaseFirestore.instance
          .collection('usernames')
          .doc(username);

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final usernameDoc = await usernameRef.get();

      if (usernameDoc.exists) {
        await user.delete();

        setState(() {
          _errorText = 'Username already in use.';
          isLoading = false;
        });

        return;
      }

      await user.updateDisplayName(fullname);

      final batch = FirebaseFirestore.instance.batch();

      batch.set(usernameRef, {
        'uid': user.uid,
        'username': username,
        'email': email,
        'createdAt': Timestamp.now(),
      });

      batch.set(userRef, {
        'uid': user.uid,
        'fullname': fullname,
        'username': username,
        'email': email,
        'bio': '',
        'profileImageUrl': null,
        'createdAt': Timestamp.now(),
      });

      await batch.commit();

      await FirebaseAuth.instance.signOut();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SignInScreen(fromRegister: true),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed.';

      if (e.code == 'email-already-in-use') {
        message = 'Email already registered.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      } else if (e.code == 'weak-password') {
        message = 'Password too weak.';
      } else if (e.code == 'requires-recent-login') {
        message = 'Please login again before deleting account.';
      }

      setState(() {
        _errorText = message;
      });
    } on FirebaseException catch (e) {
      if (userCredential?.user != null) {
        try {
          await userCredential!.user!.delete();
        } catch (_) {}
      }

      setState(() {
        _errorText = '[${e.plugin}/${e.code}] ${e.message ?? 'Error'}';
      });
    } catch (e) {
      if (userCredential?.user != null) {
        try {
          await userCredential!.user!.delete();
        } catch (_) {}
      }

      setState(() {
        _errorText = e.toString();
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: _obsecurePassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obsecurePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obsecurePassword = !_obsecurePassword;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Fullname',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _passwordField(
                    controller: _passwordController,
                    label: 'Password',
                  ),
                  const SizedBox(height: 20),
                  _passwordField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                  ),
                  if (_errorText.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      _errorText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _signUp,
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
