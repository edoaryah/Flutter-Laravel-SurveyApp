import 'package:flutter/material.dart';

class NationalityDropdown extends StatefulWidget {
  final List<String> nationalities;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const NationalityDropdown({
    super.key,
    required this.nationalities,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<NationalityDropdown> createState() {
    return _NationalityDropdownState();
  }
}

class _NationalityDropdownState extends State<NationalityDropdown> {
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
      items: widget.nationalities.map<DropdownMenuItem<String>>((String value) {
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
