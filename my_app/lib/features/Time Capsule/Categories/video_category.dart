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
  late double _currentPosition = 0;
  late double _videoLength = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _videoLength = _controller.value.duration.inSeconds.toDouble();
        });
        _controller.play();
      });

    // Listen to the controller's position change to update the current position
    _controller.addListener(() {
      setState(() {
        _currentPosition = _controller.value.position.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Seek the video by a specific number of seconds (negative for backward, positive for forward)
  void _seekToOffset(int offsetInSeconds) {
    final newPosition = _currentPosition + offsetInSeconds;
    if (newPosition >= 0 && newPosition <= _videoLength) {
      _controller.seekTo(Duration(seconds: newPosition.toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Video player
            _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : CircularProgressIndicator(),

            const SizedBox(height: 16), // Add some space between video and controls

            // Controls and Progress Bar
            Column(
              children: [
                // 10 seconds back and forward buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 10 seconds backward button
                    IconButton(
                      icon: Icon(
                        Icons.fast_rewind,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () => _seekToOffset(-10),
                    ),
                    // Play/Pause button (optional)
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      },
                    ),
                    // 10 seconds forward button
                    IconButton(
                      icon: Icon(
                        Icons.fast_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () => _seekToOffset(10),
                    ),
                  ],
                ),

                // Progress bar
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.orangeAccent,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.black26,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
