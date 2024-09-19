import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher/menu_page.dart';

class PreviewPage extends StatefulWidget {
  PreviewPage({required this.name});
  final String name;
  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  ConfettiController confettiController =
      ConfettiController(duration: Duration(seconds: 3));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confettiController.play();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MenuPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConfettiWidget(
            confettiController: confettiController,
            blastDirection: -pi / 4,
            emissionFrequency: 0.2,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nice to meet you.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                      color: Colors.white.withOpacity(0.5)),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
