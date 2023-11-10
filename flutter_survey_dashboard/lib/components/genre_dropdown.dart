import 'package:flutter/material.dart';

class GenreDropdown extends StatefulWidget {
  final List<String> genres;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const GenreDropdown({
    super.key,
    required this.genres,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<GenreDropdown> createState() {
    return _GenreDropdownState();
  }
}

class _GenreDropdownState extends State<GenreDropdown> {
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
      items: widget.genres.map<DropdownMenuItem<String>>((String value) {
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
