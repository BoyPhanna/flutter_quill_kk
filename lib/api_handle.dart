import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

void getData(
    {required QuillController controller,
    required List<String> datas,
    required String type}) {
  datas.clear();
  var json = controller.document.toDelta().toJson();
  for (var data in json) {
    RegExp regExp = RegExp(r'\{' + type + r': (.+?)\}');

    RegExpMatch? match = regExp.firstMatch(data["insert"].toString());

    // print(image["insert"]);
    if (match != null) {
      String path = match.group(1)!;
      datas.add(path);
    }
  }
  debugPrint("Images : ${jsonEncode(datas)}");

  // debugPrint("Data : ${jsonEncode(data)}");
}
