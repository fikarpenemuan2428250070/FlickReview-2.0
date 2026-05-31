import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flickreview/l10n/app_localizations.dart';
import '../main.dart';

class SignInScreen extends StatefulWidget {
  final bool fromRegister;

  const SignInScreen({super.key, this.fromRegister = false});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscurePassword = true;

  bool isLoading = false;

  String errorText = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.fromRegister) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.registrationSuccess)),
        );
      }
    });
  }

  // ================= SIGN IN =================
  Future<void> signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorText = AppLocalizations.of(context)!.emailPasswordRequired;
      });

      return;
    }

    setState(() {
      isLoading = true;

      errorText = '';
    });

    try {
      // ================= FIREBASE LOGIN =================
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorText = AppLocalizations.of(context)!.userNotFound;
      } else if (e.code == 'wrong-password') {
        errorText = AppLocalizations.of(context)!.wrongPassword;
      } else if (e.code == 'invalid-email') {
        errorText = AppLocalizations.of(context)!.invalidEmail;
      } else if (e.code == 'invalid-credential') {
        errorText = AppLocalizations.of(context)!.invalidCredential;
      } else {
        errorText = AppLocalizations.of(context)!.loginFailed;
      }

      setState(() {});
    } catch (e) {
      setState(() {
        errorText = AppLocalizations.of(context)!.somethingWentWrong;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signIn)),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // ================= LOGO =================
              const Icon(
                Icons.movie_creation,
                size: 90,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),

              Text(
                l10n.welcomeBack,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              // ================= EMAIL =================
              TextFormField(
                controller: _emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  labelText: l10n.email,

                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // ================= PASSWORD =================
              TextFormField(
                controller: _passwordController,

                obscureText: obscurePassword,

                decoration: InputDecoration(
                  labelText: l10n.password,

                  border: const OutlineInputBorder(),

                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),

                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ================= ERROR =================
              if (errorText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 24),

              // ================= BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,

                    foregroundColor: Colors.white,

                    disabledBackgroundColor: Colors.deepPurple.withValues(alpha: 0.6),

                    disabledForegroundColor: Colors.white,

                    elevation: 0,

                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onPressed: isLoading ? null : signIn,

                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          l10n.signIn,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= SIGN UP LINK =================
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,

                    color: isDark ? Colors.white : Colors.deepPurple,
                  ),

                  children: [
                    TextSpan(text: "${l10n.dontHaveAccount} "),

                    TextSpan(
                      text: l10n.register,

                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,

                        decoration: TextDecoration.underline,
                      ),

                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/signup');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
