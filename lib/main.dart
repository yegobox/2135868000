import 'dart:async';
import 'dart:developer';

import 'package:backup/constants/routes.dart';
import 'package:backup/screens/home_screen.dart';
import 'package:backup/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized(); //imp line need to be added first
    FlutterError.onError = (FlutterErrorDetails details) {
      log("Error From INSIDE FRAME_WORK");
      log("----------------------");
      log("Error :  ${details.exception}");
      log("StackTrace :  ${details.stack}");
    };
    await dotenv.load(fileName: "assets/.env");
    ConnectivityService();
    runApp(MyApp());
  }, ((error, stack) {
    log(error.toString());
  }));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'YegoMemo',
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            primarySwatch: Colors.deepPurple,
            appBarTheme: const AppBarTheme(color: Colors.blue),
            scaffoldBackgroundColor: const Color.fromARGB(255, 6, 6, 31)),
        debugShowCheckedModeBanner: false,
        home: Home(title: 'YegoMemo'),
        routes: routes);
  }
}
