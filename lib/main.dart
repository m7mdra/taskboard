import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taskboard/board_widget.dart';
import 'package:taskboard/model/task.dart';

import 'model/board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          boards.add(Board("Board ${Random().nextInt(100)}"));
        });
      }),
      body: ListView.builder(
        primary: true,
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) {
          var board = boards[index];
          return BoardWidget(board: board,addNewTaskCallback: (){
            board.newTask(Task("Task ${Random().nextInt(100)}"));
            setState(() {

            });
          },);
        },
        scrollDirection: Axis.horizontal,
        itemCount: boards.length,
      ),
    );
  }
}

