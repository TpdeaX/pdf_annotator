import 'package:isar/isar.dart';

part 'stroke.g.dart';

@collection
class Stroke {
  Id id = Isar.autoIncrement;
  
  @Index()
  String? documentDriveId;
  
  List<double>? pointsX;
  List<double>? pointsY;
  
  int? colorValue;
  double? strokeWidth;
  
  int? timestamp;
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentDriveId': documentDriveId,
      'pointsX': pointsX,
      'pointsY': pointsY,
      'colorValue': colorValue,
      'strokeWidth': strokeWidth,
      'timestamp': timestamp,
    };
  }

  static Stroke fromJson(Map<String, dynamic> json) {
    return Stroke()
      ..id = json['id']
      ..documentDriveId = json['documentDriveId']
      ..pointsX = (json['pointsX'] as List?)?.cast<double>()
      ..pointsY = (json['pointsY'] as List?)?.cast<double>()
      ..colorValue = json['colorValue']
      ..strokeWidth = json['strokeWidth']
      ..timestamp = json['timestamp'];
  }
}
