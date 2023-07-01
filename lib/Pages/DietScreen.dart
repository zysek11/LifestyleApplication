import 'package:flutter/material.dart';
import 'package:lifestyle_application/Pages/dietMenu/DietArchive.dart';
import 'package:lifestyle_application/Pages/dietMenu/DietDayCounter.dart';
import 'package:lifestyle_application/Pages/dietMenu/DietRecipes.dart';

import 'menuBlock.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({Key? key}) : super(key: key);

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {

  int dietMenuIndex = 1;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // Swipe w prawo
          if (dietMenuIndex > 0) {
            setState(() {
              dietMenuIndex--;
              _controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            });
          }
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // Swipe w lewo
          if (dietMenuIndex < 2) {
            setState(() {
              dietMenuIndex++;
              _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            });
          }
        }
      },
      child: Container(
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
                            dietMenuIndex = 0;
                            _controller.animateToPage(0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          });
                        },
                        child: MenuBlock(queue: 0, emi: dietMenuIndex, name: "Przepisy")),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            dietMenuIndex = 1;
                            _controller.animateToPage(1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          });
                        },
                        child: MenuBlock(queue: 1, emi: dietMenuIndex, name: "Dzienny licznik")),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            dietMenuIndex = 2;
                            _controller.animateToPage(2,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          });
                        },
                        child: MenuBlock(queue: 2, emi: dietMenuIndex, name: "Archiwum")),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: PageView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    DietRecipes(),
                    DietDayCounter(),
                    DietArchive(),
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