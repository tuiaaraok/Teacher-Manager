import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';
import 'package:teacher/add_homework_page.dart';
import 'package:teacher/add_test_page.dart';
import 'package:teacher/create_name_page.dart';
import 'package:teacher/data/boxes.dart';
import 'package:teacher/data/homework.dart';
import 'package:teacher/data/journal.dart';
import 'package:teacher/data/test.dart';
import 'package:teacher/add_journal_page.dart';
import 'package:teacher/firebase_options.dart';
import 'package:teacher/homework_page.dart';
import 'package:teacher/journal_list_page.dart';
import 'package:teacher/journal_page.dart';
import 'package:teacher/list_test_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:teacher/menu_page.dart';
import 'package:teacher/onboarding_page.dart';
import 'package:teacher/preview_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(TestAdapter());
  Hive.registerAdapter(TestInfoAdapter());
  Hive.registerAdapter(JournalAdapter());
  Hive.registerAdapter(HomeworkAdapter());
  await Hive.openBox<Test>(HiveBoxes.test);
  await Hive.openBox<Journal>(HiveBoxes.journal);
  await Hive.openBox<Homework>(HiveBoxes.homework);
  await Hive.openBox("userName");
  await Hive.openBox("privacyLink");

  // Call the _initializeRemoteConfig function
  await _initializeRemoteConfig().then((onValue) {
    runApp(MyApp(
      link: onValue,
    ));
  });
}

Future<String> _initializeRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  var box = await Hive.openBox('privacyLink');
  String link = '';

  if (box.isEmpty) {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    // Defaults setup

    try {
      bool updated = await remoteConfig.fetchAndActivate();
      print("Remote Config Update Status: $updated");

      link = remoteConfig.getString("link");

      print("Fetched link: $link");
    } catch (e) {
      print("Failed to fetch remote config: $e");
    }
  } else {
    if (box.get('link').contains("showAgreebutton")) {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 1),
      ));

      try {
        bool updated = await remoteConfig.fetchAndActivate();
        print("Remote Config Update Status: $updated");

        link = remoteConfig.getString("link");
        print("Fetched link: $link");
      } catch (e) {
        print("Failed to fetch remote config: $e");
      }
      if (!link.contains("showAgreebutton")) {
        box.put('link', link);
      }
    } else {
      link = box.get('link');
    }
  }

  return link == ""
      ? "https://telegra.ph/ColorCode-Design-and-Art-Privacy-Policy-10-21?showAgreebutton"
      : link;
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.link});
  final String link;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Color(0xFF6E02C3),
                appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)),
            home: Hive.box("privacyLink").isEmpty
                ? WebViewScreen(
                    link: link,
                  )
                : Hive.box("privacyLink")
                        .get('link')
                        .contains("showAgreebutton")
                    ? Hive.box("userName").isEmpty
                        ? OnboardingPage()
                        : MenuPage()
                    : WebViewScreen(
                        link: link,
                      ),
          );
        });
  }
}

class WebViewScreen extends StatefulWidget {
  WebViewScreen({required this.link});
  final String link;

  @override
  State<WebViewScreen> createState() {
    return _WebViewScreenState();
  }
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool loadAgree = false;
  WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    if (Hive.box("privacyLink").isEmpty) {
      Hive.box("privacyLink").put('link', widget.link);
    }

    _initializeWebView(widget.link); // Initialize WebViewController
  }

  void _initializeWebView(String url) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print(progress);
            if (progress == 100) {
              loadAgree = true;
              setState(() {});
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    setState(() {}); // Optional, if you want to trigger a rebuild elsewhere
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: Stack(children: [
          WebViewWidget(controller: controller),
          if (loadAgree)
            GestureDetector(
                onTap: () async {
                  var box = await Hive.openBox('privacyLink');
                  box.put('link', widget.link);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => OnboardingPage(),
                    ),
                  );
                },
                child: widget.link.contains("showAgreebutton")
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: 200,
                            height: 60,
                            color: Colors.amber,
                            child: Center(child: Text("AGREE")),
                          ),
                        ))
                    : null),
        ]),
      ),
    );
  }
}
