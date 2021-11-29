

import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

class ImageConvertor{


  Future<File> compressImage({required File file, required int quality, required int percentage, required targetWidth, required targetHeight})async{
    return await FlutterNativeImage.compressImage(file.path,
        quality: quality, percentage: percentage, targetWidth: targetWidth, targetHeight: targetHeight);
  }


}