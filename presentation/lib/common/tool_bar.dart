import 'package:flutter_quill/flutter_quill.dart';

QuillToolbar simpleQuillToolbar(QuillController controller) {
  return QuillToolbar.basic(
    controller: controller,
    showAlignmentButtons: false,
    showBackgroundColorButton: false,
    showBoldButton: true,
    showCenterAlignment: false,
    showClearFormat: false,
    showCodeBlock: false,
    showColorButton: true,
    showDirection: false,
    showDividers: false,
    showFontFamily: false,
    showFontSize: true,
    showHeaderStyle: true,
    showIndent: false,
    showInlineCode: false,
    showItalicButton: false,
    showJustifyAlignment: false,
    showLeftAlignment: false,
    showLink: false,
    showListBullets: false,
    showListCheck: false,
    showListNumbers: false,
    showQuote: false,
    showRedo: false,
    showRightAlignment: false,
    showSearchButton: false,
    showSmallButton: false,
    showStrikeThrough: true,
    showSubscript: false,
    showSuperscript: false,
    showUnderLineButton: true,
    showUndo: false,
  );
}
