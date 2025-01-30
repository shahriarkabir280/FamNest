// // import 'package:flutter/material.dart';
// // import 'package:video_player/video_player.dart';
// // import 'package:flutter_downloader/flutter_downloader.dart'; // Retained import for downloading functionality
// // import 'package:share_plus/share_plus.dart'; // Import the share_plus package
// //
// // import '../../gradient_color.dart';
// //
// // class VideoCategory extends StatefulWidget {
// //   final List<Map<String, dynamic>> items;
// //   final String searchQuery;
// //   final Function(String, int) onRename;
// //   final Function(String, int) onDelete;
// //   final TextEditingController searchController;
// //
// //   VideoCategory({
// //     required this.items,
// //     required this.searchQuery,
// //     required this.onRename,
// //     required this.onDelete,
// //     required this.searchController,
// //   });
// //
// //   @override
// //   _VideoCategoryState createState() => _VideoCategoryState();
// // }
// //
// // class _VideoCategoryState extends State<VideoCategory> {
// //   bool isSelectMode = false;
// //   List<int> selectedIndices = [];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Filter items based on the search query
// //     final filteredItems = widget.items
// //         .where((item) =>
// //             item['file_name'] != null &&
// //             item['file_name']
// //                 .toLowerCase()
// //                 .contains(widget.searchQuery.toLowerCase()))
// //         .toList();
// //
// //     return Container(
// //       decoration: BoxDecoration(
// //         gradient: DynamicGradient.createGradient(
// //           [
// //             Colors.orangeAccent.withOpacity(0.3),
// //             Colors.redAccent.withOpacity(0.4)
// //           ],
// //           Alignment.bottomRight,
// //           Alignment.topLeft,
// //         ),
// //       ),
// //       child: Stack(
// //         children: [
// //           // GridView for videos
// //           GridView.builder(
// //             padding:
// //                 const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
// //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 2,
// //               crossAxisSpacing: 2.0,
// //               childAspectRatio: 0.75,
// //             ),
// //             itemCount: filteredItems.length,
// //             itemBuilder: (context, index) {
// //               final item = filteredItems[index];
// //               final videoUrl = item['url'] ?? ""; // URL of the video
// //               final fileName = item['file_name'] ?? "Unnamed Video";
// //
// //               return Padding(
// //                 padding: const EdgeInsets.all(2.0),
// //                 child: Column(
// //                   children: [
// //                     GestureDetector(
// //                       onTap: () {
// //                         if (videoUrl.isNotEmpty) {
// //                           _showFullScreenVideo(context, videoUrl);
// //                         } else {
// //                           ScaffoldMessenger.of(context).showSnackBar(
// //                             const SnackBar(
// //                                 content: Text("Video URL is missing")),
// //                           );
// //                         }
// //                       },
// //                       child: Container(
// //                         width: 80,
// //                         height: 80,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(8.0),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: Colors.black26,
// //                               blurRadius: 5.0,
// //                               offset: const Offset(2, 2),
// //                             ),
// //                           ],
// //                         ),
// //                         child: ClipRRect(
// //                           borderRadius: BorderRadius.circular(8.0),
// //                           child: videoUrl.isNotEmpty
// //                               ? Container(
// //                                   width: 80,
// //                                   height: 80,
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.black.withOpacity(0.6),
// //                                     borderRadius: BorderRadius.circular(8.0),
// //                                     boxShadow: [
// //                                       BoxShadow(
// //                                         color: Colors.black26,
// //                                         blurRadius: 5.0,
// //                                         offset: const Offset(2, 2),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   child: Image.asset(
// //                                     'assets/TimeCapsuleIcons/videoIcon.jpg',
// //                                     // Replace with the actual image URL or asset
// //                                     fit: BoxFit.cover,
// //                                     errorBuilder: (context, error, stackTrace) {
// //                                       return const Icon(
// //                                         Icons.broken_image,
// //                                         size: 50,
// //                                         color: Colors.white,
// //                                       );
// //                                     },
// //                                   ),
// //                                 )
// //                               : const Icon(
// //                                   Icons.broken_image,
// //                                   size: 50,
// //                                 ),
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 12.0),
// //                     Text(
// //                       fileName.length > 40
// //                           ? "${fileName.substring(0, 35)}..."
// //                           : fileName,
// //                       textAlign: TextAlign.center,
// //                       style: const TextStyle(
// //                         fontSize: 15.0,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                     if (!isSelectMode)
// //                     Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Row(
// //                           mainAxisSize: MainAxisSize.min,
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             IconButton(
// //                               padding: EdgeInsets.zero,
// //                               icon: const Icon(Icons.edit, size: 25),
// //                               onPressed: () => widget.onRename('Images', index),
// //                             ),
// //                             IconButton(
// //                               padding: EdgeInsets.zero,
// //                               icon: const Icon(Icons.delete, size: 25),
// //                               onPressed: () => widget.onDelete('Images', index),
// //                             ),
// //                           ],
// //                         ),
// //                         // const SizedBox(height: 5), // Adjust height for spacing
// //                         Row(
// //                           mainAxisSize: MainAxisSize.min,
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             IconButton(
// //                               padding: EdgeInsets.zero,
// //                               icon: const Icon(Icons.download, size: 25),
// //                               onPressed: () =>
// //                                   _downloadVideo(videoUrl, fileName),
// //                             ),
// //                             IconButton(
// //                               padding: EdgeInsets.zero,
// //                               icon: const Icon(Icons.share, size: 25),
// //                               onPressed: () => _shareVideo(videoUrl),
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                     if (isSelectMode)
// //                       Positioned(
// //                         top: 5,
// //                         right: 5,
// //                         child: Checkbox(
// //                           value: selectedIndices.contains(index),
// //                           onChanged: (bool? value) {
// //                             setState(() {
// //                               if (value == true) {
// //                                 selectedIndices.add(index);
// //                               } else {
// //                                 selectedIndices.remove(index);
// //                               }
// //                             });
// //                           },
// //                         ),
// //                       ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // Full-screen video view
// //   void _showFullScreenVideo(BuildContext context, String videoUrl) {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => FullScreenVideoPage(videoUrl: videoUrl),
// //       ),
// //     );
// //   }
// //
// //   // Download video functionality
// //   void _downloadVideo(String videoUrl, String fileName) async {
// //     if (videoUrl.isNotEmpty) {
// //       try {
// //         final taskId = await FlutterDownloader.enqueue(
// //           url: videoUrl,
// //           savedDir: '/storage/emulated/0/Download',
// //           // Example save path
// //           fileName: fileName,
// //           showNotification: true,
// //           // Show download progress
// //           openFileFromNotification: true, // Open file after download
// //         );
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Download started")),
// //         );
// //       } catch (e) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Download failed")),
// //         );
// //       }
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Video URL is missing")),
// //       );
// //     }
// //   }
// //
// //   // Share video functionality
// //   void _shareVideo(String videoUrl) {
// //     if (videoUrl.isNotEmpty) {
// //       Share.share(videoUrl,
// //           subject: "Check out this video!"); // Share the video URL
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Video URL is missing")),
// //       );
// //     }
// //   }
// // }
// //
// // class FullScreenVideoPage extends StatefulWidget {
// //   final String videoUrl;
// //
// //   FullScreenVideoPage({required this.videoUrl});
// //
// //   @override
// //   _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
// // }
// //
// // class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
// //   late VideoPlayerController _controller;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = VideoPlayerController.network(widget.videoUrl)
// //       ..initialize().then((_) {
// //         setState(() {});
// //         _controller.play(); // Auto-play the video
// //       });
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: SafeArea(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Expanded(
// //               child: _controller.value.isInitialized
// //                   ? AspectRatio(
// //                       aspectRatio: _controller.value.aspectRatio,
// //                       child: VideoPlayer(_controller),
// //                     )
// //                   : const Center(
// //                       child: CircularProgressIndicator(),
// //                     ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(20.0),
// //               child: ElevatedButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 style: ElevatedButton.styleFrom(
// //                   foregroundColor: Colors.black,
// //                   backgroundColor: Colors.lightBlueAccent,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                   padding:
// //                       const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
// //                 ),
// //                 child: const Text(
// //                   'Back',
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:share_plus/share_plus.dart';
//
// import '../../gradient_color.dart';
//
// class VideoCategory extends StatefulWidget {
//   final List<Map<String, dynamic>> items;
//   final String searchQuery;
//   final Function(String, int) onRename;
//   final Function(String, int) onDelete;
//   final TextEditingController searchController;
//
//   VideoCategory({
//     required this.items,
//     required this.searchQuery,
//     required this.onRename,
//     required this.onDelete,
//     required this.searchController,
//   });
//
//   @override
//   _VideoCategoryState createState() => _VideoCategoryState();
// }
//
// class _VideoCategoryState extends State<VideoCategory> {
//   @override
//   Widget build(BuildContext context) {
//     final filteredItems = widget.items
//         .where((item) =>
//     item['file_name'] != null &&
//         item['file_name']
//             .toLowerCase()
//             .contains(widget.searchQuery.toLowerCase()))
//         .toList();
//
//     return Container(
//       decoration: BoxDecoration(
//         gradient: DynamicGradient.createGradient(
//           [
//             Colors.orangeAccent.withOpacity(0.3),
//             Colors.redAccent.withOpacity(0.4)
//           ],
//           Alignment.bottomRight,
//           Alignment.topLeft,
//         ),
//       ),
//       child: GridView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 2.0,
//           childAspectRatio: 0.75,
//         ),
//         itemCount: filteredItems.length,
//         itemBuilder: (context, index) {
//           final item = filteredItems[index];
//           final videoUrl = item['url'] ?? "";
//           final fileName = item['file_name'] ?? "Unnamed Video";
//
//           return Padding(
//             padding: const EdgeInsets.all(2.0),
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     if (videoUrl.isNotEmpty) {
//                       _showFullScreenVideo(context, videoUrl);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Video URL is missing")),
//                       );
//                     }
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.asset(
//                       'assets/TimeCapsuleIcons/videoIcon.jpg',
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Icon(Icons.broken_image, size: 50);
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12.0),
//                 Text(
//                   fileName.length > 40
//                       ? "${fileName.substring(0, 35)}..."
//                       : fileName,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 PopupMenuButton<String>(
//                   onSelected: (value) {
//                     if (value == 'rename') {
//                       widget.onRename('Videos', index);
//                     } else if (value == 'delete') {
//                       widget.onDelete('Videos', index);
//                     } else if (value == 'download') {
//                       _downloadVideo(videoUrl, fileName);
//                     } else if (value == 'share') {
//                       _shareVideo(videoUrl);
//                     }
//                   },
//                   itemBuilder: (context) => [
//                     PopupMenuItem(
//                       value: 'rename',
//                       child: ListTile(
//                         leading: Icon(Icons.edit),
//                         title: Text('Rename'),
//                       ),
//                     ),
//                     PopupMenuItem(
//                       value: 'delete',
//                       child: ListTile(
//                         leading: Icon(Icons.delete),
//                         title: Text('Delete'),
//                       ),
//                     ),
//                     PopupMenuItem(
//                       value: 'download',
//                       child: ListTile(
//                         leading: Icon(Icons.download),
//                         title: Text('Download'),
//                       ),
//                     ),
//                     PopupMenuItem(
//                       value: 'share',
//                       child: ListTile(
//                         leading: Icon(Icons.share),
//                         title: Text('Share'),
//                       ),
//                     ),
//                   ],
//                   child: Icon(Icons.more_vert),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _showFullScreenVideo(BuildContext context, String videoUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoPage(videoUrl: videoUrl),
//       ),
//     );
//   }
//
//   void _downloadVideo(String videoUrl, String fileName) async {
//     if (videoUrl.isNotEmpty) {
//       try {
//         await FlutterDownloader.enqueue(
//           url: videoUrl,
//           savedDir: '/storage/emulated/0/Download',
//           fileName: fileName,
//           showNotification: true,
//           openFileFromNotification: true,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Download started")),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Download failed")),
//         );
//       }
//     }
//   }
//
//   void _shareVideo(String videoUrl) {
//     if (videoUrl.isNotEmpty) {
//       Share.share(videoUrl, subject: "Check out this video!");
//     }
//   }
// }
//
// class FullScreenVideoPage extends StatefulWidget {
//   final String videoUrl;
//
//   FullScreenVideoPage({required this.videoUrl});
//
//   @override
//   _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
// }
//
// class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../gradient_color.dart';
//
// class VideoCategory extends StatelessWidget {
//   final List<Map<String, dynamic>> items;
//   final String searchQuery;
//   final Function(String, int) onRename;
//   final Function(String, int) onDelete;
//   final TextEditingController searchController;
//
//   VideoCategory({
//     required this.items,
//     required this.searchQuery,
//     required this.onRename,
//     required this.onDelete,
//     required this.searchController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter items based on the search query
//     final filteredItems = items
//         .where((item) =>
//     item['file_name'] != null &&
//         item['file_name'].toLowerCase().contains(searchQuery.toLowerCase()))
//         .toList();
//
//     return Container(
//       // color: Colors.orangeAccent.withOpacity(0.9),
//         decoration: BoxDecoration(
//           gradient: DynamicGradient.createGradient(
//             [Colors.orangeAccent.withOpacity(0.3), Colors.redAccent.withOpacity(0.4)],
//             Alignment.bottomRight,
//             Alignment.topLeft,
//           ),
//         ),
//       child: GridView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Number of items per row
//           crossAxisSpacing: 8.0, // Space between columns
//           mainAxisSpacing: 16.0, // Space between rows
//           childAspectRatio: 0.9, // Adjust the aspect ratio as needed
//         ),
//         itemCount: filteredItems.length,
//         itemBuilder: (context, index) {
//           final item = filteredItems[index];
//           final videoUrl = item['url'] ?? ""; // Cloudinary URL of the video
//           final fileName = item['file_name'] ?? "Unnamed Video";
//
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     if (videoUrl.isNotEmpty) {
//                       // Navigate to full-screen video view
//                       _showFullScreenVideo(context, videoUrl);
//                     } else {
//                       // Show a message if the URL is missing
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text("Video URL is missing"),
//                         ),
//                       );
//                     }
//                   },
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 5.0,
//                           offset: const Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: videoUrl.isNotEmpty
//                           ? const Icon(
//                         Icons.videocam,
//                         size: 50,
//                         color: Colors.blueAccent,
//                       ) // Placeholder icon for videos
//                           : const Icon(
//                         Icons.broken_image,
//                         size: 50,
//                       ), // Placeholder for missing URL
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12.0),
//                 Text(
//                   fileName.length > 40
//                       ? "${fileName.substring(0, 35)}..."
//                       : fileName,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.edit),
//                       onPressed: () => onRename('Videos', index),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () => onDelete('Videos', index),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // Full-screen video view
//   void _showFullScreenVideo(BuildContext context, String videoUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoPage(videoUrl: videoUrl),
//       ),
//     );
//   }
// }
//
// class FullScreenVideoPage extends StatefulWidget {
//   final String videoUrl;
//
//   FullScreenVideoPage({required this.videoUrl});
//
//   @overridez
//   _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
// }
//
// class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play(); // Auto-play the video
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: _controller.value.isInitialized
//                   ? AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     )
//                   : const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//             ),
//             // Back button
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.lightBlueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                 ),
//                 child: const Text(
//                   'Back',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'dart:io';
// //
// // class VideoCategory extends StatelessWidget {
// //   final List<Map<String, dynamic>> items;
// //   final String searchQuery;
// //   final TextEditingController searchController;
// //   final Function(String, int) onRename;
// //   final Function(String, int) onDelete;
// //
// //   VideoCategory({
// //     required this.items,
// //     required this.searchQuery,
// //     required this.searchController,
// //     required this.onRename,
// //     required this.onDelete,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Filter videos based on the search query
// //     final filteredItems = items
// //         .where((item) =>
// //         item['file_name'].toLowerCase().contains(searchQuery.toLowerCase()))
// //         .toList();
// //
// //     return ListView.builder(
// //       itemCount: filteredItems.length,
// //       itemBuilder: (context, index) {
// //         final item = filteredItems[index];
// //         return ListTile(
// //           leading: Icon(Icons.video_library), // Video thumbnail can be added here
// //           title: Text(item['file_name']),
// //           trailing: Row(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               IconButton(
// //                 icon: const Icon(Icons.edit),
// //                 onPressed: () => onRename('Videos', index),
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.delete),
// //                 onPressed: () => onDelete('Videos', index),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:share_plus/share_plus.dart'; // Import the share package
//
// import '../../gradient_color.dart';
//
// class VideoCategory extends StatefulWidget {
//   final List<Map<String, dynamic>> items;
//   final String searchQuery;
//   final Function(String, int) onRename;
//   final Function(String, int) onDelete;
//   final TextEditingController searchController;
//
//   VideoCategory({
//     required this.items,
//     required this.searchQuery,
//     required this.onRename,
//     required this.onDelete,
//     required this.searchController,
//   });
//
//   @override
//   _VideoCategoryState createState() => _VideoCategoryState();
// }
//
// class _VideoCategoryState extends State<VideoCategory> {
//   bool isSelectMode = false;
//   List<int> selectedIndices = [];
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter items based on the search query
//     final filteredItems = widget.items
//         .where((item) =>
//     item['file_name'] != null &&
//         item['file_name'].toLowerCase().contains(widget.searchQuery.toLowerCase()))
//         .toList();
//
//     return Container(
//       decoration: BoxDecoration(
//         gradient: DynamicGradient.createGradient(
//           [Colors.orangeAccent.withOpacity(0.3), Colors.redAccent.withOpacity(0.4)],
//           Alignment.bottomRight,
//           Alignment.topLeft,
//         ),
//       ),
//       child: Stack(
//         children: [
//           // GridView for videos
//           GridView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0), // Add padding to prevent overflow
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Two videos in one row
//               crossAxisSpacing: 8.0, // Space between columns
//               childAspectRatio: 0.9, // Adjust ratio to give items enough vertical space
//             ),
//             itemCount: filteredItems.length,
//             itemBuilder: (context, index) {
//               final item = filteredItems[index];
//               final videoUrl = item['url'] ?? ""; // URL of the video
//               final fileName = item['file_name'] ?? "Unnamed Video";
//
//               return Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         if (videoUrl.isNotEmpty) {
//                           _showFullScreenVideo(context, videoUrl);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Video URL is missing")),
//                           );
//                         }
//                       },
//                       child: Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 5.0,
//                               offset: const Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8.0),
//                           child: videoUrl.isNotEmpty
//                               ? Container(
//                             width: 80,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.6),
//                               borderRadius: BorderRadius.circular(8.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black26,
//                                   blurRadius: 5.0,
//                                   offset: const Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Image.asset(
//                               'assets/TimeCapsuleIcons/videoIcon.jpg', // Replace with the actual image URL or asset
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.broken_image,
//                                   size: 50,
//                                   color: Colors.white,
//                                 );
//                               },
//                             ),
//                           )
//                               : const Icon(
//                             Icons.broken_image,
//                             size: 50,
//                           ),
//                         )
//
//                       ),
//                     ),
//                     const SizedBox(height: 12.0),
//                     Text(
//                       fileName.length > 40 ? "${fileName.substring(0, 35)}..." : fileName,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     if (!isSelectMode)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit),
//                             onPressed: () => widget.onRename('Videos', index),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () => widget.onDelete('Videos', index),
//                           ),
//                         ],
//                       ),
//                     if (isSelectMode)
//                       Positioned(
//                         top: 5,
//                         right: 5,
//                         child: Checkbox(
//                           value: selectedIndices.contains(index),
//                           onChanged: (bool? value) {
//                             setState(() {
//                               if (value == true) {
//                                 selectedIndices.add(index);
//                               } else {
//                                 selectedIndices.remove(index);
//                               }
//                             });
//                           },
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           // Share button
//           Positioned(
//             bottom: 120,
//             right: 18,
//             child: FloatingActionButton(
//               onPressed: () {
//                 setState(() {
//                   isSelectMode = !isSelectMode;
//                   if (!isSelectMode) {
//                     selectedIndices.clear();
//                   }
//                 });
//               },
//               backgroundColor: isSelectMode ? Colors.red : Colors.blue,
//               child: Icon(isSelectMode ? Icons.close : Icons.share),
//             ),
//           ),
//           // Share selected videos
//           if (isSelectMode)
//             Positioned(
//               bottom: 200,
//               right: 18,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   if (selectedIndices.isNotEmpty) {
//                     final selectedUrls = selectedIndices
//                         .map((index) => filteredItems[index]['url'])
//                         .whereType<String>()
//                         .toList();
//
//                     Share.shareXFiles(
//                       selectedUrls.map((url) => XFile(url)).toList(),
//                       text: "Check out these videos!",
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("No videos selected to share")),
//                     );
//                   }
//                 },
//                 backgroundColor: Colors.green,
//                 child: const Icon(Icons.send),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // Full-screen video view
//   void _showFullScreenVideo(BuildContext context, String videoUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoPage(videoUrl: videoUrl),
//       ),
//     );
//   }
// }
//
// class FullScreenVideoPage extends StatefulWidget {
//   final String videoUrl;
//
//   FullScreenVideoPage({required this.videoUrl});
//
//   @override
//   _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
// }
//
// class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play(); // Auto-play the video
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: _controller.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//                   : const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//             // Back button
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.lightBlueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                 ),
//                 child: const Text(
//                   'Back',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:share_plus/share_plus.dart'; // Import the share package
// import 'package:flutter_downloader/flutter_downloader.dart';  // Add this import for downloading functionality
//
// import '../../gradient_color.dart';
//
// class VideoCategory extends StatefulWidget {
//   final List<Map<String, dynamic>> items;
//   final String searchQuery;
//   final Function(String, int) onRename;
//   final Function(String, int) onDelete;
//   final TextEditingController searchController;
//
//   VideoCategory({
//     required this.items,
//     required this.searchQuery,
//     required this.onRename,
//     required this.onDelete,
//     required this.searchController,
//   });
//
//   @override
//   _VideoCategoryState createState() => _VideoCategoryState();
// }
//
// class _VideoCategoryState extends State<VideoCategory> {
//   bool isSelectMode = false;
//   List<int> selectedIndices = [];
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter items based on the search query
//     final filteredItems = widget.items
//         .where((item) =>
//     item['file_name'] != null &&
//         item['file_name'].toLowerCase().contains(widget.searchQuery.toLowerCase()))
//         .toList();
//
//     return Container(
//       decoration: BoxDecoration(
//         gradient: DynamicGradient.createGradient(
//           [Colors.orangeAccent.withOpacity(0.3), Colors.redAccent.withOpacity(0.4)],
//           Alignment.bottomRight,
//           Alignment.topLeft,
//         ),
//       ),
//       child: Stack(
//         children: [
//           // GridView for videos
//           GridView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0), // Add padding to prevent overflow
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Two videos in one row
//               crossAxisSpacing: 8.0, // Space between columns
//               childAspectRatio: 0.9, // Adjust ratio to give items enough vertical space
//             ),
//             itemCount: filteredItems.length,
//             itemBuilder: (context, index) {
//               final item = filteredItems[index];
//               final videoUrl = item['url'] ?? ""; // URL of the video
//               final fileName = item['file_name'] ?? "Unnamed Video";
//
//               return Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         if (videoUrl.isNotEmpty) {
//                           _showFullScreenVideo(context, videoUrl);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Video URL is missing")),
//                           );
//                         }
//                       },
//                       child: Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 5.0,
//                               offset: const Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8.0),
//                           child: videoUrl.isNotEmpty
//                               ? Container(
//                             width: 80,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.6),
//                               borderRadius: BorderRadius.circular(8.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black26,
//                                   blurRadius: 5.0,
//                                   offset: const Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Image.asset(
//                               'assets/TimeCapsuleIcons/videoIcon.jpg', // Replace with the actual image URL or asset
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.broken_image,
//                                   size: 50,
//                                   color: Colors.white,
//                                 );
//                               },
//                             ),
//                           )
//                               : const Icon(
//                             Icons.broken_image,
//                             size: 50,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12.0),
//                     Text(
//                       fileName.length > 40 ? "${fileName.substring(0, 35)}..." : fileName,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     if (!isSelectMode)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit),
//                             onPressed: () => widget.onRename('Videos', index),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () => widget.onDelete('Videos', index),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.download, size: 27), // Add download button
//                             onPressed: () => _downloadVideo(videoUrl, fileName), // Trigger download
//                           ),
//                         ],
//                       ),
//                     if (isSelectMode)
//                       Positioned(
//                         top: 5,
//                         right: 5,
//                         child: Checkbox(
//                           value: selectedIndices.contains(index),
//                           onChanged: (bool? value) {
//                             setState(() {
//                               if (value == true) {
//                                 selectedIndices.add(index);
//                               } else {
//                                 selectedIndices.remove(index);
//                               }
//                             });
//                           },
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           // Share button
//           Positioned(
//             bottom: 120,
//             right: 18,
//             child: FloatingActionButton(
//               onPressed: () {
//                 setState(() {
//                   isSelectMode = !isSelectMode;
//                   if (!isSelectMode) {
//                     selectedIndices.clear();
//                   }
//                 });
//               },
//               backgroundColor: isSelectMode ? Colors.red : Colors.blue,
//               child: Icon(isSelectMode ? Icons.close : Icons.share),
//             ),
//           ),
//           // Share selected videos
//           if (isSelectMode)
//             Positioned(
//               bottom: 200,
//               right: 18,
//               child: FloatingActionButton(
//                 onPressed: () async {
//                   if (selectedIndices.isNotEmpty) {
//                     final selectedUrls = selectedIndices
//                         .map((index) => filteredItems[index]['url'])
//                         .whereType<String>()
//                         .toList();
//
//                     if (selectedUrls.isNotEmpty) {
//                       // Share the selected URLs directly
//                       Share.share(
//                         selectedUrls.join("\n"), // Share the URLs of the selected videos
//                         subject: "Check out these Videos!", // Optional message
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("No Videos available to share")),
//                       );
//                     }
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("No Videos selected to share")),
//                     );
//                   }
//                 },
//                 backgroundColor: Colors.green,
//                 child: const Icon(Icons.send),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // Full-screen video view
//   void _showFullScreenVideo(BuildContext context, String videoUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoPage(videoUrl: videoUrl),
//       ),
//     );
//   }
//
//   // Download video functionality
//   void _downloadVideo(String videoUrl, String fileName) async {
//     if (videoUrl.isNotEmpty) {
//       try {
//         final taskId = await FlutterDownloader.enqueue(
//           url: videoUrl,
//           savedDir: '/storage/emulated/0/Download', // Example save path
//           fileName: fileName,
//           showNotification: true, // Show download progress
//           openFileFromNotification: true, // Open file after download
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Download started")),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Download failed")),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Video URL is missing")),
//       );
//     }
//   }
// }
//
// class FullScreenVideoPage extends StatefulWidget {
//   final String videoUrl;
//
//   FullScreenVideoPage({required this.videoUrl});
//
//   @override
//   _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
// }
//
// class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play(); // Auto-play the video
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: _controller.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//                   : const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//             // Back button
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.lightBlueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                 ),
//                 child: const Text(
//                   'Back',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//          ),
//       ),
//     );
//   }
// }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:share_plus/share_plus.dart'; // Import the share package
//
// import '../../gradient_color.dart';
//
// class VideoCategory extends StatefulWidget {
//   final List<Map<String, dynamic>> items;
//   final String searchQuery;
//   final Function(String, int) onRename;
//   final Function(String, int) onDelete;
//   final TextEditingController searchController;
//
//   VideoCategory({
//     required this.items,
//     required this.searchQuery,
//     required this.onRename,
//     required this.onDelete,
//     required this.searchController,
//   });
//
//   @override
//   _VideoCategoryState createState() => _VideoCategoryState();
// }
//
// class _VideoCategoryState extends State<VideoCategory> {
//   bool isSelectMode = false;
//   List<int> selectedIndices = [];
//
//   @override
//   Widget build(BuildContext context) {
//     // Filter items based on the search query
//     final filteredItems = widget.items
//         .where((item) =>
//     item['file_name'] != null &&
//         item['file_name'].toLowerCase().contains(widget.searchQuery.toLowerCase()))
//         .toList();
//
//     return Container(
//       decoration: BoxDecoration(
//         gradient: DynamicGradient.createGradient(
//           [Colors.orangeAccent.withOpacity(0.3), Colors.redAccent.withOpacity(0.4)],
//           Alignment.bottomRight,
//           Alignment.topLeft,
//         ),
//       ),
//       child: Stack(
//         children: [
//           // GridView for videos
//           GridView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0), // Add padding to prevent overflow
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Two videos in one row
//               crossAxisSpacing: 8.0, // Space between columns
//               childAspectRatio: 0.9, // Adjust ratio to give items enough vertical space
//             ),
//             itemCount: filteredItems.length,
//             itemBuilder: (context, index) {
//               final item = filteredItems[index];
//               final videoUrl = item['url'] ?? ""; // URL of the video
//               final fileName = item['file_name'] ?? "Unnamed Video";
//
//               return Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         if (videoUrl.isNotEmpty) {
//                           _showFullScreenVideo(context, videoUrl);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("Video URL is missing")),
//                           );
//                         }
//                       },
//                       child: Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 5.0,
//                               offset: const Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8.0),
//                           child: videoUrl.isNotEmpty
//                               ? Container(
//                             width: 80,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.6),
//                               borderRadius: BorderRadius.circular(8.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black26,
//                                   blurRadius: 5.0,
//                                   offset: const Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Image.asset(
//                               'assets/TimeCapsuleIcons/videoIcon.jpg', // Replace with the actual image URL or asset
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.broken_image,
//                                   size: 50,
//                                   color: Colors.white,
//                                 );
//                               },
//                             ),
//                           )
//                               : const Icon(
//                             Icons.broken_image,
//                             size: 50,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12.0),
//                     Text(
//                       fileName.length > 40 ? "${fileName.substring(0, 35)}..." : fileName,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     if (!isSelectMode)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit),
//                             onPressed: () => widget.onRename('Videos', index),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () => widget.onDelete('Videos', index),
//                           ),
//                           // Removed the download button
//                         ],
//                       ),
//                     if (isSelectMode)
//                       Positioned(
//                         top: 5,
//                         right: 5,
//                         child: Checkbox(
//                           value: selectedIndices.contains(index),
//                           onChanged: (bool? value) {
//                             setState(() {
//                               if (value == true) {
//                                 selectedIndices.add(index);
//                               } else {
//                                 selectedIndices.remove(index);
//                               }
//                             });
//                           },
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           // Share button
//           Positioned(
//             bottom: 120,
//             right: 18,
//             child: FloatingActionButton(
//               onPressed: () {
//                 setState(() {
//                   isSelectMode = !isSelectMode;
//                   if (!isSelectMode) {
//                     selectedIndices.clear();
//                   }
//                 });
//               },
//               backgroundColor: isSelectMode ? Colors.red : Colors.blue,
//               child: Icon(isSelectMode ? Icons.close : Icons.share),
//             ),
//           ),
//           // Share selected videos
//           if (isSelectMode)
//             Positioned(
//               bottom: 200,
//               right: 18,
//               child: FloatingActionButton(
//                 onPressed: () async {
//                   if (selectedIndices.isNotEmpty) {
//                     final selectedUrls = selectedIndices
//                         .map((index) => filteredItems[index]['url'])
//                         .whereType<String>()
//                         .toList();
//
//                     if (selectedUrls.isNotEmpty) {
//                       // Share the selected URLs directly
//                       Share.share(
//                         selectedUrls.join("\n"), // Share the URLs of the selected videos
//                         subject: "Check out these Videos!", // Optional message
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("No Videos available to share")),
//                       );
//                     }
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("No Videos selected to share")),
//                     );
//                   }
//                 },
//                 backgroundColor: Colors.green,
//                 child: const Icon(Icons.send),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // Full-screen video view
//   void _showFullScreenVideo(BuildContext context, String videoUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoPage(videoUrl: videoUrl),
//       ),
//     );
//   }
// }
//
// class FullScreenVideoPage extends StatefulWidget {
//   final String videoUrl;
//
//   FullScreenVideoPage({required this.videoUrl});
//
//   @override
//   _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
// }
//
// class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play(); // Auto-play the video
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: _controller.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//                   : const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//             // Back button
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.lightBlueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                 ),
//                 child: const Text(
//                   'Back',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:share_plus/share_plus.dart';

