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

  int dietMenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget exerciseWidget;
    switch(dietMenuIndex){
      case 0:
        exerciseWidget = const DietRecipes();
        break;
      case 1:
        exerciseWidget = const DietDayCounter();
        break;
      case 2:
        exerciseWidget = const DietArchive();
        break;
      default:
        exerciseWidget = const DietRecipes();
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
                          dietMenuIndex = 0;
                        });
                      },
                      child: MenuBlock(queue: 0, emi: dietMenuIndex, name: "Recipes")),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: (){
                        setState(() {
                          dietMenuIndex = 1;
                        });
                      },
                      child: MenuBlock(queue: 1, emi: dietMenuIndex, name: "Daily Counter")),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: (){
                        setState(() {
                          dietMenuIndex = 2;
                        });
                      },
                      child: MenuBlock(queue: 2, emi: dietMenuIndex, name: "Archive")),
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