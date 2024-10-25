import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:teacher/data/boxes.dart';
import 'package:teacher/data/test.dart';

class AddTestPage extends StatefulWidget {
  @override
  State<AddTestPage> createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {
  TextEditingController notesController = TextEditingController();
  List<TextEditingController> question = [];
  List<List<TextEditingController>> answer = [];
  List<List<bool>> isCurrentAnswer = [];

  bool allFieldsFilled() {
    // Проверяем, заполнены ли все поля
    if (notesController.text.isEmpty) return false;

    for (var q in question) {
      if (q.text.isEmpty) return false; // Проверьте вопросы
    }

    for (var ansList in answer) {
      for (var ans in ansList) {
        if (ans.text.isEmpty) return false; // Проверьте ответы
      }
    }

    return true; // Все поля заполнены
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tests",
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
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    // Class name input
                    Container(
                      width: 310.w,
                      child: Text(
                        "Test name",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 60.h,
                      width: 310.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Color(0xFFC2B0FF).withOpacity(0.3),
                          border: Border.all(color: Colors.white, width: 2.h)),
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          controller: notesController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18.sp)),
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.transparent,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Questions and answers
              for (int i = 0; i < question.length; i++)
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Container(
                    width: 300.w,
                    child: Column(
                      children: [
                        // Question input
                        Container(
                          width: 300.w,
                          child: Text(
                            "Question title (${i + 1})",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 60.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Color(0xFFC2B0FF).withOpacity(0.3),
                              border:
                                  Border.all(color: Colors.white, width: 2.h)),
                          child: Center(
                            child: TextField(
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              controller: question[i],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 18.sp)),
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.transparent,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp),
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        // Answer inputs
                        for (int k = 0;
                            k <
                                (answer.isEmpty || answer.length <= i
                                    ? 0
                                    : answer[i].length);
                            k++)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    isCurrentAnswer[i][k] =
                                        !isCurrentAnswer[i][k];
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 48.h,
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFC2B0FF),
                                        border: Border.all(
                                            color: Colors.white, width: 2.h),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.r))),
                                    child: Center(
                                      child: isCurrentAnswer[i][k]
                                          ? Icon(
                                              Icons.done,
                                              size: 40.h,
                                              color: Colors.greenAccent,
                                            )
                                          : SizedBox.shrink(),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 50.h,
                                  width: 220.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Color(0xFFC2B0FF).withOpacity(0.3),
                                      border: Border.all(
                                          color: Colors.white, width: 2.h)),
                                  child: Center(
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      controller: answer[i][k],
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: 'Answer choice $k',
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              fontSize: 18.sp)),
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.transparent,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp),
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Add answer button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              // Ensure answer list exists for this question
                              if (answer.length <= i) {
                                answer.add([]);
                              }
                              isCurrentAnswer[i].add(false);
                              answer[i].add(TextEditingController());
                              setState(() {});
                            },
                            child: Container(
                              width: 50.r,
                              height: 50.r,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.r)),
                                border:
                                    Border.all(color: Colors.white, width: 4.h),
                              ),
                              child: Center(
                                child: Container(
                                  width: 30.r,
                                  height: 30.r,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.r)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF7D49F4),
                                          Color(0xFF5225C1)
                                        ]),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 30.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              // Add question button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: GestureDetector(
                  onTap: () {
                    question.add(TextEditingController());
                    isCurrentAnswer.add([false]);

                    answer.add([
                      TextEditingController()
                    ]); // Initialize a new list for answers
                    setState(() {});
                  },
                  child: Container(
                    width: 64.h,
                    height: 64.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF7D49F4), Color(0xFF5225C1)]),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 60.h,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              // Create button
              GestureDetector(
                onTap: () {
                  if (allFieldsFilled()) {
                    print("object");
                    List<TestInfo> infoTest = [];

                    for (int m = 0; m < question.length; m++) {
                      TestInfo info = TestInfo();
                      info.question = question[m].text.toString();
                      info.answer = answer[m]
                          .map((controller) => controller.text)
                          .toList();
                      info.isAnwer = isCurrentAnswer[m];
                      infoTest.add(info);
                    }
                    infoTest.forEach((action) {
                      print("----------------");
                      print("Action Answer: ${action.answer}");
                      print("Action is Answer: ${action.isAnwer}");
                      print("Action question: ${action.question}");
                      print("----------------");
                    });
                    if (infoTest.isNotEmpty) {
                      Box<Test> contactsBox = Hive.box<Test>(HiveBoxes.test);
                      Test addTest = Test(
                          className: notesController.text.toString(),
                          elemDate: infoTest);
                      contactsBox.add(addTest);
                      Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  width: 260.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    gradient: allFieldsFilled()
                        ? LinearGradient(
                            colors: [Color(0xFF7D49F4), Color(0xFF5225C1)])
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
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
