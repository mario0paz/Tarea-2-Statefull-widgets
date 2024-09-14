import 'package:flutter/material.dart';

class TextCustom extends StatefulWidget {
  const TextCustom(
      {super.key,
      required this.title,
      required this.onChanged,
      required this.onChanged2});

  final String title;
  final Function(int) onChanged;
  final VoidCallback onChanged2;
  @override
  State<TextCustom> createState() => _TextCustomState();
}

class _TextCustomState extends State<TextCustom> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          final intValue = int.parse(value);
          widget.onChanged(intValue);
          widget.onChanged2();
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: widget.title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
