import 'package:flutter/MATERIAL.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B57),
        title: Text('Notatka'),
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
