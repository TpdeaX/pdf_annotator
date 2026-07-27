import 'package:flutter/material.dart';

class Stroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  Stroke({
    required this.points,
    this.color = Colors.red,
    this.strokeWidth = 3.0,
  });
}

class AnnotationProvider extends ChangeNotifier {
  // Maps a PDF page number to its corresponding strokes
  final Map<int, List<Stroke>> _pageStrokes = {};

  List<Stroke> getStrokesForPage(int pageNumber) {
    return _pageStrokes[pageNumber] ?? [];
  }

  void addStroke(int pageNumber, Stroke stroke) {
    _pageStrokes.putIfAbsent(pageNumber, () => []).add(stroke);
    notifyListeners();
  }

  void updateLastStroke(int pageNumber, Offset point) {
    final strokes = _pageStrokes[pageNumber];
    if (strokes != null && strokes.isNotEmpty) {
      strokes.last.points.add(point);
      notifyListeners();
    }
  }

  // TODO: Add methods to persist/load strokes to/from Isar database
}
