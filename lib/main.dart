import 'package:backup/constants/routes.dart';
import 'package:backup/screens/home_screen.dart';
import 'package:backup/services/isar_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'YegoMemo',
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            primarySwatch: Colors.deepPurple,
            appBarTheme: AppBarTheme(color: Colors.blue),
            scaffoldBackgroundColor: Color.fromARGB(255, 6, 6, 31)),
        debugShowCheckedModeBanner: false,
        home: Home(title: 'YegoMemo'),
        routes: routes);
  }
}
