import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lab2',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Operaciones Aritmeticas'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _primerValorController = TextEditingController();
  TextEditingController _segundoValorController = TextEditingController();
  String _resultado = '';
  String? _operacion;

  void _calcular() {
    if (_formKey.currentState!.validate() && _operacion != null) {
      double primerValor = double.parse(_primerValorController.text);
      double segundoValor = double.parse(_segundoValorController.text);

      switch (_operacion) {
        case 'Suma':
          _resultado = (primerValor + segundoValor).toStringAsFixed(0);
          break;
        case 'Resta':
          _resultado = (primerValor - segundoValor).toStringAsFixed(0);
          break;
        case 'Multiplicacion':
          _resultado = (primerValor * segundoValor).toStringAsFixed(0);
          break;
        case 'Division':
          if (segundoValor == 0) {
            _resultado = 'no es posible una division entre 0';
          } else {
            _resultado = (primerValor / segundoValor).toString();
          }
          break;
      }
      setState(() {});
    } else {
      setState(() {
        _resultado = 'seleccione una operacion';
      });
    }
  }

  void _limpiar() {
    _primerValorController.clear();
    _segundoValorController.clear();
    _operacion = null;
    _resultado = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _primerValorController,
                decoration: InputDecoration(
                  labelText: 'valor#1',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ingrese el primer valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'ingrese un numero valido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _segundoValorController,
                decoration: InputDecoration(
                  labelText: 'segundo Valor',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ingrese el segundo valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'ingrese un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Label',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _operacion,
                    hint: Text('seleccione una operacion'),
                    items: <String>[
                      'Suma',
                      'Resta',
                      'Multiplicacion',
                      'Division'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _operacion = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calcular,
                child: Text('Calcular'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _limpiar,
                child: Text('Limpiar'),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Resultado: $_resultado',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calcular,
        tooltip: 'Calcular',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
