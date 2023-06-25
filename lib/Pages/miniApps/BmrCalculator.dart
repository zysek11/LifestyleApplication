import 'package:flutter/material.dart';

class BmrCalculator extends StatefulWidget {
  const BmrCalculator({Key? key}) : super(key: key);

  @override
  State<BmrCalculator> createState() => _BmrCalculatorState();
}

class _BmrCalculatorState extends State<BmrCalculator> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: Text('BMR Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}