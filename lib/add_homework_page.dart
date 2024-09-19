import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:teacher/data/boxes.dart';
import 'package:teacher/data/homework.dart';

class AddHomeworkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<StatefulWidget> {
  FocusNode _nodeText1 = FocusNode();
  TextEditingController taskController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  TextEditingController todayController = TextEditingController();
  TextEditingController surrenderController = TextEditingController();
  bool allFieldsFilled() {
    return taskController.text.isNotEmpty &&
        todayController.text.isNotEmpty &&
        surrenderController.text.isNotEmpty &&
        classNameController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardActions(
        config: KeyboardActionsConfig(
            keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
            nextFocus: true,
            actions: [
              KeyboardActionsItem(
                focusNode: _nodeText1,
              ),
            ]),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Homework",
                        style: TextStyle(color: Colors.white, fontSize: 24.sp),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Center(
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  color: Color(0xFF6E02C3), fontSize: 18.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Container(
                    width: 300.w,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Class name",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 50.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.h),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                                color: Color(0xFFC2B0FF).withOpacity(0.3),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: TextField(
                                  controller: classNameController,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Name',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 120.w,
                                    child: Text(
                                      "Today",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2.h),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                      color: Color(0xFFC2B0FF).withOpacity(0.3),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: TextField(
                                        controller: todayController,
                                        textInputAction:
                                            TextInputAction.newline,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '01.12.2024',
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        cursorColor: Colors.white,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                        onChanged: (text) {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 120.w,
                                    child: Text(
                                      "Surrender",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2.h),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r)),
                                      color: Color(0xFFC2B0FF).withOpacity(0.3),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: TextField(
                                        controller: surrenderController,
                                        textInputAction:
                                            TextInputAction.newline,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '01.12.2024',
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        cursorColor: Colors.white,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                        onChanged: (text) {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Task",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 240.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.h),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                                color: Color(0xFFC2B0FF).withOpacity(0.3),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: TextField(
                                  minLines: 1,
                                  maxLines: 5, // Set a maximum number of lines
                                  controller: taskController,
                                  focusNode: _nodeText1,
                                  textInputAction: TextInputAction.newline,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Task name',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),

                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60.h),
                          child: GestureDetector(
                            onTap: () {
                              if (allFieldsFilled()) {
                                Box<Homework> contactsBox =
                                    Hive.box<Homework>(HiveBoxes.homework);
                                Homework addHomeWork = Homework(
                                    className:
                                        classNameController.text.toString(),
                                    today: todayController.text.toString(),
                                    surrender:
                                        surrenderController.text.toString(),
                                    task: taskController.text.toString());
                                contactsBox.add(addHomeWork);
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              width: 260.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                                gradient: allFieldsFilled()
                                    ? LinearGradient(colors: [
                                        Color(0xFF7D49F4),
                                        Color(0xFF5225C1)
                                      ])
                                    : LinearGradient(colors: [
                                        Color.fromARGB(162, 124, 73, 244),
                                        Color.fromARGB(103, 81, 37, 193)
                                      ]),
                              ),
                              child: Center(
                                child: Text(
                                  "Create",
                                  style: TextStyle(
                                      color: allFieldsFilled()
                                          ? Colors.white
                                          : Color(0xFFF2F2F7).withOpacity(0.5),
                                      fontSize: 24.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
