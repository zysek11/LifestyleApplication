import 'package:hive_flutter/hive_flutter.dart';
part 'Gym.g.dart';

@HiveType(typeId: 1)
class Gym extends HiveObject {
  @HiveField(0)
  String name = "";

  @HiveField(1)
  int series = 0;

  @HiveField(2)
  int repeats = 0;

  @HiveField(3)
  String seriesTime = "";

  @HiveField(4)
  String breakTime = "";

  @HiveField(5)
  String description = "";

  Gym(this.name, this.series, this.repeats, this.seriesTime, this.breakTime, this.description);
}