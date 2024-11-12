import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Convertor Valutar',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
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
  final double exchangeRate = 17.83;

  final TextEditingController mdlController = TextEditingController();
  final TextEditingController usdController = TextEditingController();

  void _convertMDLtoUSD(String mdlValue) {
    if (mdlValue.isNotEmpty) {
      double mdl = double.tryParse(mdlValue) ?? 0;
      double usd = mdl / exchangeRate;
      usdController.text = usd.toStringAsFixed(2);
    } else {
      usdController.clear();
    }
  }

  void _convertUSDtoMDL(String usdValue) {
    if (usdValue.isNotEmpty) {
      double usd = double.tryParse(usdValue) ?? 0;
      double mdl = usd * exchangeRate;
      mdlController.text = mdl.toStringAsFixed(2);
    } else {
      mdlController.clear();
    }
  }

  void _swapValues() {
    String mdlValue = mdlController.text;
    String usdValue = usdController.text;

    if (mdlValue.isNotEmpty && usdValue.isNotEmpty) {
      mdlController.text = usdValue;
      usdController.text = mdlValue;
    }
    _convertMDLtoUSD(mdlController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convertor Valutar'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Convertor Valutar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
            ),
            SizedBox(height: 40),
            _buildCurrencyField(
              controller: mdlController,
              label: 'MDL',
              flag: '🇲🇩',
              onChanged: _convertMDLtoUSD,
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _swapValues,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.tealAccent.withOpacity(0.5),
                  ),
                  child: Icon(
                    Icons.swap_vert,
                    size: 40,
                    color: Colors.teal[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildCurrencyField(
              controller: usdController,
              label: 'USD',
              flag: '🇺🇸',
              onChanged: _convertUSDtoMDL,
            ),
            SizedBox(height: 40),
            Divider(
              color: Colors.teal[300],
              thickness: 1,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Rată de schimb orientativă',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                '1 USD = $exchangeRate MDL',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildCurrencyField({
    required TextEditingController controller,
    required String label,
    required String flag,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 20,
        color: Colors.teal[900],
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 18, color: Colors.teal[700]),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 14.0, left: 10.0),
          child: Text(
            flag,
            style: TextStyle(fontSize: 28),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.tealAccent.withOpacity(0.1),
      ),
      onChanged: onChanged,
    );
  }
}
