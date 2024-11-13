import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
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
      locale: Locale('km'),
      localizationsDelegates: [
        FlutterQuillLocalizations.delegate,
      ],
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

  @override
  void initState() {
    controller.document = Document.fromJson([
      {
        "insert": {
          'table': [
            [
              {'content': 'Cell 1'},
              {'content': 'Cell 2'},
              {'content': 'Cell 3'},
              {'content': 'Cell 4'}
            ],
            [
              {'content': 'Cell 3'},
              {'content': 'Cell 4'},
              {'content': 'Cell 3'},
              {'content': 'Cell 4'}
            ]
          ]
        },
      },
      {"insert": "\n"}
    ]);
    if (!kIsWeb)
      VideoPlayerMediaKit.ensureInitialized(
        windows: true,
      );
    controller.readOnly = readOnly;
    super.initState();
  }

  Map<String, String> videoMaps = {};
  Map<String, String> imageMaps = {};
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
          onPressed: () async {
            await sendDataToApi(
                imageMaps: imageMaps,
                videoMaps: videoMaps,
                controller: controller);
            var data = replaceData(
                imageMaps: imageMaps,
                videoMaps: videoMaps,
                controller: controller);

            await sendDescriptionToApi(data);
            print(data);
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
          ? QuillSimpleToolbar(
              controller: controller,
              config: QuillSimpleToolbarConfig(
                multiRowsDisplay: true,
                showAlignmentButtons: true,
                showRightAlignment: true,
                showLeftAlignment: true,
                showSearchButton: true,
                buttonOptions: QuillSimpleToolbarButtonOptions(
                  fontFamily: QuillToolbarFontFamilyButtonOptions(items: {
                    'khmer regular': FontFamily.khmerRegular,
                    'Moul-Regular': FontFamily.moulRegular,
                    'Fasthand-Regular': FontFamily.fasthandRegular,
                  }),
                  fontSize: QuillToolbarFontSizeButtonOptions(
                    items: {
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
                  ),
                ),
                embedButtons: FlutterQuillEmbeds.toolbarButtons(
                  imageButtonOptions: QuillToolbarImageButtonOptions(
                    imageButtonConfig: QuillToolbarImageConfig(
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
