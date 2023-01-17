import 'package:backup/constants/routes.dart';
import 'package:backup/screens/home_screen.dart';
import 'package:backup/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  ConnectivityService();
  runApp(MyApp());
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
            appBarTheme: AppBarTheme(color: Colors.blue),
            scaffoldBackgroundColor: Color.fromARGB(255, 6, 6, 31)),
        debugShowCheckedModeBanner: false,
        home: Home(title: 'YegoMemo'),
        routes: routes);
  }
}
