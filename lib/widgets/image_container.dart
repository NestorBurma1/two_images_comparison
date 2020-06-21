import 'package:flutter/material.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    @required this.theme,
    @required this.image1,
  });

  final ThemeData theme;
  final Image image1;

  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            child: widget.image1,
            decoration: BoxDecoration(
                border: Border.all(color: widget.theme.primaryColor, width: 2.0)),
          ),
        ],
      ),
    );
  }
}