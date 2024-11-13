import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

void getData(
    {required QuillController controller,
    required Map<String, String> datas,
    required String type}) {
  datas.clear();
  var json = controller.document.toDelta().toJson();
  for (var data in json) {
    RegExp regExp = RegExp(r'\{' + type + r': (.+?)\}');

    RegExpMatch? match = regExp.firstMatch(data["insert"].toString());

    // print(image["insert"]);
    if (match != null) {
      String path = match.group(1)!;
      datas.addAll({path: path});
    }
  }
  debugPrint("Images : ${datas}");

  // debugPrint("Data : ${jsonEncode(data)}");
}

class FolderUpload {
  static const img = "img";
  static const video = "video";
}

Future<String> uploadImage(
    {required String filePath, required String folder}) async {
  Dio dio = Dio();
  dio.options.headers = {
    "Authorization":
        r"Bearer 4yEnSj7WxiTmS0$inuDIYfxJjDFCMbWRxRsKUUXF1Gf$adqmu64IAfDlbKDK0vZ$WUYYwMalwHbSaaFAknPMefd8T2ZRQH#42z6T"
  };

  String filename =
      "${DateTime.now().toUtc().millisecondsSinceEpoch.toString()}.${filePath.split('.').last}";
  var response = await dio.post("http://192.168.1.114:49470/api/v1/file",
      data: FormData.fromMap({
        'PATH': "item/details/" + "${folder}",
        'file': await MultipartFile.fromFile(
          filePath,
          filename: "${filename}",
        ),
      }));

  if (response.statusCode == 200) {
    // print("${folder}/${filename}");
    // print(response.data);
    return filename;
  } else {
    throw Exception('Failed to upload image');
  }
}

Future<void> sendDataToApi(
    {required Map<String, String> imageMaps,
    required Map<String, String> videoMaps,
    required QuillController controller}) async {
  getData(controller: controller, datas: imageMaps, type: "image");
  getData(controller: controller, datas: videoMaps, type: "video");
  // debugPrint("Images: ${jsonEncode(imageMaps)}");
  for (var video in videoMaps.keys) {
    String name =
        await uploadImage(filePath: video, folder: FolderUpload.video);
    videoMaps[video] = name;
  }
  for (var image in imageMaps.keys) {
    String name = await uploadImage(filePath: image, folder: FolderUpload.img);
    imageMaps[image] = name;
  }
  // debugPrint(videoMaps.toString());
  // debugPrint(imageMaps.toString());
}

String replaceData(
    {required Map<String, String> imageMaps,
    required Map<String, String> videoMaps,
    required QuillController controller}) {
  var data = jsonEncode(controller.document.toDelta().toJson());
  // print("top");
  // print(data);
  for (var video in videoMaps.keys) {
    data = data.replaceAll(RegExp(RegExp.escape(video.replaceAll(r'\', r'\\'))),
        videoMaps[video]!);
  }
  for (var image in imageMaps.keys) {
    var image2 = image.replaceAll(r'\', r'\\');
    // print(image2);
    // print(imageMaps[image]);
    data = data.replaceAll(RegExp(RegExp.escape(image2)), imageMaps[image]!);
  }
  return data;
}

Future<void> sendDescriptionToApi(String data) async {
  Dio dio = Dio();
  dio.options.headers = {
    "Authorization":
        r"Bearer 4yEnSj7WxiTmS0$inuDIYfxJjDFCMbWRxRsKUUXF1Gf$adqmu64IAfDlbKDK0vZ$WUYYwMalwHbSaaFAknPMefd8T2ZRQH#42z6T"
  };

  Map<String, dynamic> json = {
    "ITEM_CODE": "E1788",
    "DB_CODES": ["B16", "BT7"],
    "MEDIA": [
      {"url": "https://", "type": 0, "thumbnail": "https://", "order": 0}
    ],
    "DESCRIPTION": jsonDecode(data),
    "MADE_BY": "huy panha"
  };
  var response = await dio
      .post("http://192.168.1.114:49470/api/v1/item/details", data: json);

  if (response.statusCode == 200) {
    print(response.data);
  } else {
    throw Exception('Failed to upload image');
  }
}
