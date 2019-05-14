import 'package:flutter/material.dart';

class BookCover extends StatelessWidget {
  final String url;

  BookCover(this.url);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Image.network(
        url.replaceFirst('zoom=5', 'zoom=10'),
        fit: BoxFit.cover,
      ),
    );
  }
}
