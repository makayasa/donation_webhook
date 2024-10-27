import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:loggy/loggy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:saweria_webhook/app/settings/global_bindings.dart';
import 'package:saweria_webhook/app/utils/my_log_printer.dart';
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:window_manager/window_manager.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  await dotenv.load(
      // fileName: 'dotenv.env',
      // fileName: r'C:\Users\rifqi\Documents\Projects\Flutter Projects\saweria_webhook\dotenv.env',
      );
  Loggy.initLoggy(
    // logPrinter: const PrettyPrinter(
    //   showColors: true,
    // ),
    logPrinter: MyLogPrinter(),
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.off,
    ),
  );
  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );
  await launchAtStartup.enable();
  //  WindowOptions windowOptions = const WindowOptions(
  //   size: Size(800, 600),
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   titleBarStyle: TitleBarStyle.hidden,
  // );
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.show();
  // });
  // WindowManager.instance.setMinimumSize(const Size(1280, 720));
  WindowManager.instance.setMinimumSize(const Size(960, 720));
  WindowManager.instance.setMaximumSize(const Size(2560, 1440));
  // windowManager.minimize();
  await GetStorage.init();
  await GetStorage.init('tuya');
  // Validate.installed();
  // var server = gs.GetServerApp(
  // host: '192.168.0.2',
  //   host: 'mkys-webhook.my.id',
  //   port: 7070,
  //   getPages: ApiPages.routes,
  // );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialBinding: GlobalBindings(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      // enableLog: false,
      // logWriterCallback: (text, {bool? isError}) {
      //   if (isError ?? false) {
      //     logger.e(text);
      //   } else {
      //     logger.w(text);
      //   }
      // },
      theme: ThemeData(
        // scaffoldBackgroundColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(
          color: kSecondaryColor,
        ),
      ),
    ),
  );
}
