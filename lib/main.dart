import 'package:flutter/material.dart';
import 'package:twoimagescomparison/widgets/compare_from_gallery.dart';

void main() => runApp(ImageCompare());

class ImageCompare extends StatefulWidget {
  @override
  _ImageCompareState createState() => _ImageCompareState();
}

class _ImageCompareState extends State<ImageCompare> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Compare two images'),
          ),
          body: CompareFromGallery()),
    );
  }
}




