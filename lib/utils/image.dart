

import 'dart:io';
import 'dart:math';

import 'package:flutter_native_image/flutter_native_image.dart';

class ImageConvertor{


  Future<File> compressImage({required File file, required int quality, required int percentage, required targetWidth, required targetHeight})async{
    return await FlutterNativeImage.compressImage(file.path,
        quality: quality, percentage: percentage, targetWidth: targetWidth, targetHeight: targetHeight);
  }

  Future<File> resizePhoto(String filePath) async {
    ImageProperties properties =
    await FlutterNativeImage.getImageProperties(filePath);

    int width = properties.width!;
    var offset = (properties.height! - properties.width!) / 2;

    File croppedFile = await FlutterNativeImage.cropImage(
        filePath, 0, offset.round(), width, width);

    return croppedFile;
  }





}