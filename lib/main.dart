import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:saweria_webhook/app/settings/global_bindings.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:window_manager/window_manager.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
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
  // WindowManager.instance.setMinimumSize(Size(1280, 720));
  // WindowManager.instance.setMaximumSize(Size(1980, 1080));
  // windowManager.minimize();
  await GetStorage.init();
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
    ),
  );
}
