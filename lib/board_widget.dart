import 'package:flutter/material.dart';
import 'package:taskboard/animated_label.dart';
import 'package:taskboard/task_widget.dart';

import 'model/board.dart';
import 'model/task.dart';

class BoardWidget extends StatefulWidget {
  final Board board;
  final VoidCallback? addNewTaskCallback;
  final bool isDragged;
  final ValueChanged<bool>? isDragging;

  const BoardWidget(
      {Key? key,
      this.isDragging,
      required this.board,
      this.addNewTaskCallback,
      this.isDragged = false})
      : super(key: key);

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(8);
    var tasks = widget.board.tasks;
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 250,
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(widget.isDragged ? 100 : 50),
            borderRadius: radius),
        duration: Duration(milliseconds: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                widget.board.name,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 16),
            Flexible(
              child: Scrollbar(
                interactive: true,
                trackVisibility: true,
                thumbVisibility: true,
                controller: scrollController,
                child: ReorderableListView.builder(
                  scrollController: scrollController,
                  buildDefaultDragHandles: false,
                  primary: false,
                  proxyDecorator:
                      (Widget child, int index, Animation<double> animation) {
                    return TaskWidget(task: widget.board.tasks[index]);
                  },
                  itemBuilder: (context, index) {
                    var task = widget.board.tasks[index];
                    return ReorderableDragStartListener(
                      index: index,
                      key: ValueKey(task.id),
                      child: Draggable<Task>(
                        affinity: Axis.horizontal,
                        // axis: Axis.horizontal,
                        rootOverlay: true,
                        onDragCompleted: () {
                          widget.isDragging?.call(false);
                          widget.board.removeTask(task);
                          if (mounted) setState(() {});
                        },
                        onDragStarted: () => widget.isDragging?.call(true),
                        onDraggableCanceled: (speed, offset) =>
                            widget.isDragging?.call(false),
                        onDragEnd: (event) => widget.isDragging?.call(false),
                        data: task,
                        childWhenDragging: TaskDragPlaceholder(),
                        feedback: Container(
                          child: TaskWidget(task: task),
                          width: 250,
                        ),
                        child: TaskWidget(
                          task: task,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Card(
                                    margin: EdgeInsets.all(32),
                                    child: Column(children: [
                                      Wrap(
                                        children: task.labels
                                            .map((e) => AnimatedLabel(
                                                  label: e,
                                                  show: true,
                                                ))
                                            .toList(),
                                      )
                                    ]),
                                  );
                                });
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: tasks.length,
                  shrinkWrap: true,
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final item = tasks.removeAt(oldIndex);
                    widget.board.tasks.insert(newIndex, item);
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 250,
              child: TextButton.icon(
                onPressed: widget.addNewTaskCallback,
                icon: Icon(Icons.add),
                label: Text("Add a Task"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TaskDragPlaceholder extends StatelessWidget {
  const TaskDragPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.withAlpha(50)),
            borderRadius: BorderRadius.circular(4)),
        height: 50);
  }
}
