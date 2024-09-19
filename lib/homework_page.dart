import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:teacher/add_homework_page.dart';
import 'package:teacher/add_test_page.dart';
import 'package:teacher/data/boxes.dart';
import 'package:teacher/data/homework.dart';
import 'package:teacher/data/test.dart';
import 'package:teacher/pdf_api.dart';
import 'package:teacher/test_page.dart';

class HomeworkPage extends StatefulWidget {
  State<StatefulWidget> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable:
                Hive.box<Homework>(HiveBoxes.homework).listenable(),
            builder: (context, Box<Homework> box, _) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Homework",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24.sp),
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Center(
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                        color: Color(0xFF6E02C3),
                                        fontSize: 18.sp),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      for (int i = 0; i < box.length; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 24.w),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  box.getAt(i)!.today.toString(),
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 320.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.r))),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 300.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                box
                                                    .getAt(i)!
                                                    .className
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Color(0xFF6E02C3),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Container(
                                                width: 150.w,
                                                height: 33.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.r)),
                                                    color: Color(0xFF6E02C3)),
                                                child: Center(
                                                  child: Text(
                                                    "Surrender: ${box.getAt(i)!.surrender.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Container(
                                              width: 300.w,
                                              child: MySeparator(
                                                  color: Color(0xFF6E02C3))),
                                        ),
                                        Container(
                                          width: 300.w,
                                          child: Text(
                                            box.getAt(i)!.task.toString(),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: box.isEmpty
                            ? Container(
                                width: 330.w,
                                height: 340.h,
                                decoration: BoxDecoration(
                                    color: Color(0xFF935EBE),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 240.w,
                                      height: 226,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "assets/homework.png",
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "You don't have\nhomework yet",
                                                style: TextStyle(
                                                    color: Color(0xFF6E02C3),
                                                    height: 1.h,
                                                    fontSize: 24.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Add your first homework",
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          AddHomeworkPage(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 50.r,
                                              height: 50.r,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(18.r)),
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
                                                  size: 50.h,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          AddHomeworkPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 50.r,
                                  height: 50.r,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.r)),
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
                                      size: 50.h,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
// Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 final pdfFile = await PdfApi.generateTable();
//                 PdfApi.openFile(pdfFile);
//               },
//               child: Container(
//                 color: Colors.white,
//                 width: 200.w,
//                 height: 50.h,
//                 child: Center(child: Text("Table Pdf")),
//               ),
//             )
//           ],
//         ),
//       ),