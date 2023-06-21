import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lifestyle_application/Pages/dietMenu/AddDailyFood.dart';
import 'package:lifestyle_application/Pages/dietMenu/EditCalories.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'dart:async';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../hive_classes/CaloriesConst.dart';
import '../../hive_classes/DayFood.dart';
import '../../hive_classes/Food.dart';

class DietDayCounter extends StatefulWidget {
  const DietDayCounter({Key? key}) : super(key: key);

  @override
  State<DietDayCounter> createState() => _DietDayCounterState();
}

class _DietDayCounterState extends State<DietDayCounter> {
  ValueNotifier<double> start = ValueNotifier<double>(0.0);
  ValueNotifier<double> fat = ValueNotifier<double>(0.0);
  ValueNotifier<double> carbs = ValueNotifier<double>(0.0);
  ValueNotifier<double> protein = ValueNotifier<double>(0.0);
  late Box caloriesConst;
  late Box dayFood;
  late String calorieController;
  late String carbsController;
  late String fatController;
  late String proteinController;
  late int calorieDay;
  late int carbsDay;
  late int fatDay;
  late int proteinDay;


  @override
  void dispose() {
    start.dispose();
    super.dispose();
  }

  void getTodayDataFromIndex(){
    DayFood todayFood;
    if (dayFood.isNotEmpty) {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String lastNotedDate = DateFormat('yyyy-MM-dd').format(dayFood.getAt(dayFood.length-1).date);
      if (currentDate == lastNotedDate) {
        todayFood = dayFood.getAt(dayFood.length-1);
      } else {
        todayFood = DayFood(
          DateTime.now(), [], 0, 0, 0, 0,
          int.parse(calorieController), int.parse(carbsController),
          int.parse(fatController), int.parse(proteinController),
        );
        dayFood.add(todayFood);
      }
    } else {
      todayFood = DayFood(
        DateTime.now(), [], 0, 0, 0, 0,
        int.parse(calorieController), int.parse(carbsController),
        int.parse(fatController), int.parse(proteinController),
      );
      dayFood.add(todayFood);
    }
    setState((){
    calorieDay = todayFood.calories_counter;
    carbsDay = todayFood.carbs_counter;
    fatDay = todayFood.fat_counter;
    proteinDay = todayFood.proteins_counter;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        fat.value =  fatDay / double.parse(fatController); // Zmiana wartości fat
        carbs.value = carbsDay / double.parse(carbsController); // Zmiana wartości fat
        protein.value = proteinDay / double.parse(proteinController); // Zmiana wartości fat
        print("ilosc elementow dayfood: "+dayFood.getAt(0).foodList.length.toString());
      });
    });
    start = ValueNotifier<double>(calorieDay.toDouble());
    });

  }
  void getHiveFromIndex() {
    // dla calorii
    if (caloriesConst.isNotEmpty) {
      final item = caloriesConst.getAt(0);
      if (item != null) {
        setState(() {
          calorieController = item.calories_const.toString();
          carbsController = item.carbs_const.toString();
          fatController = item.fat_const.toString();
          proteinController = item.proteins_const.toString();
        });
      }
    } else {
      caloriesConst.add(CaloriesConst(1000, 100, 100, 100));
      final item = caloriesConst.getAt(0);
      setState(() {
        calorieController = item.calories_const.toString();
        carbsController = item.carbs_const.toString();
        fatController = item.fat_const.toString();
        proteinController = item.proteins_const.toString();
    });
    }
  }

  @override
  void initState() {
    super.initState();
    dayFood = Hive.box('dayFood');
    caloriesConst = Hive.box('caloriesConst');
    getHiveFromIndex();
    getTodayDataFromIndex();
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
                                onTap: () async{
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditCalories()),
                                  ).then((value) {
                                      setState(() {
                                        // Zaktualizuj dane w stanie widoku
                                        caloriesConst = Hive.box('caloriesConst');
                                        dayFood = Hive.box('dayFood');
                                        getHiveFromIndex();
                                        getTodayDataFromIndex();
                                      });
                                  });
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
                                  Container(
                                    width: 85,
                                    height: 85,
                                    child: SfRadialGauge(
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 0,
                                          maximum: double.parse(calorieController),
                                          showLabels: false,
                                          showTicks: false,
                                          radiusFactor: 1,
                                          axisLineStyle: AxisLineStyle(
                                            cornerStyle: CornerStyle.bothCurve,
                                            gradient: const SweepGradient(
                                              colors: [
                                                Colors.redAccent,
                                                Colors.yellow,
                                                Colors.green,
                                              ],
                                              stops: <double>[
                                                0,  0.5,  1
                                              ]
                                            ),
                                            thickness: 15,
                                          ),
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                              value: start.value,
                                              width: 15,
                                              enableAnimation: true,
                                              animationDuration: 500,
                                              cornerStyle: CornerStyle.bothCurve,
                                              sizeUnit: GaugeSizeUnit.logicalPixel,
                                            )
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Text(
                                                start.value.toStringAsFixed(0),
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              positionFactor: 0.3,
                                              axisValue: 5,
                                              angle: 90,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Prog kaloryczny:", style:
                                          TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                        child: Text(calorieController,style:
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
                                        child: Text(calorieDay.toString(),style:
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
                                        child: Text((int.parse(calorieController) - calorieDay).toString(),style:
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
                          itemCount: dayFood.getAt(dayFood.length - 1).foodList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item2 = dayFood.getAt(dayFood.length - 1).foodList[index];
                            return Dismissible(
                              key: ObjectKey(item2),
                              onDismissed: (direction) {
                                setState(() {
                                  DayFood thisDay = dayFood.getAt(dayFood.length - 1);
                                  thisDay.calories_counter -= thisDay.foodList[index].calories;
                                  thisDay.carbs_counter -= thisDay.foodList[index].carbs;
                                  thisDay.fat_counter -= thisDay.foodList[index].fat;
                                  thisDay.proteins_counter -= thisDay.foodList[index].proteins;
                                  thisDay.foodList.removeAt(index);
                                  dayFood.putAt(dayFood.length - 1, thisDay);
                                  getTodayDataFromIndex();
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
                                        dayFood = Hive.box('dayFood');
                                        getTodayDataFromIndex();
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
                                                            item2.name,
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
                                                                item2.type.toString(),
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
                                                                    text: item2.calories
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
                                                        child: Text(item2.carbs.toString(),
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
                                                        child: Text(item2.fat.toString(),
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
                                                        child: Text(item2.proteins.toString(),
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
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddDailyFood(editMode: false, index: -1)),
                        ).then((value) {
                          if (value == true) {
                            setState(() {
                              // Zaktualizuj dane w stanie widoku
                              dayFood = Hive.box('dayFood');
                              getHiveFromIndex();
                              getTodayDataFromIndex();
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
