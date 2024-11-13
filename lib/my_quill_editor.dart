import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_test/edit_data_table.dart';

class MyQuillEditor extends StatelessWidget {
  final QuillController controller;
  final FocusNode focusNode;
  final ScrollController scrollController;
  const MyQuillEditor({
    super.key,
    required this.focusNode,
    required this.scrollController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      controller: controller,
      focusNode: focusNode,
      scrollController: scrollController,
      config: QuillEditorConfig(
          placeholder: "Type something...",
          searchConfig: const QuillSearchConfig(
            searchEmbedMode: SearchEmbedMode.plainText,
          ),
          scrollable: true,
          embedBuilders: [
            CustomTableEmbedBuilder(),
            ...kIsWeb
                ? FlutterQuillEmbeds.editorWebBuilders()
                : FlutterQuillEmbeds.editorBuilders()
          ]),
    );
  }
}

class TimeStampEmbed extends Embeddable {
  const TimeStampEmbed(
    String value,
  ) : super(timeStampType, value);

  static const String timeStampType = 'timeStamp';

  static TimeStampEmbed fromDocument(Document document) =>
      TimeStampEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class TimeStampEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'timeStamp';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    return Row(
      children: [
        const Icon(Icons.access_time_rounded),
        Text(embedContext.node.value.data as String),
      ],
    );
  }
}

class CustomTableEmbedBuilder extends EmbedBuilder {
  @override
  Widget build(BuildContext context, EmbedContext embed) {
    // print(embed.node.value.data);
    var table = embed.node.value.data as List;

    if (table.isNotEmpty) return EditableDataTableExample();
    return Container();
  }

  @override
  String get key => "table";
}
