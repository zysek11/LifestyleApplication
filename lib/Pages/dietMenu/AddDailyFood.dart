import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../hive_classes/DayFood.dart';
import '../../hive_classes/Food.dart';
import '../../hive_classes/Recipe.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddDailyFood extends StatefulWidget {
  const AddDailyFood({Key? key, required this.editMode, required this.index}) : super(key: key);

  final int index;
  final bool editMode;
  @override
  State<AddDailyFood> createState() => _AddDailyFoodState();
}

class _AddDailyFoodState extends State<AddDailyFood> {

  List<String> _items = ['sniadanie', 'obiad', 'kolacja', 'deser', 'przekaska','napoj'];

  bool isCorrect = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController =  TextEditingController();
  String typeController = 'sniadanie';
  TextEditingController calorieController =  TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController fatController =  TextEditingController();
  TextEditingController proteinController =  TextEditingController();
  late Box dayFood;


  void getHiveFromIndex() {
    final item = dayFood.getAt(dayFood.length-1).foodList[widget.index];
    if (item != null) {
      setState(() {
        nameController.text = item.name;
        typeController = item.type;
        calorieController.text = item.calories.toString();
        carbsController.text = item.carbs.toString();
        fatController.text = item.fat.toString();
        proteinController.text = item.proteins.toString();
      });
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
    dayFood = Hive.box('dayFood');
    if (widget.editMode) {
      getHiveFromIndex();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: const Text("Add or modify food"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.fastfood,
                      size: 125,
                      color: Color(
                          0xFFEC9006),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NameCont(name: "Nazwa", verticalPadding: 5),
                      TextFieldBlack(
                        hintTF: "Podaj nazwe jedzenia...",
                        maxLength: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'To pole jest wymagane';
                          }
                          return null;
                        },
                        tec: nameController,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Typ dania:  ",style: TextStyle(fontSize: 20),),
                          DropdownButton<String>(
                              value: typeController,
                              onChanged: (String? newValue) {
                                setState(() {
                                  typeController = newValue!;
                                });
                              },
                              isDense: true,
                              items: _items.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(fontSize: 20)),
                            );
                          }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      NameCont(name: "Kalorie i makroskładniki"),
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
                            final food = Food(nameController.text,
                                typeController,
                                int.parse(calorieController.text),
                                int.parse(carbsController.text),
                                int.parse(fatController.text),
                                int.parse(proteinController.text)
                            );
                            DayFood thisDay = dayFood.getAt(dayFood.length-1);
                            setState(() {
                              if (widget.editMode == false) {
                                thisDay.foodList.add(food);
                                thisDay.calories_counter += food.calories;
                                thisDay.carbs_counter += food.carbs;
                                thisDay.fat_counter += food.fat;
                                thisDay.proteins_counter += food.proteins;
                                dayFood.putAt(dayFood.length-1,thisDay);
                              }
                              else{
                                thisDay.calories_counter = thisDay.calories_counter -
                                    thisDay.foodList[widget.index].calories + food.calories;
                                thisDay.carbs_counter = thisDay.carbs_counter -
                                    thisDay.foodList[widget.index].carbs + food.carbs;
                                thisDay.fat_counter = thisDay.fat_counter -
                                    thisDay.foodList[widget.index].fat + food.fat;
                                thisDay.proteins_counter = thisDay.proteins_counter -
                                    thisDay.foodList[widget.index].proteins + food.proteins;
                                thisDay.foodList[widget.index] = food;
                                dayFood.putAt(dayFood.length-1,thisDay);
                              }
                            });
                            print(food.name);
                            print(food.type);
                            print(food.calories);
                            print(food.carbs);
                            print(food.fat);
                            print(food.proteins);
                            Navigator.pop(context,true);
                          }
                        },
                        child: Text(
                          widget.editMode ? "Aktualizuj danie" : "Dodaj danie",
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
