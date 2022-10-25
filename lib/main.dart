import 'package:flutter/material.dart';
import 'package:flutter_form/FormScreen.dart';
import 'package:flutter_form/ListScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.deepPurpleAccent, width: 2))),
      ),
      home: const ListScreen(),
    );
  }
}
