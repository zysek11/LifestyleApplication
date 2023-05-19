import 'package:hive_flutter/hive_flutter.dart';
part 'Stretching.g.dart';

@HiveType(typeId: 0)
class Stretching extends HiveObject {
  @HiveField(0)
  String name = "";

  @HiveField(1)
  int series = 0;

  @HiveField(2)
  int repeats = 0;

  @HiveField(3)
  String description = "";

  Stretching(this.name, this.series, this.repeats, this.description);
}