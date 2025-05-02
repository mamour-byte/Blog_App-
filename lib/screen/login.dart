import 'package:blogapp/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/page_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginWithGoogle() {
    // TODO: Google login
  }

  void _loginWithFacebook() {
    // TODO: Facebook login
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Login logic
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
                  const PageTitle(title: 'Login', subtitle: 'Welcome back!'),
                  const SizedBox(height: 32),
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
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(text: 'Login', onPressed: _submit),
                  const SizedBox(height: 24),
                  const Text('or', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  SignInButton(Buttons.Google, onPressed: _loginWithGoogle),
                  const SizedBox(height: 10),
                  SignInButton(Buttons.Facebook, onPressed: _loginWithFacebook),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
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
