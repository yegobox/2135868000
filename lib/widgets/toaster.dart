import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToasterType { success, fail, warning }

void showToast(message, type) {
  Color backgroundColor;
  if (type == ToasterType.success) {
    backgroundColor = Color.fromARGB(255, 39, 153, 43);
  } else if (type == ToasterType.fail) {
    backgroundColor = Colors.red;
  } else {
    backgroundColor = Colors.grey;
  }
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 20.0);
}
