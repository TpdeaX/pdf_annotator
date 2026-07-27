import 'package:isar/isar.dart';

// Note: Run `dart run build_runner build` to generate the `stroke_entity.g.dart` file.
part 'stroke_entity.g.dart';

@collection
class StrokeEntity {
  Id id = Isar.autoIncrement;

  late int pageNumber;
  
  // Isar doesn't natively support storing Offset, so we split it into X and Y coordinate lists.
  late List<double> pointsX;
  late List<double> pointsY;
  
  late int colorValue;
  late double strokeWidth;
}
