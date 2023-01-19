import 'package:backup/screens/create_memo_screen.dart';
import 'package:backup/screens/edit_memo_screen.dart';
import 'package:backup/screens/view_memo_screen.dart';
import 'package:flutter/widgets.dart';

Map<String, Widget Function(dynamic)> routes = {
  CreateMemo.route_name: (context) => CreateMemo(),
  EditMemo.route_name: (context) => EditMemo(),
  ViewMemo.route_name: (context) => ViewMemo()
};
