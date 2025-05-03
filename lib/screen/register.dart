import 'package:blogapp/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../models/api_response.dart';
import '../models/user.dart';
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
  bool loading = false;

  void registerUser() async {
    setState(() {
      loading = true;
    });
    APIResponse response = await register(_nameController.text, _emailController.text, _passwordController.text);
    setState(() {
      loading = false;
    });
    if (response.error == null) {
      _saveAndRedirectionToHome(response.data as User);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}')),
      );
    }
  }


  void _saveAndRedirectionToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      registerUser();
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
                  CustomButton(
                    text: loading ? 'Loading...' : 'Sign up',
                    onPressed: loading ? null : _submit,
                  ),
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
                        child: const Text("Sign In"),
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
