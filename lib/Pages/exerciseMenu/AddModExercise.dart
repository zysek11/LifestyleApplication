import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../hive_classes/Exercise.dart';
import '';
import '../../hive_classes/Gym.dart';

class AddModExercise extends StatefulWidget {
  const AddModExercise({Key? key, required this.editMode, required this.index, required this.boxName, required this.gymMode}) : super(key: key);

  final int index;
  final String boxName;
  final bool editMode;
  final bool gymMode;
  @override
  State<AddModExercise> createState() => _AddModExerciseState();
}

class _AddModExerciseState extends State<AddModExercise> {
  //File? pickedImage;
  //bool isPicked = false;
  bool isChecked = false;
  bool isCorrect = false;
  List<String> _types = ['klata', 'plecy', 'nogi', 'barki', 'biceps','triceps','brzuch'];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController =  TextEditingController();
  TextEditingController typeController =  TextEditingController();
  String defaultType = 'klata';
  TextEditingController seriesController =  TextEditingController();
  TextEditingController repeatsController =  TextEditingController();
  TextEditingController seriesTimeController = TextEditingController();
  TextEditingController breakTimeController =  TextEditingController();
  TextEditingController descController =  TextEditingController();
  late Box exercises;

  //Future<void> _pickImage() async {
  //  final ImagePicker _picker = ImagePicker();
  //  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //  if (image != null) {
  //    setState(() {
  //      pickedImage = File(image.path);
  //      imageController = TextEditingController();
  //      imageController.text = pickedImage!.path;
  //      isPicked = true;
  //    });
  //  }
  //}

  void getHiveFromIndex() {
    final item = exercises.getAt(widget.index);
    if (item != null) {
      setState(() {
        nameController.text = item.name;
        if(widget.gymMode == true) {
            typeController.text = item.type.toString();
          }
        seriesController.text = item.series.toString();
        repeatsController.text = item.repeats.toString();
        seriesTimeController.text = item.seriesTime.toString();
        breakTimeController.text = item.breakTime.toString();
        descController.text = item.description;
        if(seriesTimeController.text != "") {
          isChecked = true;
        }
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
  
  IconData _getIconForBoxName(String boxName) {
    switch (boxName) {
      case 'exercises':
        return Icons.sports_gymnastics;
      case 'exercisesGym':
        return Icons.fitness_center;
      case 'exercisesVolley':
        return Icons.sports_volleyball;
      default:
        return Icons.add;
    }
  }

  //void saveExercise() {
  //  for (var i = 0; i < ingrControllers.length; i++) {
  //    ingredientList[i] = ingrControllers[i].text;
  //  }
  //}

  @override
  void initState() {
    super.initState();
    exercises = Hive.box(widget.boxName);
    if (widget.editMode) {
      getHiveFromIndex();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: const Text("Add or modify exercise"),
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
                    child: Icon(
                      _getIconForBoxName(widget.boxName),
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
                        hintTF: "Podaj nazwe cwiczenia...",
                        maxLength: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'To pole jest wymagane';
                          }
                          return null;
                        },
                        tec: nameController,
                      ),
                      if (widget.gymMode == true) SizedBox(height: 20),
                      if (widget.gymMode == true)
                        Row(
                          children: [
                            Text("Typ cwiczenia:  ",style: TextStyle(fontSize: 20),),
                            DropdownButton<String>(
                              value: defaultType,
                              onChanged: (String? newValue) {
                                setState(() {
                                  defaultType = newValue!;
                                });
                              },
                              isDense: true,
                              items: _types.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(fontSize: 20)),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      SizedBox(height: 20),
                      NameCont(name: "Serie i powtorzenia"),
                      MacroRow(
                        carbohydratesHint: "Podaj serie",
                        unitText: "ilosc",
                        maxLength: 2,
                        keybordType: TextInputType.number,
                        textAlign: TextAlign.start,
                        tec: seriesController,
                      ),
                      SizedBox(height: 10),
                      MacroRow(
                        carbohydratesHint: "Podaj powtorzenia",
                        unitText: "ilosc",
                        maxLength: 3,
                        keybordType: TextInputType.number,
                        textAlign: TextAlign.start,
                        tec: repeatsController,
                      ),
                      SizedBox(height: 10,),
                      SizedBox(height: 10,),
                      NameCont(name: "Czas"),
                      MacroRow(
                        carbohydratesHint: "Wykonywanie cwiczenia",
                        unitText: "",
                        maxLength: 10,
                        keybordType: TextInputType.number,
                        textAlign: TextAlign.start,
                        tec: seriesTimeController,
                      ),
                      SizedBox(height: 10,),
                      MacroRow(
                        carbohydratesHint: "Przerwa",
                        unitText: "",
                        maxLength: 10,
                        keybordType: TextInputType.number,
                        textAlign: TextAlign.start,
                        tec: breakTimeController,
                      ),
                      SizedBox(height: 20),
                      NameCont(name: "Opis"),
                      TextFieldBlack(
                        hintTF: "Opis cwiczenia...",
                        maxLines: 5,
                        tec: descController,
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
                            final exercise;
                            if(widget.gymMode == true) {
                              exercise = Gym(
                                  nameController.text,
                                  defaultType,
                                  int.parse(seriesController.text),
                                  int.parse(repeatsController.text),
                                  seriesTimeController.text,
                                  breakTimeController.text,
                                  descController.text
                              );
                              }
                            else {
                              exercise = Exercise(
                                  nameController.text,
                                  int.parse(seriesController.text),
                                  int.parse(repeatsController.text),
                                  seriesTimeController.text,
                                  breakTimeController.text,
                                  descController.text
                              );
                            }
                            setState(() {
                              if (widget.editMode == false) {
                                exercises.add(exercise);
                              }
                              else{
                                exercises.putAt(widget.index,exercise);
                              }
                            });
                            print(exercise.name);
                            print(exercise.repeats);
                            print(exercise.series);
                            print(exercise.seriesTime);
                            print(exercise.breakTime);
                            print(exercise.description);
                            Navigator.pop(context,true);
                          }
                        },
                        child: Text(
                          widget.editMode ? "Aktualizuj cwiczenie" : "Dodaj cwiczenie",
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
  final TextAlign textAlign;
  final TextEditingController tec;

  const MacroRow(
      {Key? key,
        required this.carbohydratesHint,
        required this.unitText,
        required this.maxLength,
        required this.keybordType,
        required this.textAlign,
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
              textAlign: textAlign,
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
  final TextAlign textAlign;
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
    this.textAlign = TextAlign.start,
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
        textAlign: textAlign,
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
