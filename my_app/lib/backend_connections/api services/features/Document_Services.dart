import 'package:http/http.dart' as http;
import 'dart:convert';

class DocumentServices {
  static const String baseUrl = "https://famnest.onrender.com";


  // Method to create a category
  static Future<Map<String, dynamic>> createCategory(String groupCode, String categoryName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categories/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "group_code": groupCode,
        "category_name": categoryName,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to create category: ${response.body}");
    }
  }

  // Method to fetch categories
  static Future<List<Map<String, dynamic>>> getCategories(String groupCode) async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories/?group_code=$groupCode'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null) {
        return List<Map<String, dynamic>>.from(data);
      }
    } else {
      throw Exception("Failed to fetch categories: ${response.body}");
    }

    return [];
  }
  // Rename category
  Future<void> renameCategory(String categoryId, String groupCode, String newName) async {
    final response = await http.put(
      Uri.parse('$baseUrl/categories/$categoryId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"group_code": groupCode, "new_name": newName}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to rename category: ${response.body}");
    }
  }

  // Delete category
  Future<void> deleteCategory(String categoryId, String groupCode) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/categories/$categoryId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"group_code": groupCode}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete category: ${response.body}");
    }
  }


// Create Folder
  static Future<void> createFolder(String folderName, String categoryId, {String? parentFolderId}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/folders/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "folder_name": folderName,
        "category_id": categoryId,
        "parent_folder": parentFolderId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to create folder: ${response.body}");
    }
  }




  // Delete Folder
  static Future<void> deleteFolder(String folderId) async {
    final response = await http.delete(Uri.parse("$baseUrl/folders/$folderId"));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete folder: ${response.body}");
    }
  }


  // Rename Folder
  static Future<void> renameFolder(String folderId, String newName) async {
    final response = await http.put(
      Uri.parse("$baseUrl/folders/$folderId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"new_name": newName}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to rename folder: ${response.body}");
    }
  }


  // Get Folders
  static Future<List<dynamic>> getFolders(String categoryId, {String? parentFolderId}) async {
    final response = await http.get(
      Uri.parse("$baseUrl/folders/$categoryId?parent_folder=${parentFolderId ?? ''}"),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to fetch folders: ${response.body}");
    }
  }




}