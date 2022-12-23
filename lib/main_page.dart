import 'dart:math';

import 'package:flutter/gestures.dart';
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
  ScrollController _controller = ScrollController();
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text('Add new board by type the title'),
                  children: [
                    TextField()
                  ],
                );
              });
        },
      ),
      body: SafeArea(
        child: Scrollbar(
          interactive: true,
          trackVisibility: true,
          thumbVisibility: true,
          controller: _controller,
          child: ReorderableListView.builder(
            scrollController: _controller,
            physics: ClampingScrollPhysics(),
            dragStartBehavior: DragStartBehavior.start,
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
              return ReorderableDragStartListener(
                  key: ValueKey(board.name),
                  index: index,
                  child: Listener(
                    onPointerMove: _pointerMove,
                    child: DragTarget<Task>(
                      hitTestBehavior: HitTestBehavior.translucent,
                      onWillAccept: (task) {
                        return !board.tasks.contains(task);
                      },
                      onAccept: (task) {
                        board.newTask(task);
                      },
                      builder: (context, data, _) {
                        return BoardWidget(
                          isDragging: (isDragging) {
                            this._isDragging = isDragging;
                          },
                          board: board,
                          addNewTaskCallback: () {
                            board
                                .newTask(Task("Task ${Random().nextInt(100)}"));
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ));
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
      ),
    );
  }

  void _pointerMove(event) {
    if (!_isDragging) {
      return;
    }
    RenderBox render = _listKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = render.localToGlobal(Offset.zero);
    double leadingX = position.dx;
    double trailingX = leadingX + render.size.width;
    const detectedRange = 100;
    if (event.position.dx < leadingX + detectedRange) {
      var to = _controller.offset - 20;
      to = (to < 0) ? 0 : to;

      _controller.jumpTo(to);
    } else if (event.position.dx > trailingX - detectedRange) {
      var to = _controller.offset + 20;
      print(to);
      to = (to > _controller.position.maxScrollExtent)
          ? _controller.position.maxScrollExtent
          : to;
      _controller.jumpTo(to);
    }
  }
}
