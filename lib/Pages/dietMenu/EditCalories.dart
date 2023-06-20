import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../hive_classes/CaloriesConst.dart';
import '../../hive_classes/DayFood.dart';
import '../../hive_classes/Recipe.dart';

class EditCalories extends StatefulWidget {
  const EditCalories({Key? key}) : super(key: key);

  @override
  State<EditCalories> createState() => _EditCaloriesState();
}

class _EditCaloriesState extends State<EditCalories> {
  bool isCorrect = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController calorieController =  TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController fatController =  TextEditingController();
  TextEditingController proteinController =  TextEditingController();
  late Box caloriesConst;
  late Box dayFood;

  void getHiveFromIndex() {
    if (caloriesConst.isNotEmpty) {
      final item = caloriesConst.getAt(0);
      if (item != null) {
        setState(() {
          calorieController.text = item.calories_const.toString();
          carbsController.text = item.carbs_const.toString();
          fatController.text = item.fat_const.toString();
          proteinController.text = item.proteins_const.toString();
        });
      }
    }
  }

  void validateFields() {
    if (formKey.currentState!.validate()) {
      // Walidacja pól została pomyślnie zakończona
      // Wykonaj inne operacje lub przejdź do kolejnego ekranu
      isCorrect = true;
    }
    else {
      isCorrect = false;
    }
  }

  @override
  void initState() {
    super.initState();
    caloriesConst = Hive.box('caloriesConst');
    dayFood = Hive.box('dayFood');
    getHiveFromIndex();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: const Text("Add or modify recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NameCont(name: "Dziennik kaloryczny"),
                      MacroRow(
                        carbohydratesHint: "Podaj kalorie",
                        unitText: "kcal",
                        maxLength: 4,
                        keybordType: TextInputType.number,
                        tec: calorieController,
                      ),
                      SizedBox(height: 10),
                      MacroRow(
                        carbohydratesHint: "Podaj weglowodany",
                        unitText: "gram",
                        maxLength: 4,
                        keybordType: TextInputType.number,
                        tec: carbsController,
                      ),
                      SizedBox(height: 10),
                      MacroRow(
                          carbohydratesHint: "Podaj tluszcze",
                          unitText: "gram",
                          maxLength: 4,
                          keybordType: TextInputType.number,
                          tec: fatController
                      ),
                      SizedBox(height: 10),
                      MacroRow(
                          carbohydratesHint: "Podaj bialko",
                          unitText: "gram",
                          maxLength: 4,
                          keybordType: TextInputType.number,
                          tec: proteinController
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor:
                          const Color(0xFF2E8B57), // Kolor tła przycisku
                        ),
                        onPressed: () {
                          validateFields();
                          if (isCorrect)
                          {
                            DayFood thisDay = dayFood.getAt(dayFood.length-1);
                            final calories_const = CaloriesConst(
                                int.parse(calorieController.text),
                                int.parse(carbsController.text),
                                int.parse(fatController.text),
                                int.parse(proteinController.text)
                            );
                            setState(() {
                              if (caloriesConst.isNotEmpty) {
                                caloriesConst.putAt(0, calories_const);
                                thisDay.calories_limit = int.parse(calorieController.text);
                                thisDay.carbs_limit = int.parse(carbsController.text);
                                thisDay.fat_limit = int.parse(fatController.text);
                                thisDay.proteins_limit = int.parse(proteinController.text);
                                dayFood.putAt(dayFood.length-1, thisDay);
                              }
                              else {
                                caloriesConst.add(calories_const);
                                thisDay.calories_limit = int.parse(calorieController.text);
                                thisDay.carbs_limit = int.parse(carbsController.text);
                                thisDay.fat_limit = int.parse(fatController.text);
                                thisDay.proteins_limit = int.parse(proteinController.text);
                                dayFood.putAt(dayFood.length-1, thisDay);
                              }
                            });
                            print(calories_const.calories_const);
                            print(calories_const.carbs_const);
                            print(calories_const.fat_const);
                            print(calories_const.proteins_const);
                            Navigator.pop(context,true);
                          }
                        },
                        child: Text(
                           "Aktualizuj dziennik",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MacroRow extends StatelessWidget {
  final String carbohydratesHint;
  final String unitText;
  final int maxLength;
  final TextInputType keybordType;
  final TextEditingController tec;

  const MacroRow(
      {Key? key,
        required this.carbohydratesHint,
        required this.unitText,
        required this.maxLength,
        required this.keybordType,
        required this.tec})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: TextFieldBlack(
              hintTF: carbohydratesHint,
              maxLength: maxLength,
              keybordType: keybordType,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'To pole jest wymagane';
                }
                return null;
              },
              tec: tec,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              unitText,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(), // Puste miejsce
        ),
      ],
    );
  }
}

class TextFieldBlack extends StatelessWidget {
  final String hintTF;
  final double verticalPadding;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final TextInputType keybordType;
  final String? Function(String?)? validator;
  final TextEditingController tec;

  const TextFieldBlack({
    Key? key,
    required this.hintTF,
    this.verticalPadding = 0.0,
    this.maxLength = 400,
    this.maxLines = 1,
    this.minLines = 1,
    this.keybordType = TextInputType.text,
    this.validator,
    required this.tec
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: TextFormField(
        controller: tec,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: keybordType,
        validator: validator,
        style: TextStyle(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
          hintText: hintTF,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2E8B57)),
          ),
        ),
      ),
    );
  }
}

class NameCont extends StatelessWidget {
  final String name;
  final double verticalPadding; // Nowy argument

  const NameCont({
    Key? key,
    required this.name,
    this.verticalPadding = 0.0, // Domyślna wartość dla wypełnienia pionowego
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      // Zastosowanie wypełnienia pionowego
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 26,
            color: Color(0xFF2E8B57),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
