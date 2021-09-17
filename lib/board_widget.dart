import 'package:flutter/material.dart';
import 'package:taskboard/task_widget.dart';

import 'model/board.dart';

class BoardWidget extends StatefulWidget {
  final Board board;
  final VoidCallback? addNewTaskCallback;

  const BoardWidget({Key? key, required this.board, this.addNewTaskCallback})
      : super(key: key);

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topCenter,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 250,
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(50),
            borderRadius: BorderRadius.circular(4)),
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
              child: ListView.builder(
                  primary: false,
                  itemBuilder: (context, index) {
                    var task = widget.board.tasks[index];
                    return TaskWidget(task: task);
                  },
                  itemCount: widget.board.tasks.length,
                  shrinkWrap: true),
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
