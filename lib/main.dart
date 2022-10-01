import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskboard/animated_label.dart';

import 'main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool show = false;
  var colors = List.generate(
      10,
      (index) => Color.fromARGB(255, Random().nextInt(255),
          Random().nextInt(255), Random().nextInt(255)));
  var labels = [
    "System Frameworks",
    "Patterns",
    "Third-party Libraries",
    "Community",
    "Tools",
    "Commons",
    "A",
    "AB",
    "ABC",
    "ABCD",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            show = !show;
          });
        },
      ),
      body: SafeArea(
        child: Wrap(
            children: List.generate(10, (index) {
          return AnimatedLabel(
            show: show,
            color: colors[index],
            label: labels[index],
          );
        }).toList()),
      ),
    );
  }
}
