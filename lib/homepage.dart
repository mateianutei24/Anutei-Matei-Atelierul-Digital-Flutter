import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  final double _ronToEuroExchangeRate = 0.20;
  final double _euroToRonExchangeRate = 4.94;

  // if _exchangeFromLeiToEuro is true the program will exchange from lei to euro, if false from euro to lei
  bool _exchangeFromLeiToEuro = true;

  // _initialValue stores a correct value from the text-field
  double? _initialValue;
  // _errorText stores the error message for the text-field
  String? _errorText;
  //_isTextFieldReadOnly variable makes the text-field read-only if the app is waiting for the user to begin another exchange
  bool _isTextFieldReadOnly = false;

  String _buttonText = 'Exchange';

  //_responseIsVisible tells the app to show or not to show the widget containing the response
  bool _responseIsVisible = false;
  // _responseValue stores the actual response
  String? _responseValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Exchange app',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio<bool>(
                    value: true,
                    groupValue: _exchangeFromLeiToEuro,
                    onChanged: (bool? value) {
                      setState(() {
                        _exchangeFromLeiToEuro = true;
                      });
                    },
                  ),
                  const Text(
                    'Convert from RON to EURO',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio<bool>(
                    value: false,
                    groupValue: _exchangeFromLeiToEuro,
                    onChanged: (bool? value) {
                      setState(() {
                        _exchangeFromLeiToEuro = false;
                      });
                    },
                  ),
                  const Text(
                    'Convert from EURO to RON',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              TextField(
                keyboardType: TextInputType.number,
                readOnly: _isTextFieldReadOnly,
                onChanged: (String value) {
                  setState(() {
                    if (double.tryParse(value) != null) {
                      _errorText = null;
                      _initialValue = double.parse(value);
                    } else {
                      _errorText = 'Your input is invalid!';
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Introduce the sum of money you wish to exchange!',
                  errorText: _errorText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_buttonText == 'Exchange') {
                        if (_initialValue != null && _errorText == null) {
                          if (_exchangeFromLeiToEuro) {
                            _responseValue =
                                '${(_initialValue! * _ronToEuroExchangeRate).toStringAsFixed(2)} EURO';
                          } else {
                            _responseValue =
                                '${(_initialValue! * _euroToRonExchangeRate).toStringAsFixed(2)} RON';
                          }
                          _responseIsVisible = true;
                          _buttonText = 'Introduce another value for exchange';
                          _isTextFieldReadOnly = true;
                        } else {
                          _errorText = "You have to introduce a valid value!";
                        }
                      } else {
                        _responseValue = null;
                        _responseIsVisible = false;
                        _buttonText = 'Exchange';
                        _isTextFieldReadOnly = false;
                      }
                    });
                  },
                  child: Text(
                    _buttonText,
                  ),
                ),
              ),
              if (_responseIsVisible)
                Text(
                  '$_responseValue',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
