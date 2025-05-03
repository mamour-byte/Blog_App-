import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/page_title.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Réinitialiser le mot de passe via l'API

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
                    title: 'Reset Password',
                    subtitle: 'Enter your new password',
                  ),
                  const SizedBox(height: 32),
                  CustomInput(
                    controller: _newPasswordController,
                    label: 'New Password',
                    hintText: 'Enter new password',
                    obscureText: true,
                    validator: validatePassword,
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Re-enter new password',
                    obscureText: true,
                    validator: (val) => validateConfirmPassword(
                      _newPasswordController.text,
                      val,
                    ),
                    icon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(text: 'Reset Password', onPressed: _submit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
