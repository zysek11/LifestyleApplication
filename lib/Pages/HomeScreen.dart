import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '';
import 'miniApps/BmiCalculator.dart';
import 'miniApps/BmrCalculator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Witaj!',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Lottie.asset('assets/animations/happy_fruit.json',
              width: 200,height: 200),
          Container(
            width: double.infinity,
            child: Card(
              color: const Color(0xFF4FAD79),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20) // Zaokrąglenie rogów
              ),// Wysokość cienia
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10,right:10,top:10),
                    child: Text('Czy wiesz, że ...',style: TextStyle(
                      fontSize: 18
                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10,right:10,top:5,bottom:10),
                    child: Text('Ćwicząc każdego dnia osiągniesz sukces?\n'
                        'Ćwicz a będziesz w najlepszej formie!\n'
                        'Patryk Programista',style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            alignment: Alignment.topLeft,
              child: Text("Twoje mini-aplikacje",style: TextStyle(
                fontSize: 25,
              ),),),
          SizedBox(height: 10,),
          Container(
            // Inne właściwości kontenera...
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BmrCalculator()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.calculate_rounded, // Wybierz odpowiednią ikonę z biblioteki flutter_icons
                        size: 64,
                        color: const Color(0xFF2E8B57),
                      ),
                      Text("BMR",style: TextStyle(
                        fontSize: 18,
                      ),)
                    ],
                  ),
                ),
                InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BmiCalculator()),
                      );
                    },
                  child: Column(
                    children: [
                      Icon(
                        Icons.compare, // Wybierz odpowiednią ikonę z biblioteki flutter_icons
                        size: 64,
                        color: const Color(0xFF2E8B57),
                      ),
                      Text("BMI",style: TextStyle(
                        fontSize: 18,
                      ),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}