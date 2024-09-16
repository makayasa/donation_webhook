// import 'package:get_server/get_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saweria_webhook/app/components/default_text.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Row(
            children: [
              DefText('Server Port :').semilarge,
              // const SizedBox(width: 10),
              Obx(
                () => DefText('${controller.port.value}', color: Colors.lightBlue).semilarge,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: DefText('Valorant Mode : ').normal,
              ),
              const SizedBox(height: 10),
              Obx(
                () => Switch(
                  value: controller.valorantMode.value,
                  onChanged: (value) {
                    controller.changedGameMode('valorant', value);
                  },
                ),
              )
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: DefText('Elden Ring Mode : ').normal,
              ),
              const SizedBox(height: 10),
              Obx(
                () => Switch(
                  value: controller.eldenringMode.value,
                  onChanged: (value) {
                    controller.changedGameMode('elden_ring', value);
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
