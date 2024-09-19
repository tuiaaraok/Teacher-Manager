import 'package:hive/hive.dart';
part 'homework.g.dart';

@HiveType(typeId: 4)
class Homework {
  @HiveField(0)
  String? className;
  @HiveField(1)
  String? today;
  @HiveField(2)
  String? surrender;
  @HiveField(3)
  String? task;
  Homework({this.className, this.today, this.surrender, this.task});
}
