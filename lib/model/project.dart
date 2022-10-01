import 'package:taskboard/model/board.dart';

class Project {
  final String name;
  final String id;
  final List<Board> boards;
  DateTime updateDate = DateTime.now();

  Project(this.name, this.id, this.boards);
}
