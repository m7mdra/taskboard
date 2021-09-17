import 'package:flutter/material.dart';
import 'package:taskboard/main.dart';

import 'model/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskWidget({Key? key, required this.task,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(4);
    return Card(
      elevation: 0.4,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          child: Text(task.name),
          padding: const EdgeInsets.all(16),
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: radius),
    );
  }
}
