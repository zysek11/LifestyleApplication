import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.grey.shade200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Praca w toku...',style: TextStyle(fontSize: 24,color: Colors.grey.shade700),),
            Lottie.asset('assets/animations/work_in_progress.json',
                width: 250, height: 250),
          ],
        ),
      ),
    );
  }
}