import 'dart:convert';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

class DriveService {
  final http.Client _client;
  late final drive.DriveApi _api;

  DriveService(this._client) {
    _api = drive.DriveApi(_client);
  }

  Future<String?> uploadFile(String name, List<int> bytes, String mimeType, {List<String>? parents}) async {
    try {
      final file = drive.File()
        ..name = name
        ..parents = parents;
      
      final media = drive.Media(Stream.value(bytes), bytes.length);
      final result = await _api.files.create(file, uploadMedia: media);
      return result.id;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<List<int>?> downloadFile(String fileId) async {
    try {
      final media = await _api.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
      
      final bytes = <int>[];
      await for (final chunk in media.stream) {
        bytes.addAll(chunk);
      }
      return bytes;
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }

  Future<bool> updateFile(String fileId, List<int> bytes) async {
    try {
      final file = drive.File();
      final media = drive.Media(Stream.value(bytes), bytes.length);
      
      await _api.files.update(file, fileId, uploadMedia: media);
      return true;
    } catch (e) {
      print('Error updating file: $e');
      return false;
    }
  }

  Future<String?> uploadPdf(String name, List<int> pdfBytes) async {
    return uploadFile(name, pdfBytes, 'application/pdf');
  }

  Future<bool> updatePdf(String fileId, List<int> pdfBytes) async {
    return updateFile(fileId, pdfBytes);
  }

  Future<String?> uploadAnnotations(String name, Map<String, dynamic> annotations) async {
    final jsonString = jsonEncode(annotations);
    final bytes = utf8.encode(jsonString);
    // AppData folder is used to hide application data from the user's main drive view
    return uploadFile(name, bytes, 'application/json', parents: ['appDataFolder']);
  }

  Future<bool> updateAnnotations(String fileId, Map<String, dynamic> annotations) async {
    final jsonString = jsonEncode(annotations);
    final bytes = utf8.encode(jsonString);
    return updateFile(fileId, bytes);
  }

  Future<Map<String, dynamic>?> downloadAnnotations(String fileId) async {
    final bytes = await downloadFile(fileId);
    if (bytes != null) {
      final jsonString = utf8.decode(bytes);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }
}
