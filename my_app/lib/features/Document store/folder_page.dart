import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import '../../Models/UserState.dart';
import '../../backend_connections/api services/features/File_Services.dart';
import '../../backend_connections/api services/features/Foder_Services.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'File  Viewer/AudioFile.dart';
import 'File  Viewer/ImageFile.dart';
import 'File  Viewer/VideoFile.dart';


class FolderPage extends StatefulWidget {
  final String folderName;
  final String folderId;
  final String categoryId;

  FolderPage({
    required this.folderName,
    required this.folderId,
    required this.categoryId,
  });

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  List<Map<String, dynamic>> subfolders = [];
  List<Map<String, dynamic>> files = [];

  bool selectMode = false;
  bool selectAll = false;

  List<bool> selectedFiles = [];
  bool isLoading = true;
  bool _isUploading = false; // For progress indicator
  bool showSelectAll = false;

  @override
  void initState() {
    super.initState();
    _fetchContent();
  }



  void _viewFile(Map<String, dynamic> file)async {
    final fileUrl = file['cloudinary_url'];
    final fileName = file['file_name'];
    final fileId =file['id'];
    final fileExtension = fileUrl.split('.').last.toLowerCase();
    print(fileUrl);
    print('FILE ID: $fileId');


    // Fetch the current group code from the UserState
    final groupCode = Provider.of<UserState>(context, listen: false).currentUser?.currentGroup?.groupCode;

    // If groupCode is null or empty, handle the error
    if (groupCode == null || groupCode.isEmpty) {
      print('Error: groupCode is null or empty');
      return;
    }

    // Add file to recent files (ensure categoryId is provided correctly)
    await FileService.addRecentFile(
      fileId: fileId,
      groupCode: groupCode, // Now non-null
      categoryId: widget.categoryId,
    );



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



  /// Add a new file
  void _addFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      try {
        final response = await FileService.uploadFile(
          file: file,
          categoryId: widget.categoryId,
          folderId: widget.folderId,
        );

        if (response == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("File uploaded successfully")),
          );
           await _fetchContent(); // Refresh content
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("File upload failed")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading file: $e")),
        );
      }
    }
  }

  //work perfectly
  Future<void> _fetchContent() async {
    setState(() {
      isLoading = true;
      selectedFiles = []; // Initialize as a dynamic list
    });

    try {
      // Fetch subfolders
      final fetchedSubfolders = await FolderService.getFolders(
        widget.categoryId,
        widget.folderId,
      );

      // Fetch files
      final fetchedFiles = await FileService.getFiles(widget.folderId);

      setState(() {
        subfolders = fetchedSubfolders.cast<Map<String, dynamic>>();
        files = fetchedFiles;
        selectedFiles = List<bool>.generate(fetchedFiles.length, (index) => false); // Dynamically resizable
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch content: $e")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }


  /// Toggle selection of a file
  void _toggleSelection(int index) {
    setState(() {
      selectedFiles[index] = !selectedFiles[index];
      showSelectAll = selectedFiles.contains(true);
    });
  }

  /// Select or deselect all files
  void _selectAll() {
    setState(() {
      bool allSelected = !selectedFiles.every((selected) => selected);
      selectedFiles = List.generate(files.length, (_) => allSelected);
      showSelectAll = allSelected;
    });
  }





  /// Add a new folder
  void _addFolder() async {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New Folder'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter folder name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              String folderName = controller.text.trim();
              if (folderName.isNotEmpty) {
                try {
                  final response = await FolderService.createFolder(
                    folderName,
                    widget.categoryId,
                    widget.folderId,
                  );
                  setState(() {
                    subfolders.add({
                      'id': response['folder_id'],
                      'folder_name': folderName,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Folder created successfully!')),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to create folder: $e')),
                  );
                }
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.create_new_folder,size: 40),
            onPressed: _addFolder,
            tooltip: 'Create New Folder',
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          // Subfolders Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Subfolders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          subfolders.isNotEmpty
              ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: subfolders.length,
            itemBuilder: (context, index) {
              final subfolder = subfolders[index];
              return ListTile(
                leading: Icon(Icons.folder, color: Colors.amber),
                title: Text(subfolder['folder_name']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'rename') {
                      _renameFolder(subfolder['id']);
                    } else if (value == 'delete') {
                      _deleteFolder(subfolder['id']);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'rename',
                      child: Text('Rename'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FolderPage(
                        folderName: subfolder['folder_name'],
                        folderId: subfolder['id'],
                        categoryId: widget.categoryId,
                      ),
                    ),
                  );
                },
              );
            },
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No subfolders available.',
              style: TextStyle(color: Colors.grey),
            ),
          ),

          // Files Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Files',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (files.isNotEmpty) // Show the "Select" button only if there are files
                  ElevatedButton(
                    onPressed: () {
                      if (!showSelectAll) {
                        // Enable select mode
                        setState(() {
                          showSelectAll = true;
                        });
                      } else if (selectedFiles.every((selected) => selected)) {
                        // Deselect all
                        setState(() {
                          selectedFiles = List<bool>.filled(files.length, false);
                        });
                      } else if (selectedFiles.any((selected) => selected)) {
                        // Cancel selection
                        setState(() {
                          showSelectAll = false;
                          selectedFiles = List<bool>.filled(files.length, false);
                        });
                      } else {
                        // Select all files
                        setState(() {
                          selectedFiles = List<bool>.filled(files.length, true);
                        });
                      }
                    },
                    child: Text(
                      !showSelectAll
                          ? 'Select'
                          : selectedFiles.every((selected) => selected)
                          ? 'Deselect All'
                          : selectedFiles.any((selected) => selected)
                          ? 'Cancel'
                          : 'Select All',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                  ),
              ],
            ),
          ),
          files.isNotEmpty
              ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: files.length,
            itemBuilder: (context, index) {
              final file = files[index];
              return ListTile(
                leading: Icon(Icons.insert_drive_file, color: Colors.blue),
                title: Text(file['file_name']),
                trailing: showSelectAll
                    ? Checkbox(
                  value: selectedFiles[index],
                  onChanged: (bool? value) {
                    _toggleSelection(index);
                  },
                  activeColor: Colors.teal,
                )
                    : null,
                onTap: () => !showSelectAll ? _viewFile(file) : null,
                onLongPress: () {
                  setState(() {
                    showSelectAll = true;
                    selectedFiles[index] = true;
                  });
                },
              );
            },
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No files available.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFile,
        child: Icon(Icons.add,color: Colors.white),
        tooltip: 'Add Files',
        backgroundColor: Colors.teal,
      ),
      bottomNavigationBar: selectedFiles.any((selected) => selected)
          ? BottomAppBar(
        color: Colors.white, // Set to white for consistency with BottomNavigationBar
        elevation: 10, // Shadow effect for raised look
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Share Button with styling and interactions
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.teal.shade400, // Selected color (active state)
              ),
              onPressed: _shareFiles, // Function to handle file sharing
              splashColor: Colors.teal.shade200, // Splash effect for interaction
              tooltip: "Share Files", // Tooltip for better UX
            ),

            // Download Button with styling and interactions
            IconButton(
              icon: Icon(
                Icons.download,
                color: Colors.grey.shade600, // Unselected color (inactive state)
              ),
              onPressed: () => openDownloadedFile(), // Pass the function reference
              splashColor: Colors.teal.shade200,
              tooltip: "Download Files",
            ),

            // Delete Button with styling and interactions
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.grey.shade600,
              ),
              onPressed: _deleteFiles, // Function to handle file deletion
              splashColor: Colors.teal.shade200,
              tooltip: "Delete Files",
            ),

            // Rename Button, only visible when one file is selected
            if (selectedFiles.where((selected) => selected).length == 1)
              IconButton(
                icon: Icon(
                  Icons.drive_file_rename_outline,
                  color: Colors.grey.shade600,
                ),
                onPressed: _renameFile, // Function to handle renaming files
                splashColor: Colors.teal.shade200,
                tooltip: "Rename File",
              ),

          ],
        ),
      )

          : null,
    );
  }




  void _shareFiles() async {
    List<Map<String, dynamic>> selectedFileObjects = [];

    for (int i = 0; i < selectedFiles.length; i++) {
      if (selectedFiles[i]) {
        selectedFileObjects.add(files[i]);
      }
    }

    if (selectedFileObjects.isNotEmpty) {
      // Collect URLs for sharing
      List fileUrls = selectedFileObjects.map((file) => file['cloudinary_url']).toList();
      print(fileUrls);
      try {
        // Sharing files
        await Share.share(
          fileUrls.join('\n'), // Join URLs for sharing
          subject: 'Check out these files!',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Files shared successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing files: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No files selected to share')),
      );
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


  Future<void> openDownloadedFile() async {
    // Collect selected files
    List<Map<String, dynamic>> selectedFileObjects = [];
    for (int i = 0; i < selectedFiles.length; i++) {
      if (selectedFiles[i]) {
        selectedFileObjects.add(files[i]);
      }
    }

    if (selectedFileObjects.isEmpty) {
      print("No files selected to open.");
      return;
    }

    List<String> successfullyDownloadedFiles = [];

    try {
      for (var file in selectedFileObjects) {
        final fileUrl = file['cloudinary_url'];
        final fileName = file['file_name'];

        if (fileUrl != null && fileName != null) {
          // Attempt to download the file
          final downloadedFile = await downloadFile(fileUrl, fileName);

          if (downloadedFile == null) {
            print("Failed to download file: $fileName");
            continue; // Continue with the next file
          }

          // Add to success list
          successfullyDownloadedFiles.add(fileName);

          print('Downloaded and saved to path: ${downloadedFile.path}');

          // Open the file
          final result = await OpenFile.open(downloadedFile.path);

          if (result.type != ResultType.done) {
            print("Failed to open file: ${downloadedFile.path}. Error: ${result.message}");
          }
        } else {
          print("Invalid file information: $file");
        }
      }

      // Show a success message if files were downloaded
      if (successfullyDownloadedFiles.isNotEmpty) {
        print("Successfully downloaded files:");
        for (var fileName in successfullyDownloadedFiles) {
          print("- $fileName");
        }
      } else {
        print("No files were successfully downloaded.");
      }
    } catch (e) {
      print("An error occurred while processing files: $e");
    }
  }

  void _deleteFiles() async {
    // Collect selected files
    List<Map<String, dynamic>> selectedFileObjects = [];
    for (int i = 0; i < selectedFiles.length; i++) {
      if (selectedFiles[i]) {
        selectedFileObjects.add(files[i]);
      }
    }

    if (selectedFileObjects.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No files selected to delete")),
      );
      return;
    }

    List<String> successfullyDeletedFiles = [];

    try {
      for (var file in selectedFileObjects) {
        final fileId = file['id'];
        final fileName = file['file_name'];

        if (fileId != null && fileName != null) {
          // Attempt to delete the file
          final result = await FileService.deleteFile(fileId);

          if (result == "success") {
            successfullyDeletedFiles.add(fileName);
            print("Successfully deleted: $fileName");
          } else {
            print("Failed to delete file: $fileName");
          }
        } else {
          print("Invalid file information: $file");
        }
      }

      // Show a success message if any files were deleted
      if (successfullyDeletedFiles.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Successfully deleted files")),
        );
        // Refresh the file list after deletion
        await _fetchContent();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No files were deleted")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting files: $e")),
      );
    }
  }


  void _renameFile() async {
    // Collect selected files
    List<Map<String, dynamic>> selectedFileObjects = [];

    for (int i = 0; i < selectedFiles.length; i++) {
      if (selectedFiles[i]) {
        selectedFileObjects.add(files[i]);
      }
    }

    if (selectedFileObjects.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No files selected to rename')),
      );
      return;
    }

    // Ensure that only one file is selected for renaming
    if (selectedFileObjects.length > 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select only one file to rename')),
      );
      return;
    }

    // Get the selected file
    var file = selectedFileObjects.first;
    String currentFileName = file['file_name'];

    // Show dialog to input new file name
    TextEditingController nameController = TextEditingController(text: currentFileName);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rename File'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Enter new file name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newFileName = nameController.text.trim();
                if (newFileName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('File name cannot be empty')),
                  );
                  return;
                }

                // Call the backend to rename the file
                bool success = await FileService.renameFile(
                  fileId: file['id'],
                  newFileName: newFileName,
                );

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('File renamed successfully')),
                  );
                  await _fetchContent(); // Refresh content
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to rename file')),
                  );
                }

                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Rename'),
            ),
          ],
        );
      },
    );
  }





  Future<void> _renameFolder(String folderId) async {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rename Folder'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new folder name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              String newName = controller.text.trim();
              if (newName.isNotEmpty) {
                try {
                  await FolderService.renameFolder(folderId, newName);
                  setState(() {
                    subfolders = subfolders.map((folder) {
                      if (folder['id'] == folderId) {
                        folder['folder_name'] = newName;
                      }
                      return folder;
                    }).toList();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Folder renamed successfully!')),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to rename folder: $e')),
                  );
                }
              }
            },
            child: Text('Rename'),
          ),
        ],
      ),
    );
  }


  Future<void> _deleteFolder(String folderId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Folder'),
        content: Text('Are you sure you want to delete this folder?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await FolderService.deleteFolder(folderId);
                setState(() {
                  subfolders.removeWhere((folder) => folder['id'] == folderId);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Folder deleted successfully!')),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete folder: $e')),
                );
              }
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

}


