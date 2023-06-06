import 'package:flutter/material.dart';

class AddModRecipe extends StatefulWidget {
  const AddModRecipe({Key? key}) : super(key: key);

  @override
  State<AddModRecipe> createState() => _AddModRecipeState();
}

class _AddModRecipeState extends State<AddModRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF2E8B57),
          title: Text("Add or modify recipe")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
              Image(
                image: AssetImage('assets/images/wiesiek.png'),
                width: MediaQuery.of(context).size.width, // Szerokość całego ekranu
                height: MediaQuery.of(context).size.height * 0.3, // 0.3 wysokości ekranu
                fit: BoxFit.cover, // Dopasowanie obrazu do rozmiaru
              ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameCont(),
                  TextFieldBlack(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldBlack extends StatelessWidget {
  const TextFieldBlack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black, fontSize: 20), // Kolor czarny dla tekstu
      decoration: InputDecoration(
        hintText: "podaj nazwę swojego przepisu",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Kolor czarny dla dolnego bordera
        ),
      ),
    );
  }
}



class NameCont extends StatelessWidget {
  const NameCont({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: const Text(
        'Nazwa',
        style: TextStyle(
            fontSize: 26,
            color: Color(0xFF2E8B57),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
