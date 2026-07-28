import 'package:flutter/material.dart';

enum AnnotationTool {
  pan,
  pen,
  highlighter,
  eraser,
  textNote,
}

class Stroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final bool isHighlighter;

  Stroke({
    required this.points,
    this.color = Colors.red,
    this.strokeWidth = 4.0,
    this.isHighlighter = false,
  });
}

class TextNote {
  final String id;
  final Offset position;
  String text;
  Color color;
  final DateTime createdAt;

  TextNote({
    required this.id,
    required this.position,
    required this.text,
    this.color = Colors.yellow,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class AnnotationProvider extends ChangeNotifier {
  AnnotationTool _currentTool = AnnotationTool.pan;
  Color _selectedColor = Colors.red;
  double _selectedStrokeWidth = 4.0;

  final Map<int, List<Stroke>> _pageStrokes = {};
  final Map<int, List<TextNote>> _pageNotes = {};

  AnnotationTool get currentTool => _currentTool;
  Color get selectedColor => _selectedColor;
  double get selectedStrokeWidth => _selectedStrokeWidth;

  void setTool(AnnotationTool tool) {
    _currentTool = tool;
    notifyListeners();
  }

  void setColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    _selectedStrokeWidth = width;
    notifyListeners();
  }

  List<Stroke> getStrokesForPage(int pageNumber) {
    return _pageStrokes[pageNumber] ?? [];
  }

  List<TextNote> getNotesForPage(int pageNumber) {
    return _pageNotes[pageNumber] ?? [];
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

  void addTextNote(int pageNumber, TextNote note) {
    _pageNotes.putIfAbsent(pageNumber, () => []).add(note);
    notifyListeners();
  }

  void updateTextNote(int pageNumber, String noteId, String newText) {
    final notes = _pageNotes[pageNumber];
    if (notes != null) {
      final idx = notes.indexWhere((n) => n.id == noteId);
      if (idx != -1) {
        notes[idx].text = newText;
        notifyListeners();
      }
    }
  }

  void deleteTextNote(int pageNumber, String noteId) {
    final notes = _pageNotes[pageNumber];
    if (notes != null) {
      notes.removeWhere((n) => n.id == noteId);
      notifyListeners();
    }
  }

  void eraseAt(int pageNumber, Offset touchPoint, {double threshold = 20.0}) {
    final strokes = _pageStrokes[pageNumber];
    if (strokes != null) {
      strokes.removeWhere((stroke) {
        return stroke.points.any((pt) => (pt - touchPoint).distance <= threshold);
      });
    }

    final notes = _pageNotes[pageNumber];
    if (notes != null) {
      notes.removeWhere((note) {
        return (note.position - touchPoint).distance <= threshold;
      });
    }

    notifyListeners();
  }

  void clearPage(int pageNumber) {
    _pageStrokes[pageNumber]?.clear();
    _pageNotes[pageNumber]?.clear();
    notifyListeners();
  }
}

