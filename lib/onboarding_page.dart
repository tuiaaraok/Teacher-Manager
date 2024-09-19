import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher/create_name_page.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<StatefulWidget> {
  int _currentPage = 0;
  final int _numPages = 2;
  List<String> subtitle = [
    "Fill out the journal, put in grades,\nenter student names, don't keep it in\nyour head",
    "Add tests and homework, everything\nis easier with the app, use with\nconvenience!"
  ];
  List<String> title = [
    "Keep an eye\non the\nmagazine!",
    "Add complex\nand simple\ntests"
  ];
  List<String> image = [
    "assets/onboarding_first.png",
    "assets/onboarding_second.png"
  ];
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: isActive ? 10.0.h : 10.h,
      width: isActive ? 10.w : 10.h,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  width: 300.h,
                  height: 300.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(300.r)),
                    image:
                        DecorationImage(image: AssetImage(image[_currentPage])),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.h),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFB67FE1), Color(0xFF6E02C3)]),
                      borderRadius: BorderRadius.all(Radius.circular(30.r))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 32.h, right: 30.w, left: 30.w),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title[_currentPage],
                              style: TextStyle(
                                  fontSize: 34.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 5.h,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              subtitle[_currentPage],
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Color(0xFFEBEBF5).withOpacity(0.6),
                                  fontWeight: FontWeight.w700),
                            )),
                        _currentPage == 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                CreateNamePage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Skip",
                                        style: TextStyle(
                                            color: Color(0xFFEBEBF5)
                                                .withOpacity(0.6),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17.sp),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _currentPage += 1;
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 85.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xFFF2E8FA),
                                              Color(0xFFCEA9EB)
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18.r))),
                                        child: Center(
                                          child: Text(
                                            "Next",
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            CreateNamePage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 290.w,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r)),
                                        gradient: LinearGradient(colors: [
                                          Color(0xFF7D49F4),
                                          Color(0xFF5225C1)
                                        ])),
                                    child: Center(
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _buildPageIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
