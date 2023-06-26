import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController weightController =  TextEditingController();
  TextEditingController heightController =  TextEditingController();
  List<String> zakresyBmi = ['WYCHUDZENIE', 'NIEDOWAGA', 'WAGA PRAWIDŁOWA',
    'NADWAGA','OTYŁOŚĆ'];
  List<Color> kolory = [Colors.red,Colors.orange,Color(0xFF2E8B57)];
  Color kolor = Colors.red;
  String bmiString = '';
  bool isCorrect = false;
  // kontrola przyciskow
  bool button = true;
  double calculateCalories = 0.0;
  // kontrola scrolla
  ScrollController _scrollController = ScrollController();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                NameCont(name: "Wskaźnik masy ciała", verticalPadding: 5),
                SizedBox(height: 10,),
                Text("BMI jest wskaźnikiem, który jest obliczany przez porównanie"
                    " wzrostu z masą ciała. Jego wartość jest pomocna w ocenie"
                    " ryzyka wystąpienia chorób związanych z nadwagą.",style: TextStyle(fontSize: 16),),
                SizedBox(height: 30,),
                MacroRow(
                    carbohydratesHint: "Podaj wagę",
                    unitText: "kg",
                    maxLength: 3,
                    keybordType: TextInputType.number,
                    tec: weightController
                ),
                SizedBox(height: 20),
                MacroRow(
                    carbohydratesHint: "Podaj wzrost",
                    unitText: "cm",
                    maxLength: 3,
                    keybordType: TextInputType.number,
                    tec: heightController
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        calculateCalories = double.parse(weightController.text) /
                              ((double.parse(heightController.text)/100)*(double.parse(heightController.text)/100));
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        if (calculateCalories <= 16.99) {
                          bmiString = zakresyBmi[0]; // WYCHUDZENIE
                          kolor = kolory[0];
                        } else if (calculateCalories >= 17 && calculateCalories <= 18.49) {
                          bmiString = zakresyBmi[1]; // NIEDOWAGA
                          kolor = kolory[1];
                        } else if (calculateCalories >= 18.5 && calculateCalories <= 24.99) {
                          bmiString = zakresyBmi[2]; // WARTOŚĆ PRAWIDŁOWA
                          kolor = kolory[2];
                        } else if (calculateCalories >= 25 && calculateCalories <= 29.99) {
                          bmiString = zakresyBmi[3]; // NADWAGA
                          kolor = kolory[1];
                        } else if (calculateCalories >= 30) {
                          bmiString = zakresyBmi[4]; // OTYŁOŚĆ
                          kolor = kolory[0];
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor:
                      const Color(0xFF2E8B57), // Kolor tła przycisku
                    ),
                    child: Text('Sprawdz',style: TextStyle(fontSize: 18),)
                ),
                if(calculateCalories  > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,bottom: 15),
                    child: Text("Oto twoj wskaźnik masy ciała: ",
                      style: TextStyle(fontSize: 20),),
                  ),
                if(calculateCalories > 0)
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Lottie.asset(
                        bmiString == 'WAGA PRAWIDŁOWA'
                            ? 'assets/animations/diet_animation.json'
                            : 'assets/animations/bad_diet_animation.json',
                        width: 250,
                        height: 250,
                      ),
                      Text("$bmiString  ${calculateCalories.toStringAsFixed(1)}",
                        style: TextStyle(fontSize: 22,color: kolor,fontWeight: FontWeight.bold),),
                    ],
                  ),
              ],
            ),
          ),
        ),
      )
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

