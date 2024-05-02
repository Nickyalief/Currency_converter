import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headline6: TextStyle(fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 18),
        ),
      ),
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _rupiahController = TextEditingController();
  String _selectedCurrency = 'USD';
  double _convertedValue = 0.0;

  final Map<String, double> _exchangeRates = {
    'USD': 0.000068, // 1 Rupiah ke USD
    'EUR': 0.000063, // 1 Rupiah ke EUR
    'JPY': 0.0094,  // 1 Rupiah ke JPY
  };

  void _onRupiahChanged(String inputText) {
    final rupiah = double.tryParse(inputText);

    if (rupiah == null) {
      setState(() {
        _convertedValue = 0.0;
      });
      return;
    }

    final rate = _exchangeRates[_selectedCurrency];
    final converted = rupiah * rate!;

    setState(() {
      _convertedValue = converted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Konversi Rupiah ke Mata Uang Lain',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _rupiahController,
                      keyboardType: TextInputType.number,
                      onChanged: _onRupiahChanged,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Jumlah Rupiah',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButton<String>(
                      value: _selectedCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCurrency = newValue!;
                          _onRupiahChanged(_rupiahController.text);
                        });
                      },
                      items: _exchangeRates.keys.map<DropdownMenuItem<String>>((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 32),
            Text(
              'Hasil Konversi: ${_convertedValue.toStringAsFixed(2)} $_selectedCurrency',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
