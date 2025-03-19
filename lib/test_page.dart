import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher/data/test.dart';
import 'package:teacher/pdf_api.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.info});
  final Test? info;
  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String nameFile = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
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
                            "Tests",
                            style:
                                TextStyle(color: Colors.white, fontSize: 24.sp),
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
                                      color: const Color(0xFF6E02C3),
                                      fontSize: 18.sp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Container(
                        height: 50.h,
                        width: 310.w,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF7D49F4), Color(0xFF5225C1)]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.r))),
                        child: Center(
                          child: Text(
                            widget.info!.className.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < widget.info!.elemDate!.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 40.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "$i",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 50.h),
                                  ),
                                  Container(
                                    height: 50.h,
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2.h, color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.h),
                                      child: Center(
                                          child: Text(
                                        "${widget.info!.elemDate![i].question}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            for (int j = 0;
                                j < widget.info!.elemDate![i].answer!.length;
                                j++)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.h),
                                      child: Container(
                                        width: 48.h,
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFC2B0FF),
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 2.h),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25.r))),
                                        child: Center(
                                          child: widget.info!.elemDate![i]
                                                  .isAnwer![j]
                                              ? Icon(
                                                  Icons.done,
                                                  size: 40.h,
                                                  color: Colors.greenAccent,
                                                )
                                              : const SizedBox.shrink(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50.h,
                                      width: 220.w,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          color: const Color(0xFFC2B0FF)
                                              .withValues(alpha: 0.3),
                                          border: Border.all(
                                              color: Colors.white, width: 2.h)),
                                      child: Center(
                                          child: Text(
                                        widget.info!.elemDate![i].answer![j],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      )),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20.h,
              bottom: 30.h,
              child: GestureDetector(
                onTap: () async {
                  final pdfFile = await PdfApi.generateTable(
                      nameFile: widget.info!.className.toString(),
                      info: widget.info);
                  PdfApi.openFile(pdfFile);
                },
                child: Container(
                  width: 100.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.r))),
                  child: Center(
                    child: Text(
                      "Unload",
                      style: TextStyle(
                          fontSize: 18.sp, color: const Color(0xFF6E02C3)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
