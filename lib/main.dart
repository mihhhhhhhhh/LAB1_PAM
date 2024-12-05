import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(LoanCalculatorApp());
}

class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoanCalculatorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoanCalculatorPage extends StatefulWidget {
  @override
  _LoanCalculatorPageState createState() => _LoanCalculatorPageState();
}

class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  double _months = 60;
  String _monthlyPayment = '0.00€';

  void _calculateLoan() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double interestRate = double.tryParse(_interestController.text) ?? 0;
    int months = _months.toInt();

    if (amount > 0 && interestRate > 0 && months > 0) {
      double monthlyInterestRate = (interestRate / 100) / 12;
      double monthlyPayment = (amount * monthlyInterestRate * pow(1 + monthlyInterestRate, months)) /
          (pow(1 + monthlyInterestRate, months) - 1);

      setState(() {
        _monthlyPayment = monthlyPayment.toStringAsFixed(2) + "€";
      });
    } else {
      setState(() {
        _monthlyPayment = "Invalid input";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Loan calculator',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text('Enter amount'),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Enter number of months'),
            Slider(
              value: _months,
              min: 1,
              max: 60,
              divisions: 59,
              activeColor: const Color.fromARGB(255, 31, 21, 216),
              label: _months.toInt().toString() + " luni",
              onChanged: (double value) {
                setState(() {
                  _months = value;
                });
              },
            ),
            SizedBox(height: 10),
            Text('Enter % per month'),
            TextField(
              controller: _interestController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Percent',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'You will pay the approximate amount\nmonthly:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    _monthlyPayment,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: _calculateLoan,
              child: Text('Calculate'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(backgroundColor: Color.fromARGB(0, 223, 1, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
