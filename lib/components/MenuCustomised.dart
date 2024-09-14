import 'package:flutter/material.dart';

class DropdownCustom extends StatefulWidget {
  const DropdownCustom({super.key, required this.onChanged});

  final Function(String) onChanged;

  @override
  State<DropdownCustom> createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  final List<String> _operations = ['Suma', 'Resta', 'Multiplicación', 'División'];
  String _selectedOperation = 'Suma';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedOperation,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedOperation = newValue;
          });
          widget.onChanged(_selectedOperation);
        }
      },
      items: _operations.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
