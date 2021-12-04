
import 'dart:math';

class Task {
  final String name;
  final int id = Random().nextInt(10000000);

  Task(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
