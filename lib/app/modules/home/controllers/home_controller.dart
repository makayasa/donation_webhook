import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:get_storage/get_storage.dart';
import 'package:saweria_webhook/app/controllers/obs_controller.dart';
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:saweria_webhook/app/utils/environment.dart';
import 'package:saweria_webhook/server/controllers/server_controller.dart';
import 'package:saweria_webhook/server/controllers/tuya_controller.dart';
import 'package:saweria_webhook/server/controllers/webhook_controller.dart';
import 'package:watcher/watcher.dart';

import '../../../utils/function_utils.dart';

class HomeController extends GetxController {
  var box = GetStorage();
  final pathText = r'D:\Program Files\souls dc\YOU_DIED.txt';
  var formKeyNgrok = GlobalKey<FormBuilderState>();
  var obsC = Get.put(ObsController());

  RxInt count = RxInt(0);
  RxBool valorantMode = RxBool(false);
  RxBool isObsConnected = RxBool(false);

  late TuyaController tuyaC;
  late ServerController serverC;
  late WebhookController saweriaC;

  void connectNgrok() {
    final isValidate = formKeyNgrok.currentState!.saveAndValidate();
    if (!isValidate) {
      return;
    }
    final value = formKeyNgrok.currentState!.value;
    final url = value['url'];
    final ip = value['ip'];
    final port = value['port'];
    // logKey('value', value);
    serverC.ngrok(url: url, ip: ip, port: port);
  }

  // Watcher watcher = Watcher(r"D:\death_count.txt");

  //* elden ring file
  final watcher = FileWatcher(
    r'D:\Program Files\souls dc\YOU_DIED.txt',
    pollingDelay: const Duration(
      // milliseconds: 10,
      seconds: 1,
    ),
  );

  @override
  void onInit() {
    super.onInit();
    valorantMode.value = box.read('valo');

    // gs.runApp(
    //   gs.GetServerApp(
    //     port: 7070,
    //     // useLog: false,
    //     initialBinding: ServerBindings(),
    //     getPages: ApiPages.routes,
    //   ),
    // );

    // var a =gs.Get.find<gs.GetServerController>();
    // a.

    if (Get.isRegistered<ServerController>()) {
      serverC = gs.Get.find<ServerController>();
    } else {
      serverC = gs.Get.put(ServerController());
    }

    if (gs.Get.isRegistered<TuyaController>()) {
      tuyaC = gs.Get.find<TuyaController>();
    } else {
      tuyaC = gs.Get.put(TuyaController());
    }

    // if (gs.Get.isRegistered<WebhookController>()) {
    //   saweriaC = gs.Get.find<WebhookController>();
    // } else {
    //   saweriaC = gs.Get.put(WebhookController());
    // }

    eldenRingDeathCount();
  }

  void eldenRingDeathCount() {
    final file = File(r'D:\Program Files\souls dc\YOU_DIED.txt');
    final currentDeath = RxInt(0);
    watcher.events.listen(
      (event) async {
        final content = await file.readAsString();
        final deathCount = int.tryParse(content.split(' ').last) ?? 0;
        logKey('content', content);
        if (deathCount > currentDeath.value) {
          final bool isEldenRingMode = box.read(kEldenRingMode);
          if (!isEldenRingMode) {
            return;
          }
          currentDeath.value = deathCount;
          await tuyaC.turnOff(lampuKamarDeviceId);
          await Future.delayed(const Duration(seconds: 4));
          await tuyaC.turnOn(lampuKamarDeviceId);
        }
      },
    );
  }

  @override
  void onReady() async {
    super.onReady();
    // tuyaC.getBrightness();
    // typeWord();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // void testCmd() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   await run('''python -c "import pyautogui; pyautogui.press(['g','g','g','g','g',]); pyautogui.hotkey('alt','f4')" ''');
  //   logKey('done');
  // }

  // Future<void> typeWord() async {
  //   await Keyboard.typeWord('Adib Mohsin', interval: 0);
  // }
}
