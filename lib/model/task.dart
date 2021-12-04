import 'dart:math';

import 'package:flutter/cupertino.dart';
colors() => List.generate(
    10,
        (index) => Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255)));
texts() => [
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
]
  ..shuffle()
  ..shuffle();

class Task {
  final String name;
  final int id = Random().nextInt(10000000);
  final List<Label> labels = List.generate(
      4, (index) => Label(name: texts()[index], color: colors()[index]));

  Task(this.name);


  void addLabel(Label label) {
    this.labels.add(label);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Label {
  final String name;
  final Color color;

  Label({required this.name, required this.color});
}
