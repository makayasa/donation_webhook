import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saweria_webhook/app/controllers/server_controller.dart';
import 'package:saweria_webhook/app/utils/default_text.dart';
import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:get_server/get_server.dart' as gs;

import '../../../utils/windows_keyboard.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // MethodChannel channel = MethodChannel('test_channel');
          // var res = await channel.invokeMethod('test');
          // print(res);

          // WindowsKeyboard.pressPlayPause();
          // WindowsKeyboard.pressWindows();
          // WindowsKeyboard.pressAltTab();

          final serverC = gs.Get.find<ServerController>();
          serverC.ngrok();
          // await Future.delayed(Duration(seconds: 3));

          // await Clipboard.setData(
          //   const ClipboardData(text: "your text zzz"),
          // );
          // WindowsKeyboard().paste();
        },
      ),
      appBar: AppBar(
        title: const Text('Halo sayang'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       child: DefText('Webhook on').normal,
          //     ),
          //     const SizedBox(height: 10),
          //     Obx(
          //       () => Switch(
          //         value: controller.valorantMode.value,
          //         onChanged: (value) {
          //           controller.valorantMode.value = value;
          //           controller.box.write('valo', controller.valorantMode.value);
          //         },
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: DefText('Valorant Mode').normal,
              ),
              const SizedBox(height: 10),
              Obx(
                () => Switch(
                  value: controller.valorantMode.value,
                  onChanged: (value) {
                    controller.valorantMode.value = value;
                    controller.box.write('valo', controller.valorantMode.value);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
