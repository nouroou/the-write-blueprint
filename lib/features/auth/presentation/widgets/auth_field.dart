import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController editingController;
  final bool isPassword;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.editingController,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    bool passwordHidden = false;
    return TextFormField(
      controller: editingController,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: isPassword ? _showPassword(passwordHidden) : null),
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
    );
  }

  IconButton _showPassword(bool passwordHidden) => IconButton(
      onPressed: () {
        if (passwordHidden) {
          passwordHidden = false;
        } else {
          passwordHidden = true;
        }
      },
      icon: Icon(
          passwordHidden ? Icons.visibility_off_outlined : Icons.visibility));
}
