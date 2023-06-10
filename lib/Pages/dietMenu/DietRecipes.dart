import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lifestyle_application/Pages/dietMenu/AddModRecipe.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:io';

class DietRecipes extends StatefulWidget {
  const DietRecipes({Key? key}) : super(key: key);

  @override
  State<DietRecipes> createState() => _DietRecipesState();
}

class _DietRecipesState extends State<DietRecipes> {
  int _selectedIndex = -1;

  late Box recipes;

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    recipes = Hive.box('recipes');
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
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bool showMore =
                        _selectedIndex == index ? true : false;
                    final item = recipes.getAt(index);
                    final List<String> skladniki = item.stringList;
                    final keyString = item?.key.toString();
                    return Dismissible(
                      key: Key(keyString!),
                      onDismissed: (direction) {
                        setState(() {
                          recipes.deleteAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.cancel),
                      ),
                      child: InkWell(
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
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.zero,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 10,bottom: 10),
                                    alignment: Alignment.topLeft,
                                    width: 125,
                                    height: 125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadiusDirectional.only(
                                          topStart: Radius.circular(15),
                                          bottomEnd: Radius.circular(15)),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadiusDirectional.only(
                                            topStart: Radius.circular(15),
                                            bottomEnd: Radius.circular(15)),
                                      child: Image.file(
                                        File(item.imagePath),
                                        fit: BoxFit.cover,
                                        width: 125,
                                        height: 125,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 125,
                                      child: Column(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(item.name,style: TextStyle(fontSize: 26),),
                                                ),
                                              )
                                          ),
                                          Expanded(
                                            flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                child: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("Kalorie: ${item.calories}",style: TextStyle(fontSize: 19),),
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,),
                              Container(
                                height: 75,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Spacer(flex: 1,),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(child: Container(
                                                alignment: Alignment.center,
                                                child: Text("Carbs"))),
                                            Expanded(child: Container(
                                                alignment: Alignment.center,
                                                child: Text(item.carbs.toString()))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(flex: 1,),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(child: Container(
                                                alignment: Alignment.center,
                                                child: Text("Fat"))),
                                            Expanded(child: Container(
                                                alignment: Alignment.center,
                                                child: Text(item.fat.toString()))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(flex: 1,),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(child: Container(
                                                alignment: Alignment.center,
                                                child: Text("Protein"))),
                                            Expanded(child: Container(
                                                alignment: Alignment.center,
                                                child: Text(item.proteins.toString()))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(flex: 1,),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              if(showMore)
                                Container(
                                  padding: EdgeInsets.only(top: 20,bottom: 8,left: 10),
                                  alignment: Alignment.topLeft,
                                    child: Text("Skladniki: ", style: TextStyle(fontSize: 20),)
                                ),
                              if(showMore)
                                ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: item.stringList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final ingredient = item.stringList[index];
                                    return ListTile(
                                      visualDensity:VisualDensity(horizontal: 0, vertical: -4),
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      leading: Icon(Icons.circle_rounded, size: 10, color: Colors.black,),
                                      title: Text(
                                        ingredient.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    );
                                  },
                                ),
                              if(showMore) SizedBox(height: 10,),
                              if (showMore)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${item?.description}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              if(showMore) SizedBox(height: 10,),
                            ],
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddModRecipe()),
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
