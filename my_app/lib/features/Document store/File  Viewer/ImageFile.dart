import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  ImageViewerScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Viewer", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            loadingBuilder: (context, progress) {
              return Center(
                child: CircularProgressIndicator(
                  value: progress == null
                      ? null
                      : progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1),
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
