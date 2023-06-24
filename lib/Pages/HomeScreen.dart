import 'package:flutter/material.dart';

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
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Card(
              color: const Color(0xFF3F9C68),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ), // Zaokrąglenie rogów
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
                    child: Text('Tutaj możesz wpisać cokolwiek,'
                        'Tutaj możesz wpisać cokolwiek,'
                        'Tutaj możesz wpisać cokolwiek',style: TextStyle(
                        fontSize: 16
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}