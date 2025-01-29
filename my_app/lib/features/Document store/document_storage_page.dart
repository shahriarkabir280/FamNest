import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/UserState.dart';
import '../../backend_connections/api services/features/Document_Services.dart';
import 'category_page.dart';

class DocumentStoragePage extends StatefulWidget {
  @override
  _DocumentStoragePageState createState() => _DocumentStoragePageState();
}

class _DocumentStoragePageState extends State<DocumentStoragePage> {
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;

  // Colors for categories
  final List<Color> categoryColors = [
    Colors.teal.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.purple.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
  ];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }
  /// Fetch categories from backend
  Future<void> _fetchCategories() async {
    final userState = Provider.of<UserState>(context, listen: false);
    final currentGroup = userState.currentUser?.currentGroup;

    if (currentGroup != null) {
      try {
        final fetchedCategories = await DocumentServices.getCategories(currentGroup.groupCode);
        setState(() {
          categories = fetchedCategories;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to fetch categories: $e")),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Create a new category
  Future<void> _addCategory(String newCategory) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final currentGroup = userState.currentUser?.currentGroup;

    if (currentGroup != null) {
      try {
        final response = await DocumentServices.createCategory(currentGroup.groupCode, newCategory);
        setState(() {
          categories.add({
          "category_name": newCategory,
          "is_preset": false,
          "id": response["category_id"],
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Category added successfully")),
            );
            } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to add category: $e")),
            );
            }
        }
        }



  // Rename a category
  Future<void> _renameCategory(String newName, int index) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final currentGroup = userState.currentUser?.currentGroup;

    if (currentGroup != null) {
      try {
        await DocumentServices().renameCategory(
          categories[index]["id"],
          currentGroup.groupCode,
          newName,
        );
        setState(() {
          categories[index]["category_name"] = newName;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category renamed successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to rename category: $e")),
        );
      }
    }
  }

// Delete a category
  Future<void> _deleteCategory(int index) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final currentGroup = userState.currentUser?.currentGroup;

    if (currentGroup != null) {
      try {
        await DocumentServices().deleteCategory(
          categories[index]["id"],
          currentGroup.groupCode,
        );
        setState(() {
          categories.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category deleted successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete category: $e")),
        );
      }
    }
  }



  // Show dialog for creating a new category
  void _showAddCategoryDialog(BuildContext context) {
    final TextEditingController _categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New Category'),
          content: TextField(
            controller: _categoryController,
            decoration: InputDecoration(hintText: 'Enter category name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newCategory = _categoryController.text.trim();
                if (newCategory.isNotEmpty) {
                  _addCategory(newCategory);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog to rename category
  void _showRenameDialog(int index) {
    final TextEditingController _renameController = TextEditingController();
    _renameController.text = categories[index]["category_name"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Rename Category"),
          content: TextField(
            controller: _renameController,
            decoration: InputDecoration(hintText: "Enter new category name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final newName = _renameController.text.trim();
                if (newName.isNotEmpty) {
                  _renameCategory(newName, index);
                  Navigator.pop(context);
                }
              },
              child: Text("Rename"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Categories"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : categories.isEmpty
          ? Center(
        child: Text(
          "No categories available.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final color = categoryColors[index % categoryColors.length];
            return _buildCategoryCard(category, color, index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, Color color, int index) {
    final bool isPreset = category["is_preset"];
    final String categoryName = category["category_name"];
    final String categoryId = category["id"]; // Assuming 'id' is the unique identifier.

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to CategoryPage with parameters
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryPage(
                categoryId: categoryId,
                categoryName: categoryName,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    isPreset ? Icons.folder : Icons.folder_open,
                    size: 40,
                    color: Colors.teal.shade700,
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == "Rename") {
                        _showRenameDialog(index);
                      } else if (value == "Delete") {
                        _deleteCategory(index);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: "Rename", child: Text("Rename")),
                      PopupMenuItem(value: "Delete", child: Text("Delete")),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
