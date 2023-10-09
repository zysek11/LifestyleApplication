
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../hive_classes/Exercise.dart';
import '../../hive_classes/Gym.dart';
import 'AddModExercise.dart';

class ExerciseGym extends StatefulWidget {
  const ExerciseGym({Key? key}) : super(key: key);

  @override
  State<ExerciseGym> createState() => _ExerciseGymState();
}

class _ExerciseGymState extends State<ExerciseGym> {
  int _selectedIndex = -1;
  late Box exercisesG;
  List<Gym> exercisesCopy = [];
  List<int> indexListMirror = [];
  bool isChecked = false;
  List<bool> buttonList = List<bool>.filled(7, true);
  List<String> _types = [
    'klata',
    'plecy',
    'nogi',
    'barki',
    'biceps',
    'triceps',
    'brzuch'
  ];

  @override
  void initState() {
    super.initState();
    exercisesG = Hive.box('exercisesGym');
    sortListByType();
  }

  void sortListByType(){
    exercisesCopy.clear();
    indexListMirror.clear();
    for(int i=0; i < _types.length; i++){
      for(int j =0; j < exercisesG.length; j++){
        print("typ: "+exercisesG.getAt(j).type);
        if(exercisesG.getAt(j).type == _types[i]){
        dynamic item = exercisesG.getAt(j);
        exercisesCopy.add(item);
        indexListMirror.add(j);
        }
      }
    }
  }

  void setOnlyOneType(int skip){
    for(int i = 0; i < buttonList.length;i++){
      if(i != skip){
        setState(() {
          buttonList[i] = false;
        });
      }
    }
  }



