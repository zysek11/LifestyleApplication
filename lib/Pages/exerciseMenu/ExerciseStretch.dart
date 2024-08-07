import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../hive_classes/Exercise.dart';
import 'AddModExercise.dart';

class ExerciseStretch extends StatefulWidget {
  const ExerciseStretch({Key? key}) : super(key: key);

  @override
  State<ExerciseStretch> createState() => _ExerciseStretchState();
}

class _ExerciseStretchState extends State<ExerciseStretch> {
  int _selectedIndex = -1;

  late Box exercises;

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    exercises = Hive.box('exercises');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ListView.separated(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                separatorBuilder: (context, index) => SizedBox(height: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool showMore =
                      _selectedIndex == index ? true : false;
                  final item = exercises.getAt(index);
                  final keyString = item?.key.toString();
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
                        exercises.deleteAt(index);
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
                          print("kliknieto!");
                        });
                      },
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddModExercise(
                                  editMode: true, index: index,boxName: "exercises",gymMode: false,)),
                        ).then((value) {
                          if (value == true) {
                            setState(() {
                              // Zaktualizuj dane w stanie widoku
                              exercises = Hive.box('exercises');
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
                                      Icons.sports_gymnastics, // Ikona hantla
                                      size: 80, // Rozmiar ikony
                                      color: Color(
                                          0xFFEC9006), // Kolor ikony
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
                },
              ),
            ),
          ],
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
                    builder: (context) =>
                        AddModExercise(editMode: false, index: -1, boxName: "exercises",gymMode: false,)),
              ).then((value) {
                if (value == true) {
                  setState(() {
                    // Zaktualizuj dane w stanie widoku
                    exercises = Hive.box('exercises');
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
