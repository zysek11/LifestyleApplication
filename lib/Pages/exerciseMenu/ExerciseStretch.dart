import 'package:flutter/material.dart';

class ExerciseStretch extends StatefulWidget {
  const ExerciseStretch({Key? key}) : super(key: key);

  @override
  _ExerciseStretchState createState() => _ExerciseStretchState();
}

class _ExerciseStretchState extends State<ExerciseStretch> {

  int _itemCount = 5;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return ListTile(
                      title: Container(
                          color: Colors.cyanAccent,
                          child: Text('Item $index')),
                    );
                  },
                  childCount: _itemCount,
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
                print('Kliknięto!');
                setState(() {
                  _itemCount++;
                });
                // Tutaj dodaj swoją funkcję, która ma zostać wykonana po kliknięciu przycisku
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
