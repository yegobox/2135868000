import 'dart:convert';

import 'package:backup/models/memo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class ViewMemo extends StatelessWidget {
  ViewMemo({super.key});
  final _controller = QuillController.basic();

  static const route_name = "view_memo";

  @override
  Widget build(BuildContext context) {
    final memo = ModalRoute.of(context)!.settings.arguments as Memo;
    _controller.document = Document.fromJson(jsonDecode(memo.memo));
    return Scaffold(
      appBar: AppBar(
        title: Text(memo.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: QuillEditor(
            autoFocus: false,
            showCursor: false,
            controller: _controller,
            focusNode: FocusNode(),
            padding: EdgeInsets.zero,
            scrollController: ScrollController(),
            expands: true,
            scrollable: true,
            readOnly: true,
          ),
        ),
      ),
    );
  }
}
