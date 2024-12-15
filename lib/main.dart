import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora Simples'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = "0";
  String _currentInput = "";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Limpar tudo
        _output = "0";
        _currentInput = "";
        _operator = "";
        _num1 = 0;
        _num2 = 0;
      } else if (value == "+" || value == "-" || value == "x" || value == "/") {
        // Configurar operador e salvar o primeiro número
        if (_currentInput.isNotEmpty) {
          _num1 = double.parse(_currentInput);
          _operator = value;
          _currentInput = "";
        }
      } else if (value == "=") {
        // Realizar cálculo
        if (_currentInput.isNotEmpty && _operator.isNotEmpty) {
          _num2 = double.parse(_currentInput);

          switch (_operator) {
            case "+":
              _output = (_num1 + _num2).toString();
              break;
            case "-":
              _output = (_num1 - _num2).toString();
              break;
            case "x":
              _output = (_num1 * _num2).toString();
              break;
            case "/":
              _output = _num2 != 0 ? (_num1 / _num2).toString() : "Erro";
              break;
          }
          _currentInput = _output;
          _operator = "";
        }
      } else {
        // Concatenar números
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String value, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _output,
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(children: ["7", "8", "9", "/"].map(_buildButton).toList()),
              Row(children: ["4", "5", "6", "x"].map(_buildButton).toList()),
              Row(children: ["1", "2", "3", "-"].map(_buildButton).toList()),
              Row(children: ["C", "0", "=", "+"].map(_buildButton).toList()),
            ],
          )
        ],
      ),
    );
  }
}
