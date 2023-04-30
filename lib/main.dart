import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'my_flutter_app_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AcScreen(),
    HeadScreen(),
    SettingsScreen(),
    // tu można dodać więcej ekranów
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          title: _currentIndex == 0
              ? Text("HomePage")
              : _currentIndex == 1
                  ? Text("AcPage")
                  : _currentIndex == 2
                      ? Text("HeadPage")
                      : _currentIndex == 3
                          ? Text("SettingsPage")
                          : Text("HomePage"),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          color: Colors.red.shade900,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
              backgroundColor: Colors.red.shade900,
              color: Colors.white,
              activeColor: Colors.red.shade900,
              tabBackgroundColor: Colors.white,
              gap: 8,
              padding: EdgeInsets.all(12),
              onTabChange: (index){
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: MyFlutterApp.hand_rock,
                  text: 'Snow',
                ),
                GButton(
                  icon: MyFlutterApp.fast_food,
                  text: 'Head',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade600,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('home page'),
          ],
        ),
      ),
    );
  }
}

class AcScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade600,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ac page'),
          ],
        ),
      ),
    );
  }
}

class HeadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.grey.shade600,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('head page'),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.grey.shade600,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('settings page'),
          ],
        ),
      ),
    );
  }
}
