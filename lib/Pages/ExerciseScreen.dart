import 'package:flutter/material.dart';
import 'exerciseMenu/ExerciseStretch.dart';
import 'exerciseMenu/ExerciseGym.dart';
import 'exerciseMenu/ExerciseVolley.dart';
import 'exerciseMenu/menuBlock.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int exerciseMenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget exerciseWidget;
    switch(exerciseMenuIndex){
      case 0:
        exerciseWidget = const ExerciseStretch();
        break;
      case 1:
        exerciseWidget = const ExerciseGym();
        break;
      case 2:
        exerciseWidget = const ExerciseVolley();
        break;
      default:
        exerciseWidget = const ExerciseStretch();
    }

    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        exerciseMenuIndex = 0;
                      });
                    },
                      child: MenuBlock(queue: 0, emi: exerciseMenuIndex, name: "Stretch")),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: (){
                        setState(() {
                          exerciseMenuIndex = 1;
                        });
                      },
                      child: MenuBlock(queue: 1, emi: exerciseMenuIndex, name: "Gym")),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: (){
                        setState(() {
                          exerciseMenuIndex = 2;
                        });
                      },
                      child: MenuBlock(queue: 2, emi: exerciseMenuIndex, name: "Volleyball")),
                ),
              ],
            ),
            const SizedBox(height: 10),
            exerciseWidget,
          ],
        ),
      ),
    );
  }
}