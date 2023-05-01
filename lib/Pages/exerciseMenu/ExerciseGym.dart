import 'package:flutter/material.dart';

class ExerciseGym extends StatelessWidget {
  const ExerciseGym({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top:20.0),
      child: Container(
        width: 200,
        height: 200,
        color: Colors.green,
      ),
    );
  }
}