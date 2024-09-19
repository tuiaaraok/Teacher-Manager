import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:teacher/add_journal_page.dart';
import 'package:teacher/data/boxes.dart';
import 'package:teacher/data/journal.dart';

import 'package:teacher/journal_page.dart';

class JournalListPage extends StatefulWidget {
  @override
  State<JournalListPage> createState() => JournalListPageState();
}

class JournalListPageState extends State<JournalListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Journal>(HiveBoxes.journal).listenable(),
            builder: (context, Box<Journal> box, _) {
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
                              "Journal",
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
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      JournalPage(
                                    i: i,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 50.h,
                              width: 310.w,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF7D49F4),
                                        Color(0xFF5225C1)
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18.r))),
                              child: Center(
                                child: Text(
                                  box.getAt(i)!.className.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
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
                                                "assets/journal.png",
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
                                                "You don't have a\njournal yet",
                                                style: TextStyle(
                                                    color: Color(0xFF6E02C3),
                                                    height: 1.h,
                                                    fontSize: 24.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Create your first magazine",
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
                                                          AddJournalPage(),
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
                                          AddJournalPage(),
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
