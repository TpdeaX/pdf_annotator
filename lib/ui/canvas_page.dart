import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import '../providers/annotation_provider.dart';

class CanvasOverlay extends StatefulWidget {
  final PdfViewerController pdfController;
  final AnnotationProvider provider;
  final bool isDrawingMode;

  const CanvasOverlay({
    super.key,
    required this.pdfController,
    required this.provider,
    this.isDrawingMode = true,
  });

  @override
  State<CanvasOverlay> createState() => _CanvasOverlayState();
}

class _CanvasOverlayState extends State<CanvasOverlay> {
  int get _currentPage => widget.pdfController.pageNumber ?? 1;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isDrawingMode,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          widget.provider.addStroke(
            _currentPage,
            Stroke(points: [details.localPosition]),
          );
        },
        onPanUpdate: (details) {
          widget.provider.updateLastStroke(
            _currentPage,
            details.localPosition,
          );
        },
        child: CustomPaint(
          painter: _AnnotationPainter(
            strokes: widget.provider.getStrokesForPage(_currentPage),
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _AnnotationPainter extends CustomPainter {
  final List<Stroke> strokes;

  _AnnotationPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      if (stroke.points.isEmpty) continue;

      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final path = Path();
      path.moveTo(stroke.points.first.dx, stroke.points.first.dy);

      for (int i = 1; i < stroke.points.length; i++) {
        path.lineTo(stroke.points[i].dx, stroke.points[i].dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AnnotationPainter oldDelegate) => true; // Optimization needed for production
}
