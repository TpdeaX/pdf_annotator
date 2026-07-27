import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/annotation_provider.dart';
import 'canvas_page.dart';

class PdfViewerPage extends StatefulWidget {
  final PlatformFile file;
  const PdfViewerPage({super.key, required this.file});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final PdfViewerController _pdfController = PdfViewerController();
  bool _isDrawingMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Annotator'),
        actions: [
          IconButton(
            icon: Icon(
              _isDrawingMode ? Icons.edit : Icons.pan_tool,
              color: _isDrawingMode ? Colors.red : Colors.blue,
            ),
            tooltip: _isDrawingMode ? 'Modo Dibujo (Click para Navegar)' : 'Modo Navegación (Click para Dibujar)',
            onPressed: () {
              setState(() {
                _isDrawingMode = !_isDrawingMode;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () => _pdfController.zoomUp(),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () => _pdfController.zoomDown(),
          ),
        ],
      ),
      // Using pdfrx for rendering the PDF dynamically
      body: kIsWeb
          ? PdfViewer.data(
              widget.file.bytes!,
              sourceName: widget.file.name,
              controller: _pdfController,
              params: PdfViewerParams(
                viewerOverlayBuilder: (context, size, handleTap) {
                  return [
                    Consumer<AnnotationProvider>(
                      builder: (context, provider, child) {
                        return CanvasOverlay(
                          pdfController: _pdfController,
                          provider: provider,
                          isDrawingMode: _isDrawingMode,
                        );
                      },
                    ),
                  ];
                },
              ),
            )
          : PdfViewer.file(
              widget.file.path!,
              controller: _pdfController,
              params: PdfViewerParams(
                viewerOverlayBuilder: (context, size, handleTap) {
                  return [
                    Consumer<AnnotationProvider>(
                      builder: (context, provider, child) {
                        return CanvasOverlay(
                          pdfController: _pdfController,
                          provider: provider,
                          isDrawingMode: _isDrawingMode,
                        );
                      },
                    ),
                  ];
                },
              ),
            ),
    );
  }
}
