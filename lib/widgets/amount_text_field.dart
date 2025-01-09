import 'package:flutter/material.dart';

class AmountTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const AmountTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '0.00',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        filled: true,
        fillColor: const Color(0xffEFEFEF),
      ),
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      onChanged: onChanged,
    );
  }
}
