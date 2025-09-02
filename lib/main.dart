import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/networkErrorPage.dart';
import 'package:eduma_app/Screen/onbording.page.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/data/Controller/themeModeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("userBox");

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final hasInternet =
          results.isNotEmpty && results.first != ConnectivityResult.none;

      if (!hasInternet) {
        // Agar internet nahi hai -> NetworkErrorPage pe bhej do
        navigatorKey.currentState?.pushNamed("/networkErrorPage");
      } else {
        // Agar internet wapas aata hai -> sirf tabhi pop karo agar koi page stack me hai
        Future.delayed(Duration(seconds: 1), () {
          if (navigatorKey.currentState?.canPop() ?? false) {
            navigatorKey.currentState?.popUntil((route) => route.isFirst);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    var box = Hive.box("userBox");
    var token = box.get("token");
    log("////////////////////////////");
    log(token ?? "No token found");
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(440, 956),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'Flutter Demo',

            theme: lightTheme,

            darkTheme: darkTheme,

            themeMode: themeMode,

            home: token == null ? OnbordingPage() : HomePage(),

            routes: {'/networkErrorPage': (context) => NetworkErrorPage()},
          );
        },
      ),
    );
  }
}
