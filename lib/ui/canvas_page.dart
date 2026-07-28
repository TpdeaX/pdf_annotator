import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import '../providers/annotation_provider.dart';

class CanvasOverlay extends StatefulWidget {
  final PdfViewerController pdfController;
  final AnnotationProvider provider;

  const CanvasOverlay({
    super.key,
    required this.pdfController,
    required this.provider,
  });

  @override
  State<CanvasOverlay> createState() => _CanvasOverlayState();
}

class _CanvasOverlayState extends State<CanvasOverlay> {
  int get _currentPage => widget.pdfController.pageNumber ?? 1;

  void _showAddNoteDialog(Offset position) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.sticky_note_2, color: Colors.amber),
              SizedBox(width: 8),
              Text('Nueva Nota de Texto'),
            ],
          ),
          content: TextField(
            controller: textController,
            maxLines: 3,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Escribe tu anotación aquí...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = textController.text.trim();
                if (text.isNotEmpty) {
                  final newNote = TextNote(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    position: position,
                    text: text,
                    color: widget.provider.selectedColor == Colors.red
                        ? Colors.amber
                        : widget.provider.selectedColor,
                  );
                  widget.provider.addTextNote(_currentPage, newNote);
                }
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteDialog(TextNote note) {
    final textController = TextEditingController(text: note.text);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.edit_note, color: Colors.amber),
              SizedBox(width: 8),
              Text('Editar Nota'),
            ],
          ),
          content: TextField(
            controller: textController,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Eliminar nota',
              onPressed: () {
                widget.provider.deleteTextNote(_currentPage, note.id);
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = textController.text.trim();
                if (text.isNotEmpty) {
                  widget.provider.updateTextNote(_currentPage, note.id, text);
                }
                Navigator.pop(context);
              },
              child: const Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tool = widget.provider.currentTool;
    final isPan = tool == AnnotationTool.pan;
    final notes = widget.provider.getNotesForPage(_currentPage);

    return IgnorePointer(
      ignoring: isPan,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapUp: (details) {
          if (tool == AnnotationTool.textNote) {
            _showAddNoteDialog(details.localPosition);
          } else if (tool == AnnotationTool.eraser) {
            widget.provider.eraseAt(_currentPage, details.localPosition);
          }
        },
        onPanStart: (details) {
          if (tool == AnnotationTool.pen) {
            widget.provider.addStroke(
              _currentPage,
              Stroke(
                points: [details.localPosition],
                color: widget.provider.selectedColor,
                strokeWidth: widget.provider.selectedStrokeWidth,
              ),
            );
          } else if (tool == AnnotationTool.highlighter) {
            widget.provider.addStroke(
              _currentPage,
              Stroke(
                points: [details.localPosition],
                color: widget.provider.selectedColor.withOpacity(0.4),
                strokeWidth: widget.provider.selectedStrokeWidth * 3.5,
                isHighlighter: true,
              ),
            );
          } else if (tool == AnnotationTool.eraser) {
            widget.provider.eraseAt(_currentPage, details.localPosition);
          }
        },
        onPanUpdate: (details) {
          if (tool == AnnotationTool.pen || tool == AnnotationTool.highlighter) {
            widget.provider.updateLastStroke(
              _currentPage,
              details.localPosition,
            );
          } else if (tool == AnnotationTool.eraser) {
            widget.provider.eraseAt(_currentPage, details.localPosition);
          }
        },
        child: Stack(
          children: [
            CustomPaint(
              painter: _AnnotationPainter(
                strokes: widget.provider.getStrokesForPage(_currentPage),
              ),
              size: Size.infinite,
            ),
            // Text Note Badges
            for (final note in notes)
              Positioned(
                left: note.position.dx - 14,
                top: note.position.dy - 14,
                child: GestureDetector(
                  onTap: () => _showEditNoteDialog(note),
                  child: Tooltip(
                    message: note.text,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: note.color.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.sticky_note_2,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
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

      if (stroke.isHighlighter) {
        paint.blendMode = BlendMode.srcOver;
      }

      final path = Path();
      path.moveTo(stroke.points.first.dx, stroke.points.first.dy);

      for (int i = 1; i < stroke.points.length; i++) {
        path.lineTo(stroke.points[i].dx, stroke.points[i].dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AnnotationPainter oldDelegate) => true;
}

