import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twoimagescomparison/services/pixel_compare.dart';
import 'package:twoimagescomparison/widgets/flat_button_widget.dart';
import 'package:twoimagescomparison/widgets/image_container.dart';

class CompareFromGallery extends StatefulWidget {
  @override
  _CompareFromGalleryState createState() => _CompareFromGalleryState();
}

class _CompareFromGalleryState extends State<CompareFromGallery> {
  static const String UpButtonText =
      'Tap here to choose first image from gallery';
  static const String BottomButtonText =
      'Tap here to choose second image from gallery and compare';
  String image1Path = 'images/image1.jpg';
  String image2Path = 'images/image2.jpg';
  List<int> bytes1 = [];
  List<int> bytes2 = [];

  PixelCompare pixelCompare = PixelCompare();

  String result = '';

  Image image1 = const Image(
    image: AssetImage('images/image1.jpg'),
  );

  Image image2 = const Image(
    image: AssetImage('images/image2.jpg'),
  );
  final picker = ImagePicker();

  Future<Image> getImage(PickedFile pickedFile) async {
    File _image;

    setState(() {
      Image.file(_image = File(pickedFile.path));
    });
    return Image.file(_image = File(pickedFile.path));
  }

  Future<void> getBytes(String path1, String path2) async{
    bytes1 = await PixelCompare().getImageListBytes(path1);
    bytes2 = await PixelCompare().getImageListBytes(path2);
    setState(() {
      result=PixelCompare().getDifferentPixelsGallery(bytes1, bytes2);
    });
  }

  Future<void> pickFirstImage() async {
    final PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery);
    image1Path = pickedFile.path;
    image1 = await getImage(pickedFile);
    bytes1 = await pickedFile.readAsBytes();
  }

  Future<void> pickSecondImageAndCompare() async {
    final PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery);
    image2Path = pickedFile.path;
    image2 = await getImage(pickedFile);
    bytes2 = await pickedFile.readAsBytes();
    setState(() {
      result = PixelCompare().getDifferentPixelsGallery(bytes1, bytes2);
    });
  }
 @override
  void initState() {
     getBytes(image1Path,  image2Path);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ImageContainer(
              theme: theme,
              image1: image1,
            ),
            FlatButtonWidget(text: UpButtonText, fun: pickFirstImage),
            ImageContainer(
              theme: theme,
              image1: image2,
            ),
            FlatButtonWidget(
                text: BottomButtonText, fun: pickSecondImageAndCompare),
            Text(
              result,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23.0, color: theme.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
