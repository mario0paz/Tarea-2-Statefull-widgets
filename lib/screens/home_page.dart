import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:statefull_pratice/components/MenuCustomised.dart';
import 'package:statefull_pratice/components/text_blank.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _capturedValue = 0;
  int _capturedValue2 = 0;
  int _result = 0;
  String _selectedOperation = 'Selecciona una operación';
  String _operation = '';

  final NumberFormat _numberFormat = NumberFormat('#,##0');

  void _calculate() {
    setState(() {
      switch (_operation) {
        case '+':
          _result = _capturedValue + _capturedValue2;
          break;
        case '-':
          _result = _capturedValue - _capturedValue2;
          break;
        case '*':
          _result = _capturedValue * _capturedValue2;
          break;
        case '/':
          _result = (_capturedValue2 == 0) ? 0 : _capturedValue ~/ _capturedValue2;
          break;
        default:
          _result = 0;
      }
    });
  }

  void _handleOperationChanged(String operation) {
    setState(() {
      switch (operation) {
        case 'Suma':
          _operation = '+';
          break;
        case 'Resta':
          _operation = '-';
          break;
        case 'Multiplicación':
          _operation = '*';
          break;
        case 'División':
          _operation = '/';
          break;
      }
      _selectedOperation = operation;
    });
    _calculate();
  }

  void _handleValueChanged(int index, value) {
    setState(() {
      if (index == 1) {
        _capturedValue = value;
      } else {
        _capturedValue2 = value;
      }
    });
    _calculate();
  }

  Widget _buildTextField(String title, int index) {
    return TextFieldCustom(
      title: title,
      onChanged: (value) => _handleValueChanged(index, value),
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
                '${_numberFormat.format(_capturedValue)} $_operation ${_numberFormat.format(_capturedValue2)} = ${_numberFormat.format(_result)}',
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
