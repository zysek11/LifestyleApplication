import 'package:hive_flutter/hive_flutter.dart';
part 'CaloriesConst.g.dart';

@HiveType(typeId: 5)
class CaloriesConst extends HiveObject {

  @HiveField(0)
  int calories_const = 0;

  @HiveField(1)
  int carbs_const = 0;

  @HiveField(2)
  int fat_const = 0;

  @HiveField(3)
  int proteins_const = 0;

  CaloriesConst(this.calories_const, this.carbs_const,
      this.fat_const, this.proteins_const);
}