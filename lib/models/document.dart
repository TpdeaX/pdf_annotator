import 'package:isar/isar.dart';

part 'document.g.dart';

@collection
class Document {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? driveId;
  
  String? name;
}
