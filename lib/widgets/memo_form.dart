import 'dart:convert';

import 'package:backup/constants/colors.dart';
import 'package:backup/models/memo.dart';
import 'package:backup/services/isar_service.dart';
import 'package:backup/widgets/editor_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class MemoForm extends StatefulWidget {
  final int? initialMemoId;
  final Function(Memo) submit;

  const MemoForm({super.key, required this.submit, this.initialMemoId});

  @override
  State<MemoForm> createState() => _MemoFormState();
}

class _MemoFormState extends State<MemoForm> {
  final _formKey = GlobalKey<FormState>();
  int? memoId;
  Memo? memo;
  String _title = "";
  final QuillController _controller = QuillController.basic();
  late Function(Memo) submit;

  final isar_service = IsarService();

  @override
  void initState() {
    super.initState();
    submit = widget.submit;
    if (widget.initialMemoId != null) {
      memoId = widget.initialMemoId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: memoId == null ? null : isar_service.getMemo(memoId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          memo = snapshot.data as Memo;
          _title = memo!.title;
          _controller.document = Document.fromJson(jsonDecode(memo!.memo));
        }
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: TextEditingController(text: _title),
                decoration: InputDecoration(labelText: 'Title', filled: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value as String,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: borderColor)),
                  child: Column(
                    children: [
                      Card(elevation: 2, child: editorToolBar(_controller)),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: QuillEditor.basic(
                            controller: _controller,
                            readOnly: false, // true for view only mode
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 1,
                      shadowColor: Color.fromARGB(24, 255, 255, 255),
                      backgroundColor: primaryButtonColor,
                      foregroundColor: Colors.white),
                  onPressed: _submit,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submit() {
    String memoText = jsonEncode(_controller.document.toDelta().toJson());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (memoId == null) {
        memo = Memo(title: _title, memo: memoText);
      } else {
        memo!.title = _title;
        memo!.memo = memoText;
      }
      submit(memo!);
    }
  }
}
