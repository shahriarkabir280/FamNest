import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'File  Viewer/AudioFile.dart';
import 'File  Viewer/ImageFile.dart';
import 'File  Viewer/VideoFile.dart';
import 'file_menu.dart'; // Import your FileMenu widget
import 'package:open_file/open_file.dart';

class RecentFilesList extends StatelessWidget {
  final List<Map<String, dynamic>> recentFiles;// Accept the recentFiles list


  const RecentFilesList({required this.recentFiles}); // Constructor to accept the list

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Ensures the list takes only the space it needs
      itemCount: recentFiles.length, // Use the length of recentFiles
      itemBuilder: (context, index) {
        final file = recentFiles[index]; // Access the current file
        String fileName = file['file_name'] ?? 'Untitled'; // Get the file name
        String fileUrl = file['cloudinary_url'];


        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text(fileName), // Use file name from the recentFiles list
            subtitle: null, // Remove description as requested
            trailing: FileMenu(fileName: fileName, fileUrl: fileUrl), // Use FileMenu here
            onTap: () async {
              // Handle file tap action to view the file
              await _viewFile(context, file);
            },
          ),
        );
      },
    );
  }

  Future<void> _viewFile(BuildContext context, Map<String, dynamic> file) async {
    final fileUrl = file['cloudinary_url'];
    final fileName = file['file_name'];
    final fileId = file['id'];
    final fileExtension = fileUrl.split('.').last.toLowerCase();
    print(fileUrl);
    print('FILE ID: $fileId');

    // Handling file type and navigation
    if (fileExtension == 'mp4' || fileExtension == 'mov' || fileExtension == 'avi') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoUrl: fileUrl)),
      );
    } else if (fileExtension == 'mp3' || fileExtension == 'wav' || fileExtension == 'ogg') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AudioPlayerScreen(audioUrl: fileUrl)),
      );
    } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png' || fileExtension == 'gif') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImageViewerScreen(imageUrl: fileUrl)),
      );
    } else {
      if (fileUrl != null && fileName != null) {
        // Attempt to download the file
        final downloadedFile = await downloadFile(fileUrl, fileName);

        // Open the file
        final result = await OpenFile.open(downloadedFile?.path);

        if (result.type != ResultType.done) {
          print("Failed to open file: ${downloadedFile?.path}. Error: ${result.message}");
        }
      } else {
        print("Invalid file information: $file");
      }
    }
  }

  Future<File?> downloadFile(String url, String name) async {
    print(url);
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration.zero,
        ),
      );

      if (response.data is List<int>) {
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data as List<int>);
        await raf.close();

        return file;
      } else {
        throw Exception("Response data is not a byte array");
      }
    } catch (e) {
      print("Download failed: $e");
      return null; // If the return type is Future<File?>
    }
  }



}
