import 'package:flutter/material.dart';
import 'views/IndexActivity.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'FranFood',
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: IndexActivity(),
  ));

}

