import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final Function(String?) onSaved;
  final int? maxLines;
  final String? initialValue;

  const MyTextField({
    Key? key,
    required this.label,
    required this.keyboardType,
    required this.onSaved,
    this.maxLines,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onSaved: onSaved,
      initialValue: initialValue,
    );
  }
}
