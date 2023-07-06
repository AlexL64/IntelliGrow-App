import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.label, required this.controller});

  final String label;
  // Controller du textFiled pour récupérer ça valeur
  final TextEditingController controller;

  // TextField custom
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey.shade900),
          borderRadius: BorderRadius.circular(5.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
      controller: controller,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
