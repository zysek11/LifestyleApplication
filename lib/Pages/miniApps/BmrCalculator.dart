import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BmrCalculator extends StatefulWidget {
  const BmrCalculator({Key? key}) : super(key: key);

  @override
  State<BmrCalculator> createState() => _BmrCalculatorState();
}

class _BmrCalculatorState extends State<BmrCalculator> {

  List<String> _actItems = ['brak', 'niska', 'umiarkowana', 'duża','bardzo duża'];
  List<String> _goalItems = ['chcę schudnąć','chcę utrzymać wagę','chcę przytyć'];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController weightController =  TextEditingController();
  TextEditingController heightController =  TextEditingController();
  TextEditingController ageController =  TextEditingController();
  String freqController = 'brak';
  String goalController = 'chcę schudnąć';
  double calculateCalories = 0.0;
  int indexOfActivity = 0;
  int indexOfGoal = 0;
  bool isCorrect = false;
  // kontrola przyciskow
  bool button = true;
  // kontrola scrolla
  final ScrollController _scrollController = ScrollController();
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
        title: Text('Kalkulator BMR'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                NameCont(name: "Zapotrzebowanie kaloryczne", verticalPadding: 5),
                SizedBox(height: 10,),
                Text("BMR to nic innego jak zapotrzebowanie kaloryczne człowieka, które"
                    " jest potrzebne do zapewnienia prawidłowego funkcjonowania organizmu.\n"
                    "Sprawdź je z pomocą kalkulatora BMR.",style: TextStyle(fontSize: 16),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: button ? Color(0xFF2E8B57) : Colors.white,
                        fixedSize: Size(150, 40),
                      ),
                      onPressed: () {
                        setState(() {
                          button = true;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.male,
                            color: button ? Colors.white : Color(0xFF2E8B57),
                          ),
                          Text(
                            "Mężczyzna",
                            style: TextStyle(
                              fontSize: 16,
                              color: button ? Colors.white : Color(0xFF2E8B57),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: button ? Colors.white : Color(0xFF2E8B57),
                        fixedSize: Size(150,40),
                      ),
                      onPressed: () {
                        setState(() {
                          button = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.female,
                            color: button ? Color(0xFF2E8B57) : Colors.white,
                          ),
                          Text(
                            "Kobieta",
                            style: TextStyle(
                              fontSize: 16,
                              color: button ? Color(0xFF2E8B57) : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                MacroRow(
                    carbohydratesHint: "Podaj wiek",
                    unitText: "",
                    maxLength: 3,
                    keybordType: TextInputType.number,
                    tec: ageController
                ),
                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.topLeft,
                    child: Text("Poziom aktywności:  ",style: TextStyle(fontSize: 20),)),
                Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButton<String>(
                    value: freqController,
                    onChanged: (String? newValue) {
                      setState(() {
                        freqController = newValue!;
                        indexOfActivity = _actItems.indexOf(newValue) + 1;
                      });
                    },
                    items: _actItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(fontSize: 20)),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Cel:  ",style: TextStyle(fontSize: 20),)),
                Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButton<String>(
                    value: goalController,
                    onChanged: (String? newValue) {
                      setState(() {
                        goalController = newValue!;
                        indexOfGoal = _goalItems.indexOf(newValue);
                      });
                    },
                    items: _goalItems.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(fontSize: 20)),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if (button == true) {
                          calculateCalories = (9.99 * int.parse(weightController.text)) +
                              (6.25 * int.parse(heightController.text)) -
                              (4.92 * int.parse(ageController.text)) + 5;
                          calculateCalories += (300 * indexOfGoal);
                          calculateCalories += (172 * indexOfActivity);

                        }
                        else {
                          calculateCalories = (9.99 * int.parse(weightController.text)) +
                              (6.25 * int.parse(heightController.text)) -
                              (4.92 * int.parse(ageController.text)) - 161;
                          calculateCalories += (300 * indexOfGoal);
                          calculateCalories += (133 * indexOfActivity);
                        }
                        Future.delayed(const Duration(milliseconds: 100), () {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
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
                 padding: const EdgeInsets.only(top: 15.0,bottom: 10),
                 child: Text("Oto twoje zapotrzebowanie kaloryczne: ",
                   style: TextStyle(fontSize: 20),),
               ),
                if(calculateCalories > 0)
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Lottie.asset('assets/animations/diet_animation.json',
                          width: 250,height: 250),
                      Text(calculateCalories.toInt().toString() + " kcal",
                      style: TextStyle(fontSize: 22,color: Color(0xFF2E8B57),fontWeight: FontWeight.bold),),
                    ],
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
