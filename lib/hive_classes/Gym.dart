import 'package:hive_flutter/hive_flutter.dart';
part 'Gym.g.dart';

@HiveType(typeId: 1)
class Gym extends HiveObject {
  @HiveField(0)
  String name = "";

  @HiveField(1)
  int series = 0;

  @HiveField(2)
  int repeatsOrTimer = 0;

  @HiveField(3)
  String breakTime = "";

  @HiveField(4)
  String description = "";

  Gym(this.name, this.series, this.repeatsOrTimer, this.breakTime, this.description);
}