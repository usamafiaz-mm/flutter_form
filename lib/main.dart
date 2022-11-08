import 'package:flutter/material.dart';
import 'package:flutter_form/screens/FormScreen.dart';
import 'package:flutter_form/screens/ListScreen.dart';

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
      debugShowCheckedModeBanner: false,
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
