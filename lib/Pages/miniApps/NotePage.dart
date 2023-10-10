import 'package:flutter/MATERIAL.dart';
import 'package:hive/hive.dart';

import '../../hive_classes/Note.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  late Box notesBox;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  List<int> availableColors = [
    0xFFFFFFFF,
    0xFFFFF8B8, // Czerwony
    0xFFFDE9EA, // Zielony
    0xFFF9E6FF, // Niebieski
    0xFFE4F7F6, // Żółty
    0xFFEBFFE5, // Fioletowy
  ];

  int selectedColor = 0xFFFFFFFF; // Domyślnie czerwony

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box('note');
    if(widget.index != -1){
      setState(() {
        _titleController.text = notesBox.getAt(widget.index).title;
        _contentController.text = notesBox.getAt(widget.index).content;
        selectedColor = notesBox.getAt(widget.index).color;
      });
    }
  }


  void _saveNote() {
    if(widget.index == -1){
      final newNote = Note(_titleController.text,
          _contentController.text,selectedColor);
      setState(() {
        notesBox.add(newNote);
      });
    }
    else{
      final newNote = Note(_titleController.text,
          _contentController.text,selectedColor);
      setState(() {
        notesBox.putAt(widget.index, newNote);
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: Text('Notatka'),
        actions: [
          IconButton(
            icon: Icon(Icons.check), // Ikona "check"
            onPressed: _saveNote, // Wywołaj funkcję zapisu danych po kliknięciu
          ),
        ],
      ),
      body: Container(
        color: Color(selectedColor),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int color in availableColors)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color; // Aktualizacja wybranego koloru
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(color),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Tytuł',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none, // Usunięcie podświetlenia
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none, // Usunięcie podświetlenia
                ),
              ),
              style: TextStyle(fontSize: 26),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: 'Treść notatki',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none, // Usunięcie podświetlenia
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none, // Usunięcie podświetlenia
                  ),
                ),
                style: TextStyle(fontSize: 20),
                maxLines: null, // Pozwala na wielolinijkowy tekst
              ),
            ),
          ],
        ),
      ),
    );
  }
}
