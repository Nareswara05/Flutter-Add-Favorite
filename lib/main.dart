// main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_2/view/homepage_view.dart';

void main() {
  runApp(GetMaterialApp(
    home: HomePage(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
