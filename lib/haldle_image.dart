import 'dart:io';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

Future<void> onImageInsert(String image, QuillController controller) async {
  final newSavedImage = await saveImage(File(image));
  controller.insertImageBlock(imageSource: newSavedImage);
}

Future<String> saveImage(File file) async {
  return file.path;
}
