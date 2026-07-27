import 'dart:convert';
import 'package:isar/isar.dart';
import '../models/stroke.dart';
import '../models/document.dart';

// Stub for Google Drive API interaction
abstract class DriveSyncApi {
  Future<String?> downloadAppData(String fileId);
  Future<void> uploadAppData(String fileId, String content);
}

class SyncEngine {
  final Isar isar;
  final DriveSyncApi driveApi;

  SyncEngine({required this.isar, required this.driveApi});

  Future<void> syncDocument(String driveId, Function() onRepaint) async {
    // 1) Pull remote JSON annotation file from Google Drive's AppData
    final remoteJsonString = await driveApi.downloadAppData(driveId);
    
    List<Stroke> remoteStrokes = [];
    if (remoteJsonString != null && remoteJsonString.isNotEmpty) {
      final List<dynamic> decoded = jsonDecode(remoteJsonString);
      remoteStrokes = decoded.map((e) => Stroke.fromJson(e as Map<String, dynamic>)).toList();
    }
    
    // 2) Compare with local Isar database strokes
    final localStrokes = await isar.strokes.filter().documentDriveIdEqualTo(driveId).findAll();
    
    // 3) Merge the arrays (conflict resolution based on timestamp)
    Map<int, Stroke> mergedMap = {};
    
    // Add remote strokes first
    for (var s in remoteStrokes) {
      if (s.timestamp != null) {
        mergedMap[s.timestamp!] = s;
      }
    }
    
    // Add local strokes, resolving conflicts (preferring local if timestamp matches, or keeping unique timestamps)
    for (var s in localStrokes) {
      if (s.timestamp != null) {
        // If a stroke exists locally with the same timestamp, it could be a conflict.
        // We'll overwrite or add the local stroke in this conflict resolution strategy.
        mergedMap[s.timestamp!] = s;
      }
    }
    
    final mergedStrokes = mergedMap.values.toList();
    // Sort by timestamp to maintain drawing order
    mergedStrokes.sort((a, b) => (a.timestamp ?? 0).compareTo(b.timestamp ?? 0));
    
    // Save merged result back to local database
    await isar.writeTxn(() async {
      await isar.strokes.filter().documentDriveIdEqualTo(driveId).deleteAll();
      await isar.strokes.putAll(mergedStrokes);
    });
    
    // 4) Push the merged JSON back to Drive
    final mergedJsonString = jsonEncode(mergedStrokes.map((s) => s.toJson()).toList());
    await driveApi.uploadAppData(driveId, mergedJsonString);
    
    // 5) Trigger a UI repaint
    onRepaint();
  }
}
