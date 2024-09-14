import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Tarea-2-Statefull-widgets/components/MenuCustomised.dart';
import 'package:Tarea-2-Statefull-widgets/components/text_blank.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _value1 = 0;
  int _value2 = 0;
  int _result = 0;
  String _selectedOperation = 'Selecciona una operación';
  String _operation = '';

  final NumberFormat _numberFormat = NumberFormat('#,##0');

  void _calculate() {
    if (_operation.isEmpty) return;

    setState(() {
      _result = {
        '+': _value1 + _value2,
        '-': _value1 - _value2,
        '*': _value1 * _value2,
        '/': (_value2 == 0) ? 0 : _value1 ~/ _value2,
      }[_operation] ?? 0;
    });
  }

  void _handleOperationChanged(String operation) {
    const operationMap = {
      'Suma': '+',
      'Resta': '-',
      'Multiplicación': '*',
      'División': '/'
    };

    setState(() {
      _operation = operationMap[operation] ?? '';
      _selectedOperation = operation;
    });
    _calculate();
  }

  void _handleValueChanged(int index, int value) {
    setState(() {
      if (index == 1) _value1 = value;
      if (index == 2) _value2 = value;
    });
    _calculate();
  }

  Widget _buildTextField(String title, int index) {
    return TextFieldCustom(
      title: title,
      onChanged: (value) => _handleValueChanged(index, int.parse(value)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculator App', textAlign: TextAlign.center),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_numberFormat.format(_value1)} $_operation ${_numberFormat.format(_value2)} = ${_numberFormat.format(_result)}',
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              _buildTextField('Introduce un valor', 1),
              _buildTextField('Introduce un valor', 2),
              DropdownCustom(
                onChanged: _handleOperationChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
