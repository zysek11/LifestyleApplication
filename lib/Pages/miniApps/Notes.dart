import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../../hive_classes/Note.dart';
import 'NotePage.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late Box notesBox;

  void _addNote() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        duration: Duration(milliseconds: 300),
        child: NotePage(index: -1),
      ),
    ).then((value) {
      // Po powrocie z ekranu NotePage, odśwież GridView
      setState(() {});
    });
  }

  void _openExistingNote(int noteIndex){
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        duration: Duration(milliseconds: 300),
        child: NotePage(index: noteIndex),
      ),
    ).then((value) {
      // Po powrocie z ekranu NotePage, odśwież GridView
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box('note');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: Text('Notatki'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Możesz dostosować liczbę kolumn
          ),
          itemCount: notesBox.length + 1, // Dodajemy 1 dla pustego elementu "+"
          itemBuilder: (context, index) {
            if (index == 0) {
              // Tworzenie pustego pola z plusem "+" na początek
              return InkWell(
                onTap: _addNote,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 48.0,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              );
            } else {
              final reversedIndex = notesBox.length - index;
              final note = notesBox.getAt(reversedIndex);
              if (note != null) {
                // Tworzenie kart notatek po indeksach
                return InkWell(
                  onTap: () => _openExistingNote(reversedIndex),
                  child: Card(
                    color: Color(note.color),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Stack(
                      children: [
                        ListTile(
                          title: Text(note.title),
                          subtitle: Text(note.content),
                          // Tutaj możesz dodać obsługę interakcji z notatką, np. edycję lub usunięcie
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Usuwanie notatki'),
                                    content: Text('Czy na pewno chcesz usunąć tę notatkę?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Zamykanie alertDialog
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Anuluj",
                                          style: TextStyle(
                                            color: const Color(0xFF2E8B57),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Usuwanie notatki i zamykanie alertDialog
                                          notesBox.deleteAt(reversedIndex);
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
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
                            child: Icon(
                              Icons.delete_outlined,
                              size: 30.0,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}