import 'package:flutter/material.dart';

class GenderDropdown extends StatefulWidget {
  final List<String> genders;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const GenderDropdown({
    super.key,
    required this.genders,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<GenderDropdown> createState() {
    return _GenderDropdownState();
  }
}

class _GenderDropdownState extends State<GenderDropdown> {
  late String currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentValue,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            currentValue = newValue;
          });
          widget.onChanged(newValue);
        }
      },
      items: widget.genders.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 15),
          ),
        );
      }).toList(),
    );
  }
}
