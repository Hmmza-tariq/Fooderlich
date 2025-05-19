import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';

class LoginScreen extends StatefulWidget {
  final String? username;

  const LoginScreen({
    super.key,
    this.username,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoggingIn = false;
  String? _errorMessage;

  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
  final TextStyle focusedStyle = const TextStyle(color: Colors.green);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(top: 44.0),
              children: [
                const SizedBox(
                  height: 200,
                  child: Image(
                    image: AssetImage(
                      'assets/fooderlich_assets/rw_logo.png',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                buildTextfield(
                  controller: _emailController,
                  hintText: '📧 Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                buildTextfield(
                  controller: _passwordController,
                  hintText: '🔒 Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                buildLoginButton(context),
                const SizedBox(height: 16),
                buildSignupLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: _isLoggingIn
          ? const Center(child: CircularProgressIndicator())
          : MaterialButton(
              color: rwColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoggingIn = true;
                    _errorMessage = null;
                  });

                  try {
                    final appStateManager =
                        Provider.of<AppStateManager>(context, listen: false);
                    final success = await appStateManager.login(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (success) {
                      if (context.mounted) {
                        // If onboarding is not complete, go to onboarding
                        if (!appStateManager.isOnboardingComplete) {
                          context.go('/onboarding');
                        } else {
                          context.go('/0');
                        }
                      }
                    } else {
                      setState(() {
                        _errorMessage =
                            'Login failed. Please check your email and password.';
                      });
                    }
                  } catch (error) {
                    setState(() {
                      _errorMessage = 'An error occurred during login.';
                    });
                  } finally {
                    setState(() {
                      _isLoggingIn = false;
                    });
                  }
                }
              },
            ),
    );
  }

  Widget buildSignupLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () {
            context.go('/signup');
          },
          child: Text(
            'Sign up',
            style: TextStyle(color: rwColor),
          ),
        ),
      ],
    );
  }

  Widget buildTextfield({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      cursorColor: rwColor,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: rwColor,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
      ),
      validator: validator,
    );
  }
}
