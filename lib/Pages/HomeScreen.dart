import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'miniApps/BmiCalculator.dart';
import 'miniApps/BmrCalculator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> ciekawostkiODietach = [
    "Dieta ketogeniczna indukuje stan ketozy, w którym organizm spala tłuszcz jako główne źródło energii.",
    "Dieta śródziemnomorska, bogata w owoce, warzywa, pełnoziarniste produkty zbożowe i zdrowe tłuszcze, jest uważana za zdrowy sposób odżywiania.",
    "Dieta wegetariańska wyklucza spożywanie mięsa i ryb, skupiając się na roślinach, nabiale i jajach.",
    "Dieta wegańska wyklucza spożywanie wszelkich produktów pochodzenia zwierzęcego, w tym mięsa, ryb, nabiału, jaj i miodu.",
    "Dieta bezglutenowa jest konieczna dla osób z nietolerancją glutenu, taką jak celiakia.",
    "Dieta paleo naśladuje sposób odżywiania się naszych przodków, opierając się na naturalnych i nieprzetworzonych składnikach.",
    "Dieta surowa (raw food) polega na spożywaniu głównie surowych, nieprzetworzonych produktów.",
    "Dieta bez laktozy wyklucza spożywanie nabiału lub produktów zawierających laktozę.",
    "Dieta niskowęglowodanowa ogranicza spożycie węglowodanów, często skupiając się na białkach i zdrowych tłuszczach.",
    "Dieta niskokaloryczna polega na ograniczeniu spożycia kalorii w celu utraty wagi.",
    "Dieta DASH została opracowana jako sposób na obniżenie ciśnienia krwi poprzez zdrowe odżywianie.",
    "Dieta medyterranejska promuje spożywanie świeżych owoców, warzyw, ryb, orzechów i oliwy z oliwek.",
    "Dieta flexitarian to elastyczne podejście do jedzenia, które skupia się na roślinach, ale pozwala na okazjonalne spożywanie mięsa.",
    "Dieta bez cukru ogranicza lub wyklucza spożywanie cukru i produktów zawierających dodany cukier.",
    "Dieta niskotłuszczowa polega na ograniczeniu spożycia tłuszczów, szczególnie nasyconych i trans.",
    "Dieta o niskim indeksie glikemicznym skupia się na spożywaniu pokarmów, które powodują wolne i stabilne podnoszenie poziomu glukozy we krwi.",
    "Dieta bogata w błonnik przynosi wiele korzyści dla zdrowia, takich jak utrzymanie prawidłowej wagi i poprawa trawienia.",
    "Dieta bez soli polega na ograniczeniu spożycia sodu i soli kuchennej, co jest korzystne dla osób z nadciśnieniem.",
    "Dieta bez laktozy wyklucza spożywanie nabiału lub produktów zawierających laktozę.",
    "Dieta sokowa polega na spożywaniu świeżo wyciskanych soków owocowych i warzywnych, często w ramach detoksu organizmu."
  ];
  String randomCiekawostka = '';

  @override
  void initState() {
    super.initState();
    final random = Random();
    randomCiekawostka =
    ciekawostkiODietach[random.nextInt(ciekawostkiODietach.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Witaj!',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Lottie.asset('assets/animations/happy_fruit.json',
              width: 200, height: 200),
          Container(
            width: double.infinity,
            child: Card(
              color: const Color(0xFF4FAD79),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      'Czy wiesz, że ...',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 10),
                    child: Text(
                      randomCiekawostka,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Twoje mini-aplikacje",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BmrCalculator()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.calculate_rounded,
                        size: 64,
                        color: const Color(0xFF2E8B57),
                      ),
                      Text(
                        "BMR",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BmiCalculator()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.compare,
                        size: 64,
                        color: const Color(0xFF2E8B57),
                      ),
                      Text(
                        "BMI",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}