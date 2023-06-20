import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lifestyle_application/hive_classes/DayFood.dart';
import 'package:lifestyle_application/hive_classes/Recipe.dart';
import 'Pages/DietScreen.dart';
import 'Pages/ExerciseScreen.dart';
import 'Pages/HomeScreen.dart';
import 'Pages/SettingsScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_classes/CaloriesConst.dart';
import 'hive_classes/Exercise.dart';
import 'hive_classes/Food.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(FoodAdapter());
  Hive.registerAdapter(CaloriesConstAdapter());
  Hive.registerAdapter(DayFoodAdapter());
  await Hive.openBox('exercises');
  await Hive.openBox('exercisesGym');
  await Hive.openBox('exercisesVolley');
  await Hive.openBox('recipes');
  await Hive.openBox('foods');
  await Hive.openBox('caloriesConst');
  await Hive.openBox('dayFood');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ExerciseScreen(),
    DietScreen(),
    SettingsScreen(),
    // tu można dodać więcej ekranów
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E8B57),
          title: _currentIndex == 0
              ? Text("HomePage")
              : _currentIndex == 1
                  ? Text("ExercisePage")
                  : _currentIndex == 2
                      ? Text("DietPage")
                      : _currentIndex == 3
                          ? Text("SettingsPage")
                          : Text("HomePage"),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFF2E8B57),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
              backgroundColor: const Color(0xFF2E8B57),
              color: Colors.grey.shade200,
              activeColor: const Color(0xFF2E8B57),
              tabBackgroundColor: Colors.grey.shade200,
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
                  icon: Icons.sports_handball,
                  text: 'Exercise',
                ),
                GButton(
                  icon: Icons.fastfood,
                  text: 'Diet',
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
