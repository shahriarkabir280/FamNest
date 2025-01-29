import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FileService {
  static const String baseUrl = 'https://famnest.onrender.com'; // Replace with your backend URL

  /// Upload a file
  static Future<String> uploadFile({
    required File file,
    required String categoryId,
    required String folderId,
  }) async {
    final url = Uri.parse('$baseUrl/upload-file/');
    var request = http.MultipartRequest('POST', url);

    request.fields['category_id'] = categoryId;
    request.fields['folder_id'] = folderId;
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: file.path.split('/').last,
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      return "success";
    } else {
      return "failure";
    }
  }

  /// Fetch files by folder ID
  static Future<List<Map<String, dynamic>>> getFiles(String folderId) async {
    final url = Uri.parse('$baseUrl/files/$folderId/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch files: ${response.body}');
    }
  }

  // Delete a file by its ID
  static Future<String> deleteFile(String fileId) async {
    final url = Uri.parse('$baseUrl/delete-file/');
    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"file_id": fileId}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody["success"] == true) {
        return "success";
      } else {
        return "failure";
      }
    } else {
      throw Exception('Failed to delete file: ${response.body}');
    }
  }



  /// Rename a single file
  static Future<bool> renameFile({
    required String fileId,
    required String newFileName,
  }) async {
    final url = Uri.parse('$baseUrl/rename-file/');
    final response = await http.put(
      url,
      body: json.encode({
        'file_id': fileId,
        'new_file_name': newFileName,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }





  static Future<void> addRecentFile({
    required String fileId,
    required String groupCode,
    required String categoryId,
  }) async {
    final url = Uri.parse(
      '$baseUrl/add-recent-file/?group_code=$groupCode&category_id=$categoryId&file_id=$fileId',
    );

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("File added to recent files.");
      } else {
        // Print the response body for debugging
        print('Failed to add file: ${response.body}');
        throw Exception('Failed to add file to recent files');
      }
    } catch (e) {
      print('Error occurred: $e');
      rethrow;
    }
  }



  static Future<List<Map<String, dynamic>>> getRecentFiles({
    required String groupCode,
    required String categoryId,
  }) async {
    final url = Uri.parse('$baseUrl/recent-files/$groupCode/$categoryId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success']) {
        final recentFiles = data['recent_files'] as List;

        // Ensure that you include cloudinary_url in the returned files data
        return List<Map<String, dynamic>>.from(recentFiles.map((file) {
          return {
            'id': file['id'],
            'file_name': file['file_name'],
            'file_id': file['file_id'],
            'file_type': file['file_type'],
            'cloudinary_url': file['cloudinary_url'],  // Include cloudinary_url
            'last_accessed': file['last_accessed'],
          };
        }));
      } else {
        print("No recent files found");
        return [];
      }
    } else {
      print('Failed to fetch recent files: ${response.body}');
      throw Exception('Failed to fetch recent files');
    }
  }

  /// Delete a recent file by its ID
  static Future<String> deleteRecentFile({
    required String groupCode,
    required String categoryId,
    required String fileId,
  }) async {
    final url = Uri.parse('$baseUrl/delete-recent-file/$groupCode/$categoryId/$fileId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        return "success";
      } else {
        return "failure";
      }
    } else {
      throw Exception('Failed to delete recent file: ${response.body}');
    }
  }







}
