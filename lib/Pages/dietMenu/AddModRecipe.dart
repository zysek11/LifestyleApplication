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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameCont(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    )
                ),
              ),
              // ...
            ],
          ),
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
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Text(
        'Nazwa',
        style: TextStyle(
            fontSize: 30,
            color: const Color(0xFF2E8B57),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
