import 'dart:convert';

import 'package:backup/models/memo.dart';
import 'package:backup/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class ViewMemo extends StatefulWidget {
  ViewMemo({super.key});
  static const route_name = "view_memo";

  @override
  State<ViewMemo> createState() => _ViewMemoState();
}

class _ViewMemoState extends State<ViewMemo> {
  final _controller = QuillController.basic();

  final isarService = IsarService();

  late Memo _memo;

  @override
  Widget build(BuildContext context) {
    _memo = ModalRoute.of(context)!.settings.arguments as Memo;
    return StreamBuilder(
      stream: isarService.getMemo(_memo.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final memo = snapshot.data as Memo;
          _memo.title = memo.title;
          _controller.document = Document.fromJson(jsonDecode(memo.memo));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(_memo.title),
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
          )),
        );
      },
    );
  }
}
