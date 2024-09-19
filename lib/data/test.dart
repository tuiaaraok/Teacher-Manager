import 'package:hive/hive.dart';
part 'test.g.dart';

@HiveType(typeId: 1)
class Test {
  @HiveField(0)
  String? className;
  @HiveField(1)
  List<TestInfo>? elemDate;
  Test({this.className, this.elemDate});
}

@HiveType(typeId: 2)
class TestInfo {
  @HiveField(0)
  String? question;
  @HiveField(1)
  List<String>? answer;
  @HiveField(2)
  List<bool>? isAnwer;
  TestInfo({this.question, this.answer, this.isAnwer});
}
