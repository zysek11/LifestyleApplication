import 'package:flutter/material.dart';

class BmrCalculator extends StatefulWidget {
  const BmrCalculator({Key? key}) : super(key: key);

  @override
  State<BmrCalculator> createState() => _BmrCalculatorState();
}

class _BmrCalculatorState extends State<BmrCalculator> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isCorrect = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: Text('BMR Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                ],
              ),
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
