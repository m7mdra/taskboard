import 'package:flutter/material.dart';
import 'package:taskboard/task_widget.dart';

import 'model/board.dart';
import 'model/task.dart';

class BoardWidget extends StatefulWidget {
  final Board board;
  final VoidCallback? addNewTaskCallback;
  final bool isDragged;

  const BoardWidget(
      {Key? key,
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
    var radius = BorderRadius.circular(4);

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
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 16),
            Flexible(
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
                      onDragCompleted: () {
                        widget.board.removeTask(task);
                        setState(() {});
                      },
                      data: task,
                      childWhenDragging: TaskDragPlaceholder(),
                      feedback: Container(
                        child: TaskWidget(task: task),
                        width: 250,
                      ),
                      child: TaskWidget(task: task,onTap: (){},),
                    ),
                  );
                },
                itemCount: widget.board.tasks.length,
                shrinkWrap: true,
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = widget.board.tasks.removeAt(oldIndex);
                  widget.board.tasks.insert(newIndex, item);
                },
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
