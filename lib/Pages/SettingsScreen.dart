import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Ustawienia',
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
            ),
            SizedBox(height: 50,),
            Lottie.asset('assets/animations/work_in_progress.json',
                width: 300, height: 300),
          ],
        ),
      ),
    );
  }
}