import '../../gradient_color.dart';

class VideoCategory extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final String searchQuery;
  final Function(String, int) onRename;
  final Function(String, int) onDelete;
  final TextEditingController searchController;

  VideoCategory({
    required this.items,
    required this.searchQuery,
    required this.onRename,
    required this.onDelete,
    required this.searchController,
  });

  @override
  _VideoCategoryState createState() => _VideoCategoryState();
}

class _VideoCategoryState extends State<VideoCategory> {
  @override
  Widget build(BuildContext context) {
    final filteredItems = widget.items
        .where((item) =>
    item['file_name'] != null &&
        item['file_name']
            .toLowerCase()
            .contains(widget.searchQuery.toLowerCase()))
        .toList();

    return Container(
      decoration: BoxDecoration(
        gradient: DynamicGradient.createGradient(
          [
            Colors.orangeAccent.withOpacity(0.3),
            Colors.redAccent.withOpacity(0.4)
          ],
          Alignment.bottomRight,
          Alignment.topLeft,
        ),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          childAspectRatio: 0.75,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          final videoUrl = item['url'] ?? "";
          final fileName = item['file_name'] ?? "Unnamed Video";

          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (videoUrl.isNotEmpty) {
                      _showFullScreenVideo(context, videoUrl);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Video URL is missing")),
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/TimeCapsuleIcons/videoIcon.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  fileName.length > 40
                      ? "${fileName.substring(0, 35)}..."
                      : fileName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'rename') {
                      widget.onRename('Videos', index);
                    } else if (value == 'delete') {
                      widget.onDelete('Videos', index);
                    } else if (value == 'download') {
                      _downloadVideo(videoUrl, fileName);
                    } else if (value == 'share') {
                      _shareVideo(videoUrl);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'rename',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Rename'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'download',
                      child: ListTile(
                        leading: Icon(Icons.download),
                        title: Text('Download'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: ListTile(
                        leading: Icon(Icons.share),
                        title: Text('Share'),
                      ),
                    ),
                  ],
                  child: Icon(Icons.more_vert),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showFullScreenVideo(BuildContext context, String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPage(videoUrl: videoUrl),
      ),
    );
  }

  void _downloadVideo(String videoUrl, String fileName) async {
    if (videoUrl.isNotEmpty) {
      try {
        await FlutterDownloader.enqueue(
          url: videoUrl,
          savedDir: '/storage/emulated/0/Download',
          fileName: fileName,
          showNotification: true,
          openFileFromNotification: true,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Download started")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Download failed")),
        );
      }
    }
  }

  void _shareVideo(String videoUrl) {
    if (videoUrl.isNotEmpty) {
      Share.share(videoUrl, subject: "Check out this video!");
    }
  }
}

class FullScreenVideoPage extends StatefulWidget {
  final String videoUrl;

  FullScreenVideoPage({required this.videoUrl});

  @override
  _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}