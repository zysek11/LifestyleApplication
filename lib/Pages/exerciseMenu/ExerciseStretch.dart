import 'package:flutter/material.dart';

class ExerciseStretch extends StatelessWidget {
  const ExerciseStretch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top:20.0),
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blue,
      ),
    );
  }
}