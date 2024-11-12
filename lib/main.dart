import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:web_test/api_handle.dart';
import 'package:web_test/font.dart';
import 'package:web_test/haldle_image.dart';
import 'package:web_test/my_quill_editor.dart';

void main() {
  // FlutterQuillLocalizations
  // print(FlutterQuillLocalizations.localizationsDelegates.toString());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Khmer-Regular"),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuillController controller = QuillController.basic();
  final FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  bool readOnly = false;
  List<String> images = [];
  List<String> videoes = [];

  @override
  void initState() {
    controller.document = Document.fromJson([
      {"insert": "\n\n\n\n\n"},
      {
        "insert": "Akira Nakai",
        "attributes": {
          "font": "Moul-Regular",
          "size": 70.0,
          "underline": true,
          "color": "#FF1A237E"
        }
      },
      {
        "insert": "    ",
        "attributes": {"underline": true, "color": "#FF1A237E"}
      },
      {"insert": " "},
      {
        "insert": "\n",
        "attributes": {"align": "center"}
      },
      {"insert": "\n\n"},
      {
        "insert": {
          "video":
              "https://github.com/BoyPhanna/video/raw/refs/heads/main/akira_music.mp4"
        }
      },
      {"insert": "\n\n"},
      {
        "insert": "       Akira Nakai",
        "attributes": {"bold": true, "color": "#FF000000", "size": 28.0}
      },
      {
        "insert": " (",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "Japanese",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff",
          "link": "https://en.wikipedia.org/wiki/Japanese_language"
        }
      },
      {
        "insert": ": 中井 啓, ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "Hepburn",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff",
          "link": "https://en.wikipedia.org/wiki/Hepburn_romanization"
        }
      },
      {
        "insert": ": ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "Nakai Akira",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff",
          "italic": true
        }
      },
      {
        "insert": ") is a ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "Japanese",
        "attributes": {
          "link": "https://en.wikipedia.org/wiki/Economy_of_Japan",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert": " automotive tuner, founder of ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "Porsche",
        "attributes": {
          "link": "https://en.wikipedia.org/wiki/Porsche",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert":
            " aftermarket tuning company RAUH-Welt BEGRIFF (RWB), who specializes in the design and installation of custom wide-body kits for classic and modern ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "Porsche models",
        "attributes": {
          "link": "https://en.wikipedia.org/wiki/List_of_Porsche_vehicles",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert": ".",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "[1]",
        "attributes": {
          "script": "super",
          "link": "https://en.wikipedia.org/wiki/Akira_Nakai#cite_note-1",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert": "[2]",
        "attributes": {
          "script": "super",
          "link": "https://en.wikipedia.org/wiki/Akira_Nakai#cite_note-2",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert": " Earlier examples sported a sticker ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "German",
        "attributes": {
          "link": "https://en.wikipedia.org/wiki/German_language",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert": ": ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "\"Sekund Entwicklung\"",
        "attributes": {"italic": true, "color": "#FF000000", "size": 28.0}
      },
      {
        "insert": " on the back which was later changed to ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "German",
        "attributes": {
          "link": "https://en.wikipedia.org/wiki/German_language",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert": ": ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "\"Zweite Entwicklung\"",
        "attributes": {"italic": true, "color": "#FF000000", "size": 28.0}
      },
      {
        "insert": ", '\"second development\"' to fix a ",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "German language",
        "attributes": {
          "link": "https://en.wikipedia.org/wiki/German_language",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert": " mistake.",
        "attributes": {
          "color": "#FF000000",
          "font": "sans-serif",
          "size": 28.0,
          "background": "#ffffffff"
        }
      },
      {
        "insert": "[3]",
        "attributes": {
          "script": "super",
          "link": "https://en.wikipedia.org/wiki/Akira_Nakai#cite_note-3",
          "color": "#FF000000",
          "size": 28.0
        }
      },
      {
        "insert": " ",
        "attributes": {"script": "super", "color": "#FF000000", "size": 28.0}
      },
      {"insert": " "},
      {
        "insert": "សួស្ដីបងៗ",
        "attributes": {"font": "Moul-Regular", "size": 35.0}
      },
      {
        "insert": "   ",
        "attributes": {"font": "Khmer-Regular", "size": 35.0}
      },
      {
        "insert": "អូវាលីដើរចេញពីផ្ទះទាំងអារម្មណ៍សោកសៅ",
        "attributes": {
          "font": "Khmer-Regular",
          "size": 35.0,
          "color": "#FF4A148C",
          "bold": true,
          "underline": true
        }
      },
      {"insert": "\n\n"},
      {
        "insert": {
          "video":
              "https://github.com/BoyPhanna/video/raw/refs/heads/main/video_2024-11-11_14-12-56.mp4"
        }
      },
      {"insert": "\n\n"},
      {
        "insert": "ดหสหด่สหด่นหดพวกดวด",
        "attributes": {"size": 35.0, "color": "#FF4527A0"}
      },
      {"insert": "\n\n\n"}
    ]);

    // controller.document = Document.fromJson([
    //   {"insert": "\n\n\n\n\n"},
    //   {
    //     "insert": "Akira Nakai",
    //     "attributes": {
    //       "font": "Moul-Regular",
    //       "size": 70.0,
    //       "underline": true,
    //       "color": "#FF1A237E"
    //     }
    //   },
    //   {
    //     "insert": "    ",
    //     "attributes": {"underline": true, "color": "#FF1A237E"}
    //   },
    //   {"insert": " "},
    //   {
    //     "insert": "\n",
    //     "attributes": {"align": "center"}
    //   },
    //   {"insert": "\n\n"},
    //   {
    //     "insert": {
    //       "video":
    //           "/data/user/0/com.example.test_quill_2/cache/86c642f7-68ff-4868-8194-59aef85af196/1000023758.mp4"
    //     }
    //   },
    //   {"insert": "\n\n"},
    //   {
    //     "insert": "       Akira Nakai",
    //     "attributes": {"bold": true, "color": "#FF000000", "size": 28.0}
    //   },
    //   {
    //     "insert": " (",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "Japanese",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff",
    //       "link": "https://en.wikipedia.org/wiki/Japanese_language"
    //     }
    //   },
    //   {
    //     "insert": ": 中井 啓, ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "Hepburn",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff",
    //       "link": "https://en.wikipedia.org/wiki/Hepburn_romanization"
    //     }
    //   },
    //   {
    //     "insert": ": ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "Nakai Akira",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff",
    //       "italic": true
    //     }
    //   },
    //   {
    //     "insert": ") is a ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "Japanese",
    //     "attributes": {
    //       "link": "https://en.wikipedia.org/wiki/Economy_of_Japan",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert": " automotive tuner, founder of ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "Porsche",
    //     "attributes": {
    //       "link": "https://en.wikipedia.org/wiki/Porsche",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert":
    //         " aftermarket tuning company RAUH-Welt BEGRIFF (RWB), who specializes in the design and installation of custom wide-body kits for classic and modern ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "Porsche models",
    //     "attributes": {
    //       "link": "https://en.wikipedia.org/wiki/List_of_Porsche_vehicles",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert": ".",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "[1]",
    //     "attributes": {
    //       "script": "super",
    //       "link": "https://en.wikipedia.org/wiki/Akira_Nakai#cite_note-1",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert": "[2]",
    //     "attributes": {
    //       "script": "super",
    //       "link": "https://en.wikipedia.org/wiki/Akira_Nakai#cite_note-2",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert": " Earlier examples sported a sticker ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "German",
    //     "attributes": {
    //       "link": "https://en.wikipedia.org/wiki/German_language",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert": ": ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "\"Sekund Entwicklung\"",
    //     "attributes": {"italic": true, "color": "#FF000000", "size": 28.0}
    //   },
    //   {
    //     "insert": " on the back which was later changed to ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "German",
    //     "attributes": {
    //       "link": "https://en.wikipedia.org/wiki/German_language",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert": ": ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "\"Zweite Entwicklung\"",
    //     "attributes": {"italic": true, "color": "#FF000000", "size": 28.0}
    //   },
    //   {
    //     "insert": ", '\"second development\"' to fix a ",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "German language",
    //     "attributes": {
    //       "link": "https://en.wikipedia.org/wiki/German_language",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert": " mistake.",
    //     "attributes": {
    //       "color": "#FF000000",
    //       "font": "sans-serif",
    //       "size": 28.0,
    //       "background": "#ffffffff"
    //     }
    //   },
    //   {
    //     "insert": "[3]",
    //     "attributes": {
    //       "script": "super",
    //       "link": "https://en.wikipedia.org/wiki/Akira_Nakai#cite_note-3",
    //       "color": "#FF000000",
    //       "size": 28.0
    //     }
    //   },
    //   {
    //     "insert": " ",
    //     "attributes": {"script": "super", "color": "#FF000000", "size": 28.0}
    //   },
    //   {"insert": " "},
    //   {
    //     "insert": "សួស្ដីបងៗ",
    //     "attributes": {"font": "Moul-Regular", "size": 35.0}
    //   },
    //   {
    //     "insert": "   ",
    //     "attributes": {"font": "Khmer-Regular", "size": 35.0}
    //   },
    //   {
    //     "insert": "អូវាលីដើរចេញពីផ្ទះទាំងអារម្មណ៍សោកសៅ",
    //     "attributes": {
    //       "font": "Khmer-Regular",
    //       "size": 35.0,
    //       "color": "#FF4A148C",
    //       "bold": true,
    //       "underline": true
    //     }
    //   },
    //   {"insert": "\n\n"},
    //   {
    //     "insert": {
    //       "video":
    //           "/data/user/0/com.example.test_quill_2/cache/a511866f-dbdd-49f5-bc30-204885b47dee/1000023741.mp4"
    //     }
    //   },
    //   {"insert": "\n\n"},
    //   {
    //     "insert": "ดหสหด่สหด่นหดพวกดวด",
    //     "attributes": {"size": 35.0, "color": "#FF4527A0"}
    //   },
    //   {"insert": "\n\n\n"}
    // ]);

    if (!kIsWeb)
      VideoPlayerMediaKit.ensureInitialized(
        windows: true,
      );
    controller.readOnly = readOnly;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                setState(() {
                  readOnly = !readOnly;
                  controller.readOnly = readOnly;
                });
              },
              icon: Icon(Icons.edit)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getData(controller: controller, datas: images, type: "image");
            getData(controller: controller, datas: videoes, type: "video");
            debugPrint("Images: ${jsonEncode(images)}");
            // debugPrint(
            //     "Data: ${jsonEncode(controller.document.toDelta().toJson())}");
          },
          child: Icon(
            Icons.send,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ..._allQuill(),
            ],
          ),
        ));
  }

  List<Widget> _allQuill() {
    return [
      !readOnly
          ? QuillToolbar.simple(
              controller: controller,
              configurations: QuillSimpleToolbarConfigurations(
                multiRowsDisplay: true,
                fontFamilyValues: const {
                  'khmer regular': FontFamily.khmerRegular,
                  'Moul-Regular': FontFamily.moulRegular,
                  'Fasthand-Regular': FontFamily.fasthandRegular,
                },
                fontSizesValues: const {
                  '14': '14.0',
                  '16': '16.0',
                  '18': '18.0',
                  '20': '20.0',
                  '22': '22.0',
                  '24': '24.0',
                  '26': '26.0',
                  '28': '28.0',
                  '30': '30.0',
                  '35': '35.0',
                  '40': '40.0',
                  '50': '50.0',
                  '70': '70.0',
                  '100': '100.0',
                },
                showAlignmentButtons: true,
                showRightAlignment: true,
                showLeftAlignment: true,
                showSearchButton: true,
                searchButtonType: SearchButtonType.modern,
                embedButtons: FlutterQuillEmbeds.toolbarButtons(
                  imageButtonOptions: QuillToolbarImageButtonOptions(
                    imageButtonConfigurations: QuillToolbarImageConfigurations(
                      onImageInsertCallback: onImageInsert,
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyQuillEditor(
            focusNode: focusNode,
            scrollController: scrollController,
            controller: controller,
          ),
        ),
      ),
    ];
  }
}
