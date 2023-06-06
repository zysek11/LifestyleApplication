import 'package:flutter/material.dart';

class AddModRecipe extends StatefulWidget {
  const AddModRecipe({Key? key}) : super(key: key);

  @override
  State<AddModRecipe> createState() => _AddModRecipeState();
}

class _AddModRecipeState extends State<AddModRecipe> {
  var ingredientList = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF2E8B57),
          title: Text("Add or modify recipe")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('assets/images/wiesiek.png'),
              width: MediaQuery.of(context)
                  .size
                  .width, // Szerokość całego ekranu
              height: MediaQuery.of(context).size.height *
                  0.3, // 0.3 wysokości ekranu
              fit: BoxFit.cover, // Dopasowanie obrazu do rozmiaru
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameCont(name: "Nazwa"),
                  TextFieldBlack(
                    hintTF: "Podaj nazwe przepisu...",
                  ),
                  SizedBox(height: 20),
                  NameCont(name: "Składniki"),
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
                            icon: Icon(Icons.cancel,color: Color(0xFF2E8B57),),
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
                      backgroundColor: const Color(0xFF2E8B57), // Kolor tła przycisku
                    ),
                    onPressed: () {
                      setState(() {
                        ingredientList.add("");
                      });
                    },
                    child: Text("Dodaj składnik"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldBlack extends StatelessWidget {
  final String hintTF;

  const TextFieldBlack({
    Key? key,
    required this.hintTF,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        hintText: hintTF,
        // Wykorzystanie argumentu hintTF jako tekst podpowiedzi
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2E8B57)),
        ),
      ),
    );
  }
}

class NameCont extends StatelessWidget {
  final String name;
  const NameCont({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        name,
        style: const TextStyle(
            fontSize: 26,
            color: Color(0xFF2E8B57),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
