import 'package:hive_flutter/hive_flutter.dart';
part 'Gym.g.dart';

@HiveType(typeId: 6)
class Gym extends HiveObject {
  @HiveField(0)
  String name = "";

  @HiveField(1)
  String type = "";

  @HiveField(2)
  int series = 0;

  @HiveField(3)
  int repeats = 0;

  @HiveField(4)
  String seriesTime = "";

  @HiveField(5)
  String breakTime = "";

  @HiveField(6)
  String description = "";

  Gym(this.name, this.type, this.series, this.repeats, this.seriesTime, this.breakTime, this.description);
}