import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'pdf_viewer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true, // Needed for web
    );

    if (result != null && result.files.single != null) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerPage(file: result.files.single),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Annotator Home')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => _pickFile(context),
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('Abrir PDF'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
