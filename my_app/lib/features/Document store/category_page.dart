import 'package:flutter/material.dart';
import 'package:my_app/backend_connections/api%20services/features/File_Services.dart';
import 'package:my_app/features/Document%20store/recent_files_list.dart';
import 'package:provider/provider.dart';
import '../../Models/UserState.dart';
import 'folder_page.dart';
import '../../backend_connections/api services/features/Document_Services.dart';

class CategoryPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  CategoryPage({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, dynamic>> folders = [];
  List<Map<String, dynamic>> recentFiles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFolders();
    _fetchRecentFiles();
  }

  /// Fetch folders from the backend
  Future<void> _fetchFolders() async {
    try {
      final fetchedFolders = await DocumentServices.getFolders(widget.categoryId);
      setState(() {
        folders = fetchedFolders.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch folders: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  /// Fetch recent files for the current category
  Future<void> _fetchRecentFiles() async {
    try {
      // Get the current user's group code from UserState
      final userState = Provider.of<UserState>(context, listen: false);
      final currentGroupCode = userState.currentUser?.currentGroup?.groupCode;

      if (currentGroupCode == null) {
        // Handle the case where the group code is not available
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Current group code is not set")),
        );
        return;
      }

      // Fetch recent files from the backend using the current group code and category ID
      final fetchedRecentFiles = await FileService.getRecentFiles(
        groupCode: currentGroupCode,
        categoryId: widget
            .categoryId, // Assuming you have the categoryId passed in as a widget property
      );

      // Log the group code (optional for debugging)
      print(currentGroupCode);

      setState(() {
        recentFiles =
            fetchedRecentFiles; // Assuming 'recentFiles' is a state variable to hold the fetched files
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch recent files: $e")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Folders",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folder = folders[index];
                  return _buildFolderCard(
                    context,
                    folderId: folder["id"],
                    folderName: folder["folder_name"],
                    icon: Icons.folder,
                    color: Colors.teal,
                  );
                },
              ),
              SizedBox(height: 20), // Add spacing before the "Recent Files" section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Recent Files",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              RecentFilesList(recentFiles: recentFiles), // Pass the recentFiles list
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a folder card widget
  Widget _buildFolderCard(
      BuildContext context, {
        required String folderId,
        required String folderName,
        required IconData icon,
        required Color color,
      }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FolderPage(
              folderName: folderName,
              folderId: folderId,
              categoryId: widget.categoryId,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: color),
              SizedBox(height: 8),
              Text(
                folderName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
