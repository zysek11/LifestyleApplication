import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddModRecipe extends StatefulWidget {
  const AddModRecipe({Key? key}) : super(key: key);

  @override
  State<AddModRecipe> createState() => _AddModRecipeState();
}

class _AddModRecipeState extends State<AddModRecipe> {
  var ingredientList = <String>[];
  File? pickedImage;
  bool isPicked = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
        isPicked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: const Text("Add or modify recipe"),
      ),
      body: SingleChildScrollView(
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
                    image: AssetImage('assets/images/wiesiek.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameCont(name: "Nazwa",verticalPadding: 5),
                  TextFieldBlack(
                    hintTF: "Podaj nazwe przepisu...",
                  ),
                  SizedBox(height: 20),
                  NameCont(name: "Składniki",),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: ingredientList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFieldBlack(
                              hintTF: "Podaj składnik...",
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel, color: Color(0xFF2E8B57)),
                            onPressed: () {
                              setState(() {
                                ingredientList.removeAt(index);
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
                      });
                    },
                    child: Text("Dodaj składnik"),
                  ),
                  SizedBox(height: 20),
                  NameCont(name: "Kalorie i makroskładniki"),
                  MacroRow(carbohydratesHint: "Podaj kalorie", unitText: "kcal",),
                  SizedBox(height: 10),
                  MacroRow(carbohydratesHint: "Podaj weglowodany", unitText: "gram",),
                  SizedBox(height: 10),
                  MacroRow(carbohydratesHint: "Podaj tluszcze", unitText: "gram",),
                  SizedBox(height: 10),
                  MacroRow(carbohydratesHint: "Podaj bialko", unitText: "bialko",),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MacroRow extends StatelessWidget {
  final String carbohydratesHint;
  final String unitText;

  const MacroRow({
    Key? key,
    required this.carbohydratesHint,
    required this.unitText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            child: TextFieldBlack(hintTF: carbohydratesHint),
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
      ],
    );
  }
}

class TextFieldBlack extends StatelessWidget {
  final String hintTF;
  final double verticalPadding; // Nowy argument

  const TextFieldBlack({
    Key? key,
    required this.hintTF,
    this.verticalPadding = 0.0, // Domyślna wartość dla wypełnienia pionowego
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding), // Zastosowanie wypełnienia pionowego
      child: TextField(
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
      padding: EdgeInsets.symmetric(vertical: verticalPadding), // Zastosowanie wypełnienia pionowego
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