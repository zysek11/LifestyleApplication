import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lifestyle_application/Pages/dietMenu/AddDailyFood.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'dart:async';

class DietDayCounter extends StatefulWidget {
  const DietDayCounter({Key? key}) : super(key: key);

  @override
  State<DietDayCounter> createState() => _DietDayCounterState();
}

class _DietDayCounterState extends State<DietDayCounter> {
  ValueNotifier<double> start = ValueNotifier(1850.0);
  ValueNotifier<double> fat = ValueNotifier(0.0);
  ValueNotifier<double> carbs = ValueNotifier(0.0);
  ValueNotifier<double> protein = ValueNotifier(0.0);
  late Box foods;

  @override
  void initState() {
    super.initState();
    foods = Hive.box('foods');
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        fat.value = 0.6; // Zmiana wartości fat
        carbs.value = 0.4; // Zmiana wartości fat
        protein.value = 0.8; // Zmiana wartości fat
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 290,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                elevation: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment:Alignment.center,
                              child: Text("Dziennik kaloryczny", style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0), // Dostosuj padding, jeśli jest potrzebny
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  // Kod obsługujący kliknięcie przycisku
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0), // Dostosuj padding, jeśli jest potrzebny
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10,
                                      top: 30,bottom: 20),
                              child: Column(
                                children: [
                                  ValueListenableBuilder<double>(
                                    valueListenable: start,
                                    builder: (BuildContext context, double value, Widget? child) {
                                      return Container(
                                        width: 85,
                                        height: 85,
                                        child: SimpleCircularProgressBar(
                                          startAngle: 0,
                                          progressColors: const [
                                            Colors.redAccent,
                                            Colors.yellow,
                                            Colors.green
                                          ],
                                          maxValue: 3800,
                                          valueNotifier: start,
                                          mergeMode: true,
                                          animationDuration: 1,
                                          onGetText: (double value) {
                                            return Text(
                                              '${value.toInt()}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Prog kaloryczny:", style:
                                          TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                        child: Text("3800",style:
                                          TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Dzisiejsze kalorie:", style:
                                          TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                        child: Text("1850",style:
                                        TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Pozostalo:", style:
                                          TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                        child: Text("2550",style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Tluszcze:",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ValueListenableBuilder<double>(
                                        valueListenable: fat,
                                        builder: (context, value, child) {
                                          return AnimatedProgressBar(
                                            height: 12,
                                            value: value,
                                            gradient: const LinearGradient(
                                              colors: [
                                                Colors.redAccent,
                                                Colors.yellow,
                                                Colors.green,
                                              ],
                                            ),
                                            backgroundColor: Colors.grey.withOpacity(0.4),
                                            duration: const Duration(milliseconds: 300),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Weglowodany:",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ValueListenableBuilder<double>(
                                        valueListenable: carbs,
                                        builder: (context, value, child) {
                                          return AnimatedProgressBar(
                                            height: 12,
                                            value: value,
                                            gradient: const LinearGradient(
                                              colors: [Colors.redAccent, Colors.yellow, Colors.green],
                                            ),
                                            backgroundColor: Colors.grey.withOpacity(0.4),
                                            duration: const Duration(milliseconds: 300),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Bialko:",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ValueListenableBuilder<double>(
                                        valueListenable: protein,
                                        builder: (context, value, child) {
                                          return AnimatedProgressBar(
                                            height: 12,
                                            value: value,
                                            gradient: const LinearGradient(
                                              colors: [Colors.redAccent, Colors.yellow, Colors.green],
                                            ),
                                            backgroundColor: Colors.grey.withOpacity(0.4),
                                            duration: const Duration(milliseconds: 300),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: ListView.separated(
                          padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 5),
                          separatorBuilder: (context, index) => SizedBox(height: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: foods.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = foods.getAt(index);
                            final keyString = item?.key.toString();
                            return Dismissible(
                              key: Key(keyString!),
                              onDismissed: (direction) {
                                setState(() {
                                  foods.deleteAt(index);
                                });
                              },
                              background: Container(
                                color: Colors.red,
                                child: const Icon(Icons.cancel),
                              ),
                              child: InkWell(
                                onLongPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddDailyFood(
                                            editMode: true, index: index)),
                                  ).then((value) {
                                    if (value == true) {
                                      setState(() {
                                        // Zaktualizuj dane w stanie widoku
                                        foods = Hive.box('foods');
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.zero,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            width: 100,
                                            height: 100,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.fastfood, // Ikona hantla
                                                size: 80, // Rozmiar ikony
                                                color: Color(
                                                    0xFFEC9006), // Kolor ikony
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 5.0,
                                                            right: 5.0,
                                                            bottom: 5.0,
                                                            top: 8),
                                                        child: Container(
                                                          alignment:
                                                          Alignment.topLeft,
                                                          child: Text(
                                                            item.name,
                                                            style: const TextStyle(
                                                                fontSize: 23),
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      )),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5.0),
                                                            child: Container(
                                                              alignment:
                                                              Alignment.topLeft,
                                                              child: Text(
                                                                item.type.toString(),
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xFFEC9006),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 19),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Container(
                                                            alignment:
                                                            Alignment.topLeft,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                style: const TextStyle(
                                                                    fontSize: 19,
                                                                    color:
                                                                    Colors.black),
                                                                children: [
                                                                  const TextSpan(
                                                                      text:
                                                                      'Kalorie:  '),
                                                                  TextSpan(
                                                                    text: item.calories
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFFEC9006),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ), // Pusty kontener
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 70,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Spacer(flex: 1,),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          "Carbs",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: Text(item.carbs.toString(),
                                                          style: TextStyle(
                                                            color: Color(0xFFEC9006),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(flex: 1,),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          "Fat",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: Text(item.fat.toString(),
                                                          style: TextStyle(
                                                            color: Color(0xFFEC9006),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(flex: 1,),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          "Protein",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: Text(item.proteins.toString(),
                                                          style: TextStyle(
                                                            color: Color(0xFFEC9006),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(flex: 1,),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E8B57),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddDailyFood(editMode: false, index: -1)),
                        ).then((value) {
                          if (value == true) {
                            setState(() {
                              // Zaktualizuj dane w stanie widoku
                              foods = Hive.box('foods');
                            });
                          }
                        });
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
