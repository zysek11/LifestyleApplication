import 'package:hive/hive.dart';
part 'Note.g.dart';

@HiveType(typeId: 7)
class Note extends HiveObject {
  @HiveField(0)
  String title = "";

  @HiveField(1)
  String content = "";

  Note(
      this.title,
      this.content
      );
}