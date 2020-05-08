
import 'package:flutter/material.dart';
import 'package:sampleproject/CCList.dart';

void main() => runApp(CCTracker());

class CCTracker extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        buttonColor: Colors.black
      ),
      home: CCList()
    );
  }
}