import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_server/get_server.dart' as gs;
import 'package:get_storage/get_storage.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:saweria_webhook/app/controllers/server_controller.dart';
import 'package:saweria_webhook/app/controllers/tuya_controller.dart';
import 'package:saweria_webhook/app/controllers/webhook_controller.dart';

import '../../../utils/function_utils.dart';

class HomeController extends GetxController {
  var box = GetStorage();

  var formKeyNgrok = GlobalKey<FormBuilderState>();
  var formKeyObs = GlobalKey<FormBuilderState>();

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

  final obsWebSocket = Rxn<ObsWebSocket>();
  void connectObs() async {
    final isValidate = formKeyObs.currentState!.saveAndValidate();
    if (!isValidate) {
      return;
    }
    final value = formKeyObs.currentState!.value;
    logKey('msk sini');
    try {
      obsWebSocket.value = await ObsWebSocket.connect(
        'ws://${value['ip']}:${value['port']}',
        onDone: () {
          logKey('onDone');
          isObsConnected.value = false;
        },
        fallbackEventHandler: (Event event) {
          logKey('fallbackEventHandler ${event.eventType}', event.eventData);
        },
      );
      obsWebSocket.value!.broadcastStream.listen((event) {
        logKey('listening', event.toString());
      });
      await obsWebSocket.value!.listen(EventSubscription.general.code);
      obsWebSocket.value!.addHandler<ExitStarted>(() {
        logKey('handler exit started');
        isObsConnected.value = false;
      });
      await obsWebSocket.value!.listen(EventSubscription.all.code);
      // obsWebSocket.value!.addHandler<StudioModeStateChanged>(
      //   (StudioModeStateChanged studioModeStateChanged) async {
      //     logKey('StudioModeStateChanged', studioModeStateChanged.studioModeEnabled);
      //   },
      // );
      // obsWebSocket.value!.addHandler<ExitStarted>((ExitStarted exitStarted) async {
      //   logKey('exitStarted');
      // });
      isObsConnected.value = true;
    } catch (e) {
      logKey('error connectObs', e.toString());
      isObsConnected.value = false;
    }
  }

  RxBool isShow = RxBool(false);

  // void getObsSource() async {
  // const sceneName = 'Basic Main Screen';
  // const sourceName = 'Main Monitor';
  // const sourceName = 'Saweria 2';
  // final list = await obsWebSocket.scenes.getSceneList();
  // logKey(list.scenes.toString());

  // final sceneItemList = await obsWebSocket.sceneItems.getSceneItemList('Main Screen');
  // logKey('sceneItemList Main Screen',sceneItemList);

  // final a = await obsWebSocket.sources.active('Main Screen');
  // logKey('a', a.videoShowing);

  // final sceneItemId = await obsWebSocket.sceneItems.getSceneItemId(SceneItemId(
  //   sceneName: sceneName,
  //   sourceName: sourceName,
  // ));

  // final sceneItemId = await obsWebSocket.sceneItems.getSceneItemId(
  //   sceneName: sceneName,
  //   sourceName: sourceName,
  // );
  // isShow.value = !isShow.value;
  // await obsWebSocket.sceneItems.setSceneItemEnabled(
  //   SceneItemEnableStateChanged(
  //     sceneName: sceneName,
  //     sceneItemId: sceneItemId,
  //     sceneItemEnabled: isShow.value,
  //   ),
  // );

  // obsWebSocket.filters.setSourceEnabled(
  //   sourceName: sourceName,
  //   filterName: filterName,
  //   filterEnabled: filterEnabled,
  // );
  // }

  void sourceStateChangedAllScene(String sourceName) async {
    try {
      final scenes = await obsWebSocket.value!.scenes.getSceneList();
      final avaiableScenes = <Scene>[];
      for (var scene in scenes.scenes) {
        final scenename = scene.sceneName;
        final sources = await obsWebSocket.value!.sceneItems.getSceneItemList(scenename);
        for (var source in sources) {
          if (source.sourceName == sourceName) {
            avaiableScenes.add(scene);
            break;
          }
        }
      }
      for (var scene in avaiableScenes) {
        final sceneItemId = await obsWebSocket.value!.sceneItems.getSceneItemId(
          sceneName: scene.sceneName,
          sourceName: sourceName,
        );
        final isShow = await obsWebSocket.value!.sceneItems.getEnabled(
          sceneName: scene.sceneName,
          sceneItemId: sceneItemId,
        );
        obsWebSocket.value!.sceneItems.setSceneItemEnabled(
          SceneItemEnableStateChanged(
            sceneName: scene.sceneName,
            sceneItemId: sceneItemId,
            sceneItemEnabled: !isShow,
          ),
        );
      }
      logKey('scenes', avaiableScenes);
    } catch (e) {
      logKey('error sourceStateChangedAllScene', e.toString());
    }
  }

