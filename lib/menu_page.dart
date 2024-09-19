import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:launch_review/launch_review.dart';
import 'package:teacher/homework_page.dart';
import 'package:teacher/journal_list_page.dart';
import 'package:teacher/list_test_page.dart';
import 'package:teacher/test_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<StatefulWidget> {
  bool onPressHelp = false;
  List<Widget> calendarCells = List<Widget>.generate(180, (index) {
    // Вычисляем номер текущего столбца, используя индекс
    int column =
        (index ~/ 9) % 20; // Определяем номер столбца каждую 7-й элемент
    double opacity =
        0.5 - (column * 0.03).clamp(0.0, 0.5); // Уменьшаем непрозрачность

    return Opacity(
      opacity: opacity,
      child: Container(
        child: Icon(
          IconsaxPlusLinear.book_saved,
          color: Colors.black,
          size: 30.w,
        ),
      ),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 9,
              children: calendarCells,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
            child: Container(
              height: double.infinity,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        onPressHelp = true;
                        setState(() {});
                      },
                      child: Container(
                        width: 119.w,
                        height: 38.h,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF7D49F4), Color(0xFF5225C1)]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Center(
                          child: Text(
                            "Help",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 700.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ListTestPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 290.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF7D49F4),
                                      Color(0xFF5225C1)
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Tests",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        HomeworkPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 290.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF7D49F4),
                                      Color(0xFF5225C1)
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Homework",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        JournalListPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 290.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF7D49F4),
                                      Color(0xFF5225C1)
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Journal",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (onPressHelp)
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Container(
                  height: 400.h,
                  width: 330.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFA58ADD), Color(0xFFA272CF)]),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.h, top: 5.h),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              onPressHelp = false;
                              setState(() {});
                            },
                            child: Container(
                              width: 38.r,
                              height: 38.r,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(38.r)),
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
                                  Icons.close,
                                  color: Colors.white,
                                  size: 38.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              String? encodeQueryParameters(
                                  Map<String, String> params) {
                                return params.entries
                                    .map((MapEntry<String, String> e) =>
                                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                    .join('&');
                              }

                              // ···
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: 'TravisJohnson9902@outlook.com',
                                query: encodeQueryParameters(<String, String>{
                                  '': '',
                                }),
                              );
                              try {
                                if (await canLaunchUrl(emailLaunchUri)) {
                                  await launchUrl(emailLaunchUri);
                                } else {
                                  throw Exception(
                                      "Could not launch $emailLaunchUri");
                                }
                              } catch (e) {
                                print(
                                    'Error launching email client: $e'); // Log the error
                              }
                            },
                            child: Container(
                              width: 230.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF7D49F4),
                                    Color(0xFF5225C1)
                                  ])),
                              child: Center(
                                child: Text(
                                  "Contact us",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              final Uri _url = Uri.parse('https://flutter.dev');
                              if (!await launchUrl(_url)) {
                                throw Exception('Could not launch $_url');
                              }
                            },
                            child: Container(
                              width: 230.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF7D49F4),
                                    Color(0xFF5225C1)
                                  ])),
                              child: Center(
                                child: Text(
                                  "Privacy policy",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              LaunchReview.launch(
                                  androidAppId: "app.openauthenticator",
                                  iOSAppId: "585027354");
                            },
                            child: Container(
                              width: 230.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF7D49F4),
                                    Color(0xFF5225C1)
                                  ])),
                              child: Center(
                                child: Text(
                                  "Rate us",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
