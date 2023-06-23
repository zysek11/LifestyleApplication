import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class DietArchive extends StatefulWidget {
  const DietArchive({Key? key}) : super(key: key);

  @override
  State<DietArchive> createState() => _DietArchiveState();
}

class _DietArchiveState extends State<DietArchive> {

  late Box dayFood;


  @override
  void initState() {
    super.initState();
    dayFood = Hive.box('dayFood');
    print("ilosc dni: "+dayFood.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.80,
          ),
          itemCount: dayFood.length -1,
          itemBuilder: (BuildContext context, int index) {
            final item = dayFood.getAt(dayFood.length - 2 - index);
            final int calories_percent = ((item.calories_counter / item.calories_limit)*100).toInt();
            final int carbs_percent = ((item.carbs_counter / item.carbs_limit)*100).toInt();
            final int fat_percent = ((item.fat_counter / item.fat_limit)*100).toInt();
            final int protein_percent = ((item.proteins_counter / item.proteins_limit)*100).toInt();

            Color getPercentageColor(int percentage) {
              if (percentage < 75) {
                return Colors.red;
              } else if (percentage >= 75 && percentage < 90) {
                return Colors.orange;
              } else if (percentage >= 90 && percentage <= 110) {
                return Colors.green;
              } else if (percentage > 110 && percentage <= 125) {
                return Colors.orange;
              } else {
                return Colors.red;
              }
            }
            return Center(
              child: InkWell(
                onTap: () {
                  // Obsługa dotknięcia elementu
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(DateFormat('yyyy-MM-dd').format(item.date),
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,
                            color: Color(0xFFEC9006),),
                        ),
                      ), // Odstęp między datą a ikonką
                      Container(
                        width: double.infinity,
                        height: 80,
                        child: Icon(Icons.fastfood,size: 70,
                        color: Color(0xFFEC9006),),// Przykładowy kolor tła ikonki
                        // Tutaj możesz dodać ikonkę jedzenia
                      ),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Kalorie:",style: TextStyle(fontSize: 16),),
                          Text(calories_percent.toString() + "%",style: TextStyle(
                              color: getPercentageColor(fat_percent),fontWeight: FontWeight.bold),)
                      ],),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Weglowodany:",style: TextStyle(fontSize: 16),),
                          Text(carbs_percent.toString() + "%",style: TextStyle(
                              color: getPercentageColor(fat_percent),fontWeight: FontWeight.bold),)
                        ],),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tluszcze:",style: TextStyle(fontSize: 16),),
                          Text(fat_percent.toString() + "%",style: TextStyle(
                            color: getPercentageColor(fat_percent),
                              fontWeight: FontWeight.bold
                          ),),
                        ],),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Bialko:",style: TextStyle(fontSize: 16),),
                          Text(protein_percent.toString() + "%",style: TextStyle(
                              color: getPercentageColor(fat_percent),
                              fontWeight: FontWeight.bold),)
                        ],),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
