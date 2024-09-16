import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:saweria_webhook/app/components/default_button.dart';
import 'package:saweria_webhook/app/utils/constant.dart';
import 'package:saweria_webhook/app/utils/default_text.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({Key? key})
      : super(
          key: key,
          settings: kScreenChangePoint,
          alwaysUseBuilder: false,
        );
  @override
  // Widget build(BuildContext context) {
  Widget builder() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // controller.tuyaC.turnOn(lampuKamarDeviceId);
          // return;
          Get.toNamed(Routes.CREATE_WEBHOOK_COMMAND);
          // controller.obsWebSocket.close();
          // controller.sourceStateChangedAllScene('Main Monitor');
          // controller.sourceStateChangedAllScene('Webcam');

          // MethodChannel channel = MethodChannel('test_channel');
          // var res = await channel.invokeMethod('test');
          // print(res);

          // WindowsKeyboard.pressPlayPause();
          // WindowsKeyboard.pressWindows();
          // WindowsKeyboard.pressAltTab();

          // await Future.delayed(Duration(seconds: 3));

          // await Clipboard.setData(
          //   const ClipboardData(text: "your text zzz"),
          // );
          // WindowsKeyboard().paste();
        },
      ),
      drawerScrimColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: kBgWhite,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.SETTING);
            },
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
          ),
          Container(
            height: Get.mediaQuery.size.height,
            constraints: const BoxConstraints(
              maxWidth: 400,
              minHeight: 720,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: kSecondaryColor,
                    constraints: const BoxConstraints(
                      minHeight: 720 / 3,
                    ),
                    child: Center(
                      child: DefaultButton(
                        onTap: () {},
                        child: DefText('Login Google').large,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: NgrokCard(),
                ),
                const Expanded(
                  child: ObsCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ObsCard extends GetView<HomeController> {
  const ObsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKeyObs,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        constraints: const BoxConstraints(
          minHeight: 720 / 3,
        ),
        height: Get.mediaQuery.size.height * 0.3,
        color: kFourthColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefText('OBS').extraLarge,
                const SizedBox(width: 5),
                Obx(
                  () => Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: controller.isObsConnected.value ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'ip',
                    initialValue: '192.168.0.2',
                    decoration: const InputDecoration(
                      hintText: 'IP',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.ip(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'port',
                    decoration: const InputDecoration(
                      hintText: 'port',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: '4460',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DefaultButton(
              onTap: () {
                // if (controller.isObsConnected.value) {
                //   return;
                // }
                controller.connectObs();
              },
              child: DefText('Connect').normal,
            ),
          ],
        ),
      ),
    );
  }
}

class NgrokCard extends GetView<HomeController> {
  const NgrokCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKeyNgrok,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 720 / 3,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: Get.mediaQuery.size.height * 0.3,
        color: kThirdColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefText('NGROK').extraLarge,
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'url',
              initialValue: 'turkey-amazed-regularly.ngrok-free.app',
              decoration: const InputDecoration(
                hintText: 'ngrok dns',
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.url(),
              ]),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'ip',
                    initialValue: '192.168.0.2',
                    decoration: const InputDecoration(
                      hintText: 'IP',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.ip()]),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'port',
                    initialValue: '7070',
                    decoration: const InputDecoration(
                      hintText: 'port',
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DefaultButton(
              onTap: () {
                controller.connectNgrok();
              },
              child: DefText('Connect').normal,
            ),
          ],
        ),
        // child: Center(
        //   child: DefText('NGROK').large,
        // ),
      ),
    );
  }
}
