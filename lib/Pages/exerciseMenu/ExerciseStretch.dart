import 'package:flutter/material.dart';

class ExerciseStretch extends StatefulWidget {
  const ExerciseStretch({Key? key}) : super(key: key);

  @override
  _ExerciseStretchState createState() => _ExerciseStretchState();
}

class _ExerciseStretchState extends State<ExerciseStretch> {
  int _selectedIndex = -1;
  final items = List<String>.generate(0, (i) => '${i + 1}');

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
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bool showMore =
                        _selectedIndex == index ? true : false;
                    final item = items[index];
                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        setState(() {
                          items.removeAt(index);
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
                            leading: const Icon(Icons.sports_gymnastics, size: 32,
                              color: Color(0xFFEC9006),),
                            title: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nazwa cwiczenia: ${items[index]}',
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
                                                text: '${items[index]}',
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
                                                text: '${items[index]}',
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
                                    const Text(
                                      "To jest dodatkowy napis\n"
                                      "Tu jest druga linijka tego napisu\n"
                                      "Tu jest trzecia i ostatnia linijka",
                                      style: TextStyle(fontSize: 16),
                                    )
                                ],
                              ),
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
                print('Kliknięto!');
                setState(() {
                  items.add("${items.length + 1}");
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
