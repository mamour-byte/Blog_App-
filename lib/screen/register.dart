import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/page_title.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Registration logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PageTitle(title: 'Register', subtitle: 'Create a new account'),
                  const SizedBox(height: 32),
                  CustomInput(
                    controller: _nameController,
                    label: 'Full Name',
                    hintText: 'Enter your full name',
                    validator: validateName,
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    validator: validateEmail,
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    validator: validatePassword,
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    obscureText: true,
                    validator: (val) => validateConfirmPassword(_passwordController.text, val),
                    icon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(text: 'Register', onPressed: _submit),
                  const SizedBox(height: 24),
                  const Text('or', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  SignInButton(Buttons.Google, onPressed: () {}),
                  const SizedBox(height: 10),
                  SignInButton(Buttons.Facebook, onPressed: () {}),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
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