  bool checkIfFiltered(String type) {
    for (int i = 0; i < _types.length; i++) {
      if (_types[i] == type) {
        return buttonList[i];
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 10),
                  separatorBuilder: (context, index) {
                    final item = exercisesCopy[index];
                    if (item != null && !checkIfFiltered(item.type)) {
                      return SizedBox
                          .shrink(); // Pomijanie marginesu separatora dla niepasujących elementów
                    } else {
                      return SizedBox(height: 20);
                    }
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: exercisesCopy.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bool showMore = _selectedIndex == index ? true : false;
                    final item = exercisesCopy[index];
                    final keyString = item?.key.toString();
                    if (checkIfFiltered(item.type) == true) {
                      return Dismissible(
                        key: Key(keyString!),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Usuwanie Ćwiczenia"),
                                content: Text("Czy na pewno chcesz usunąć to ćwiczenie?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false), // Anuluj
                                    child: Text(
                                      "Anuluj",
                                      style: TextStyle(color: const Color(0xFF2E8B57),),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true), // Usuń
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: const Color(0xFF2E8B57),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Usuń",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {
                          setState(() {
                            exercisesG.deleteAt(indexListMirror[index]);
                            sortListByType();
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.cancel),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_selectedIndex == index) {
                                // Ten sam element został kliknięty po raz drugi, więc go odznaczamy
                                _selectedIndex = -1;
                              } else {
                                // Inny element został kliknięty, więc go zaznaczamy
                                _selectedIndex = index;
                              }
                            });
                          },
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddModExercise(
                                        editMode: true,
                                        index: indexListMirror[index],
                                        boxName: "exercisesGym",
                                        gymMode: true,
                                      )),
                            ).then((value) {
                              if (value == true) {
                                setState(() {
                                  // Zaktualizuj dane w stanie widoku
                                  exercisesG = Hive.box('exercisesGym');
                                  sortListByType();
                                });
                              }
                            });
                          },
                          child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.zero,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: 100,
                                      height: 125,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.fitness_center, // Ikona hantla
                                          size: 80, // Rozmiar ikony
                                          color: Color(0xFFEC9006), // Kolor ikony
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 125,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 5.0,
                                                      right: 5.0,
                                                      bottom: 5.0,
                                                      top: 8),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            item.name,
                                                            style: TextStyle(
                                                                fontSize: 23),
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.topCenter,
                                                          child: Icon(
                                                            showMore
                                                                ? Icons
                                                                    .keyboard_arrow_up
                                                                : Icons
                                                                    .keyboard_arrow_down,
                                                            size: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: RichText(
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                                fontSize: 19,
                                                                color:
                                                                    Colors.black),
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      'Serie:  '),
                                                              TextSpan(
                                                                text: item.series
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFFEC9006),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: TextStyle(
                                                              fontSize: 19,
                                                              color:
                                                                  Colors.black),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    'Powtorzenia:  '),
                                                            TextSpan(
                                                              text: item.repeats
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFEC9006),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ), // Pusty kontener
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15.0, left: 10, right: 10),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 19, color: Colors.black),
                                        children: [
                                          TextSpan(text: 'Typ:  '),
                                          TextSpan(
                                            text: item.type,
                                            style: TextStyle(
                                                color: Color(0xFFEC9006),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ), // Pusty kontener
                                if (showMore)
                                  Container(
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Wykonanie",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      item.seriesTime.toString(),
                                                      style: TextStyle(
                                                        color: Color(0xFFEC9006),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Przerwa",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      item.breakTime.toString(),
                                                      style: TextStyle(
                                                        color: Color(0xFFEC9006),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                if (showMore)
                                  SizedBox(
                                    height: 20,
                                  ),
                                if (showMore)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '${item?.description}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                if (showMore)
                                  SizedBox(
                                    height: 15,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttonList[0] = !buttonList[0];
                      });
                    },
                    onLongPress: (){
                      setOnlyOneType(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          buttonList[0] ? Color(0xFF2E8B57) : Colors.white,
                    ),
                    child: Text(
                      'Klata',
                      style: TextStyle(
                          fontSize: 17,
                          color:
                              buttonList[0] ? Colors.white : Color(0xFF2E8B57)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttonList[1] = !buttonList[1];
                      });
                    },
                    onLongPress: (){
                      setOnlyOneType(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          buttonList[1] ? Color(0xFF2E8B57) : Colors.white,
                    ),
                    child: Text(
                      'Plecy',
                      style: TextStyle(
                          fontSize: 17,
                          color:
                              buttonList[1] ? Colors.white : Color(0xFF2E8B57)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttonList[2] = !buttonList[2];
                      });
                    },
                    onLongPress: (){
                      setOnlyOneType(2);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          buttonList[2] ? Color(0xFF2E8B57) : Colors.white,
                    ),
                    child: Text(
                      'Nogi',
                      style: TextStyle(
                          fontSize: 17,
                          color:
                              buttonList[2] ? Colors.white : Color(0xFF2E8B57)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttonList[3] = !buttonList[3];
                      });
                    },
                    onLongPress: (){
                      setOnlyOneType(3);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          buttonList[3] ? Color(0xFF2E8B57) : Colors.white,
                    ),
                    child: Text(
                      'Barki',
                      style: TextStyle(
                          fontSize: 17,
                          color:
                              buttonList[3] ? Colors.white : Color(0xFF2E8B57)),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttonList[4] = !buttonList[4];
                      });
                    },
                    onLongPress: (){
                      setOnlyOneType(4);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          buttonList[4] ? Color(0xFF2E8B57) : Colors.white,
                    ),
                    child: Text(
                      'Biceps',
                      style: TextStyle(
                          fontSize: 17,
                          color:
                              buttonList[4] ? Colors.white : Color(0xFF2E8B57)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttonList[5] = !buttonList[5];
                      });
                    },
                    onLongPress: (){
                      setOnlyOneType(5);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          buttonList[5] ? Color(0xFF2E8B57) : Colors.white,
                    ),
                    child: Text(
                      'Triceps',
                      style: TextStyle(
                          fontSize: 17,
                          color:
                              buttonList[5] ? Colors.white : Color(0xFF2E8B57)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        buttonList[6] = !buttonList[6];
                      });
                    },
                    onLongPress: (){
                      setOnlyOneType(6);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          buttonList[6] ? Color(0xFF2E8B57) : Colors.white,
                    ),
                    child: Text(
                      'Brzuch',
                      style: TextStyle(
                          fontSize: 17,
                          color:
                              buttonList[6] ? Colors.white : Color(0xFF2E8B57)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E8B57),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddModExercise(
                          editMode: false,
                          index: -1,
                          boxName: "exercisesGym",
                          gymMode: true,
                        )),
              ).then((value) {
                if (value == true) {
                  setState(() {
                    // Zaktualizuj dane w stanie widoku
                    exercisesG = Hive.box('exercisesGym');
                    sortListByType();

                  });
                }
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
