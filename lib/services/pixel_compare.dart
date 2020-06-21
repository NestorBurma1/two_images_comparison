import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';

class PixelCompare {
  img.Image image1decoded;

  img.Image image2decoded;

  List<int> image1values;

  List<int> image2values;

  bool _checkSize = true;

  Future<List<int>> getImageListBytes(String imagePath) async {
    final ByteData imageBytes = await rootBundle.load(imagePath);
    final List<int> values = imageBytes.buffer.asUint8List();
    return values;
  }

  bool comparePixels(int image1pixel, int image2pixel) {
    final int hex1 = abgrToArgb(image1pixel);
    final int hex2 = abgrToArgb(image2pixel);
    return hex1 == hex2;
  }

  int abgrToArgb(int argbColor) {
    final int r = (argbColor >> 16) & 0xFF;
    final int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  bool checkImageSize(List<int> image1values, List<int> image2values) {
    image1decoded = img.decodeImage(image1values);
    image2decoded = img.decodeImage(image2values);
    return image1decoded.width == image2decoded.width &&
        image1decoded.height == image2decoded.height;
  }

  String getDifferentPixelsGallery(
      List<int> image1values, List<int> image2values) {
    int counter = 0;

    _checkSize = checkImageSize(image1values, image2values);

    if (!_checkSize)
      return 'Can not compare different  size images, choose images with the same sizes';
    for (int i = 0; i < image1decoded.width; i++) {
      for (int j = 0; j < image1decoded.height; j++) {
        final int pixel32Image1 = image1decoded.getPixelSafe(i, j);
        final int pixel32Image2 = image2decoded.getPixelSafe(i, j);
        if (!comparePixels(pixel32Image1, pixel32Image2))
          counter++;
      }
    }

    final double percent =
        counter / (image1decoded.height * image1decoded.width / 100);
    final String percentString = percent.toStringAsFixed(2);

    if (percent > 0)
      return 'Difference in $counter pixels or $percentString%';
    else
      return 'No difference between images';
  }
}
