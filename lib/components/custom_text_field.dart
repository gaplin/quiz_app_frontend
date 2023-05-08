import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int minSymbols;
  final int maxSymbols;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.minSymbols,
    required this.maxSymbols,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      child: TextFormField(
        controller: controller,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
        validator: (value) {
          if (value == null ||
              value.length < minSymbols ||
              value.length > maxSymbols) {
            return 'Minimum $minSymbols and maximum $maxSymbols required';
          }
          return null;
        },
      ),
    );
  }
}
