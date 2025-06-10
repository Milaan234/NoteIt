import 'package:hive/hive.dart';

part 'note.g.dart';

// defines the Note class
@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  final int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String? content;
  @HiveField(3)
  final DateTime createdAt;

  Note ({
    required this.id,
    required this.title,
    this.content,
    required this.createdAt
  });

}