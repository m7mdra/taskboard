import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskboard/model/board.dart';

import 'board_widget.dart';
import 'model/task.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var boards = <Board>[
    Board("Backlog"),
    Board("Sprint Backlog"),
    Board("Working on"),
    Board("Bugs"),
    Board("Testing"),
  ];
  GlobalKey<ReorderableListState> _listKey = GlobalKey<ReorderableListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReorderableListView.builder(
          proxyDecorator:
              (Widget child, int index, Animation<double> animation) {
            return BoardWidget(
              board: boards[index],
              isDragged: true,
            );
          },
          buildDefaultDragHandles: false,
          key: _listKey,
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            var board = boards[index];
            return ReorderableDelayedDragStartListener(
              key: ValueKey(board.name),
              index: index,
              child: DragTarget<Task>(
                onAccept: (task) {
                  board.newTask(task);
                },
                builder: (context, data, _) {
                  return BoardWidget(
                    board: board,
                    addNewTaskCallback: () {
                      board.newTask(Task("Task ${Random().nextInt(100)}"));
                      setState(() {});
                    },
                  );
                },
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: boards.length,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = boards.removeAt(oldIndex);
              boards.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }
}
