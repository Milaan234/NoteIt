import 'package:hive/hive.dart';

part 'task.g.dart';

// defines the Task class
@HiveType(typeId: 2)
class Task extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  bool isChecked;
  @HiveField(3)
  final DateTime createdAt;

  Task ({
    required this.id,
    required this.title,
    required this.isChecked,
    required this.createdAt,
  });

}