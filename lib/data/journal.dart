import 'package:hive/hive.dart';
part 'journal.g.dart';

@HiveType(typeId: 3)
class Journal {
  @HiveField(0)
  String? className;
  @HiveField(1)
  Map<String, Map<String, List<String>>>? journal;
  Journal({this.className, this.journal});
}
