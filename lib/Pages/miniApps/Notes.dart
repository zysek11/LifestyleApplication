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
            if (index < notesBox.length) {
              final note = notesBox.getAt(index);
              if (note != null) {
                return Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    // Tutaj możesz dodać obsługę interakcji z notatką, np. edycję lub usunięcie
                  ),
                );
              }
            } else {
              // Jeśli jesteśmy na ostatnim indeksie (pusty element "+")
              return InkWell(
                onTap: () {
                  // Kliknięcie na "+" przeniesie użytkownika do strony tworzenia notatki
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade, // Wybierz rodzaj animacji, np. scale
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: 300), // Czas trwania animacji
                      child: NotePage(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
                        topRight: Radius.circular(15), bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(30))
                  ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 48.0,
                        color: Colors.grey,
                      ),
                    ),
                )
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}