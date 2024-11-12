import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter/foundation.dart';

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
      configurations: QuillEditorConfigurations(
          placeholder: "Type something...",
          sharedConfigurations: _sharedConfigurations,
          elementOptions: const QuillEditorElementOptions(
            codeBlock: QuillEditorCodeBlockElementOptions(
              enableLineNumbers: true,
            ),
            orderedList: QuillEditorOrderedListElementOptions(),
            unorderedList: QuillEditorUnOrderedListElementOptions(
              useTextColorForDot: true,
            ),
          ),
          characterShortcutEvents: standardCharactersShortcutEvents,
          spaceShortcutEvents: standardSpaceShorcutEvents,
          searchConfigurations: QuillSearchConfigurations(
            searchEmbedMode: SearchEmbedMode.none,
          ),
          scrollable: true,
          embedBuilders: [
            ...kIsWeb
                ? FlutterQuillEmbeds.editorWebBuilders()
                : FlutterQuillEmbeds.editorBuilders()
          ]),
    );
  }

  QuillSharedConfigurations get _sharedConfigurations {
    return const QuillSharedConfigurations(
      locale: Locale('km', 'en'),
      extraConfigurations: {
        QuillSharedExtensionsConfigurations.key:
            QuillSharedExtensionsConfigurations(
          assetsPrefix: 'assets', // Defaults to assets
        ),
      },
    );
  }
}
