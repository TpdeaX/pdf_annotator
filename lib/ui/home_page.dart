import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:intl/intl.dart';
import 'pdf_viewer.dart';
import '../services/auth_service.dart';
import '../services/drive_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  DriveService? _driveService;
  List<drive.File> _files = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initDrive();
  }

  Future<void> _initDrive({bool interactive = false}) async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final client = await _authService.getAuthenticatedClient(interactive: interactive);
      if (client != null) {
        _driveService = DriveService(client);
        await _loadFiles();
      }
    } catch (e) {
      print('Error initializing drive: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadFiles() async {
    if (_driveService == null) return;
    setState(() => _isLoading = true);
    final files = await _driveService!.listPdfs();
    setState(() {
      _files = files;
      _isLoading = false;
    });
  }

  Future<void> _pickAndUploadFile() async {
    if (_driveService == null) {
      await _initDrive(interactive: true);
    }
    if (_driveService == null) return;

    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() => _isLoading = true);
      
      final fileBytes = result.files.single.bytes!;
      final fileName = result.files.single.name;
      
      final newFileId = await _driveService!.uploadPdf(fileName, fileBytes);
      
      setState(() => _isLoading = false);
      
      if (newFileId != null) {
        await _loadFiles();
        if (mounted) {
           _openCloudFile(newFileId, fileName);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al subir PDF')));
        }
      }
    }
  }

  Future<void> _openCloudFile(String fileId, String fileName) async {
    setState(() => _isLoading = true);
    final bytes = await _driveService!.downloadFile(fileId);
    setState(() => _isLoading = false);
    
    if (bytes != null && mounted) {
       final platformFile = PlatformFile(
         name: fileName,
         size: bytes.length,
         bytes: Uint8List.fromList(bytes),
       );
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => PdfViewerPage(file: platformFile),
         ),
       );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al descargar PDF')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus Archivos (Google Drive)'),
        actions: [
          if (_driveService != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadFiles,
            ),
          if (user != null)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Cerrar Sesión',
              onPressed: () async {
                await _authService.signOut();
                setState(() {
                  _driveService = null;
                  _files = [];
                });
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _driveService == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.account_circle, size: 80, color: Colors.blueAccent),
                      const SizedBox(height: 16),
                      const Text(
                        'Conéctate a Google Drive',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Inicia sesión para sincronizar tus carpetas y archivos PDF en la nube.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => _initDrive(interactive: true),
                        icon: const Icon(Icons.login),
                        label: const Text('Iniciar Sesión con Google'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              : _files.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.folder_open, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            'La carpeta "PDF Annotator" está vacía',
                            style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sube un PDF para comenzar a leer y anotar.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _pickAndUploadFile,
                            icon: const Icon(Icons.upload_file),
                            label: const Text('Subir mi primer PDF'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        final file = _files[index];
                        final date = file.modifiedTime != null
                            ? DateFormat.yMd().add_Hm().format(file.modifiedTime!.toLocal())
                            : 'Desconocido';
                        final modifier = file.lastModifyingUser?.displayName ?? 'Desconocido';
                        
                        return ListTile(
                          leading: const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 40),
                          title: Text(file.name ?? 'Sin nombre', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Modificado: $date\nPor: $modifier'),
                          isThreeLine: true,
                          onTap: () => _openCloudFile(file.id!, file.name ?? 'document.pdf'),
                        );
                      },
                    ),
      floatingActionButton: _driveService != null && _files.isNotEmpty && !_isLoading
          ? FloatingActionButton(
              onPressed: _pickAndUploadFile,
              child: const Icon(Icons.add),
              tooltip: 'Subir nuevo PDF',
            )
          : null,
    );
  }
}

