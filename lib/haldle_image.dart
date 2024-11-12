import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

Future<void> onImageInsert(String image, QuillController controller) async {
  if (kIsWeb || isHttpBasedUrl(image)) {
    controller.insertImageBlock(imageSource: image);
    return;
  }
  final newSavedImage = await saveImage(File(image));
  controller.insertImageBlock(imageSource: newSavedImage);
}

Future<String> saveImage(File file) async {
  return file.path;
}
