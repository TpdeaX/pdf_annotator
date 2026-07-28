import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  int _initialPage = 1;
  int _currentPage = 1;
  int _totalPages = 1;
  double _currentZoom = 1.0;
  bool _isLoadingLastPage = true;

  final List<Color> _presetColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.orange,
    Colors.purple,
    Colors.black,
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();
    _loadLastVisitedPage();
  }

  Future<void> _loadLastVisitedPage() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'pdf_last_page_${widget.file.name}';
    final savedPage = prefs.getInt(key) ?? 1;
    if (mounted) {
      setState(() {
        _initialPage = savedPage;
        _currentPage = savedPage;
        _isLoadingLastPage = false;
      });
    }
  }

  Future<void> _saveLastVisitedPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'pdf_last_page_${widget.file.name}';
    await prefs.setInt(key, page);
  }

  void _showPageJumpDialog() {
    final pageController = TextEditingController(text: '$_currentPage');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Ir a la Página'),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
              hintText: '1 - $_totalPages',
              labelText: 'Número de página',
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final page = int.tryParse(pageController.text.trim());
                if (page != null && page >= 1 && page <= _totalPages) {
                  _pdfController.goToPage(pageNumber: page);
                }
                Navigator.pop(context);
              },
              child: const Text('Ir'),
            ),
          ],
        );
      },
    );
  }

  void _showColorPicker(AnnotationProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seleccionar Color',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _presetColors.map((color) {
                  final isSelected = provider.selectedColor.value == color.value;
                  return GestureDetector(
                    onTap: () {
                      provider.setColor(color);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Theme.of(context).primaryColor, width: 3.5)
                            : Border.all(color: Colors.grey.shade300, width: 1.5),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: color.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _showStrokeWidthPicker(AnnotationProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setBottomSheetState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Grosor del Trazo',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${provider.selectedStrokeWidth.toInt()} px',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: provider.selectedStrokeWidth,
                    min: 1.0,
                    max: 24.0,
                    divisions: 23,
                    label: '${provider.selectedStrokeWidth.toInt()} px',
                    onChanged: (val) {
                      provider.setStrokeWidth(val);
                      setBottomSheetState(() {});
                    },
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 120,
                      height: provider.selectedStrokeWidth,
                      decoration: BoxDecoration(
                        color: provider.selectedColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showZoomPresets() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Opciones de Zoom',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.aspect_ratio),
                title: const Text('100% (Tamaño Normal)'),
                onTap: () {
                  _pdfController.zoomDown();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.zoom_in),
                title: const Text('150%'),
                onTap: () {
                  _pdfController.zoomUp();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.zoom_in_map),
                title: const Text('Aumentar Zoom'),
                onTap: () {
                  _pdfController.zoomUp();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingLastPage) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final provider = Provider.of<AnnotationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.file.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          // Jump to Page Badge
          InkWell(
            onTap: _showPageJumpDialog,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$_currentPage / $_totalPages',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Zoom Badge & Buttons
          IconButton(
            icon: const Icon(Icons.zoom_out, size: 20),
            tooltip: 'Reducir Zoom',
            onPressed: () => _pdfController.zoomDown(),
          ),
          InkWell(
            onTap: _showZoomPresets,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '${(_currentZoom * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in, size: 20),
            tooltip: 'Aumentar Zoom',
            onPressed: () => _pdfController.zoomUp(),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Stack(
        children: [
          // PDF Rendering Engine
          kIsWeb
              ? PdfViewer.data(
                  widget.file.bytes!,
                  sourceName: widget.file.name,
                  controller: _pdfController,
                  initialPageNumber: _initialPage,
                  params: PdfViewerParams(
                    onPageChanged: (page) {
                      if (page != null) {
                        setState(() {
                          _currentPage = page;
                        });
                        _saveLastVisitedPage(page);
                      }
                    },
                    onViewerReady: (document, controller) {
                      setState(() {
                        _totalPages = document.pages.length;
                      });
                    },
                    viewerOverlayBuilder: (context, size, handleTap) {
                      return [
                        CanvasOverlay(
                          pdfController: _pdfController,
                          provider: provider,
                        ),
                      ];
                    },
                  ),
                )
              : PdfViewer.file(
                  widget.file.path!,
                  controller: _pdfController,
                  initialPageNumber: _initialPage,
                  params: PdfViewerParams(
                    onPageChanged: (page) {
                      if (page != null) {
                        setState(() {
                          _currentPage = page;
                        });
                        _saveLastVisitedPage(page);
                      }
                    },
                    onViewerReady: (document, controller) {
                      setState(() {
                        _totalPages = document.pages.length;
                      });
                    },
                    viewerOverlayBuilder: (context, size, handleTap) {
                      return [
                        CanvasOverlay(
                          pdfController: _pdfController,
                          provider: provider,
                        ),
                      ];
                    },
                  ),
                ),

          // Floating Glassmorphic Toolbar at Bottom
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Pan Mode (Hand)
                    _buildToolButton(
                      context,
                      tool: AnnotationTool.pan,
                      icon: Icons.pan_tool_outlined,
                      activeIcon: Icons.pan_tool,
                      label: 'Navegar',
                      provider: provider,
                    ),
                    // Pen Mode
                    _buildToolButton(
                      context,
                      tool: AnnotationTool.pen,
                      icon: Icons.edit_outlined,
                      activeIcon: Icons.edit,
                      label: 'Lápiz',
                      provider: provider,
                    ),
                    // Highlighter Mode
                    _buildToolButton(
                      context,
                      tool: AnnotationTool.highlighter,
                      icon: Icons.border_color_outlined,
                      activeIcon: Icons.border_color,
                      label: 'Resaltador',
                      provider: provider,
                    ),
                    // Text Note Mode
                    _buildToolButton(
                      context,
                      tool: AnnotationTool.textNote,
                      icon: Icons.sticky_note_2_outlined,
                      activeIcon: Icons.sticky_note_2,
                      label: 'Nota',
                      provider: provider,
                    ),
                    // Eraser Mode
                    _buildToolButton(
                      context,
                      tool: AnnotationTool.eraser,
                      icon: Icons.auto_fix_normal_outlined,
                      activeIcon: Icons.auto_fix_normal,
                      label: 'Borrador',
                      provider: provider,
                    ),

                    const SizedBox(width: 8),
                    Container(height: 24, width: 1, color: Colors.grey.shade400),
                    const SizedBox(width: 8),

                    // Color Selector Badge
                    GestureDetector(
                      onTap: () => _showColorPicker(provider),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade400, width: 1.5),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: provider.selectedColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // Stroke Width Badge
                    GestureDetector(
                      onTap: () => _showStrokeWidthPicker(provider),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${provider.selectedStrokeWidth.toInt()}px',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),
                    // Clear Page Button
                    IconButton(
                      icon: const Icon(Icons.delete_sweep_outlined, color: Colors.redAccent, size: 22),
                      tooltip: 'Limpiar Página',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Limpiar anotaciones'),
                            content: const Text('¿Deseas borrar los trazos y notas de esta página?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                onPressed: () {
                                  provider.clearPage(_currentPage);
                                  Navigator.pop(ctx);
                                },
                                child: const Text('Borrar', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(
    BuildContext context, {
    required AnnotationTool tool,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required AnnotationProvider provider,
  }) {
    final isSelected = provider.currentTool == tool;
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: () => provider.setTool(tool),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? primaryColor : Colors.grey.shade700,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

