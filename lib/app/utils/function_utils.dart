import 'dart:convert';
import 'dart:developer' as dev;

import 'package:get/get.dart';
import 'package:process_run/cmd_run.dart';
import 'package:saweria_webhook/app/utils/network_controller.dart';

import '../../helpers/saweria_message_helper.dart';
import 'environment.dart';

void logKey([key, content]) {
  String finalLog = '';
  dynamic tempContent = content ?? key;
  if (tempContent is Map || tempContent is List) {
    try {
      finalLog = json.encode(tempContent);
    } catch (e) {
      finalLog = tempContent.toString();
    }
  } else if (tempContent is String) {
    finalLog = tempContent;
  } else {
    finalLog = tempContent.toString();
  }

  if (content != null) {
    dev.log('$key => $finalLog');
  } else {
    dev.log(finalLog);
  }
}

dynamic runCommand({bool isPython3 = false, required String pyautoguiCommand}) {
  String pathCommand = '';
  if (isPython3) {
    pathCommand += 'python3 -c "import pyautogui;"';
  } else {
    pathCommand += 'python -c "import pyautogui;"';
  }
  pathCommand = pathCommand.replaceRange(pathCommand.length - 2, pathCommand.length - 1, '; $pyautoguiCommand');
  logKey('pathCommand', pathCommand);
  return run(pathCommand);
}

dynamic startNgrok({required String url, required String ip, required String port}) async {
  final res = await run(
    'ngrok http --domain=$url $ip:$port --log-format=json --log=stdout',
    onProcess: (process) async {
      logKey('startNgrok', process.pid);
    },
  ).catchError(
    (a) async {
      logKey('catchError');
      Get.snackbar('Error', 'Ngrok is already running');
      return a;
    },
  );
  logKey('res', res);
  return res;
}

String tuyaInit() {
  return "import tinytuya; lampu_kamar = tinytuya.BulbDevice('$lampuKamarDeviceId', '$lampuKamarLocalIp', '$lampuKamarLocalKey', version=3.3);";
}

void dropWeapon(bool valorantMode) async {
  if (!valorantMode) {
    return;
  }
  // var commandString = "pyautogui.press('1'); pyautogui.press('g');";
  // runCommand(pyautoguiCommand: commandString);
  final networkC = Get.find<NetworkController>();
  try {
    await networkC.post(
      'http://127.0.0.1:6969/keyboard_event/drop_weapon',
    );
  } catch (e) {
    logKey('error dropWeapon', e);
  }
}

void allChat(String message, bool valorantMode) async {
  // logKey('masuk allchat', valorantMode.value);
  var msg = message;
  var chat = msg.split(SaweriaMessageHelper.TXT).last;

  if (!valorantMode) {
    return;
  }
  // var commandString = "pyautogui.press('enter'); pyautogui.write('$chat'); pyautogui.hotkey('shift','enter'); pyautogui.press('enter');";
  var commandString =
      " pyautogui.hotkey('shiftright','enter', inverval=0.25);pyautogui.hotkey('shiftright','enter'); pyautogui.write('$chat'); pyautogui.press('enter');";
  // var commandString = "pyautogui.keyDown('shift'); pyautogui.press('enter'); pyautogui.keyUp('shift'); pyautogui.write('$chat');  pyautogui.press('enter');";
  runCommand(pyautoguiCommand: commandString);
}

void moveMouse() async {
  var cmdString = 'pyautogui.moveTo(100, 100, 2, pyautogui.easeInQuad);';
  runCommand(pyautoguiCommand: cmdString);
}

bool isEmpty(dynamic val) {
  return [
    "",
    " ",
    null,
    'null',
    '{}',
    '[]',
    '0',
    '0.0',
    '-1',
  ].contains(val.toString());
}

bool isNotEmpty(dynamic val) {
  return ![
    "",
    " ",
    null,
    'null',
    '{}',
    '[]',
    '0',
    '0.0',
    '0.00',
    '-1',
  ].contains(val.toString());
}
