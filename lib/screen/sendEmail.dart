import 'package:blogapp/screen/ProfilPage.dart';
import 'package:blogapp/screen/resetPassword.dart';
import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/page_title.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Envoyer un e-mail avec le lien de réinitialisation
      Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPasswordPage()));
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
                children: [
                  const PageTitle(
                    title: 'Forgot Password',
                    subtitle: 'Enter your email to reset your password',
                  ),
                  const SizedBox(height: 32),
                  CustomInput(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    validator: validateEmail,
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(text: 'Send Reset Link', onPressed: _submit),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Profilpage()));
                    },
                    child: const Text('Back to Login'),
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
