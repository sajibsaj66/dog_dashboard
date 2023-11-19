import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  final List<String> images;
  String title;

  ImageList({required this.images, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,  // Display the title
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),  // Add spacing
        Expanded(
          child: ListView.builder(
            itemCount: images.length,  // Determine the number of images to display
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),  // Add padding around each image
                child: Image.network(images[index]),  // Display each image
              );
            },
          ),
        ),
      ],
    );
  }
}
