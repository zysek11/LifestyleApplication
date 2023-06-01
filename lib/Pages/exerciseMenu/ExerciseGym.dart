import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../hive_classes/Gym.dart';

class ExerciseGym extends StatefulWidget {
  const ExerciseGym({Key? key}) : super(key: key);

  @override
  _ExerciseGymState createState() => _ExerciseGymState();
}

class _ExerciseGymState extends State<ExerciseGym> {
  int _selectedIndex = -1;
  late Box exercisesG;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    exercisesG = Hive.box('exercisesGym');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: exercisesG.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bool showMore =
                        _selectedIndex == index ? true : false;
                    final item = exercisesG.getAt(index);
                    final keyString = item?.key.toString();
                    return Dismissible(
                      key: Key(keyString!),
                      onDismissed: (direction) {
                        setState(() {
                          exercisesG.deleteAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.cancel),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF2E8B57),
                                width: 2.0,
                                style: BorderStyle.solid)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
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
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final textController1 =
                                        TextEditingController(text: item?.name);
                                    final textController2 =
                                        TextEditingController(
                                            text: (item?.series).toString());
                                    final textController3 =
                                        TextEditingController(
                                            text: (item?.repeats).toString());
                                    final textController4 =
                                        TextEditingController(
                                            text: (item?.seriesTime));
                                    final textController5 =
                                        TextEditingController(
                                            text: item?.breakTime);
                                    final textController6 =
                                        TextEditingController(
                                            text: item?.description);
                                    return AlertDialog(
                                      titlePadding: EdgeInsets.zero,
                                      title: Container(
                                        color: const Color(0xFF2E8B57),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Edytuj ",
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              child: const Icon(
                                                Icons.edit,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Nazwa ćwiczenia:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF2E8B57),
                                                  )),
                                            ),
                                            TextField(
                                              controller: textController1,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Serie:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF2E8B57),
                                                  )),
                                            ),
                                            TextField(
                                              controller: textController2,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Powtorzenia:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF2E8B57),
                                                  )),
                                            ),
                                            TextField(
                                              controller: textController3,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Czas wykonywania:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF2E8B57),
                                                  )),
                                            ),
                                            TextField(
                                              controller: textController4,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Przerwa:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF2E8B57),
                                                  )),
                                            ),
                                            TextField(
                                              controller: textController5,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Opis:",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF2E8B57),
                                                  )),
                                            ),
                                            TextField(
                                              controller: textController6,
                                              maxLines: null,
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.zero),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ButtonBar(
                                          alignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2E8B57),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: Row(
                                                      children: const [
                                                        Text(
                                                          "Zapisz",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Icon(
                                                          Icons.check,
                                                          size: 20,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              onPressed: () {
                                                final exercise = Gym(
                                                  textController1.text,
                                                  int.parse(
                                                      textController2.text),
                                                  int.parse(
                                                      textController3.text),
                                                  textController4.text,
                                                  textController5.text,
                                                  textController6.text,
                                                );
                                                setState(() {
                                                  exercisesG.putAt(index,
                                                      exercise); // dodanie elementu do listy
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFF2E8B57),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: Row(
                                                      children: const [
                                                        Text(
                                                          "Anuluj",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF2E8B57),
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Icon(
                                                          Icons.close,
                                                          size: 20,
                                                          color:
                                                              Color(0xFF2E8B57),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // zamknięcie okna dialogowego
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            },
                            leading: const Icon(
                              Icons.fitness_center,
                              size: 32,
                              color: Color(0xFFEC9006),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${item?.name}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF2E8B57),
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Serie: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF2E8B57),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: '${item?.series}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Powtórzenia: ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF2E8B57),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: '${item?.repeats}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (item?.seriesTime != "")
                                  Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Czas serii: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF2E8B57),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: '${item?.seriesTime}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                if(item?.breakTime != "")
                                Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Czas przerwy: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF2E8B57),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: '${item?.breakTime}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (showMore) const SizedBox(height: 10),
                                if (showMore)
                                  Text(
                                    '${item?.description}',
                                    style: const TextStyle(fontSize: 16),
                                  )
                              ],
                            ),
                            trailing: showMore == true
                                ? const Icon(Icons.arrow_drop_up_sharp)
                                : const Icon(Icons.arrow_drop_down_sharp),
                            dense: false,
                            isThreeLine: false,
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final textController1 = TextEditingController();
                      final textController2 = TextEditingController();
                      final textController3 = TextEditingController();
                      final textController4 = TextEditingController();
                      final textController5 = TextEditingController();
                      final textController6 = TextEditingController();
                      return Container(
                        child: AlertDialog(
                          titlePadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.all(0),
                          title: Container(
                            color: const Color(0xFF2E8B57),
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Dodaj ",
                                  style: TextStyle(fontSize: 22),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          content: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Nazwa ćwiczenia:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E8B57),
                                        )),
                                  ),
                                  TextField(
                                    controller: textController1,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Serie:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E8B57),
                                        )),
                                  ),
                                  TextField(
                                    controller: textController2,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Powtorzenia:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E8B57),
                                        )),
                                  ),
                                  TextField(
                                    controller: textController3,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Opis:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E8B57),
                                        )),
                                  ),
                                  TextField(
                                    controller: textController6,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CheckboxListTile(
                                    title: const Text("Pomiar czasu",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E8B57),
                                        )),
                                    value: isChecked,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: Color(0xFF2E8B57),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value ?? false;
                                      });
                                    },
                                  ),
                                  if (isChecked)
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Czas wykonywania:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF2E8B57),
                                              )),
                                        ),
                                        TextField(
                                          controller: textController4,
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Przerwa:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF2E8B57),
                                              )),
                                        ),
                                        TextField(
                                          controller: textController5,
                                          decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.zero),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            );
                          }),
                          actions: [
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2E8B57),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Zapisz",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.check,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ],
                                        )),
                                  ),
                                  onPressed: () {
                                    final exercise = Gym(
                                        textController1.text,
                                        int.parse(textController2.text),
                                        int.parse(textController3.text),
                                        textController4.text,
                                        textController5.text,
                                        textController6.text);
                                    setState(() {
                                      exercisesG.add(
                                          exercise); // dodanie elementu do listy
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xFF2E8B57),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          children: const [
                                            Text(
                                              "Anuluj",
                                              style: TextStyle(
                                                  color: Color(0xFF2E8B57),
                                                  fontSize: 16),
                                            ),
                                            SizedBox(width: 10),
                                            Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Color(0xFF2E8B57),
                                            ),
                                          ],
                                        )),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // zamknięcie okna dialogowego
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
