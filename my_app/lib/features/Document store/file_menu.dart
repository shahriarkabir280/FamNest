import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class FileMenu extends StatelessWidget {
  final String fileName;
  final String fileUrl;

  FileMenu({
    required this.fileName,
    required this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'Share') {
          _shareFile(context, fileUrl);
        } else if (value == 'Download') {
          _openDownloadedFile(fileUrl, fileName);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Download', child: Text('Download')),
        PopupMenuItem(value: 'Share', child: Text('Share')),
      ],
    );
  }

  void _shareFile(context, String fileUrl) async {
    try {
      await Share.share(
        fileUrl,
        subject: 'Check out this file!',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File shared successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing file: $e')),
      );
    }
  }

  Future<File?> downloadFile(String url, String name) async {
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
      return null;
    }
  }

  Future<void> _openDownloadedFile(String fileUrl, String fileName) async {
    if (fileUrl.isEmpty || fileName.isEmpty) {
      print("Invalid file information.");
      return;
    }

    try {
      final downloadedFile = await downloadFile(fileUrl, fileName);
      if (downloadedFile == null) {
        print("Failed to download file: $fileName");
        return;
      }

      print('Downloaded and saved to path: ${downloadedFile.path}');
      final result = await OpenFile.open(downloadedFile.path);
      if (result.type != ResultType.done) {
        print("Failed to open file: ${downloadedFile.path}. Error: ${result.message}");
      } else {
        print("File opened successfully.");
      }
    } catch (e) {
      print("An error occurred while processing the file: $e");
    }
  }
}
