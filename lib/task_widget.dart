import 'package:flutter/material.dart';
import 'package:taskboard/animated_label.dart';

import 'model/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskWidget({Key? key, required this.task, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(4);
    return Card(
      elevation: 0.4,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(
              children: task.labels
                  .map((e) =>
                      AnimatedLabel(show: false, color: e.color, label: e.name))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Text(task.name)
          ]),
          padding: const EdgeInsets.all(16),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: radius),
    );
  }
}
