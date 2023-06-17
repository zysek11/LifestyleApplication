import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
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
      child: Stack(
        children: [
          CustomScrollView(
              // ... reszta kodu CustomScrollView
              ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 1.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    elevation: 0,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
