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
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Zaokrąglenie rogów
              ),// Wysokość cienia
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Czy wiesz, że ...'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Tutaj możesz wpisać cokolwiek'),
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