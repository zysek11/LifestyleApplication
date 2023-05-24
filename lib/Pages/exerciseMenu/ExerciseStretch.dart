import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../hive_classes/Stretching.dart';

class ExerciseStretch extends StatefulWidget {
  const ExerciseStretch({Key? key}) : super(key: key);

  @override
  _ExerciseStretchState createState() => _ExerciseStretchState();
}

class _ExerciseStretchState extends State<ExerciseStretch> {
  int _selectedIndex = -1;

  late Box<Stretching> exercises;

  @override
  void initState()
  {
    super.initState();
    exercises = Hive.box<Stretching>('exercises');
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
                  itemCount: exercises.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bool showMore =
                        _selectedIndex == index ? true : false;
                    final item = exercises.getAt(index);
                    final keyString = item?.key.toString();
                    return Dismissible(
                      key: Key(keyString!),
                      onDismissed: (direction) {
                        setState(() {
                          exercises.deleteAt(index);
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
                            onLongPress: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final textController1 = TextEditingController(text: item?.name);
                                    final textController2 = TextEditingController(text: (item?.series).toString());
                                    final textController3 = TextEditingController(text: (item?.repeats).toString());
                                    final textController4 = TextEditingController(text: item?.description);
                                    return AlertDialog(
                                      titlePadding: EdgeInsets.zero,
                                      title: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        color: const Color(0xFF2E8B57),
                                        child: const Icon(Icons.edit,size: 50,),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: textController1,
                                              decoration: InputDecoration(labelText: "nazwa cwiczenia:"),
                                            ),
                                            TextField(
                                              controller: textController2,
                                              decoration: InputDecoration(labelText: "serie:"),
                                            ),
                                            TextField(
                                              controller: textController3,
                                              decoration: InputDecoration(labelText: "Powtorzenia:"),
                                            ),
                                            TextField(
                                              controller: textController4,
                                              decoration: const InputDecoration(labelText: "Opis:"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text('Zapisz'),
                                          onPressed: () {
                                            final exercise = Stretching(
                                              textController1.text,
                                              int.parse(textController2.text),
                                              int.parse(textController3.text),
                                              textController4.text,
                                            );
                                            setState(() {
                                              exercises.putAt(index,exercise); // dodanie elementu do listy
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Anuluj'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // zamknięcie okna dialogowego
                                          },
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            leading: const Icon(Icons.sports_gymnastics, size: 32,
                              color: Color(0xFFEC9006),),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nazwa cwiczenia: ${item?.name}',
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
                                                  fontWeight:
                                                      FontWeight.bold),
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
                                  ],
                                ),
                                if (showMore) const SizedBox(height: 10),
                                if (showMore)
                                  Text( '${item?.description}',
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
                      return AlertDialog(
                        title: Text('Dodaj element'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: textController1,
                                decoration: InputDecoration(hintText: "Nazwa cwiczenia:"),
                              ),
                              TextField(
                                controller: textController2,
                                decoration: InputDecoration(hintText: "Serie: "),
                              ),
                              TextField(
                                controller: textController3,
                                decoration: InputDecoration(hintText: "Powtorzenia: "),
                              ),
                              TextField(
                                controller: textController4,
                                decoration: InputDecoration(hintText: "Opis: "),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text('Zapisz'),
                            onPressed: () {
                              final exercise = Stretching(
                                textController1.text,
                                int.parse(textController2.text),
                                int.parse(textController3.text),
                                textController4.text,
                              );
                              setState(() {
                                exercises.add(exercise); // dodanie elementu do listy
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Anuluj'),
                            onPressed: () {
                              Navigator.of(context).pop(); // zamknięcie okna dialogowego
                            },
                          )
                        ],
                      );
                    }
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
