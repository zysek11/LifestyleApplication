import 'package:hive_flutter/hive_flutter.dart';
part 'Food.g.dart';

@HiveType(typeId: 3)
class Food extends HiveObject {

  @HiveField(0)
  String name = "";

  @HiveField(1)
  String type = "";

  @HiveField(2)
  int calories = 0;

  @HiveField(3)
  int carbs = 0;

  @HiveField(4)
  int fat = 0;

  @HiveField(5)
  int proteins = 0;

  Food(
      this.name, this.type, this.calories, this.carbs, this.fat, this.proteins);
}