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

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box('note');
    if(widget.index != -1){
      setState(() {
        _titleController.text = notesBox.getAt(widget.index).title;
        _contentController.text = notesBox.getAt(widget.index).content;
      });
    }
  }


  void _saveNote() {
    if(widget.index == -1){
      final newNote = Note(_titleController.text,
          _contentController.text);
      setState(() {
        notesBox.add(newNote);
      });
    }
    else{
      final newNote = Note(_titleController.text,
          _contentController.text);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Column(
          children: [
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
