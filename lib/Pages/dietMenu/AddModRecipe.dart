import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../hive_classes/Recipe.dart';

class AddModRecipe extends StatefulWidget {
  const AddModRecipe({Key? key, required this.editMode, required this.index}) : super(key: key);

  final int index;
  final bool editMode;
  @override
  State<AddModRecipe> createState() => _AddModRecipeState();
}

class _AddModRecipeState extends State<AddModRecipe> {
  var ingredientList = <String>[];
  File? pickedImage;
  bool isPicked = false;
  bool isCorrect = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController =  TextEditingController();
  TextEditingController imageController =  TextEditingController();
  TextEditingController calorieController =  TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController fatController =  TextEditingController();
  TextEditingController proteinController =  TextEditingController();
  TextEditingController descController =  TextEditingController();
  List<TextEditingController> ingrControllers = [];
  late Box recipes;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
        imageController = TextEditingController();
        imageController.text = pickedImage!.path;
        isPicked = true;
      });
    }
  }

  void getHiveFromIndex() {
    final item = recipes.getAt(widget.index);
    if (item != null) {
      setState(() {
        nameController.text = item.name;
        calorieController.text = item.calories.toString();
        carbsController.text = item.carbs.toString();
        fatController.text = item.fat.toString();
        proteinController.text = item.proteins.toString();
        descController.text = item.description;
        ingrControllers = item.stringList
            .map((ingredient) => TextEditingController(text: ingredient))
            .toList()
            .cast<TextEditingController>(); // Dodana konwersja typów
        ingredientList = item.stringList.toList(); // Przypisanie wartości do ingredientList
        pickedImage = File(item.imagePath);
        imageController.text = pickedImage!.path;
        isPicked = true;
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

  void saveRecipe() {
    for (var i = 0; i < ingrControllers.length; i++) {
      ingredientList[i] = ingrControllers[i].text;
    }
  }

  @override
  void initState() {
    super.initState();
    recipes = Hive.box('recipes');
    if (widget.editMode) {
      getHiveFromIndex();
    }
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
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      image: isPicked == true
                          ? DecorationImage(
                              image: FileImage(pickedImage!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage('assets/images/plus2.png'),
                              fit: BoxFit.cover,
                            ),
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
                        hintTF: "Podaj nazwe przepisu...",
                        maxLength: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'To pole jest wymagane';
                          }
                          return null;
                        },
                        tec: nameController,
                      ),
                      SizedBox(height: 20),
                      NameCont(
                        name: "Składniki",
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: ingredientList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Expanded(
                                child: TextFieldBlack(
                                  hintTF: "Podaj składnik...", maxLength: 50, tec: ingrControllers[index],
                                ),

                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.cancel, color: Color(0xFF2E8B57)),
                                onPressed: () {
                                  setState(() {
                                    ingredientList.removeAt(index);
                                    ingrControllers.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF2E8B57), // Kolor tła przycisku
                        ),
                        onPressed: () {
                          setState(() {
                            ingredientList.add("");
                            ingrControllers.add(TextEditingController());
                          });
                        },
                        child: Text("Dodaj składnik"),
                      ),
                      SizedBox(height: 20),
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
                      NameCont(name: "Opis"),
                      TextFieldBlack(
                        hintTF: "Opis przepisu...",
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
                              saveRecipe();
                              ingredientList.removeWhere((element) => element.isEmpty);
                              final recipe = Recipe(
                                nameController.text,
                                imageController.text,
                                ingredientList,
                                int.parse(calorieController.text),
                                int.parse(carbsController.text),
                                int.parse(fatController.text),
                                int.parse(proteinController.text),
                                descController.text
                              );
                              setState(() {
                                if (widget.editMode == false) {
                                  recipes.add(recipe);
                                }
                                else{
                                  recipes.putAt(widget.index,recipe);
                                }
                              });
                              print(recipe.name);
                              print(recipe.imagePath);
                              print(recipe.stringList);
                              print(recipe.calories);
                              print(recipe.carbs);
                              print(recipe.fat);
                              print(recipe.proteins);
                              print(recipe.description);
                              Navigator.pop(context,true);
                            }
                        },
                        child: Text(
                          widget.editMode ? "Aktualizuj przepis" : "Dodaj przepis",
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
