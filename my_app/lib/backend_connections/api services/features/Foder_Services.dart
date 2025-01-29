import 'dart:convert';
import 'package:http/http.dart' as http;

class FolderService {
  static const String baseUrl = 'https://famnest.onrender.com'; // Replace with your backend URL

  /// Create a folder
  static Future<Map<String, dynamic>> createFolder(
     String folderName,
     String categoryId,
    String? parentFolderId,
  ) async {
    final url = Uri.parse('$baseUrl/create-folder/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'folder_name': folderName,
        'category_id': categoryId,
        'parent_folder_id': parentFolderId,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create folder: ${response.body}');
    }
  }

  /// Get folders by category and parent folder
  static Future<List<Map<String, dynamic>>> getFolders(
     String categoryId,
    String? parentFolderId,
  ) async {
    final url = Uri.parse('$baseUrl/folders/$categoryId/?parent_folder_id=$parentFolderId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch folders: ${response.body}');
    }
  }

  static Future<void> renameFolder(String folderId, String newName) async {
    final response = await http.put(
      Uri.parse("$baseUrl/rename-folder/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "folder_id": folderId,
        "new_name": newName,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to rename folder: ${response.body}");
    }
  }


  static Future<void> deleteFolder(String folderId) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/delete-folder/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "folder_id": folderId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete folder: ${response.body}");
    }
  }



}
