import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:teacher/data/test.dart';

class PdfApi {
  static Future<File> generateTable(
      {required String nameFile, required Test? info}) async {
    final pdf = Document();

    // Загрузим шрифт. Убедитесь, что вы добавили шрифт в проект.
    final ttf = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final font = Font.ttf(ttf);

    pdf.addPage(MultiPage(
      build: (context) => [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(nameFile,
              style: TextStyle(
                  fontSize: 40.sp, fontWeight: FontWeight.bold, font: font)),
        ),
        SizedBox(height: 40.h),
        for (int i = 0; i < info!.elemDate!.length; i++)
          Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${i + 1}",
                          style: TextStyle(fontSize: 50.h, font: font),
                        ),
                        Container(
                          height: 50.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2.h),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            child: Center(
                              child: Text(
                                "${info.elemDate![i].question}",
                                style: TextStyle(fontSize: 18.sp, font: font),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (int j = 0; j < info.elemDate![i].answer!.length; j++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Container(
                              width: 48.h,
                              height: 48.h,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2.h),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.r))),
                              child: Center(child: Text("")),
                            ),
                          ),
                          Container(
                            height: 50.h,
                            width: 220.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(width: 2.h)),
                            child: Center(
                              child: Text(
                                info.elemDate![i].answer![j],
                                style: TextStyle(fontSize: 16.sp, font: font),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ))
      ],
    ));

    return saveDocument(name: "${nameFile}.pdf", pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    try {
      final result = await OpenFile.open(url);
      print(result.message); // Это может помочь вам в отладке
    } catch (e) {
      print(e);
    }
  }
}
