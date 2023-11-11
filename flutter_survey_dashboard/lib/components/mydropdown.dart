import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final List<String> items;
  final String label;
  final Function(String?) onChanged;
  final double? width;
  final String Function(String)? displayText;
  final String? initialValue;

  const MyDropdown({
    Key? key,
    required this.items,
    required this.label,
    required this.onChanged,
    this.width,
    this.displayText,
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
        DropdownButtonFormField(
          value: initialValue,
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(displayText != null ? displayText!(item) : item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
