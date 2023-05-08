import 'package:flutter/material.dart';

class ExerciseStretch extends StatefulWidget {
  const ExerciseStretch({Key? key}) : super(key: key);

  @override
  _ExerciseStretchState createState() => _ExerciseStretchState();
}

class _ExerciseStretchState extends State<ExerciseStretch> {

  int _itemCount = 1;
  int _selectedIndex = -1;

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
                  itemCount: _itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    final backgroundColor =
                    _selectedIndex == index ? Colors.green.shade100 : Colors.white;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: (){
                          setState(() {
                            _selectedIndex = index;
                            print("kliknieto!");
                          });
                        },
                        leading: Icon(Icons.person),
                        title: Text('This is: $index'),
                        subtitle: Text('Subtitle for title...'),
                        trailing: Icon(Icons.arrow_drop_down_sharp),
                        dense: false,
                        isThreeLine: false,
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
