import 'package:hive_flutter/hive_flutter.dart';
part 'Recipe.g.dart';

@HiveType(typeId: 2)
class Recipe extends HiveObject {

  @HiveField(0)
  String name = "";

  @HiveField(1)
  String imagePath = "";

  @HiveField(2)
  List<String> stringList = [];

  @HiveField(3)
  int calories = 0;

  @HiveField(4)
  int carbs = 0;

  @HiveField(5)
  int fat = 0;

  @HiveField(6)
  int proteins = 0;

  @HiveField(7)
  String description = "";

  Recipe(this.name, this.imagePath, this.stringList, this.calories, this.carbs,
      this.fat, this.proteins, this.description);
}