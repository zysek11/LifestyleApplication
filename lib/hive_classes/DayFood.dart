import 'package:hive_flutter/hive_flutter.dart';
import 'Food.dart';
part 'DayFood.g.dart';

@HiveType(typeId: 4)
class DayFood extends HiveObject {

  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  List<Food> foodList = [];

  @HiveField(2)
  int calories_counter = 0;

  @HiveField(3)
  int carbs_counter = 0;

  @HiveField(4)
  int fat_counter = 0;

  @HiveField(5)
  int proteins_counter = 0;

  @HiveField(6)
  int carbs_limit = 0;

  @HiveField(7)
  int fat_limit = 0;

  @HiveField(8)
  int calories_limit = 0;

  @HiveField(9)
  int proteins_limit = 0;

  DayFood(this.date, this.foodList, this.calories_counter,
      this.carbs_counter,
      this.fat_counter, this.proteins_counter,
      this.calories_limit, this.carbs_limit,
      this.fat_limit, this.proteins_limit);
}