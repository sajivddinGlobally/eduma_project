import 'dart:developer';
import 'package:eduma_app/Screen/home.page.dart';
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeController);

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

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),

            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: themeMode,

            home: token == null ? OnbordingPage() : HomePage(),
          );
        },
      ),
    );
  }
}