  void hideSourceOnCurrentScene(String sourceName) async {}

  Future<void> toggleSourceOnActiveScene(String sourceName, {String? sceneName}) async {
    try {
      final currentScene = await obsWebSocket.value!.scenes.getCurrentProgramScene();
      final sourcesId = await obsWebSocket.value!.sceneItems.getId(sceneName: sceneName ?? currentScene, sourceName: sourceName);
      final sourceStatus = await obsWebSocket.value!.sendRequest(
        Request(
          'GetSourceActive',
          requestData: {
            'sourceName': sourceName,
          },
        ),
      );
      await obsWebSocket.value!.sceneItems.setSceneItemEnabled(
        SceneItemEnableStateChanged(
          sceneName: sceneName ?? currentScene,
          sceneItemId: sourcesId,
          sceneItemEnabled: !sourceStatus?.responseData?['videoShowing'],
        ),
      );
    } catch (e) {
      logKey('error hideSourceOnActiveScene', e);
    }
  }

  Future<void> hideSourceOnAllScene(String sourceName) async {
    try {
      final scenes = await obsWebSocket.value!.scenes.getSceneList();
      final avaiableScenes = <Scene>[];
      for (var scene in scenes.scenes) {
        final scenename = scene.sceneName;
        final sources = await obsWebSocket.value!.sceneItems.getSceneItemList(scenename);
        for (var source in sources) {
          if (source.sourceName == sourceName) {
            avaiableScenes.add(scene);
            break;
          }
        }
      }
      for (var scene in avaiableScenes) {
        final sceneItemId = await obsWebSocket.value!.sceneItems.getSceneItemId(
          sceneName: scene.sceneName,
          sourceName: sourceName,
        );
        obsWebSocket.value!.sceneItems.setSceneItemEnabled(
          SceneItemEnableStateChanged(
            sceneName: scene.sceneName,
            sceneItemId: sceneItemId,
            sceneItemEnabled: false,
          ),
        );
      }
    } catch (e) {
      logKey('error sourceStateChangedAllScene', e.toString());
    }
  }

  Future<void> showSourceOnAllScene(String sourceName) async {
    try {
      final scenes = await obsWebSocket.value!.scenes.getSceneList();
      final avaiableScenes = <Scene>[];
      for (var scene in scenes.scenes) {
        final _scenename = scene.sceneName;
        final sources = await obsWebSocket.value!.sceneItems.getSceneItemList(_scenename);
        for (var source in sources) {
          if (source.sourceName == sourceName) {
            avaiableScenes.add(scene);
            break;
          }
        }
        // logKey('scene = $_scenename', sources);
      }
      for (var scene in avaiableScenes) {
        final sceneItemId = await obsWebSocket.value!.sceneItems.getSceneItemId(
          sceneName: scene.sceneName,
          sourceName: sourceName,
        );
        obsWebSocket.value!.sceneItems.setSceneItemEnabled(
          SceneItemEnableStateChanged(
            sceneName: scene.sceneName,
            sceneItemId: sceneItemId,
            sceneItemEnabled: true,
          ),
        );
      }
    } catch (e) {
      logKey('error sourceStateChangedAllScene', e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    valorantMode.value = box.read('valo');
    if (gs.Get.isRegistered<TuyaController>()) {
      tuyaC = gs.Get.find<TuyaController>();
    } else {
      tuyaC = gs.Get.put(TuyaController());
    }
    if (Get.isRegistered<ServerController>()) {
      serverC = gs.Get.find<ServerController>();
    } else {
      serverC = gs.Get.put(ServerController());
    }
    if (gs.Get.isRegistered<WebhookController>()) {
      saweriaC = gs.Get.find<WebhookController>();
    } else {
      saweriaC = gs.Get.put(WebhookController());
    }
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
