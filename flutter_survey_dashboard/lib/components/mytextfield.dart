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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onSaved: onSaved,
          initialValue: initialValue,
        ),
      ],
    );
  }
}
