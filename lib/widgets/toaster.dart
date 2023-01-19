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

class Toaster {
  FToast fToast = FToast();

  Toaster(BuildContext context) {
    fToast.init(context);
  }

  showToast(type, message) {
    Color backgroundColor;
    if (type == ToasterType.success) {
      backgroundColor = const Color.fromARGB(255, 39, 153, 43);
    } else if (type == ToasterType.fail) {
      backgroundColor = Colors.red;
    } else {
      backgroundColor = Colors.grey;
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }
}
