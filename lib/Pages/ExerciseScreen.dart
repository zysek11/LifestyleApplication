import 'package:flutter/material.dart';
import 'exerciseMenu/ExerciseStretch.dart';
import 'exerciseMenu/ExerciseGym.dart';
import 'exerciseMenu/ExerciseVolley.dart';
import 'menuBlock.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int exerciseMenuIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.grey.shade200,
      child: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            // Swipe w prawo
            if (exerciseMenuIndex > 0) {
              setState(() {
                exerciseMenuIndex--;
                _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              });
            }
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            // Swipe w lewo
            if (exerciseMenuIndex < 2) {
              setState(() {
                exerciseMenuIndex++;
                _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              });
            }
          }
        },
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
                          _controller.animateToPage(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        });
                      },
                        child: MenuBlock(queue: 0, emi: exerciseMenuIndex, name: "Stretch")),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            exerciseMenuIndex = 1;
                            _controller.animateToPage(1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          });
                        },
                        child: MenuBlock(queue: 1, emi: exerciseMenuIndex, name: "Gym")),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            exerciseMenuIndex = 2;
                            _controller.animateToPage(2,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          });
                        },
                        child: MenuBlock(queue: 2, emi: exerciseMenuIndex, name: "Volleyball")),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: PageView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    ExerciseStretch(),
                    ExerciseGym(),
                    ExerciseVolley(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}