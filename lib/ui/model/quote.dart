import 'package:hive/hive.dart';
part 'quote.g.dart';

@HiveType(typeId: 1)
class Quote {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final bool favourite;

  Quote({
    required this.title,
    required this.text,
    required this.id,
    required this.favourite,
  });
}