import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:teacher/preview_page.dart';

class CreateNamePage extends StatefulWidget {
  const CreateNamePage({super.key});

  @override
  State<StatefulWidget> createState() => CreateNamePageState();
}

class CreateNamePageState extends State<StatefulWidget> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "I'd like to know\nyour name",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 80.h),
                    child: Text(
                      "What's your name?",
                      style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.white.withValues(alpha: 0.6),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 310.w,
                    child: Text(
                      "Your name",
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: const Color(0xFFC2B0FF).withValues(alpha: 0.3),
                        border: Border.all(color: Colors.white, width: 2.h)),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        controller: nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none, // Убираем обводку
                            focusedBorder:
                                InputBorder.none, // Убираем обводку при фокусе
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withValues(alpha: 0.5),
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
                  SizedBox(
                    height: 300.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 60.h),
                    child: GestureDetector(
                      onTap: () async {
                        if (nameController.text.isNotEmpty) {
                          var box = await Hive.openBox('userName');
                          box.put('name', nameController.text.toString());
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => PreviewPage(
                                name: nameController.text.toString(),
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 260.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                          gradient: nameController.text.isNotEmpty
                              ? const LinearGradient(colors: [
                                  Color(0xFF7D49F4),
                                  Color(0xFF5225C1)
                                ])
                              : const LinearGradient(colors: [
                                  Color.fromARGB(162, 124, 73, 244),
                                  Color.fromARGB(103, 81, 37, 193)
                                ]),
                        ),
                        child: Center(
                          child: Text(
                            "Start",
                            style: TextStyle(
                                color: nameController.text.isNotEmpty
                                    ? Colors.white
                                    : const Color(0xFFF2F2F7)
                                        .withValues(alpha: 0.5),
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
        ),
      ),
    );
  }
}
