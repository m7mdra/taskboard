import 'dart:collection';
import 'dart:math';

import 'package:taskboard/model/task.dart';

class Board {
  final String name;
  List<Task> _tasks =
  List.generate(5, (index) => Task("Task ${Random().nextInt(100)}"))
      .toList();
  DateTime createDate = DateTime.now();
  late DateTime updateDate;

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  Board(this.name);

  void newTask(Task task) {
    _tasks.add(task);
    _updateDate();
  }

  _updateDate() {
    updateDate = DateTime.now();
  }

  void removeTask(Task task) {
    _tasks.removeWhere((element) => element.id == task.id);
    _updateDate();
  }
}
