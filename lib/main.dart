import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';
import 'package:teacher/add_homework_page.dart';
import 'package:teacher/add_test_page.dart';
import 'package:teacher/create_name_page.dart';
import 'package:teacher/data/boxes.dart';
import 'package:teacher/data/homework.dart';
import 'package:teacher/data/journal.dart';
import 'package:teacher/data/test.dart';
import 'package:teacher/add_journal_page.dart';
import 'package:teacher/homework_page.dart';
import 'package:teacher/journal_list_page.dart';
import 'package:teacher/journal_page.dart';
import 'package:teacher/list_test_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:teacher/menu_page.dart';
import 'package:teacher/onboarding_page.dart';
import 'package:teacher/preview_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TestAdapter());
  Hive.registerAdapter(TestInfoAdapter());
  Hive.registerAdapter(JournalAdapter());
  Hive.registerAdapter(HomeworkAdapter());
  await Hive.openBox<Test>(HiveBoxes.test);
  await Hive.openBox<Journal>(HiveBoxes.journal);
  await Hive.openBox<Homework>(HiveBoxes.homework);
  await Hive.openBox("userName");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              // onGenerateRoute: NavigationApp.generateRoute,
              theme: ThemeData(
                  scaffoldBackgroundColor: Color(0xFF6E02C3),
                  appBarTheme:
                      AppBarTheme(backgroundColor: Colors.transparent)),
              home:
                  Hive.box("userName").isEmpty ? OnboardingPage() : MenuPage());
        });
  }
}
